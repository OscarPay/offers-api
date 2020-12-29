# https://blog.saeloun.com/2019/10/28/bind-parameters-in-activerecord-sql-queries.html
# https://blog.lunarcollective.co/writing-sql-in-rails-speed-vs-convenience-e5d8c0ec25d9
# http://jameshuynh.com/rails/paginate/find_by_sql/2017/09/30/how-to-paginate-rails-find-by-sql-result/

class SearchOffersService

  def initialize
    @per_page = 5
  end

  def call(params)
    query = params[:query]
    user_id = params[:user_id]
    sort = params[:sort] || 'ASC'
    page = params[:page].to_i || 1

    user = User.find(user_id)
    search_query(user_id, user.company, "ASC", page, query)
  end

  private

  def search_query(user_id, user_company, sort, page, query)
    # binds = [
    #   ActiveRecord::Relation::QueryAttribute.new(
    #   "id", 6, ActiveRecord::Type::Integer.new
    #   )
    # ]

    sql = %(
      WITH u_departments AS (SELECT * FROM user_departments WHERE user_id = $1),
      joined_table AS (
        SELECT offers.id, offers.price, offers.company, 'perfect_match' as label, 1 as priority FROM offer_departments
        JOIN offers ON offers.id = offer_departments.offer_id
        WHERE company = $2
        AND department_id IN (SELECT department_id FROM u_departments)
        GROUP BY offers.id
        UNION ALL
        SELECT id, price, company, 'good_match' as label, 2 as priority FROM offers WHERE company = $2
        UNION ALL
        #{offers_query(query).to_sql}
      )
      SELECT * FROM joined_table ORDER BY priority, price ASC LIMIT $3 OFFSET $4
    )

    ActiveRecord::Base.connection.exec_query(
      sql,
      'Search offers',
      [
        [nil, user_id],
        [nil, user_company],
        [nil, @per_page],
        [nil, offset(page)]
      ]
      )
  end

  def offers_query(query)
    wildcard_search = "%#{query}%"
    Offer
      .select([:id, :price, :company, "'offer' as label", "'3' as priority"])
      .where('company ILIKE ?', wildcard_search)
  end

  def offset(page)
    (page - 1) * @per_page
  end

end