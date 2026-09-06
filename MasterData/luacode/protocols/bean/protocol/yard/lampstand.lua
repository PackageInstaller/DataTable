local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local LampStand = dataclass("LampStand")
LampStand.id = 0
LampStand.level = 0
LampStand.leftRefreshTime = 0
LampStand.leftRefreshLightSpotTime = 0
LampStand.glowwormLevel = 0
LampStand.speed = 0
LampStand.white = 0
LampStand.dark = 0
LampStand.mix = 0

function LampStand:Ctor()
  self.lampTask = {}
  self.LightSpots = {}
end

function LampStand:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftRefreshTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.lampTask)) then
    return false
  end
  for key, value in pairs(self.lampTask) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.LightSpots)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.LightSpots[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftRefreshLightSpotTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.glowwormLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.speed) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.white) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.dark) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.mix) then
    return false
  end
  return true
end

function LampStand:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftRefreshTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    value = require("protocols.bean.protocol.yard.lamptask").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.lampTask[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.LightSpots[i] = require("protocols.bean.protocol.yard.light").Create()
    if not self.LightSpots[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.leftRefreshLightSpotTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.glowwormLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.speed = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.white = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.dark = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.mix = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return LampStand
