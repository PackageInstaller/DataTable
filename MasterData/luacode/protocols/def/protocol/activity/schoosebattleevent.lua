local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChooseBattleEvent = dataclass("SChooseBattleEvent", require("framework.net.protocol"))
SChooseBattleEvent.ProtocolType = 2724
SChooseBattleEvent.MaxSize = 65535
SChooseBattleEvent.eventId = 0

function SChooseBattleEvent:Ctor(client)
  SChooseBattleEvent.super.Ctor(self, client)
end

function SChooseBattleEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventId) then
    return false
  end
  return true
end

function SChooseBattleEvent:Unmarshal(buffer)
  local ret = true
  ret, self.eventId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChooseBattleEvent
