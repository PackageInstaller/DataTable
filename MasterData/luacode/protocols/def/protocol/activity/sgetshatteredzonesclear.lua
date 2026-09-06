local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetShatteredZonesClear = dataclass("SGetShatteredZonesClear", require("framework.net.protocol"))
SGetShatteredZonesClear.ProtocolType = 2413
SGetShatteredZonesClear.MaxSize = 65535

function SGetShatteredZonesClear:Ctor(client)
  SGetShatteredZonesClear.super.Ctor(self, client)
  self.clearRewards = {}
end

function SGetShatteredZonesClear:Marshal(buffer)
  local length = table.slen(self.clearRewards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.clearRewards[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SGetShatteredZonesClear:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.clearRewards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.clearRewards[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShatteredZonesClear
