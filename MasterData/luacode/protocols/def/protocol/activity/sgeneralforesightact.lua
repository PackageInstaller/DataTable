local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGeneralForesightAct = dataclass("SGeneralForesightAct", require("framework.net.protocol"))
SGeneralForesightAct.ProtocolType = 2656
SGeneralForesightAct.MaxSize = 65535
SGeneralForesightAct.activityId = 0
SGeneralForesightAct.curLeftTime = 0
SGeneralForesightAct.actLeftTime = 0
SGeneralForesightAct.unlockedTimes = 0

function SGeneralForesightAct:Ctor(client)
  SGeneralForesightAct.super.Ctor(self, client)
  self.receiveAward = {}
  self.foresightGoodInfo = require("protocols.bean.protocol.shop.foresightgoodinfo").Create()
end

function SGeneralForesightAct:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.curLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.actLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockedTimes) then
    return false
  end
  local length = table.slen(self.receiveAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receiveAward[i]) then
      return false
    end
  end
  if not self.foresightGoodInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SGeneralForesightAct:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.curLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.actLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.unlockedTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receiveAward[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  if not self.foresightGoodInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SGeneralForesightAct
