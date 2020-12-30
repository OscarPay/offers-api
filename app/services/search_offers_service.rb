class SearchOffersService

  def call(params)
    query = params[:query]
    user_id = params[:user_id]
    sort = params[:sort] || 'ASC'
    page = params[:page].to_i || 1
    departments_id = params[:department_id] || []

    user = User.find(user_id)
    SearchOffersQuery.new(user).call(sort, page, query, departments_id)
  end

end