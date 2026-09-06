local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshAlchemy = dataclass("SRefreshAlchemy", require("framework.net.protocol"))
SRefreshAlchemy.ProtocolType = 2354
SRefreshAlchemy.MaxSize = 65535
SRefreshAlchemy.effect = 0

function SRefreshAlchemy:Ctor(client)
  SRefreshAlchemy.super.Ctor(self, client)
  self.alchemy = require("protocols.bean.protocol.yard.alchemy").Create()
  self.mainResult = {}
  self.secondResult = {}
end

function SRefreshAlchemy:Marshal(buffer)
  if not self.alchemy:Marshal(buffer) then
    return false
  end
  local length = table.slen(self.mainResult)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.mainResult[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.secondResult)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.secondResult[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.effect) then
    return false
  end
  return true
end

function SRefreshAlchemy:Unmarshal(buffer)
  local ret = true
  if not self.alchemy:Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.mainResult[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.mainResult[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.secondResult[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.secondResult[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.effect = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshAlchemy
