require 'net/http'
require 'uri'
require 'json'
if ARGV.length<1
	puts "Too little arguments!\nUsage:\nruby gtranslate <text> [lang_from] [lang_to]\nDefault: en -> pl"
	exit
else
	text = ARGV[0]
	lang_to = 'pl'
	lang_from = 'en'
	if ARGV.length == 3
		lang_to = ARGV[2]
		lang_from = ARGV[1]
	elsif ARGV.length == 2
		lang_from = ARGV[1]
	end
end
jsonres = Net::HTTP.post_form(URI.parse('http://ajax.googleapis.com/ajax/services/language/translate'),{'v'=>'1.0','q'=>text,'langpair'=>lang_from+'|'+lang_to})
translation = JSON.parse(jsonres.body)

if translation['responseStatus'] == 200
	puts "Translation: "+'['+lang_from+'] '+text+' -> ['+lang_to+'] '+translation['responseData']['translatedText']
else
	puts translation['responseDetails']
end
