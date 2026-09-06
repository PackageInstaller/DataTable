local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCompleteFloor = dataclass("SCompleteFloor", require("framework.net.protocol"))
SCompleteFloor.ProtocolType = 2627
SCompleteFloor.MaxSize = 65535
SCompleteFloor.floorId = 0

function SCompleteFloor:Ctor(client)
  SCompleteFloor.super.Ctor(self, client)
end

function SCompleteFloor:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  return true
end

function SCompleteFloor:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCompleteFloor
