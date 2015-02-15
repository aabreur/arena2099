require 'mongoid'
require 'pry'
require 'json'

Mongoid.load!("mongoid.yml", :development)

class Fighter
	include Mongoid::Document
	field :name, type: String
	field :title, type: String
	field :pic, type: Hash
	field :strenght, type: Integer, default: ->{ rand(5..20) }
	field :age, type: Integer, default: ->{ rand(19..23) }
	field :salary, type: Integer, default: 2000
	field :wins, type: Integer, default: 0
	field :losses, type: Integer, default: 0
	field :tags, type: Array, default: []

	def self.gen(type = "dwarf") 
		prot = JSON.parse(IO.read("prototypes.json"))[type]
		pic = prot['pic']
		pic["frames"].map! do |frame|
			puts "#{frame['image']}"
			frame.tap do |f|
				f["filters"].map! do |filter|
					lower = filter["value"][0]
					higher = filter["value"][1]
					puts "#{filter['function']} #{lower} -> #{higher}"
					filter.merge( "value" => rand(lower..higher))
				end
			end
		end
		new({
			name: "#{prot['names'].sample} #{prot['surnames'].sample}",
			title: "#{prot['title_prefixes'].sample} #{prot['title_suffixes'].sample}",
			pic: pic
		})
	end
end
