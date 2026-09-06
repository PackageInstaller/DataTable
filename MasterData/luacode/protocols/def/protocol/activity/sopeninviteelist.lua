local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenInviteeList = dataclass("SOpenInviteeList", require("framework.net.protocol"))
SOpenInviteeList.ProtocolType = 2459
SOpenInviteeList.MaxSize = 65535
SOpenInviteeList.limitNum = 0

function SOpenInviteeList:Ctor(client)
  SOpenInviteeList.super.Ctor(self, client)
  self.users = {}
end

function SOpenInviteeList:Marshal(buffer)
  local length = table.slen(self.users)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.users[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.limitNum) then
    return false
  end
  return true
end

function SOpenInviteeList:Unmarshal(buffer)
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
  ret, self.limitNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenInviteeList
