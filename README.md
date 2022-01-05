## AbstractFinder

### API wrapper for search, pagination, filter.

General idea to pass query, relations to avoid N+1 and permitted params to paginate, filter and sort AbstractFinder collection.


class RecordsContrroller << Api::BaseController
  def index
  finder = AbstractFinder.call(
    query,
    [:rating],
    params
  )

  render json: RecordSerializer.new(
    finder.collection,
    { meta: finder.meta, params: permitted_params }
  ).serializable_hash
end
