-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceivespringbossreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveSpringBossReward = dataclass("SReceiveSpringBossReward", require("framework.net.protocol"))
SReceiveSpringBossReward.ProtocolType = 2585
SReceiveSpringBossReward.MaxSize = 65535
SReceiveSpringBossReward.bossId = 0
SReceiveSpringBossReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveSpringBossReward
  ((SReceiveSpringBossReward.super).Ctor)(self, client)
end

SReceiveSpringBossReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossId) then
    return false
  end
  return true
end

SReceiveSpringBossReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveSpringBossReward

