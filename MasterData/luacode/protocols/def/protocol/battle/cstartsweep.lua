local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartSweep = dataclass("CStartSweep", require("framework.net.protocol"))
CStartSweep.ProtocolType = 4136
CStartSweep.MaxSize = 65535
CStartSweep.battleType = 0
CStartSweep.id = 0
CStartSweep.lineupId = 0
CStartSweep.sweepNum = 0

function CStartSweep:Ctor(client)
  CStartSweep.super.Ctor(self, client)
end

function CStartSweep:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.battleType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sweepNum) then
    return false
  end
  return true
end

function CStartSweep:Unmarshal(buffer)
  local ret = true
  ret, self.battleType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sweepNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartSweep
