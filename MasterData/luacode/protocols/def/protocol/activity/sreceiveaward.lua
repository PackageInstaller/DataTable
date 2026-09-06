local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveAward = dataclass("SReceiveAward", require("framework.net.protocol"))
SReceiveAward.ProtocolType = 2408
SReceiveAward.MaxSize = 65535
SReceiveAward.actId = 0

function SReceiveAward:Ctor(client)
  SReceiveAward.super.Ctor(self, client)
  self.index = {}
  self.itemInfo = {}
end

function SReceiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.actId) then
    return false
  end
  local length = table.slen(self.index)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index[i]) then
      return false
    end
  end
  local length = table.slen(self.itemInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SReceiveAward:Unmarshal(buffer)
  local ret = true
  ret, self.actId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.index[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.itemInfo[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveAward
