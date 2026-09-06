local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveOne = dataclass("CReceiveOne", require("framework.net.protocol"))
CReceiveOne.ProtocolType = 1406
CReceiveOne.MaxSize = 65535
CReceiveOne.uniqueId = 0

function CReceiveOne:Ctor(client)
  CReceiveOne.super.Ctor(self, client)
end

function CReceiveOne:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  return true
end

function CReceiveOne:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveOne
