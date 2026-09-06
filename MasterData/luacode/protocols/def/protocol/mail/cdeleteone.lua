local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteOne = dataclass("CDeleteOne", require("framework.net.protocol"))
CDeleteOne.ProtocolType = 1408
CDeleteOne.MaxSize = 65535
CDeleteOne.uniqueId = 0

function CDeleteOne:Ctor(client)
  CDeleteOne.super.Ctor(self, client)
end

function CDeleteOne:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  return true
end

function CDeleteOne:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteOne
