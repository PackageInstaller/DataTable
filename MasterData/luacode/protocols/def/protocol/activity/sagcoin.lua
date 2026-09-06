local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
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

function SAgCoin:Ctor(client)
  SAgCoin.super.Ctor(self, client)
  self.commonCollection = {}
  self.highCollection = {}
  self.tasks = {}
end

function SAgCoin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.actId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.deadline) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.highUnlocked) then
    return false
  end
  local length = table.slen(self.commonCollection)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.commonCollection[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.highCollection)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.highCollection[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.tasks)) then
    return false
  end
  for key, value in pairs(self.tasks) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.refreshDailyTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeMoneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargePrice) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.levelPrice) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chipNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.needChipNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canReceiveMaxAward) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxTaskNum) then
    return false
  end
  return true
end

function SAgCoin:Unmarshal(buffer)
  local ret = true
  ret, self.actId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.deadline = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.highUnlocked = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.commonCollection[i] = require("protocols.bean.protocol.activity.collection").Create()
    if not self.commonCollection[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.highCollection[i] = require("protocols.bean.protocol.activity.collection").Create()
    if not self.highCollection[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.task.taskinfo").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.tasks[key] = value
  end
  ret, self.refreshDailyTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.chargeMoneyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chargePrice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.levelPrice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chipNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.needChipNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.canReceiveMaxAward = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.maxTaskNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAgCoin
