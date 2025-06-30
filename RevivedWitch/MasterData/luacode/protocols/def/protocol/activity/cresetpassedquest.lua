-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cresetpassedquest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CResetPassedQuest = dataclass("CResetPassedQuest", require("framework.net.protocol"))
CResetPassedQuest.ProtocolType = 2425
CResetPassedQuest.MaxSize = 65536
CResetPassedQuest.resetID = 0
CResetPassedQuest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CResetPassedQuest
  ((CResetPassedQuest.super).Ctor)(self, client)
end

CResetPassedQuest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.resetID) then
    return false
  end
  return true
end

CResetPassedQuest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CResetPassedQuest

