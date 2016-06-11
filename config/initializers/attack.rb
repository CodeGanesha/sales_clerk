# Block requests for php or cgi, jps and what else the people throw at us
Rack::Attack.blacklist('block admin probes') do |req|
  # Request are blocked if the return value is truthy
  reject = false
  ["php" , "jsp" , "cgi", "asp", "cfm," "proxy.txt", "soapCaller", "Win32" , "HNAP1" , "w00tw00t",
    "pma" , "mysql" ,"msd" , "MySQL" , "jmx-console" , "ervlet" , "xml" ,"install",
    "webdav"].each do |no|
    if req.path.include?(no)
      reject = true
      break
    end
  end
  reject
end

# Block requests from people clearly out to break servers
Rack::Attack.blacklist('block admin ips') do |req|
  [ "79.143.82.69" , "85.76.99.50" ].include? req.ip
end

# Throttle requests to 5 requests per second per ip
Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second) do |req|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.

  req.ip
end

# Always allow requests from shop
# (blacklist & throttles are skipped)
Rack::Attack.whitelist('allow from known or dev') do |req|
  # Requests are allowed if the return value is truthy
  if Rails.env.production?
    [ "85.76.112.161" , "85.76.99.50"].include? req.ip
  else
    true
  end
end
