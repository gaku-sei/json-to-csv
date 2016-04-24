ERRORS = {
  no_args: {
    code: 1,
    message: 'You must provide a path to the JSON file you want to convert'
  },
  ruby_version: {
    code: 2,
    message: 'Please use ruby 2.3.*'
  },
  file_does_not_exist: {
    code: 3,
    message: 'The file %{filepath} does not exist'
  },
  array: {
    code: 4,
    message: 'The parsed JSON file should resolve to an array'
  },
  parse_error: {
    code: 5,
    message: 'Could not parse the JSON file'
  }
}

def exit_gently(name, options = {})
  error = ERRORS[name]
  STDERR.puts error[:message] % options
  exit error[:code]
end
