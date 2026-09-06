local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetLoverReward = dataclass("CGetLoverReward", require("framework.net.protocol"))
CGetLoverReward.ProtocolType = 2596
CGetLoverReward.MaxSize = 65535
CGetLoverReward.boxId = 0

function CGetLoverReward:Ctor(client)
  CGetLoverReward.super.Ctor(self, client)
end

function CGetLoverReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.boxId) then
    return false
  end
  return true
end

function CGetLoverReward:Unmarshal(buffer)
  local ret = true
  ret, self.boxId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetLoverReward
