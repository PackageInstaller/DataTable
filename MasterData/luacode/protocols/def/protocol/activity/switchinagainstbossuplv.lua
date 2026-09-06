local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWitchInAgainstBossUpLv = dataclass("SWitchInAgainstBossUpLv", require("framework.net.protocol"))
SWitchInAgainstBossUpLv.ProtocolType = 2670
SWitchInAgainstBossUpLv.MaxSize = 65535
SWitchInAgainstBossUpLv.witchLv = 0

function SWitchInAgainstBossUpLv:Ctor(client)
  SWitchInAgainstBossUpLv.super.Ctor(self, client)
end

function SWitchInAgainstBossUpLv:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.witchLv) then
    return false
  end
  return true
end

function SWitchInAgainstBossUpLv:Unmarshal(buffer)
  local ret = true
  ret, self.witchLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWitchInAgainstBossUpLv
