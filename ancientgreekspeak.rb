#!/usr/bin/env ruby

require 'i18n'

Encoding.default_external = Encoding::UTF_8

# Usage: Takes Unicode Polytonic Greek on STDIN or as arguments, outputs
# phonetic pronunciation on STDOUT designed to be piped into the Mac `say` command.
# e.g.:
# echo 'ἄγω ἄξω ἤγαγον ἦχα ἤγμαι ἤχθην' | ./ancientgreekspeak.rb | say
#
# Apple docs:
# https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/SpeechSynthesisProgrammingGuide/Phonemes/Phonemes.html
# https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/SpeechSynthesisProgrammingGuide/FineTuning/FineTuning.html

accent_table = {
"\u{0313}": '', # smooth breathing
"\u{0314}": 'h', # rough breathing
"\u{0342}": '1', # circumflex
"\u{0301}": '1', # acute
"\u{0300}": '1' # grave
}

digraph_table = {
'γγ': 'N',
'γκ': 'Nk',
'γμ': 'Nm',
'γξ': 'Nks',
'γχ': 'Nk',
'ηι': 'IX',
'ηυ': 'UW',
'ει': 'EY',
'ευ': 'UW',
'οι': 'OY',
'αι': 'AY',
'αυ': 'AW' # or AO?
}

phoneme_table = {
'α': 'AA',
'β': 'b',
'γ': 'g',
'δ': 'd',
'ε': 'IX', # EY IX EH
'ζ': 'sd',
'η': 'EH',
'θ': 'Th',
'ι': 'IH',
'κ': 'k',
'λ': 'l',
'μ': 'm',
'ν': 'n',
'ξ': 'ks',
'ο': 'AO',
'π': 'p',
'ρ': 'r',
'σ': 's',
'ς': 's',
'τ': 't',
'υ': 'UW',
'φ': 'f',
'χ': 'k',
'ψ': 'ps',
'ω': 'OW',
';': '?',
'·': ';'
}

ARGF.each_line do |line|
  transliterated_words = []
  nfd = line.unicode_normalize(:nfc).downcase.unicode_normalize(:nfd)
  nfd.squeeze(' ').split(' ').each do |word|
    # change iota subscript to adscript
    word.gsub!("\u{0345}": 'ι')
    # move breathings and accents in front of vowels
    word.gsub!(/(ει|ευ|οι|αι|αυ|α|ε|η|ι|ο|υ|ω)([\u{0300}\u{0301}\u{0313}\u{0314}]+)/,"\\2\\1")
    [accent_table, digraph_table, phoneme_table].each do |lookup_table|
      lookup_table.each do |key, value|
        word.gsub!(key.to_s,value.to_s)
      end
    end
    transliterated_words << word
  end
  puts '[[inpt PHON]]' + transliterated_words.join(' ')
end