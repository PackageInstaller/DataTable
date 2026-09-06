local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCompleteFloor = dataclass("CCompleteFloor", require("framework.net.protocol"))
CCompleteFloor.ProtocolType = 2626
CCompleteFloor.MaxSize = 65535
CCompleteFloor.floorId = 0

function CCompleteFloor:Ctor(client)
  CCompleteFloor.super.Ctor(self, client)
end

function CCompleteFloor:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  return true
end

function CCompleteFloor:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteFloor
