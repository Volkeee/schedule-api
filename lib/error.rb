class Error
  def self.unauthorized
    { response: {
      code: 401,
      name: 'Not authorized',
      description: 'Need to authorize to view this page!'
    } }
  end

  def self.not_found
    { response: {
      code: 404,
      name: 'Not found',
      description: 'Resource does not exist!'
    } }
  end

  def self.conflict
    { response: {
      code: 409,
      name: 'Resource conflict',
      description: 'Info already exist. Try different one'
    } }
  end
end
