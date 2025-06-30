-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/cpartybossquickbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CPartyBossQuickBattle = dataclass("CPartyBossQuickBattle", require("framework.net.protocol"))
CPartyBossQuickBattle.ProtocolType = 5045
CPartyBossQuickBattle.MaxSize = 65535
CPartyBossQuickBattle.bossid = 0
CPartyBossQuickBattle.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CPartyBossQuickBattle
  ((CPartyBossQuickBattle.super).Ctor)(self, client)
end

CPartyBossQuickBattle.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
    return false
  end
  return true
end

CPartyBossQuickBattle.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CPartyBossQuickBattle

