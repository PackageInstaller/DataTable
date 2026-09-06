local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local WitchRoom = dataclass("WitchRoom")
WitchRoom.name = ""
WitchRoom.id = 0
WitchRoom.level = 0

function WitchRoom:Ctor()
  self.floors = {}
  self.defaultTheme = {}
end

function WitchRoom:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.floors)) then
    return false
  end
  for key, value in pairs(self.floors) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.defaultTheme)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.defaultTheme[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function WitchRoom:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.yard.witchfloor").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.floors[key] = value
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.defaultTheme[i] = require("protocols.bean.protocol.yard.theme").Create()
    if not self.defaultTheme[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return WitchRoom
