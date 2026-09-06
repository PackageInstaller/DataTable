local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ResourcePass = dataclass("ResourcePass")
ResourcePass.status = 0
ResourcePass.level = 0
ResourcePass.process = 0
ResourcePass.spirit = 0
ResourcePass.first = 0
ResourcePass.LOCK = 0
ResourcePass.UNCLEAR = 1
ResourcePass.CLEAR = 2

function ResourcePass:Ctor()
  self.firstItems = {}
  self.randItems = {}
  self.activityItems = {}
end

function ResourcePass:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.process) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spirit) then
    return false
  end
  local length = table.slen(self.firstItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.firstItems[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.randItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.randItems[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.activityItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.activityItems[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.first) then
    return false
  end
  return true
end

function ResourcePass:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.process = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.spirit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.firstItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.firstItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.randItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.randItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.activityItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.activityItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.first = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ResourcePass
