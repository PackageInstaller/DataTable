local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSkinRedPoints = dataclass("SSkinRedPoints", require("framework.net.protocol"))
SSkinRedPoints.ProtocolType = 3643
SSkinRedPoints.MaxSize = 65535

function SSkinRedPoints:Ctor(client)
  SSkinRedPoints.super.Ctor(self, client)
  self.looked = {}
end

function SSkinRedPoints:Marshal(buffer)
  local length = table.slen(self.looked)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.looked[i]) then
      return false
    end
  end
  return true
end

function SSkinRedPoints:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.looked[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSkinRedPoints
