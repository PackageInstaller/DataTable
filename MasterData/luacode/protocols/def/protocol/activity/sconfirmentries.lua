local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SConfirmEntries = dataclass("SConfirmEntries", require("framework.net.protocol"))
SConfirmEntries.ProtocolType = 2486
SConfirmEntries.MaxSize = 65535
SConfirmEntries.score = 0

function SConfirmEntries:Ctor(client)
  SConfirmEntries.super.Ctor(self, client)
end

function SConfirmEntries:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  return true
end

function SConfirmEntries:Unmarshal(buffer)
  local ret = true
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SConfirmEntries
