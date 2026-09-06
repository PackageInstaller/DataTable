local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SArenaReceiveAward = dataclass("SArenaReceiveAward", require("framework.net.protocol"))
SArenaReceiveAward.ProtocolType = 2433
SArenaReceiveAward.MaxSize = 65535

function SArenaReceiveAward:Ctor(client)
  SArenaReceiveAward.super.Ctor(self, client)
  self.itemInfo = {}
end

function SArenaReceiveAward:Marshal(buffer)
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

function SArenaReceiveAward:Unmarshal(buffer)
  local ret = true
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

return SArenaReceiveAward
