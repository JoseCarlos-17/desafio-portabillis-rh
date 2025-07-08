module Authorization
  def verify_is_client
    if !current_user.client?
      render json: {
        message: 'Você não tem permissão para acessar a este recurso.'
      },
      status: :forbidden
    end
  end

  def verify_is_manager
    if !current_user.manager?
      render json: {
        message: 'Você não tem permissão para acessar a este recurso.'
      },
      status: :forbidden
    end
  end
end