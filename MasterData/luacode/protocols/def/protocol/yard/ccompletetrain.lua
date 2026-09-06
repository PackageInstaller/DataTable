local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCompleteTrain = dataclass("CCompleteTrain", require("framework.net.protocol"))
CCompleteTrain.ProtocolType = 2374
CCompleteTrain.MaxSize = 65535
CCompleteTrain.index = 0

function CCompleteTrain:Ctor(client)
  CCompleteTrain.super.Ctor(self, client)
end

function CCompleteTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function CCompleteTrain:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteTrain
