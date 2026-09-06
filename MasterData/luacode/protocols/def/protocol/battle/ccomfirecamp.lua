local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CComfireCamp = dataclass("CComfireCamp", require("framework.net.protocol"))
CComfireCamp.ProtocolType = 4110
CComfireCamp.MaxSize = 65535
CComfireCamp.camp = 0

function CComfireCamp:Ctor(client)
  CComfireCamp.super.Ctor(self, client)
end

function CComfireCamp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.camp) then
    return false
  end
  return true
end

function CComfireCamp:Unmarshal(buffer)
  local ret = true
  ret, self.camp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CComfireCamp
