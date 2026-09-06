local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSkinRedPoints = dataclass("CSkinRedPoints", require("framework.net.protocol"))
CSkinRedPoints.ProtocolType = 3642
CSkinRedPoints.MaxSize = 65535
CSkinRedPoints.looked = 0

function CSkinRedPoints:Ctor(client)
  CSkinRedPoints.super.Ctor(self, client)
end

function CSkinRedPoints:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.looked) then
    return false
  end
  return true
end

function CSkinRedPoints:Unmarshal(buffer)
  local ret = true
  ret, self.looked = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSkinRedPoints
