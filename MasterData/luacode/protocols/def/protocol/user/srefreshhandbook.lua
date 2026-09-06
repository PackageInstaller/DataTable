local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshHandbook = dataclass("SRefreshHandbook", require("framework.net.protocol"))
SRefreshHandbook.ProtocolType = 2260
SRefreshHandbook.MaxSize = 65535
SRefreshHandbook.id = 0
SRefreshHandbook.bookType = 0

function SRefreshHandbook:Ctor(client)
  SRefreshHandbook.super.Ctor(self, client)
end

function SRefreshHandbook:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bookType) then
    return false
  end
  return true
end

function SRefreshHandbook:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.bookType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshHandbook
