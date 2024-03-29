
use strict;
#use warnings;

# This script finds the distance of each CA on straight line (Regression line )
# i.e: Line of best fit for every epitope. Draws a line of fit for each of 
# epitope and then finds distance of each of CA with straight line ...

# Add the path of the executable to the library path
use FindBin;
use lib $FindBin::Bin;

use Data::Dumper;
use SFPerlVars;
use Math::Vec qw(NewVec);
use antigenProcessing qw (getAntigenChains);
use general qw(readDirPDB);
use File::Basename;
use Cwd;

use epitope qw (
                  getRegionRange
                  getFragmentResidue
                  writepymolScript
                  getDistanceToStraightLine
                  getChainLabelAndType
                  getCACoordsForRegion
                  getXYZ
                  calculateDistanceWithLine
                  getBestFitLineCoords
                  makePeptideFigure
                  printArrays
                  getLeastDistanceCAlpha
           );

my $pymol = "/usr/bin/pymol";

my $dir = getcwd();

`mkdir -p $dir/LINEAR`;
`mkdir -p $dir/CURVED`;
`mkdir -p $dir/FOLDED`;
chdir $dir;
my $infile = "epitope_sequence-G3-CR3";

my @dirFiles = readDirPDB ($dir); # Reading all PDB complexes in an array
my $EPITOPE;

my $pdb;
my %distances;

open (my $ALL, ">>AllDistances.txt") or die "Can not open\n";
open (my $REGLEN, ">>RegionLength\n");
open (my $CURVEDLEN, ">>$dir/CURVED/CurvedLength");
open (my $LINEARLEN, ">>$dir/LINEAR/LinearLength");
open (my $FOLDEDLEN, ">>$dir/FOLDED/FoldedLength");
open (my $SSINFO, ">>$dir/SecondaryStr");

# Open file containg Epitope sequence                                         
                      
open ($EPITOPE, '<', "./stats/$infile") or die
    "Can not open file";

my @epitopeSequenceFile = <$EPITOPE>;

# Reading every PDB file in the directory 
foreach my $pdbFile (@dirFiles)
{

############
    my @antigen_DNA;
    my @antigen_protein;
    my %parsedData;
    my @distancesCalphaToLine;
    my @AlldistToLine;
    my @distToLine;
    my $antigen_chain_label;
    my $aligned_pdb ;
    my ($antigen_chain_label, $antigen_chian_type);
    my (@rangeRegion, @residueFragment) = ();
############

    chomp $pdbFile;
    my $epitopeInfo;

    # Looking for Epitope Sequence in the file                                
    foreach my $epitope (@epitopeSequenceFile)
    {
        chomp $epitope;

        if ($epitope =~ /$pdbFile/)
        {
            $epitopeInfo = $epitope;
        }
    }

    # Obtaining PDB file name, regions and fragments in variable
    my ($pdb_file, $regions, $fragments) = split (':', $epitopeInfo);
    
    if ($_ =~ /^Antibody/) # ignoring first line                              
    {
        next;
    }

    else
    {
	print "Processing ... $pdb_file\n";
        open (my $COMPLEX, $pdb_file) or die
            "Can not open $pdb_file"; # open PDB file                        
	chomp (my @dataArray = <$COMPLEX>);

        # Obtaining original antigen chain labels from processed PDB header
        my @antigenChains = getAntigenChains($pdb_file);

        # Making directory
        my ($pdb, $ext) = split('\.', $pdb_file);
        mkdir $pdb;
        chdir $pdb;
        
        ###############
	my $pdbFileName = basename($pdbFile, ".pdb");
	open (my $SUMRY, '>', $pdbFileName."_Summary.log") or 
	    die "can not open file $!";
        
        `mv ../AllDistances.txt ./`; 
	
        # To align the antibody structure around a center                 
        my $abalign = $SFPerlVars::abalign;
        $aligned_pdb = "aligned_".$pdb_file;
        `$abalign -k ../$pdb_file $aligned_pdb`;

        
        # To obtain the range on each epitopic region i.e, start and end  
	@rangeRegion = getRegionRange($regions);
   	print {$SUMRY} Dumper (\@rangeRegion); 	

	# To obtain all residues of fragments
	@residueFragment = getFragmentResidue($fragments);	    
	print {$SUMRY} Dumper (\@residueFragment);

        # To make pymol figure of antigen with highlighted regions in red 
        # and fragments in green 
	writepymolScript(\@rangeRegion, \@residueFragment,
                         \@antigenChains, $aligned_pdb, $pdb_file);
        
        # The array of arrays containing distances to straight line for
        # all epitopic regions in one antibody 
	my ($epitopeSSRef, $deviationsRef) = getDistanceToStraightLine 
	    (\@rangeRegion, \@dataArray, $antigen_chain_label, $pdb_file, $SUMRY, $dir, $REGLEN,
             $CURVEDLEN, $LINEARLEN, $FOLDEDLEN, $SSINFO);
            
           # Dereferencing.. 
#	my @distancesCalphaToLineRef = @{$distancesCalphaToLine};
	my @epitopeSS = @{$epitopeSSRef}; 
		    
	    # Print Array of SS and Distances
	    printArrays (\@epitopeSS, $deviationsRef, $pdb_file, $ALL);

	    # Hash of arrays to store regions corresponding to an antibody
#	    $distances{$pdb_file} = [@{$distancesCalphaToLine}];
	    `mv AllDistances.txt ../`;
	    chdir '../';
	
    }

    unlink "AllCAcoords.pdb";
#    last;
  
} # Foreach loop ends... 

################### Main Endssss ###############

open (my $OUT, ">./$pdb/DistanceToRegressionLine.txt") or
    die ("Can not open file for writing\n");

foreach my $key (keys %distances)
{

print $OUT "$key: ",  Dumper ($distances{$key});


}


########### Methods ###############

