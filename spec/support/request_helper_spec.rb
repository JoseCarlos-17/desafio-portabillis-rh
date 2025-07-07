def json_body
  JSON.parse(response.body, symbolize_names: true)
end

def get_headers(user)
  post '/auth/sign_in',
  params: { email: user.email, password: user.password },
  as: :json

  {
    'access-token': response.headers['access-token'],
    'client': response.headers['client'],
    'uid': response.headers['uid'],
    'expiry': response.headers['expiry'],
    'token-type': response.headers['token-type']
  }
end