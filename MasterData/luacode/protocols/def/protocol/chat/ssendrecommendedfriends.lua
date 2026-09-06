local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendRecommendedFriends = dataclass("SSendRecommendedFriends", require("framework.net.protocol"))
SSendRecommendedFriends.ProtocolType = 1121
SSendRecommendedFriends.MaxSize = 65535

function SSendRecommendedFriends:Ctor(client)
  SSendRecommendedFriends.super.Ctor(self, client)
  self.users = {}
end

function SSendRecommendedFriends:Marshal(buffer)
  local length = table.slen(self.users)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.users[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SSendRecommendedFriends:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.users[i] = require("protocols.bean.protocol.chat.otheruserinfo").Create()
    if not self.users[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendRecommendedFriends
