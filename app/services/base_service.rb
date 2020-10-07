class BaseService
  def success(payload = {})
    OpenStruct.new(success?: true, payload: payload)
  end

  def failure(payload = {})
    OpenStruct.new(success?: false, payload: payload)
  end
end
