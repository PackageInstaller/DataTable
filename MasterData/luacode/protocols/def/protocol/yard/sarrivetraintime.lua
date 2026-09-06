local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SArriveTrainTime = dataclass("SArriveTrainTime", require("framework.net.protocol"))
SArriveTrainTime.ProtocolType = 2380
SArriveTrainTime.MaxSize = 65535
SArriveTrainTime.index = 0

function SArriveTrainTime:Ctor(client)
  SArriveTrainTime.super.Ctor(self, client)
  self.train = require("protocols.bean.protocol.yard.train").Create()
end

function SArriveTrainTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not self.train:Marshal(buffer) then
    return false
  end
  return true
end

function SArriveTrainTime:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.train:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SArriveTrainTime
