-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/party/boss/partybossstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local PartyBossState = dataclass("PartyBossState")
PartyBossState.bossid = 0
PartyBossState.state = 0
PartyBossState.hp = 0
PartyBossState.mymaxdamage = 0
PartyBossState.Ctor = function(self)
  -- function num : 0_0
end

PartyBossState.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.hp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.mymaxdamage) then
    return false
  end
  return true
end

PartyBossState.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyBossState

