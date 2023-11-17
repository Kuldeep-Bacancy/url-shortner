class ShortCode
  # What is Base62:- https://dev.to/joshduffney/what-is-base62-conversion-13o0

  ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  BASE = ALPHABET.length

  def self.encode(number)
    result = ''
    while number > 0
      result += ALPHABET[number % BASE]
      number /= BASE
    end
    result.reverse
  end

  def self.decode(string)
    result = 0

    string.to_s.reverse.each_char.with_index do |char, index|
      power = BASE**index
      index = ALPHABET.index(char)
      result += index * power
    end
    result
  end
end
