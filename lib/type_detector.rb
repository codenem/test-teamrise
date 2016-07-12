require 'csv'

module TypeDetector
  FREQUENCIES_REGEX = Regexp.new(I18n.t('datetime.prompts').values.map(&:downcase).join('|'))
  NUMBERS_REGEXP = /(?<!\d)(\d{1,3}([\.,]\d{1,3})*)(?!\d)/
  UNITS_REGEXP = /[a-zA-Z]\p{Sc}|%/

  def self.detect(string)
    string = string.downcase
    values = string.scan(NUMBERS_REGEXP).map(&:first)
    unit = string.scan(UNITS_REGEXP).first
    frequency = string.scan(FREQUENCIES_REGEX)

    if values.size == 1
      start = 0
      target = values.first
    end

    if values.size == 2
      start = values.first
      target = values.second
    end

    [
      ['objectif',
        target ? 'chiffré' : 'à action unique',
        frequency.present? ? 'récurrent' : ''].join(' '),
      start,
      target,
      unit
    ]
  end

  def self.results(strings)
    results = []
    strings.each do |s|
      results << detect(s).unshift(s)
    end
    results
  end

  def self.csv_results(results)
    File.delete('results.csv') if File.exists?('results.csv')
    CSV.open('results.csv', 'w') do |csv|
      csv << ['title', 'type', 'progress_start', 'progress_target', 'progress_unit']
      results.each {|r| csv << r }
    end
  end
end
