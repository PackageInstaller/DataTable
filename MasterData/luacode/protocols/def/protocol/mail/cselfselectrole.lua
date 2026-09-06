local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSelfSelectRole = dataclass("CSelfSelectRole", require("framework.net.protocol"))
CSelfSelectRole.ProtocolType = 1415
CSelfSelectRole.MaxSize = 65535
CSelfSelectRole.mailKey = 0
CSelfSelectRole.select = 0

function CSelfSelectRole:Ctor(client)
  CSelfSelectRole.super.Ctor(self, client)
end

function CSelfSelectRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.mailKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.select) then
    return false
  end
  return true
end

function CSelfSelectRole:Unmarshal(buffer)
  local ret = true
  ret, self.mailKey = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.select = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSelfSelectRole
