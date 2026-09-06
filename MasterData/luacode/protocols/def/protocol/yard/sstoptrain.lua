local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSTopTrain = dataclass("SSTopTrain", require("framework.net.protocol"))
SSTopTrain.ProtocolType = 2377
SSTopTrain.MaxSize = 65535
SSTopTrain.index = 0

function SSTopTrain:Ctor(client)
  SSTopTrain.super.Ctor(self, client)
end

function SSTopTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function SSTopTrain:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSTopTrain
