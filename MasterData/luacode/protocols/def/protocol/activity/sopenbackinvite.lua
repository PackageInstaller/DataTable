local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenBackInvite = dataclass("SOpenBackInvite", require("framework.net.protocol"))
SOpenBackInvite.ProtocolType = 2550
SOpenBackInvite.MaxSize = 65535
SOpenBackInvite.invitationCode = ""
SOpenBackInvite.inviteeNum = 0
SOpenBackInvite.returnTime = 0
SOpenBackInvite.discountTime = 0

function SOpenBackInvite:Ctor(client)
  SOpenBackInvite.super.Ctor(self, client)
  self.inviteeLimit = {}
  self.goodInfo = {}
end

function SOpenBackInvite:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.invitationCode) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.inviteeNum) then
    return false
  end
  local length = table.slen(self.inviteeLimit)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.inviteeLimit[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.returnTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.discountTime) then
    return false
  end
  local length = table.slen(self.goodInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.goodInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenBackInvite:Unmarshal(buffer)
  local ret = true
  ret, self.invitationCode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.inviteeNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.inviteeLimit[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.returnTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.discountTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.goodInfo[i] = require("protocols.bean.protocol.activity.goodinfo").Create()
    if not self.goodInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBackInvite
