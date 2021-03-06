# wkhtml2pdf Ruby interface
# http://code.google.com/p/wkhtmltopdf/

require 'logger'

class WickedPdf
  attr_accessor :exe_path, :log_file, :logger

  def initialize
    @exe_path = `which wkhtmltopdf`.chomp
    @log_file = "#{RAILS_ROOT}/log/wkhtmltopdf.log"
    @logger   = RAILS_DEFAULT_LOGGER
  end

  def pdf_from_string(string)
    path = @exe_path
    # Don't output errors to standard out
    path << ' -q'

    logger.info "\n\n-- wkhtmltopdf command --"

    tmp_file = "tmp/wkhtmltopdf-#{rand(42)}.html"
    File.open(tmp_file, "w") { |f| f.write(string) }
    path = "#{path + ' ' + tmp_file + ' -'}"

    logger.info path
    logger.info ''

    pdf = `#{path}`
    File.delete(tmp_file)
    pdf
  end
end
