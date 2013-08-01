require "datahub/plugin/scrap"
require "tempfile"

module DataHub::Plugins
  
  class SpeakerDeck
    include DataHub::Plugin::Scrap

    INDEX_PATH = "SpeakerDeck/index.dat"
    
    def coll_name
      "speakerdeck"
    end

    def execute(coll)
      @attributes[:urls].each do |url|
        get_content url
      end
    end

    private
    def get_content(url)
      file_paths = Hash.new
      index, = dropbox_download INDEX_PATH
      if index
        file_paths = Marshal.load(index)
      end
      
      doc = get_doc url
      doc.xpath('//div[@class="talk public"]').each do |node|
        data_id = node.attribute("data-id").value
        title_node = node.xpath('div[@class="talk-listing-meta"]/h3/a')
        title = title_node.text
        href = title_node.attribute("href").value

        blank, user_name, file_name = href.split("/")
        dropbox_path = "SpeakerDeck/#{user_name}_#{file_name}.pdf"
        old_path = "SpeakerDeck/old/#{user_name}_#{file_name}.pdf"

        unless file_paths[dropbox_path]
          puts "[NEW] #{href}"
          temp = Tempfile.new(data_id)

          dl_doc = get_doc "https://speakerdeck.com#{href}"
          dl_doc.xpath('//a[@id="share_pdf"]').each do |dl_node|
            dl_href = dl_node.attribute("href").value
            download(dl_href, temp)
            dropbox_add(temp, dropbox_path, true)
            temp.close(true)

            DataHub::Helpers::write_pubsub_message(@attributes[:pubsub_to],
                                                   "#{dropbox_path} #{title}"
                                                   )
            file_paths[dropbox_path] = 1
          end
        else
          puts "      #{href}"
        end
      end
      temp_index = Tempfile.new("index")
      temp_index.puts Marshal.dump(file_paths)
      temp_index.close
      dropbox_add(temp_index, INDEX_PATH, true)
    end
    
  end
end
