local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPassFloorEndPoint = dataclass("SPassFloorEndPoint", require("framework.net.protocol"))
SPassFloorEndPoint.ProtocolType = 2416
SPassFloorEndPoint.MaxSize = 65535

function SPassFloorEndPoint:Ctor(client)
  SPassFloorEndPoint.super.Ctor(self, client)
  self.receiveItems = {}
end

function SPassFloorEndPoint:Marshal(buffer)
  local length = table.slen(self.receiveItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.receiveItems[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SPassFloorEndPoint:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.receiveItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.receiveItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SPassFloorEndPoint
