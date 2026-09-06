local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshFriendInfos = dataclass("SRefreshFriendInfos", require("framework.net.protocol"))
SRefreshFriendInfos.ProtocolType = 1130
SRefreshFriendInfos.MaxSize = 65535

function SRefreshFriendInfos:Ctor(client)
  SRefreshFriendInfos.super.Ctor(self, client)
  self.user = {}
end

function SRefreshFriendInfos:Marshal(buffer)
  local length = table.slen(self.user)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.user[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshFriendInfos:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.user[i] = require("protocols.bean.protocol.chat.otheruserinfo").Create()
    if not self.user[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshFriendInfos
