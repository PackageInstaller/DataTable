local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCancelLoading = dataclass("SCancelLoading", require("framework.net.protocol"))
SCancelLoading.ProtocolType = 1805
SCancelLoading.MaxSize = 65535
SCancelLoading.protocolType = 0

function SCancelLoading:Ctor(client)
  SCancelLoading.super.Ctor(self, client)
end

function SCancelLoading:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.protocolType) then
    return false
  end
  return true
end

function SCancelLoading:Unmarshal(buffer)
  local ret = true
  ret, self.protocolType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCancelLoading
