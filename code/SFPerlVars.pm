package SFPerlVars;

# Where this file lives

$libdir = "/home/bsm/ucbterd/scripts/lib";

# Data
$datadir = "/acrm/www/html/abs/abdb/data";

# Tmp dir
$tmpdir = "/tmp/SF";

# About the PDB
$pdbdir       = "/acrm/data/pdb";
#$pdbdir = "/acrm/nouf2data1/acrm8/data/pdb";
$pdbprep      = "/acrm/data/pdb/pdb";
#$pdbprep = "/acrm/nouf2data1/acrm8/data/pdb/pdb";
$pdbprepname  = "pdb";
$pdbext       = ".ent";

# Obsolete PDB
$obspdbdir = "/acrm/data/pdb_obsolete/uncompressed_files";
$obspdbprep = "pdb";
$obspdbext = ".ent";

# Other PDB-related files
$pdbdomdir = "/acrm/data/dompdb";
$domsstdir = "/acrm/data/domsst";
$sstdir    = "/acrm/data/sst";
$pdbseqdir = "/acrm/data/pdbseq";
$pisadir   = "/acrm/data/pisa";
$pisaext   = ".pisa";
$xmasdir   = "/acrm/data/xmas/pdb";
$xmasprep  = "/acrm/data/xmas/pdb/pdb";
$xmasext   = ".xmas";

# makepatch and related
$makepatch = "/home/bsm/martin/bin/makepatch";
$xmas2pdb  = "/home/bsm/martin/acrm/CONSULTANCY/inpharmatica/software/xmas2pdb/xmas2pdb";

$radii_file = "/acrm/data/people/zcbtfo4/radii.dat";
$pdb2xmas   = "/home/bsm/martin/acrm/CONSULTANCY/inpharmatica/software/pdb2xmas/pdb2xmas";

# Command-line program paths for pdb and related classes
$getresol = '/home/bsm/martin/bin/getresol';
$getchainlist = '/home/bsm/martin/bin/getchainlist';
$pdbgetchain = '/home/bsm/martin/bin/pdbgetchain';
$chaincontacts = '/home/bsm/martin/bin/chaincontacts';
$countpdb = '/home/bsm/martin/bin/countpdb';
$idabchain ='/home/bsm/martin/bin/idabchain';
$renumpdb = '/home/bsm/martin/bin/renumpdb';
$kabatnum = '/home/bsm/martin/abnum/installed/numbering/kabatnum.pl';
#$kabatnum = '~/allscript/bin/kabatnum_saba.pl';
$getpdb = '/home/bsm/martin/bin/getpdb';
$chaintype = '/home/bsm/martin/bin/chaintype';
$abalign = '/home/bsm/martin/bin/abalign';
$xmastoss = '/home/bsm/martin/scripts/xmastoss.pl';
$pdbline = '/home/bsm/martin/bin/pdbline';
$resdist = '/home/bsm/martin/bin/resdist'; 
$pdbatoms = '/home/bsm/martin/bin/pdbatoms';
$pdbsplitchains = "/home/bsm/martin/bin/pdbsplitchains"; 
$hashapten = "/home/bsm/martin/bin/hashapten";
$abnr = '/home/bsm/martin/scripts/abnr/abnr.pl';

# My normal binaries directory
$bindir  = "/home/bsm/martin/bin";

# Other binaries directories
$ssapbindir = "/acrm/home/andrew/ssap/bin";
$mlsabindir = "/acrm/home/andrew/mlsa";
$sstrucbindir = "/acrm/home/andrew/sstruc/bin";

# Environment variables for Kabat related programs
#$ENV{'KABATALIGN'} = "/acrm/home/andrew/kabat/data"; # Alignment matrices
#$ENV{'KABATDIR'}   = "/acrm/data/kabat/kabatman";    # KabatMan data 
$ENV{'KABATALIGN'} = "/home/bsm/martin/kabat/data"; # Alignment matrices
$ENV{'KABATDIR'}   = "/home/bsm/martin/kabat/data";    # KabatMan data 



# My general data directory
#$ENV{'DATADIR'}    = "/home/bsm/";
$ENV{'DATADIR'} = "/home/bsm/martin/data";

# BLAST related
$BlastAllExe       = "/acrm/usr/local/bin/blastall";
$BlastPGPExe       = "/acrm/usr/local/bin/blastpgp";
$BlastDBDir        = "/acrm/data/blastdb";
$BlastRCFile       = "/acrm/home/andrew/.ncbirc";

# FASTA related
$ssearch = "/acrm/usr/local/bin/ssearch33";
$fasta   = "/acrm/usr/local/bin/fasta33";
$ssearch_64 = "/acrm/usr64/local/bin/ssearch33";
$fasta_64   = "/acrm/usr64/local/bin/fasta33";

# PostgreSQL related
$pghost = "acrm8";
$psql   = "/acrm/usr/local/bin/psql";

$ENV{'PGHOST'} = $pghost;
$ENV{'PGLIB'} = "/usr/lib/pgsql";
$ENV{'LD_LIBRARY_PATH'} = "$ENV{'LD_LIBRARY_PATH'}:/usr/lib/pgsql";


1;

