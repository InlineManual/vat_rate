module VatRate
  class FileStore

    def initialize(file)
      @file = file
    end

    def read
      File.read(@file)
    end

  end
end
