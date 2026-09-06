local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetLoverReward = dataclass("SGetLoverReward", require("framework.net.protocol"))
SGetLoverReward.ProtocolType = 2597
SGetLoverReward.MaxSize = 65535

function SGetLoverReward:Ctor(client)
  SGetLoverReward.super.Ctor(self, client)
  self.progressReward = {}
end

function SGetLoverReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.progressReward)) then
    return false
  end
  for key, value in pairs(self.progressReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetLoverReward:Unmarshal(buffer)
  local ret = true
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
    self.progressReward[key] = value
  end
  return ret
end

return SGetLoverReward
