local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCommonGainRole = dataclass("SCommonGainRole", require("framework.net.protocol"))
SCommonGainRole.ProtocolType = 1528
SCommonGainRole.MaxSize = 65535

function SCommonGainRole:Ctor(client)
  SCommonGainRole.super.Ctor(self, client)
  self.roles = {}
  self.crystals = {}
  self.items = {}
end

function SCommonGainRole:Marshal(buffer)
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.roles[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.crystals)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.crystals[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.items)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.items[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCommonGainRole:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.roles[i] = require("protocols.bean.protocol.card.cardinfo").Create()
    if not self.roles[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.crystals[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.crystals[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.items[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.items[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCommonGainRole
