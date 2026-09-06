local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDragonBoatFestivalInfo = dataclass("SDragonBoatFestivalInfo", require("framework.net.protocol"))
SDragonBoatFestivalInfo.ProtocolType = 2653
SDragonBoatFestivalInfo.MaxSize = 65535
SDragonBoatFestivalInfo.leftTime = 0
SDragonBoatFestivalInfo.actOpen = 0
SDragonBoatFestivalInfo.wishOpen = 0
SDragonBoatFestivalInfo.shopOpen = 0

function SDragonBoatFestivalInfo:Ctor(client)
  SDragonBoatFestivalInfo.super.Ctor(self, client)
  self.redpoint = {}
end

function SDragonBoatFestivalInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.actOpen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.wishOpen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopOpen) then
    return false
  end
  local length = table.slen(self.redpoint)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redpoint[i]) then
      return false
    end
  end
  return true
end

function SDragonBoatFestivalInfo:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.actOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.wishOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.shopOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.redpoint[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SDragonBoatFestivalInfo
