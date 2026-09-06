local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangRoomName = dataclass("CChangRoomName", require("framework.net.protocol"))
CChangRoomName.ProtocolType = 2356
CChangRoomName.MaxSize = 65535
CChangRoomName.name = ""

function CChangRoomName:Ctor(client)
  CChangRoomName.super.Ctor(self, client)
end

function CChangRoomName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function CChangRoomName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangRoomName
