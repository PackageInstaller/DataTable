local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLittleBattlePass = dataclass("SLittleBattlePass", require("framework.net.protocol"))
SLittleBattlePass.ProtocolType = 2662
SLittleBattlePass.MaxSize = 65535
SLittleBattlePass.actId = 0
SLittleBattlePass.deadline = 0
SLittleBattlePass.highUnlocked = 0
SLittleBattlePass.chargeMoneyType = 0
SLittleBattlePass.chargePrice = 0
SLittleBattlePass.level = 0
SLittleBattlePass.chipNum = 0
SLittleBattlePass.needChipNum = 0
SLittleBattlePass.leftTime = 0
SLittleBattlePass.weeklyLeftTime = 0

function SLittleBattlePass:Ctor(client)
  SLittleBattlePass.super.Ctor(self, client)
  self.commonCollection = {}
  self.highCollection = {}
  self.tasks = {}
end

function SLittleBattlePass:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeMoneyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargePrice) then
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
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.weeklyLeftTime) then
    return false
  end
  return true
end

function SLittleBattlePass:Unmarshal(buffer)
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
  ret, self.chargeMoneyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chargePrice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.weeklyLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLittleBattlePass
