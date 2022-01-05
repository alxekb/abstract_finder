## AbstractFinder

### API wrapper for search, pagination, filter.

General idea to pass query, relations to avoid N+1 and permitted params to paginate, filter and sort AbstractFinder collection.


``` ruby
class RecordsContrroller < Api::BaseController
  def index
  finder = AbstractFinder.call(
    Record.latest, # scope, method or class
    %w[rating status],
    params
  )

  render json: RecordSerializer.new(
    finder.collection,
    { meta: finder.meta, params: permitted_params }
  ).serializable_hash

  private

  def params
    params.require(:record).permit(:page, :per_page, :search_by, :q, :order_by)
  end
end
```
