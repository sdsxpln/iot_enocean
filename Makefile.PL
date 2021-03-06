use 5.014002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'enoceaniot',
    VERSION_FROM      => 'lib/enoceaniot.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/enoceaniot.pm') : ()), # retrieve abstract from module
    LIBS              => [''], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I. -I../gtw -I../gtw/src -I../gtw/lib', # e.g., '-I. -I/usr/include/other'
    MYEXTLIB          => '../gtw/src/build/libiotf.so',
    # Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(),
              {name=>"CONFIG_FILE_ERROR", macro=>"1"},
              {name=>"MISSING_INPUT_PARAM", macro=>"1"},
              {name=>"QUICKSTART_NOT_SUPPORTED", macro=>"1"});
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'enoceaniot',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
