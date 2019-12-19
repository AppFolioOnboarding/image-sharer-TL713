module PageObjects
  class Document < AePageObjects::Document
    def flash_message
      notice.text
    end
  end
end

