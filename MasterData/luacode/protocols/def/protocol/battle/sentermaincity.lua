local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnterMainCity = dataclass("SEnterMainCity", require("framework.net.protocol"))
SEnterMainCity.ProtocolType = 1953
SEnterMainCity.MaxSize = 65535
SEnterMainCity.lastFloorId = 0
SEnterMainCity.tip = 0
SEnterMainCity.dungeonType = 0
SEnterMainCity.TIP_VOID = 0
SEnterMainCity.TIP_FAIL = 1
SEnterMainCity.TIP_NORMAL = 2
SEnterMainCity.TIP_JUMP = 3
SEnterMainCity.TIP_NO_TALK = 4
SEnterMainCity.TIP_EXCEPTION = 5
SEnterMainCity.TIP_DO_NOTHING = 6
SEnterMainCity.TOWER_BACK = 66

function SEnterMainCity:Ctor(client)
  SEnterMainCity.super.Ctor(self, client)
  self.battleResult = require("protocols.bean.protocol.battle.battleresult").Create()
  self.money = {}
  self.exploreawards = {}
  self.resourceParams = {}
  self.firstPassAward = {}
  self.curBattleInfo = require("protocols.bean.protocol.battle.battleinfo").Create()
end

function SEnterMainCity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lastFloorId) then
    return false
  end
  if not self.battleResult:Marshal(buffer) then
    return false
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
  local length = table.slen(self.exploreawards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.exploreawards[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.resourceParams)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resourceParams[i]) then
      return false
    end
  end
  local length = table.slen(self.firstPassAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.firstPassAward[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.tip) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonType) then
    return false
  end
  if not self.curBattleInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SEnterMainCity:Unmarshal(buffer)
  local ret = true
  ret, self.lastFloorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.battleResult:Unmarshal(buffer) then
    return false
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.exploreawards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.exploreawards[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.resourceParams[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.firstPassAward[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.firstPassAward[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.tip = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dungeonType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.curBattleInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SEnterMainCity
