local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeLineupName = dataclass("SChangeLineupName", require("framework.net.protocol"))
SChangeLineupName.ProtocolType = 1046
SChangeLineupName.MaxSize = 65535
SChangeLineupName.lineupId = 0
SChangeLineupName.name = ""

function SChangeLineupName:Ctor(client)
  SChangeLineupName.super.Ctor(self, client)
end

function SChangeLineupName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function SChangeLineupName:Unmarshal(buffer)
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

return SChangeLineupName
