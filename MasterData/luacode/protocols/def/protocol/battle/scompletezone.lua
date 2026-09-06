local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCompleteZone = dataclass("SCompleteZone", require("framework.net.protocol"))
SCompleteZone.ProtocolType = 1958
SCompleteZone.MaxSize = 65535
SCompleteZone.zoneId = 0
SCompleteZone.currentZone = 0

function SCompleteZone:Ctor(client)
  SCompleteZone.super.Ctor(self, client)
  self.money = {}
  self.firstPassAward = {}
  self.exploreAwards = {}
  self.topMessage = require("protocols.bean.protocol.notify.sendtopmessage").Create()
end

function SCompleteZone:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentZone) then
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
  local length = table.slen(self.firstPassAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.firstPassAward[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.exploreAwards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.exploreAwards[i]:Marshal(buffer) then
      return false
    end
  end
  if not self.topMessage:Marshal(buffer) then
    return false
  end
  return true
end

function SCompleteZone:Unmarshal(buffer)
  local ret = true
  ret, self.zoneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.currentZone = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.money[key] = value
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.exploreAwards[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.exploreAwards[i]:Unmarshal(buffer) then
      return false
    end
  end
  if not self.topMessage:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SCompleteZone
