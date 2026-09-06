local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshTrain = dataclass("SRefreshTrain", require("framework.net.protocol"))
SRefreshTrain.ProtocolType = 2381
SRefreshTrain.MaxSize = 65535
SRefreshTrain.index = 0

function SRefreshTrain:Ctor(client)
  SRefreshTrain.super.Ctor(self, client)
  self.train = require("protocols.bean.protocol.yard.train").Create()
end

function SRefreshTrain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not self.train:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshTrain:Unmarshal(buffer)
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

return SRefreshTrain
