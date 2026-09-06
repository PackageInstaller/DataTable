local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveStageAward = dataclass("CReceiveStageAward", require("framework.net.protocol"))
CReceiveStageAward.ProtocolType = 3503
CReceiveStageAward.MaxSize = 65535
CReceiveStageAward.id = 0
CReceiveStageAward.stageId = 0

function CReceiveStageAward:Ctor(client)
  CReceiveStageAward.super.Ctor(self, client)
end

function CReceiveStageAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stageId) then
    return false
  end
  return true
end

function CReceiveStageAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stageId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveStageAward
