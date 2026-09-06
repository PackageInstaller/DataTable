local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckMailCode = dataclass("CCheckMailCode", require("framework.net.protocol"))
CCheckMailCode.ProtocolType = 2257
CCheckMailCode.MaxSize = 65535
CCheckMailCode.code = ""

function CCheckMailCode:Ctor(client)
  CCheckMailCode.super.Ctor(self, client)
end

function CCheckMailCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.code) then
    return false
  end
  return true
end

function CCheckMailCode:Unmarshal(buffer)
  local ret = true
  ret, self.code = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckMailCode
