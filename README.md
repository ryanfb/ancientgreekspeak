# ancientgreekspeak

Usage: Takes Unicode Polytonic Greek on STDIN or as arguments, outputs
phonetic pronunciation on STDOUT designed to be piped into the Mac `say` command.
e.g.:

    echo 'ἄγω ἄξω ἤγαγον ἦχα ἤγμαι ἤχθην' | ./ancientgreekspeak.rb | say

Apple docs:
* <https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/SpeechSynthesisProgrammingGuide/Phonemes/Phonemes.html>
* <https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/SpeechSynthesisProgrammingGuide/FineTuning/FineTuning.html>
