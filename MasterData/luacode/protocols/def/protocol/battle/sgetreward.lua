local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetReward = dataclass("SGetReward", require("framework.net.protocol"))
SGetReward.ProtocolType = 4116
SGetReward.MaxSize = 65535

function SGetReward:Ctor(client)
  SGetReward.super.Ctor(self, client)
  self.process = {}
end

function SGetReward:Marshal(buffer)
  local length = table.slen(self.process)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.process[i]) then
      return false
    end
  end
  return true
end

function SGetReward:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.process[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SGetReward
