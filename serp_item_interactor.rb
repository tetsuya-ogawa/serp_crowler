class SerpItemInteractor
  def initialize(repository, presenter)
    @repository = repository
    @presenter = presenter
  end

  def run(kws, domains)
    results = []
    kws.each do |kw|
      results << @repository.fetch(kw: kw)
      puts "#{kw} is done"
      STDOUT.flush
      sleep(45)
    end
    @presenter.run(serp_items: results.flatten, column_domains: domains)
  end
end
