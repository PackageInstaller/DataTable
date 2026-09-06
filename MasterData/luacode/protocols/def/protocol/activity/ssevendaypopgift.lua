local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSevenDayPopGIft = dataclass("SSevenDayPopGIft", require("framework.net.protocol"))
SSevenDayPopGIft.ProtocolType = 2743
SSevenDayPopGIft.MaxSize = 65535
SSevenDayPopGIft.pop = 0
SSevenDayPopGIft.hasBought = 0
SSevenDayPopGIft.leftTime = 0
SSevenDayPopGIft.goodId = 0

function SSevenDayPopGIft:Ctor(client)
  SSevenDayPopGIft.super.Ctor(self, client)
  self.rewards = {}
end

function SSevenDayPopGIft:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pop) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hasBought) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rewards)) then
    return false
  end
  for key, value in pairs(self.rewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function SSevenDayPopGIft:Unmarshal(buffer)
  local ret = true
  ret, self.pop = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.hasBought = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.rewards[key] = value
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenDayPopGIft
