class DataParsingService

  def initialize(data)
    @data = data.read
  end

  def parse
    if @data.strip.blank?
      raise Exceptions::InvalidData.new("File must contain some data.")
    end
    @data.split(/\n/)
  end

end