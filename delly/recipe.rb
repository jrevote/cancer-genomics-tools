class Delly2 < FPM::Cookery::Recipe
  description 'Delly2 is an integrated structural variant prediction method that can discover and genotype deletions, tandem duplications, inversions and translocations at single-nucleotide resolution in short-read massively parallel sequencing data.'
  name 'delly'
  version '0.7.1'
  revision 0
  homepage 'https://github.com/tobiasrausch/delly'
  source "https://github.com/tobiasrausch/delly/releases/download/v#{version}/delly_v#{version}_linux_x86_64bit"

  # Build:
  def build
  end

  # Install:
  def install
    safesystem "mv delly_v#{version}_linux_x86_64bit delly"
    chmod 0755, 'delly'
    bin.install 'delly'
  end
end
