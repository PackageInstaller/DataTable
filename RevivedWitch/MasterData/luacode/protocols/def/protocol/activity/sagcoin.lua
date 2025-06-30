-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sagcoin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAgCoin = dataclass("SAgCoin", require("framework.net.protocol"))
SAgCoin.ProtocolType = 2402
SAgCoin.MaxSize = 65535
SAgCoin.actId = 0
SAgCoin.deadline = 0
SAgCoin.highUnlocked = 0
SAgCoin.refreshDailyTime = 0
SAgCoin.chargeMoneyType = 0
SAgCoin.chargePrice = 0
SAgCoin.levelPrice = 0
SAgCoin.level = 0
SAgCoin.chipNum = 0
SAgCoin.needChipNum = 0
SAgCoin.canReceiveMaxAward = 0
SAgCoin.leftTime = 0
SAgCoin.maxTaskNum = 0
SAgCoin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAgCoin
  ((SAgCoin.super).Ctor)(self, client)
  self.commonCollection = {}
  self.highCollection = {}
  self.tasks = {}
end

SAgCoin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.actId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.deadline) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.highUnlocked) then
    return false
  end
  local length = (table.slen)(self.commonCollection)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.commonCollection)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.highCollection)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.highCollection)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.tasks)) then
    return false
  end
  for key,value in pairs(self.tasks) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R11_PC94) then
      return false
    end
    if not value:Marshal(R11_PC94) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.refreshDailyTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chargeMoneyType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chargePrice) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.levelPrice) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chipNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.needChipNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.canReceiveMaxAward) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.maxTaskNum) then
    return false
  end
  return true
end

SAgCoin.Unmarshal = function(self, buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.commonCollection)[i] = ((require("protocols.bean.protocol.activity.collection")).Create)()
    if not ((self.commonCollection)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

    (self.highCollection)[i] = ((require("protocols.bean.protocol.activity.collection")).Create)()
    if not ((self.highCollection)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC115: Overwrote pending register: R7 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC124: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.tasks)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAgCoin

