# Class Base finder
class BaseFinder
  DEFAULT_PER_PAGE = 10

  attr_reader :collection

  def self.call(*args)
    instance = new(*args)
    instance.call
    instance
  end

  def initialize(filters)
    @filters = filters
  end

  def call
    load_collection

    self
  end

  def page
    filter_by(:page)&.to_i || 1
  end

  def per_page
    filter_by(:per_page)&.to_i || DEFAULT_PER_PAGE
  end

  def total
    return 0 if @collection.blank?

    @total ||= @collection.count
  end

  def meta
    {
      page: page,
      per_page: per_page,
      total: @total
    }
  end

  protected

  def load_collection
    @collection = nil
  end

  # Internal: check if filter by param specified
  #   param_name - name of filters param
  #
  # Returns Boolean
  def filtered_by?(param_name)
    filter_by(param_name).present?
  end

  # Internal: filter value for parameter
  #   param_name - name of filters param
  #
  # Returns String
  def filter_by(param_name)
    @filters[param_name]
  end
end
