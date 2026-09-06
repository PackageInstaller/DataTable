local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActive = dataclass("CActive", require("framework.net.protocol"))
CActive.ProtocolType = 103
CActive.MaxSize = 256
CActive.code = ""

function CActive:Ctor(client)
  CActive.super.Ctor(self, client)
end

function CActive:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.code) then
    return false
  end
  return true
end

function CActive:Unmarshal(buffer)
  local ret = true
  ret, self.code = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActive
