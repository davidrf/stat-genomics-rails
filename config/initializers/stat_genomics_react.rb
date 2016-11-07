module StatGenomicsReact
  class << self
    def base_url
      "#{STAT_GENOMICS_REACT_PROTOCOL}://#{STAT_GENOMICS_REACT_URL}"
    end

    def cors_urls
      [base_url, STAT_GENOMICS_REACT_URL]
    end
  end
end
