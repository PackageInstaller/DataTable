local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STriggleSuccess = dataclass("STriggleSuccess", require("framework.net.protocol"))
STriggleSuccess.ProtocolType = 1933
STriggleSuccess.MaxSize = 65535
STriggleSuccess.eventId = 0

function STriggleSuccess:Ctor(client)
  STriggleSuccess.super.Ctor(self, client)
end

function STriggleSuccess:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventId) then
    return false
  end
  return true
end

function STriggleSuccess:Unmarshal(buffer)
  local ret = true
  ret, self.eventId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STriggleSuccess
