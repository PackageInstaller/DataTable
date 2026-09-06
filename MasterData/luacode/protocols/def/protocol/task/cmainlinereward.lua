local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMainLineReward = dataclass("CMainLineReward", require("framework.net.protocol"))
CMainLineReward.ProtocolType = 1638
CMainLineReward.MaxSize = 65535
CMainLineReward.mainLineId = 0

function CMainLineReward:Ctor(client)
  CMainLineReward.super.Ctor(self, client)
end

function CMainLineReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mainLineId) then
    return false
  end
  return true
end

function CMainLineReward:Unmarshal(buffer)
  local ret = true
  ret, self.mainLineId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMainLineReward
