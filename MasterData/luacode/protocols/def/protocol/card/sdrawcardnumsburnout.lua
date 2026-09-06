local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDrawCardNumsBurnOut = dataclass("SDrawCardNumsBurnOut", require("framework.net.protocol"))
SDrawCardNumsBurnOut.ProtocolType = 1509
SDrawCardNumsBurnOut.MaxSize = 65535
SDrawCardNumsBurnOut.kind = 0
SDrawCardNumsBurnOut.ONE_DRAW = 1
SDrawCardNumsBurnOut.FIVE_DRAW = 2
SDrawCardNumsBurnOut.TOTAL_DRAW = 2

function SDrawCardNumsBurnOut:Ctor(client)
  SDrawCardNumsBurnOut.super.Ctor(self, client)
end

function SDrawCardNumsBurnOut:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  return true
end

function SDrawCardNumsBurnOut:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDrawCardNumsBurnOut
