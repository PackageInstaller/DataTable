local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLookOtherInfo = dataclass("SLookOtherInfo", require("framework.net.protocol"))
SLookOtherInfo.ProtocolType = 1137
SLookOtherInfo.MaxSize = 65535
SLookOtherInfo.title = ""
SLookOtherInfo.introduce = ""
SLookOtherInfo.likedNum = 0
SLookOtherInfo.partyName = ""

function SLookOtherInfo:Ctor(client)
  SLookOtherInfo.super.Ctor(self, client)
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
  self.support = require("protocols.bean.protocol.chat.roleinfo").Create()
  self.display = {}
end

function SLookOtherInfo:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.title) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.introduce) then
    return false
  end
  if not self.support:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.display)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.display[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likedNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyName) then
    return false
  end
  return true
end

function SLookOtherInfo:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.title = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.introduce = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  if not self.support:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.display[i] = require("protocols.bean.protocol.ranking.role").Create()
    if not self.display[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.likedNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.partyName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLookOtherInfo
