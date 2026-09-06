local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTowerBreakLineup = dataclass("CTowerBreakLineup", require("framework.net.protocol"))
CTowerBreakLineup.ProtocolType = 1993
CTowerBreakLineup.MaxSize = 65535
CTowerBreakLineup.lineupId = 0

function CTowerBreakLineup:Ctor(client)
  CTowerBreakLineup.super.Ctor(self, client)
end

function CTowerBreakLineup:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  return true
end

function CTowerBreakLineup:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTowerBreakLineup
