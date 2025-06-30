-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sresetpassedquest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SResetPassedQuest = dataclass("SResetPassedQuest", require("framework.net.protocol"))
SResetPassedQuest.ProtocolType = 2426
SResetPassedQuest.MaxSize = 65536
SResetPassedQuest.result = 0
SResetPassedQuest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SResetPassedQuest
  ((SResetPassedQuest.super).Ctor)(self, client)
end

SResetPassedQuest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SResetPassedQuest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SResetPassedQuest

