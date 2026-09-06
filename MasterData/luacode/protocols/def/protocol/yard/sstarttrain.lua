local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartTrain = dataclass("SStartTrain", require("framework.net.protocol"))
SStartTrain.ProtocolType = 2373
SStartTrain.MaxSize = 65535
SStartTrain.index = 0

function SStartTrain:Ctor(client)
  SStartTrain.super.Ctor(self, client)
  self.train = require("protocols.bean.protocol.yard.train").Create()
end

function SStartTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not self.train:Marshal(buffer) then
    return false
  end
  return true
end

function SStartTrain:Unmarshal(buffer)
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

return SStartTrain
