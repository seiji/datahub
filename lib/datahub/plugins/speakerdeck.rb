require "datahub/plugin/scrap"
require "tempfile"

module DataHub::Plugins
  
  class SpeakerDeck
    include DataHub::Plugin::Scrap

    def coll_name
      "speakerdeck"
    end

    def execute(coll)
      @attributes['urls'].each do |url|
        get_content url
      end
    end

    private
    def get_content(doc)
      doc.xpath('//div[@class="talk public"]').each do |node|
        data_id = node.attribute("data-id").value
        title_node = node.xpath('div[@class="talk-listing-meta"]/h3/a')
        title = title_node.text
        href = title_node.attribute("href").value

        blank, user_name, file_name = href.split("/")
        dropbox_path = "SpeakerDeck/#{user_name}/#{file_name}.pdf"

        unless dropbox_metadata dropbox_path
          puts "[NEW] #{href}"
          temp = Tempfile.new(data_id)

          dl_doc = get_doc "https://speakerdeck.com#{href}"
          dl_doc.xpath('//a[@id="share_pdf"]').each do |dl_node|
            dl_href = dl_node.attribute("href").value
            download(dl_href, temp)
            dropbox_add(temp, dropbox_path)
            temp.close(true)

            DataHub::Helpers::write_pubsub_message(@attributes[:pubsub_to],
                                                   "[SpeakerDeck] #{title} #{dropbox_path}"
                                                   )

          end
          sleep 1
        else
          puts "      #{href}"
        end
      end
    end
  end
end
