local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChristmasSupport = dataclass("CChristmasSupport", require("framework.net.protocol"))
CChristmasSupport.ProtocolType = 2564
CChristmasSupport.MaxSize = 65535
CChristmasSupport.num = 0

function CChristmasSupport:Ctor(client)
  CChristmasSupport.super.Ctor(self, client)
end

function CChristmasSupport:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function CChristmasSupport:Unmarshal(buffer)
  local ret = true
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChristmasSupport
