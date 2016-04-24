# Will recursively build the CSV headers
def build_headers(elements, check_all = false)
  def rec(h, root)
    h.map do |(key, val)|
      val.is_a?(Hash) ? rec(val, "#{root}/#{key}") : "#{root}/#{key}"
    end.flatten
  end

  rec(elements.first, '').map { |header| header[1..-1].split '/' }
end

# Formats the header elements
def format_headers(headers)
  headers.map { |header| header.join('.') }
end

# Formats an element according to the provided headers
def format_element(headers, element)
  headers.map do |header|
    v = element.dig(*header)
    v.is_a?(Array) ? v.join(',') : v
  end
end
