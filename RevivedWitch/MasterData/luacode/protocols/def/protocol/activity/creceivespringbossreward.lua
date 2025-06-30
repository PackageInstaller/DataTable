-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivespringbossreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveSpringBossReward = dataclass("CReceiveSpringBossReward", require("framework.net.protocol"))
CReceiveSpringBossReward.ProtocolType = 2584
CReceiveSpringBossReward.MaxSize = 65535
CReceiveSpringBossReward.bossId = 0
CReceiveSpringBossReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveSpringBossReward
  ((CReceiveSpringBossReward.super).Ctor)(self, client)
end

CReceiveSpringBossReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossId) then
    return false
  end
  return true
end

CReceiveSpringBossReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSpringBossReward

