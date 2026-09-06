local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeLineupName = dataclass("CChangeLineupName", require("framework.net.protocol"))
CChangeLineupName.ProtocolType = 1045
CChangeLineupName.MaxSize = 65535
CChangeLineupName.lineupId = 0
CChangeLineupName.name = ""

function CChangeLineupName:Ctor(client)
  CChangeLineupName.super.Ctor(self, client)
end

function CChangeLineupName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function CChangeLineupName:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeLineupName
