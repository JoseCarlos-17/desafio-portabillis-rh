class UserFiltersQuery
  attr_accessor :clients, :params

  def initialize(clients = User.all, params)
    @clients = clients
    @params = params
  end

  def call
    clients = @clients.where(access_level: 'client')

    clients = filter_by_name(clients) if params[:by_name]
    clients = filter_by_email(clients) if params[:by_email]
    clients = order_list_by(clients) if params[:order_by]

    clients
  end

  private

  def filter_by_name(list)
    list.where(name: params[:by_name])
  end

  def filter_by_email(list)
    list.where(email: params[:by_email])
  end

  def order_list_by(list)
    list.order(params[:order_by] => :desc)
  end
end