local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPartyBossBattleResult = dataclass("SPartyBossBattleResult", require("framework.net.protocol"))
SPartyBossBattleResult.ProtocolType = 5046
SPartyBossBattleResult.MaxSize = 65535
SPartyBossBattleResult.bossid = 0
SPartyBossBattleResult.battletime = 0
SPartyBossBattleResult.beforescore = 0
SPartyBossBattleResult.realdamage = 0
SPartyBossBattleResult.realscore = 0
SPartyBossBattleResult.chances = 0

function SPartyBossBattleResult:Ctor(client)
  SPartyBossBattleResult.super.Ctor(self, client)
  self.itemList = {}
  self.money = {}
end

function SPartyBossBattleResult:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.battletime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.beforescore) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.realdamage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.realscore) then
    return false
  end
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chances) then
    return false
  end
  return true
end

function SPartyBossBattleResult:Unmarshal(buffer)
  local ret = true
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.battletime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.beforescore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.realdamage = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.realscore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
  ret, self.chances = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPartyBossBattleResult
