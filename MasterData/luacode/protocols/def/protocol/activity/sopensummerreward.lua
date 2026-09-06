local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenSummerReward = dataclass("SOpenSummerReward", require("framework.net.protocol"))
SOpenSummerReward.ProtocolType = 2720
SOpenSummerReward.MaxSize = 65535
SOpenSummerReward.score = 0

function SOpenSummerReward:Ctor(client)
  SOpenSummerReward.super.Ctor(self, client)
  self.receiveAward = {}
end

function SOpenSummerReward:Marshal(buffer)
  local length = table.slen(self.receiveAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receiveAward[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  return true
end

function SOpenSummerReward:Unmarshal(buffer)
  local ret = true
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
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenSummerReward
