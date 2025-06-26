-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/sreceiveachievelevelaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveAchieveLevelAward = dataclass("SReceiveAchieveLevelAward", require("framework.net.protocol"))
SReceiveAchieveLevelAward.ProtocolType = 1622
SReceiveAchieveLevelAward.MaxSize = 65535
SReceiveAchieveLevelAward.level = 0
SReceiveAchieveLevelAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveAchieveLevelAward
  ((SReceiveAchieveLevelAward.super).Ctor)(self, client)
end

SReceiveAchieveLevelAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  return true
end

SReceiveAchieveLevelAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveAchieveLevelAward

