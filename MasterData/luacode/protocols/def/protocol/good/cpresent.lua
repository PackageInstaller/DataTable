local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPresent = dataclass("CPresent", require("framework.net.protocol"))
CPresent.ProtocolType = 3403
CPresent.MaxSize = 65535
CPresent.roleId = 0
CPresent.itemId = 0
CPresent.itemNum = 0

function CPresent:Ctor(client)
  CPresent.super.Ctor(self, client)
end

function CPresent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  return true
end

function CPresent:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CPresent
