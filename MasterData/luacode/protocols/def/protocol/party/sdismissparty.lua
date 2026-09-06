local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDismissParty = dataclass("SDismissParty", require("framework.net.protocol"))
SDismissParty.ProtocolType = 5029
SDismissParty.MaxSize = 65535
SDismissParty.result = 0

function SDismissParty:Ctor(client)
  SDismissParty.super.Ctor(self, client)
end

function SDismissParty:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SDismissParty:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDismissParty
