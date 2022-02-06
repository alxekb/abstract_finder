## AbstractFinder

### API wrapper for search, pagination, filter.

General idea to pass a query, relations to avoid N+1 and permitted params to paginate, filter and sort AbstractFinder collection.


``` ruby
class RecordsContrroller < Api::BaseController
  def index
    finder = AbstractFinder.call(
      Record.latest,     # scope, method or a class
      %w[rating status], # to fight N+1
      params             # permitted params for pagination, filtering, ordering and search
    )

    render json: RecordSerializer.new(
      finder.collection,
      { meta: finder.meta, params: permitted_params }
    ).serializable_hash
  end

  private

  def params
    params.require(:record).permit(:page, :per_page, :search_by, :q, :order_by)
  end
end
```
