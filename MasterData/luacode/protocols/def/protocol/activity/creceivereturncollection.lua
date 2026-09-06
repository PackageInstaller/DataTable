local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveReturnCollection = dataclass("CReceiveReturnCollection", require("framework.net.protocol"))
CReceiveReturnCollection.ProtocolType = 2740
CReceiveReturnCollection.MaxSize = 65535
CReceiveReturnCollection.CollectionType = 0
CReceiveReturnCollection.level = 0
CReceiveReturnCollection.roleId = 0
CReceiveReturnCollection.HIGH = 2
CReceiveReturnCollection.COMMON = 1

function CReceiveReturnCollection:Ctor(client)
  CReceiveReturnCollection.super.Ctor(self, client)
end

function CReceiveReturnCollection:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.CollectionType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CReceiveReturnCollection:Unmarshal(buffer)
  local ret = true
  ret, self.CollectionType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveReturnCollection
