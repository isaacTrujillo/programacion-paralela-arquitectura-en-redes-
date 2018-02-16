require_relative 'manage_services'

def insert_user(user)
  dataset = ManageServices.instance.db[:users]
  dataset.insert(name: user[:name], userName: user[:userName],
                 email: user[:email])
end

def insert_site(site)
  dataset = ManageServices.instance.db[:sites]
  dataset.insert(name: site[:name], url: site[:url])
end

def insert_registry(data)
  dataset = ManageServices.instance.db[:user_has_accounts]
  dataset.insert(userName: data[:userName],
                 password: data[:password],
                 userID: user_id(data), siteID: site_id(data))
end

def user_id(data)
  ManageServices.instance.db[:users].where(name: data[:name]).first[:id]
end

def site_id(data)
  ManageServices.instance.db[:sites].where(name: data[:site]).first[:id]
end

def change_user_email(user, new_email)
  dataset = ManageServices.instance.db[:users].where(name: user)
  dataset.update(email: new_email)
end

def get_users_from_site(site)
  site_id = ManageServices.instance.db[:sites].where(name: site).first[:id]
  dataset = ManageServices.instance.db[:user_has_accounts]
                          .join(:users, id: :userID).where(siteID: site_id)
  users = []
  dataset.each do |r|
    users.push r[:name]
  end
  users
end

def get_sites_from_user(user)
  user_id = ManageServices.instance.db[:users].where(name: user).first[:id]
  dataset = ManageServices.instance.db[:user_has_accounts]
                          .join(:sites, id: :siteID).where(userID: user_id)
  sites = []
  dataset.each do |r|
    sites.push r[:name]
  end
  sites
end

def all_users_sites
  dataset = ManageServices.instance.db[:user_has_accounts]
                          .join(:users, id: Sequel[:user_has_accounts][:userID])
                          .join(:sites, id: Sequel[:user_has_accounts][:siteID])
  return_infomation(dataset)
end

def return_infomation(dataset)
  data = []
  select_info(dataset).each do |r|
    data.push "name: #{r[:user]}, user name: #{r[:userName]}," \
              "password: #{r[:password]} , site: #{r[:siteName]}."
  end
  data
end

def select_info(dataset)
  dataset.select(Sequel[:users][:name].as(:user),
                 Sequel[:user_has_accounts][:userName],
                 :password,
                 Sequel[:sites][:name].as(:siteName))
end

# Example of insert_user
# insert_user({:name => 'Carlos',:userName => 'carXer',
#              :email => 'Carlos@gmail.com'})

# Example of insert_site
# insert_site({:name => 'instagram',:url => 'https://instagram.com'})

# Example of insert_registry
# insert_registry({:userName =>'Carloins',:password => 'Carlos123',
#                  :name => 'Carlos',:site => 'instagram'})

# Example of change_user_email
# change_user_email('Julio','julio@gmail.com.com')

# Example of getting users from site
# puts get_users_from_site('youtube')

# Example of getting sites from users
# puts get_sites_from_user('Carlos')

# Example of getting all users and sites
puts all_users_sites
