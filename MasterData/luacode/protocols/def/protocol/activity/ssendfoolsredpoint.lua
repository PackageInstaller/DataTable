local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendFoolsRedPoint = dataclass("SSendFoolsRedPoint", require("framework.net.protocol"))
SSendFoolsRedPoint.ProtocolType = 2621
SSendFoolsRedPoint.MaxSize = 65535
SSendFoolsRedPoint.SHOP = 1

function SSendFoolsRedPoint:Ctor(client)
  SSendFoolsRedPoint.super.Ctor(self, client)
  self.redpoint = {}
end

function SSendFoolsRedPoint:Marshal(buffer)
  local length = table.slen(self.redpoint)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redpoint[i]) then
      return false
    end
  end
  return true
end

function SSendFoolsRedPoint:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.redpoint[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendFoolsRedPoint
