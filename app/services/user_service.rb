class UserService
  
  def find_by_username(username)
    User.find_by(username: username)
  end

  def find_by_id(id)
    User.find(id)
  end

  def save(params)
    user = User.create(params)
  end

  def update_by_id(id, params)
    user = User.find(id)
    user.update(params)
    user
  end

  def delete_by_id(id)
    User.delete(id)
  end
end
