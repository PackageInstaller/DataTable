local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveForesightAct = dataclass("CReceiveForesightAct", require("framework.net.protocol"))
CReceiveForesightAct.ProtocolType = 2657
CReceiveForesightAct.MaxSize = 65535
CReceiveForesightAct.activityId = 0
CReceiveForesightAct.dayNum = 0

function CReceiveForesightAct:Ctor(client)
  CReceiveForesightAct.super.Ctor(self, client)
end

function CReceiveForesightAct:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dayNum) then
    return false
  end
  return true
end

function CReceiveForesightAct:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dayNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveForesightAct
