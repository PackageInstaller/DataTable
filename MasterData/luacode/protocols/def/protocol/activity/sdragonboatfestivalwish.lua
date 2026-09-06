local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDragonBoatFestivalWish = dataclass("SDragonBoatFestivalWish", require("framework.net.protocol"))
SDragonBoatFestivalWish.ProtocolType = 2655
SDragonBoatFestivalWish.MaxSize = 65535
SDragonBoatFestivalWish.currPoolId = 0

function SDragonBoatFestivalWish:Ctor(client)
  SDragonBoatFestivalWish.super.Ctor(self, client)
  self.dragonBoatItemPool = {}
end

function SDragonBoatFestivalWish:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currPoolId) then
    return false
  end
  local length = table.slen(self.dragonBoatItemPool)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.dragonBoatItemPool[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SDragonBoatFestivalWish:Unmarshal(buffer)
  local ret = true
  ret, self.currPoolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.dragonBoatItemPool[i] = require("protocols.bean.protocol.activity.dragonboatitempool").Create()
    if not self.dragonBoatItemPool[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SDragonBoatFestivalWish
