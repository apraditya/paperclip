module GoogleStorageMethods
  def load_google_storage
    begin
      require 'google-storage'
    rescue LoadError => e
      fail "You do not have google-storage and facets gems installed."
    end
  end

  def assert_gs_credentials(key, secret)
    load_google_storage
    begin
      include GoogleStorage
      service = Service.new(
        :accesskey => key,
        :secretkey => secret
      )
      service.buckets
    rescue GoogleStorage::AccessDeniedException => e
      fail "Could not connect using Google Storage credentials in GS_ACCESS_KEY_ID and GS_SECRET_ACCESS_KEY. " +
           "Please make sure these are set in your environment."
    end
  end
end

World(GoogleStorageMethods)
