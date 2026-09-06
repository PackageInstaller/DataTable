local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRespondApplicant = dataclass("CRespondApplicant", require("framework.net.protocol"))
CRespondApplicant.ProtocolType = 1133
CRespondApplicant.MaxSize = 65535
CRespondApplicant.userId = 0
CRespondApplicant.result = 0

function CRespondApplicant:Ctor(client)
  CRespondApplicant.super.Ctor(self, client)
end

function CRespondApplicant:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function CRespondApplicant:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRespondApplicant
