class OpenIdRequest < ActiveRecord::Base
  
  validates_presence_of :token
  validates_presence_of :parameters
  
  before_validation :make_token, :on => :create
  
  serialize :parameters, Hash
  
  def parameters=(params)
    self[:parameters] = params.is_a?(Hash) ? params.delete_if { |k,v| k.index('openid.') != 0 } : nil
  end
  
  def from_trusted_domain?
    host = URI.parse(parameters['openid.realm'] || parameters['openid.trust_root']).host
    Masquerade::Application::Config['trusted_domains'].find { |domain| host.ends_with? domain } unless Masquerade::Application::Config['trusted_domains'].nil?
  end

  private
  
  def make_token
    self.token = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
  
end
