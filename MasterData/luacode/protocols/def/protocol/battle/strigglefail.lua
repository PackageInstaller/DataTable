local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STriggleFail = dataclass("STriggleFail", require("framework.net.protocol"))
STriggleFail.ProtocolType = 1946
STriggleFail.MaxSize = 65535
STriggleFail.eventId = 0

function STriggleFail:Ctor(client)
  STriggleFail.super.Ctor(self, client)
end

function STriggleFail:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventId) then
    return false
  end
  return true
end

function STriggleFail:Unmarshal(buffer)
  local ret = true
  ret, self.eventId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STriggleFail
