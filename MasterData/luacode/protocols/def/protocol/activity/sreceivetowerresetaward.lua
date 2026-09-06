local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveTowerResetAward = dataclass("SReceiveTowerResetAward", require("framework.net.protocol"))
SReceiveTowerResetAward.ProtocolType = 2420
SReceiveTowerResetAward.MaxSize = 65535
SReceiveTowerResetAward.passedPoints = 0

function SReceiveTowerResetAward:Ctor(client)
  SReceiveTowerResetAward.super.Ctor(self, client)
  self.items = {}
end

function SReceiveTowerResetAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.passedPoints) then
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

function SReceiveTowerResetAward:Unmarshal(buffer)
  local ret = true
  ret, self.passedPoints = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return SReceiveTowerResetAward
