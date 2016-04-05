
require_relative 'TF1SearchProvider'

term = ARGV[0]
#puts term
#puts quality

provider = TF1SearchProvider.new()

provider.search(term)