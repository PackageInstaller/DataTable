local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenTrain = dataclass("SOpenTrain", require("framework.net.protocol"))
SOpenTrain.ProtocolType = 2484
SOpenTrain.MaxSize = 65535

function SOpenTrain:Ctor(client)
  SOpenTrain.super.Ctor(self, client)
  self.trainsInfo = {}
end

function SOpenTrain:Marshal(buffer)
  local length = table.slen(self.trainsInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.trainsInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenTrain:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.trainsInfo[i] = require("protocols.bean.protocol.activity.battleinfo").Create()
    if not self.trainsInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenTrain
