local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRougeTowerUpdateUnreceivedReward = dataclass("SRougeTowerUpdateUnreceivedReward", require("framework.net.protocol"))
SRougeTowerUpdateUnreceivedReward.ProtocolType = 2756
SRougeTowerUpdateUnreceivedReward.MaxSize = 65535
SRougeTowerUpdateUnreceivedReward.updateType = 0
SRougeTowerUpdateUnreceivedReward.RECEIVE = 2
SRougeTowerUpdateUnreceivedReward.REQUIRE = 1
SRougeTowerUpdateUnreceivedReward.NEW = 0

function SRougeTowerUpdateUnreceivedReward:Ctor(client)
  SRougeTowerUpdateUnreceivedReward.super.Ctor(self, client)
  self.unreceivedReward = {}
end

function SRougeTowerUpdateUnreceivedReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.updateType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.unreceivedReward)) then
    return false
  end
  for key, value in pairs(self.unreceivedReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SRougeTowerUpdateUnreceivedReward:Unmarshal(buffer)
  local ret = true
  ret, self.updateType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.unreceivedReward[key] = value
  end
  return ret
end

return SRougeTowerUpdateUnreceivedReward
