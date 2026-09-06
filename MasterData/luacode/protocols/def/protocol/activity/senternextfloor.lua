local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnterNextFloor = dataclass("SEnterNextFloor", require("framework.net.protocol"))
SEnterNextFloor.ProtocolType = 2625
SEnterNextFloor.MaxSize = 65535
SEnterNextFloor.floorId = 0

function SEnterNextFloor:Ctor(client)
  SEnterNextFloor.super.Ctor(self, client)
end

function SEnterNextFloor:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  return true
end

function SEnterNextFloor:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SEnterNextFloor
