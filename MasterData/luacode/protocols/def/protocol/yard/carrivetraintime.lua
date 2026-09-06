local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CArriveTrainTime = dataclass("CArriveTrainTime", require("framework.net.protocol"))
CArriveTrainTime.ProtocolType = 2379
CArriveTrainTime.MaxSize = 65535
CArriveTrainTime.index = 0

function CArriveTrainTime:Ctor(client)
  CArriveTrainTime.super.Ctor(self, client)
end

function CArriveTrainTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function CArriveTrainTime:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CArriveTrainTime
