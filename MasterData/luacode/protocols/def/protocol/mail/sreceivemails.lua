local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveMails = dataclass("SReceiveMails", require("framework.net.protocol"))
SReceiveMails.ProtocolType = 1412
SReceiveMails.MaxSize = 65535

function SReceiveMails:Ctor(client)
  SReceiveMails.super.Ctor(self, client)
  self.uniqueIds = {}
  self.items = {}
  self.role = {}
end

function SReceiveMails:Marshal(buffer)
  local length = table.slen(self.uniqueIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.uniqueIds[i]:Marshal(buffer) then
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
  local length = table.slen(self.role)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.role[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SReceiveMails:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.uniqueIds[i] = require("protocols.bean.protocol.mail.operateresult").Create()
    if not self.uniqueIds[i]:Unmarshal(buffer) then
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.role[i] = require("protocols.bean.protocol.card.cardinfo").Create()
    if not self.role[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveMails
