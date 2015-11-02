class Tabix < FPM::Cookery::Recipe
  description 'Tabix indexes a TAB-delimited genome position file in.tab.bgz and creates an index file ( in.tab.bgz.tbi or in.tab.bgz.csi ) when region is absent from the command-line. '
  name 'delly'
  version '0.2.6'
  revision 0
  homepage 'http://sourceforge.net/projects/samtools/files/tabix/'
  source "http://sourceforge.net/projects/samtools/files/tabix/tabix-#{version}.tar.bz2"

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'zlib1g-dev']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install ['tabix', 'bgzip']
  end
end
