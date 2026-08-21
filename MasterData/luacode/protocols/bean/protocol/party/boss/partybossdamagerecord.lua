-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/party/boss/partybossdamagerecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local PartyBossDamageRecord = dataclass("PartyBossDamageRecord")
PartyBossDamageRecord.username = ""
PartyBossDamageRecord.bossid = 0
PartyBossDamageRecord.damage = 0
PartyBossDamageRecord.ts = 0
PartyBossDamageRecord.ifkill = 0
PartyBossDamageRecord.Ctor = function(self)
  -- function num : 0_0
end

PartyBossDamageRecord.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.username) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.damage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.ts) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.ifkill) then
    return false
  end
  return true
end

PartyBossDamageRecord.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyBossDamageRecord

