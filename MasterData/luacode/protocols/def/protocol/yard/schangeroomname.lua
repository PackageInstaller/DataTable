local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeRoomName = dataclass("SChangeRoomName", require("framework.net.protocol"))
SChangeRoomName.ProtocolType = 2357
SChangeRoomName.MaxSize = 65535
SChangeRoomName.name = ""

function SChangeRoomName:Ctor(client)
  SChangeRoomName.super.Ctor(self, client)
end

function SChangeRoomName:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  return true
end

function SChangeRoomName:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeRoomName
