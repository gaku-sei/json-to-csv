require_relative 'lib'
require 'test/unit'

class TestJSONToCSV < Test::Unit::TestCase
  def setup
    @elements = [{
      'id' => 0,
      'name' => 'foobar',
      'roles' => ['admin', 'developer'],
      'pictures' => {
        'main' => {
          'id' => 0,
          'url' => 'http://...'
        }
      }
    }]

    @formatted_element = [0, 'foobar', 'admin,developer', 0, 'http://...']

    @headers = [['id'], ['name'], ['roles'],
                ['pictures', 'main', 'id'], ['pictures', 'main', 'url']]

    @formatted_headers = ['id', 'name', 'roles', 'pictures.main.id', 'pictures.main.url']
  end

  def test_build_headers
    assert_equal(@headers, build_headers(@elements))
  end

  def test_format_headers
    assert_equal(@formatted_headers, format_headers(@headers))
  end

  def test_format_element
    assert_equal(@formatted_element, format_element(@headers, @elements.first))
  end
end
