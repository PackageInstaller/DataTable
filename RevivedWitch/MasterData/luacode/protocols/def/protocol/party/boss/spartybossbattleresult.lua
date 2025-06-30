-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/spartybossbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPartyBossBattleResult = dataclass("SPartyBossBattleResult", require("framework.net.protocol"))
SPartyBossBattleResult.ProtocolType = 5046
SPartyBossBattleResult.MaxSize = 65535
SPartyBossBattleResult.bossid = 0
SPartyBossBattleResult.battletime = 0
SPartyBossBattleResult.beforescore = 0
SPartyBossBattleResult.realdamage = 0
SPartyBossBattleResult.realscore = 0
SPartyBossBattleResult.chances = 0
SPartyBossBattleResult.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPartyBossBattleResult
  ((SPartyBossBattleResult.super).Ctor)(self, client)
  self.itemList = {}
  self.money = {}
end

SPartyBossBattleResult.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.battletime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.beforescore) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.realdamage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.realscore) then
    return false
  end
  local length = (table.slen)(self.itemList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.itemList)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.money)) then
    return false
  end
  for key,value in pairs(self.money) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC84) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC84) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chances) then
    return false
  end
  return true
end

SPartyBossBattleResult.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    (self.itemList)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC99: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.money)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPartyBossBattleResult

