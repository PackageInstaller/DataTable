local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChooseBattleEvent = dataclass("CChooseBattleEvent", require("framework.net.protocol"))
CChooseBattleEvent.ProtocolType = 2723
CChooseBattleEvent.MaxSize = 65535
CChooseBattleEvent.eventId = 0

function CChooseBattleEvent:Ctor(client)
  CChooseBattleEvent.super.Ctor(self, client)
end

function CChooseBattleEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventId) then
    return false
  end
  return true
end

function CChooseBattleEvent:Unmarshal(buffer)
  local ret = true
  ret, self.eventId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChooseBattleEvent
