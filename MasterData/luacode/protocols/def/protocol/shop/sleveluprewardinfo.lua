local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLevelUpRewardInfo = dataclass("SLevelUpRewardInfo", require("framework.net.protocol"))
SLevelUpRewardInfo.ProtocolType = 3638
SLevelUpRewardInfo.MaxSize = 65535
SLevelUpRewardInfo.unlock = 0
SLevelUpRewardInfo.goodId = 0
SLevelUpRewardInfo.chargeNum = 0
SLevelUpRewardInfo.UN_CHARGE = 0
SLevelUpRewardInfo.CHARGE = 1

function SLevelUpRewardInfo:Ctor(client)
  SLevelUpRewardInfo.super.Ctor(self, client)
  self.ids = {}
end

function SLevelUpRewardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlock) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeNum) then
    return false
  end
  local length = table.slen(self.ids)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ids[i]) then
      return false
    end
  end
  return true
end

function SLevelUpRewardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.unlock = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chargeNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.ids[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLevelUpRewardInfo
