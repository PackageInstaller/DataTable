local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBattleEvent = dataclass("SBattleEvent", require("framework.net.protocol"))
SBattleEvent.ProtocolType = 2722
SBattleEvent.MaxSize = 65535
SBattleEvent.curEvent = 0

function SBattleEvent:Ctor(client)
  SBattleEvent.super.Ctor(self, client)
  self.eventId = {}
end

function SBattleEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curEvent) then
    return false
  end
  local length = table.slen(self.eventId)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventId[i]) then
      return false
    end
  end
  return true
end

function SBattleEvent:Unmarshal(buffer)
  local ret = true
  ret, self.curEvent = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.eventId[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SBattleEvent
