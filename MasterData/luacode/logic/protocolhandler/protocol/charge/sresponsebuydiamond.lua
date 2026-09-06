local function p1(protocol)
  SdkManager.Pay(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
