-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schoosebattleevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChooseBattleEvent = dataclass("SChooseBattleEvent", require("framework.net.protocol"))
SChooseBattleEvent.ProtocolType = 2724
SChooseBattleEvent.MaxSize = 65535
SChooseBattleEvent.eventId = 0
SChooseBattleEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChooseBattleEvent
  ((SChooseBattleEvent.super).Ctor)(self, client)
end

SChooseBattleEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventId) then
    return false
  end
  return true
end

SChooseBattleEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChooseBattleEvent

