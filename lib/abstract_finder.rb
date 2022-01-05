require_relative 'abstract_finder/base_finder'

# AbstractFinder
class AbstractFinder < BaseFinder
  attr_reader :model, :associations

  SORT = %w[asc desc].freeze

  def self.call(model, associations = [], args = [])
    new(model, associations, args).call
  end

  def initialize(model, associations, args) # rubocop:disable Lint/MissingSuper
    @model = model
    @associations = associations
    @filters = args
  end

  def call
    load_collection

    self
  end

  protected

  def load_collection
    base_collection
    query if @filters[:q].present? && @collection.respond_to?(:search_by)
    order if @filters[:order].present?
    filter if @filters[:filter_by].present? && @collection.respond_to?(:filter_by)
    total
    finalize_collection
  end

  def base_collection
    @collection = model.all.includes(associations)
  end

  def finalize_collection
    @collection = @collection.page(page).per(per_page)
  end

  # define #search_by method in query model and use this finder
  def query
    @collection = @collection.includes(associations).search_by(@filters[:q]) if @collection.respond_to? :search_by
  end

  def filter; end

  def order
    @collection = @collection.order(created_at: @filters[:order])
  end
end
