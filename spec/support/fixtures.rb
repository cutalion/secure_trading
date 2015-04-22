module Fixtures
  def good_response_xml
    File.read(File.expand_path('../../fixtures/good_response.xml', __FILE__))
  end
end
