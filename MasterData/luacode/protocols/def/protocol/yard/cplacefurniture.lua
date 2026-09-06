local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPlaceFurniture = dataclass("CPlaceFurniture", require("framework.net.protocol"))
CPlaceFurniture.ProtocolType = 2359
CPlaceFurniture.MaxSize = 65535
CPlaceFurniture.floorId = 0

function CPlaceFurniture:Ctor(client)
  CPlaceFurniture.super.Ctor(self, client)
  self.furniture = {}
end

function CPlaceFurniture:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  local length = table.slen(self.furniture)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.furniture[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function CPlaceFurniture:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.furniture[i] = require("protocols.bean.protocol.yard.furniture").Create()
    if not self.furniture[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return CPlaceFurniture
