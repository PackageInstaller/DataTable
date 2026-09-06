local function p1(protocol)
  local DeepLinkTag = {No = 0, Have = 1}
  
  local tag = DeepLinkTag.No
  local center = LuaNetManager.CreateProtocol("protocol.user.center")
  if center then
    center.deepLink = tag
    center:Send()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
