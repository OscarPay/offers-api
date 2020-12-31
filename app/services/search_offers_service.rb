class SearchOffersService
  class SearchOffersServiceError < StandardError; end

  def initialize(service = IntrosService, generator = GenerateValuesQuery)
    @sort_opts = %w[ASC DESC]
    @service = service
    @generator = generator
  end

  def call(params)
    query = params[:query]
    user_id = params[:user_id]
    sort = params[:sort] || 'ASC'
    page = params[:page] || 1
    departments_id = params[:department_id] || []

    unless user_id
      raise SearchOffersServiceError.new 'user_id is required'
    end

    unless @sort_opts.include?(sort.upcase)
      raise SearchOffersServiceError.new "sort allowed values: #{@sort_opts.join(', ')}"
    end

    intros = @service.call
    intros_sql = @generator.new.call(intros['intros'].slice(0, 5))

    user = User.find(user_id)
    SearchOffersQuery.new(user).call(sort, page.to_i, query, departments_id, intros_sql)
  end

end