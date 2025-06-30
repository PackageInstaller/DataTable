-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlocknewsidequest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockNewSideQuest = dataclass("CUnlockNewSideQuest", require("framework.net.protocol"))
CUnlockNewSideQuest.ProtocolType = 2423
CUnlockNewSideQuest.MaxSize = 65536
CUnlockNewSideQuest.unlockDungeonID = 0
CUnlockNewSideQuest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockNewSideQuest
  ((CUnlockNewSideQuest.super).Ctor)(self, client)
end

CUnlockNewSideQuest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockDungeonID) then
    return false
  end
  return true
end

CUnlockNewSideQuest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockNewSideQuest

