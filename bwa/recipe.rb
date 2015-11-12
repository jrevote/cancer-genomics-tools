class BWA < FPM::Cookery::Recipe
  description 'BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome.'
  name 'bwa'
  version '0.7.12' 
  revision 0
  homepage 'http://bio-bwa.sourceforge.net/'
  source "http://sourceforge.net/projects/bio-bwa/files/bwa-#{version}.tar.bz2"
  md5 '075704634146ec8cc7543c0dee8960e7'

  # Build Dependencies:
  build_depends ['gcc']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install 'bwa'
  end
end
