class Api::V1::GridsController < Api::V1::BaseController
  def index
    @rows = Grid.all.order("index ASC, row ASC").includes(:animals, :ressources, :plants, :islands).group_by(&:index)

    # cache = CachedView.find_by(name: 'MAIN')

    # unless cache
      payload = render_to_string :index
      # cache = CachedView.create(name: 'MAIN', payload: payload)
    # end

    # render json: JSON.parse(cache.payload)

    render :index
  end
end
