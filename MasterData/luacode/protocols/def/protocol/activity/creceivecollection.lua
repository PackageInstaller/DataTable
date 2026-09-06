local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveCollection = dataclass("CReceiveCollection", require("framework.net.protocol"))
CReceiveCollection.ProtocolType = 2405
CReceiveCollection.MaxSize = 65535
CReceiveCollection.CollectionType = 0
CReceiveCollection.level = 0
CReceiveCollection.HIGH = 2
CReceiveCollection.COMMON = 1

function CReceiveCollection:Ctor(client)
  CReceiveCollection.super.Ctor(self, client)
end

function CReceiveCollection:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.CollectionType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function CReceiveCollection:Unmarshal(buffer)
  local ret = true
  ret, self.CollectionType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveCollection
