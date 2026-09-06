local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STransaction = dataclass("STransaction", require("framework.net.protocol"))
STransaction.ProtocolType = 1942
STransaction.MaxSize = 65535
STransaction.kind = 0
STransaction.value = 0

function STransaction:Ctor(client)
  STransaction.super.Ctor(self, client)
end

function STransaction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  return true
end

function STransaction:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STransaction
