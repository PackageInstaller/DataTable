local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBreakLineup = dataclass("CBreakLineup", require("framework.net.protocol"))
CBreakLineup.ProtocolType = 1043
CBreakLineup.MaxSize = 65535
CBreakLineup.lineupId = 0

function CBreakLineup:Ctor(client)
  CBreakLineup.super.Ctor(self, client)
end

function CBreakLineup:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  return true
end

function CBreakLineup:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBreakLineup
