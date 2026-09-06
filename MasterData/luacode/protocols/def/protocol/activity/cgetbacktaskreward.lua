local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetBackTaskReward = dataclass("CGetBackTaskReward", require("framework.net.protocol"))
CGetBackTaskReward.ProtocolType = 2558
CGetBackTaskReward.MaxSize = 65535
CGetBackTaskReward.goodId = 0

function CGetBackTaskReward:Ctor(client)
  CGetBackTaskReward.super.Ctor(self, client)
end

function CGetBackTaskReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function CGetBackTaskReward:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetBackTaskReward
