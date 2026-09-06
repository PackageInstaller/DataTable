local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenFloorBox = dataclass("COpenFloorBox", require("framework.net.protocol"))
COpenFloorBox.ProtocolType = 2632
COpenFloorBox.MaxSize = 65535
COpenFloorBox.floorId = 0

function COpenFloorBox:Ctor(client)
  COpenFloorBox.super.Ctor(self, client)
end

function COpenFloorBox:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  return true
end

function COpenFloorBox:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenFloorBox
