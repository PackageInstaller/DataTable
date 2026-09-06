local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckMailCode = dataclass("SCheckMailCode", require("framework.net.protocol"))
SCheckMailCode.ProtocolType = 2258
SCheckMailCode.MaxSize = 65535
SCheckMailCode.result = 0
SCheckMailCode.address = ""

function SCheckMailCode:Ctor(client)
  SCheckMailCode.super.Ctor(self, client)
end

function SCheckMailCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.address) then
    return false
  end
  return true
end

function SCheckMailCode:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.address = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckMailCode
