local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveTowerAward = dataclass("SReceiveTowerAward", require("framework.net.protocol"))
SReceiveTowerAward.ProtocolType = 2455
SReceiveTowerAward.MaxSize = 65535
SReceiveTowerAward.id = 0

function SReceiveTowerAward:Ctor(client)
  SReceiveTowerAward.super.Ctor(self, client)
  self.items = {}
end

function SReceiveTowerAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
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

function SReceiveTowerAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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

return SReceiveTowerAward
