local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSweepResult = dataclass("SSweepResult", require("framework.net.protocol"))
SSweepResult.ProtocolType = 4139
SSweepResult.MaxSize = 65535
SSweepResult.playerExp = 0

function SSweepResult:Ctor(client)
  SSweepResult.super.Ctor(self, client)
  self.itemList = {}
  self.money = {}
  self.roleExp = {}
  self.roleGoodCurExp = {}
  self.roleGoodLv = {}
  self.roleGoodExp = {}
  self.rolesIndex = {}
  self.restituteReward = {}
end

function SSweepResult:Marshal(buffer)
  local length = table.slen(self.itemList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemList[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.money)) then
    return false
  end
  for key, value in pairs(self.money) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.playerExp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleExp)) then
    return false
  end
  for key, value in pairs(self.roleExp) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleGoodCurExp)) then
    return false
  end
  for key, value in pairs(self.roleGoodCurExp) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleGoodLv)) then
    return false
  end
  for key, value in pairs(self.roleGoodLv) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleGoodExp)) then
    return false
  end
  for key, value in pairs(self.roleGoodExp) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rolesIndex)) then
    return false
  end
  for key, value in pairs(self.rolesIndex) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.restituteReward)) then
    return false
  end
  for key, value in pairs(self.restituteReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  return true
end

function SSweepResult:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemList[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemList[i]:Unmarshal(buffer) then
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    self.money[key] = value
  end
  ret, self.playerExp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    self.roleExp[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.roleGoodCurExp[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.roleGoodLv[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.roleGoodExp[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.rolesIndex[key] = value
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    self.restituteReward[key] = value
  end
  return ret
end

return SSweepResult
