require 'datahub/version'

module DataHub
  STORE_LOCAL = "store_local"
  STORE_DROPBOX = "store_dropbox"

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.bin
    File.join root, 'bin'
  end

  def self.lib
    File.join root, 'lib'
  end
end

