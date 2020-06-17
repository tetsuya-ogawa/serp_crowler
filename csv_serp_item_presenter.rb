require 'csv'

class CsvSerpItemPresenter
  def self.run(serp_items:, column_domains:)
    columns = column_domains.dup.prepend('kw')
    serp_items_with_kw = serp_items.group_by {|i| i.kw}
    CSV.open('./outputs.csv','w', encoding: "SJIS") do |table|
      table << columns
      serp_items_with_kw.each do |kw, serp_items|
        table << [].tap do |me|
          me << kw
          column_domains.each do |domain|
            me << (serp_items.find{|item| item.url.include?(domain) }&.rank || 30)
          end
        end
      end
     end
  end
end
