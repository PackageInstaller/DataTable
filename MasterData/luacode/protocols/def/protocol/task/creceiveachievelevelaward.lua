-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/creceiveachievelevelaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveAchieveLevelAward = dataclass("CReceiveAchieveLevelAward", require("framework.net.protocol"))
CReceiveAchieveLevelAward.ProtocolType = 1621
CReceiveAchieveLevelAward.MaxSize = 65535
CReceiveAchieveLevelAward.level = 0
CReceiveAchieveLevelAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveAchieveLevelAward
  ((CReceiveAchieveLevelAward.super).Ctor)(self, client)
end

CReceiveAchieveLevelAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  return true
end

CReceiveAchieveLevelAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveAchieveLevelAward

