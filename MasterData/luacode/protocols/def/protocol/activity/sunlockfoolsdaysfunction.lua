local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockFoolsDaysFunction = dataclass("SUnlockFoolsDaysFunction", require("framework.net.protocol"))
SUnlockFoolsDaysFunction.ProtocolType = 2639
SUnlockFoolsDaysFunction.MaxSize = 65535
SUnlockFoolsDaysFunction.functionId = 0
SUnlockFoolsDaysFunction.COPY_BATTLE = 1
SUnlockFoolsDaysFunction.RED_CLOWN = 2
SUnlockFoolsDaysFunction.BLUE_CLOWN = 3

function SUnlockFoolsDaysFunction:Ctor(client)
  SUnlockFoolsDaysFunction.super.Ctor(self, client)
end

function SUnlockFoolsDaysFunction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.functionId) then
    return false
  end
  return true
end

function SUnlockFoolsDaysFunction:Unmarshal(buffer)
  local ret = true
  ret, self.functionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockFoolsDaysFunction
