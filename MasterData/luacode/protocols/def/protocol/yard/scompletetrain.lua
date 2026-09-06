local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCompleteTrain = dataclass("SCompleteTrain", require("framework.net.protocol"))
SCompleteTrain.ProtocolType = 2375
SCompleteTrain.MaxSize = 65535
SCompleteTrain.index = 0
SCompleteTrain.resultType = 0
SCompleteTrain.result = ""
SCompleteTrain.ADD_EXP = 1
SCompleteTrain.ADD_LEVEL = 2
SCompleteTrain.ADD_MONEY = 3

function SCompleteTrain:Ctor(client)
  SCompleteTrain.super.Ctor(self, client)
  self.train = require("protocols.bean.protocol.yard.train").Create()
end

function SCompleteTrain:Marshal(buffer)
  if not self.train:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resultType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.result) then
    return false
  end
  return true
end

function SCompleteTrain:Unmarshal(buffer)
  local ret = true
  if not self.train:Unmarshal(buffer) then
    return false
  end
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.resultType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCompleteTrain
