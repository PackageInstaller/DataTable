local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FavorAwardInfo = dataclass("FavorAwardInfo")
FavorAwardInfo.status = 0
FavorAwardInfo.STATUS_CANT = 0
FavorAwardInfo.STATUS_ABLE = 2
FavorAwardInfo.STATUS_ALREADY = 1

function FavorAwardInfo:Ctor()
  self.awards = {}
end

function FavorAwardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  local length = table.slen(self.awards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awards[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function FavorAwardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.awards[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return FavorAwardInfo
