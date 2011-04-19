require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  
  fixtures :sites, :release_policies
  
  def setup
    @site = sites(:venteria)
  end

  def test_should_require_account
    @site.account = nil
    assert_invalid @site, :account
  end
  
  def test_should_require_persona
    @site.persona = nil
    assert_invalid @site, :persona
  end
  
  def test_should_require_url
    @site.url = nil
    assert_invalid @site, :url
  end
  
  def test_should_have_unique_url_across_account
    @site.account = sites(:blog).account
    @site.url = sites(:blog).url
    assert_invalid @site, :url
  end
  
  def test_should_delete_associated_release_policies_on_destroy
    @release_policy = release_policies(:venteria_nickname)
    @release_policy.site.destroy
    assert_nil ReleasePolicy.find_by_id(@release_policy.id)
  end
  
  def test_should_set_release_policies_from_given_properties
    @site.properties = valid_properties
    assert_equal 6, @site.release_policies.size
  end
  
end
