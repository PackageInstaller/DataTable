local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenCompleteLineup = dataclass("COpenCompleteLineup", require("framework.net.protocol"))
COpenCompleteLineup.ProtocolType = 4126
COpenCompleteLineup.MaxSize = 65535
COpenCompleteLineup.zoneId = 0
COpenCompleteLineup.playType = 0
COpenCompleteLineup.RESOURCE_LINEUP = 1

function COpenCompleteLineup:Ctor(client)
  COpenCompleteLineup.super.Ctor(self, client)
end

function COpenCompleteLineup:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.playType) then
    return false
  end
  return true
end

function COpenCompleteLineup:Unmarshal(buffer)
  local ret = true
  ret, self.zoneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.playType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenCompleteLineup
