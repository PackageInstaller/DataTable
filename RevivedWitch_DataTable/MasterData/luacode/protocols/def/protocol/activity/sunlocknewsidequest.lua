-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sunlocknewsidequest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUnlockNewSideQuest = dataclass("SUnlockNewSideQuest", require("framework.net.protocol"))
SUnlockNewSideQuest.ProtocolType = 2424
SUnlockNewSideQuest.MaxSize = 65536
SUnlockNewSideQuest.result = 0
SUnlockNewSideQuest.dungeonID = 0
SUnlockNewSideQuest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUnlockNewSideQuest
  ((SUnlockNewSideQuest.super).Ctor)(self, client)
end

SUnlockNewSideQuest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dungeonID) then
    return false
  end
  return true
end

SUnlockNewSideQuest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockNewSideQuest

