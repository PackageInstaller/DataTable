local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStopTrain = dataclass("CStopTrain", require("framework.net.protocol"))
CStopTrain.ProtocolType = 2376
CStopTrain.MaxSize = 65535
CStopTrain.index = 0

function CStopTrain:Ctor(client)
  CStopTrain.super.Ctor(self, client)
end

function CStopTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function CStopTrain:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStopTrain
