local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CComplementSigned = dataclass("CComplementSigned", require("framework.net.protocol"))
CComplementSigned.ProtocolType = 2679
CComplementSigned.MaxSize = 65535
CComplementSigned.dayId = 0

function CComplementSigned:Ctor(client)
  CComplementSigned.super.Ctor(self, client)
end

function CComplementSigned:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dayId) then
    return false
  end
  return true
end

function CComplementSigned:Unmarshal(buffer)
  local ret = true
  ret, self.dayId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CComplementSigned
