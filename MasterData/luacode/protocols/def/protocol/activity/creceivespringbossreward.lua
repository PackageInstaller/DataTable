local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSpringBossReward = dataclass("CReceiveSpringBossReward", require("framework.net.protocol"))
CReceiveSpringBossReward.ProtocolType = 2584
CReceiveSpringBossReward.MaxSize = 65535
CReceiveSpringBossReward.bossId = 0

function CReceiveSpringBossReward:Ctor(client)
  CReceiveSpringBossReward.super.Ctor(self, client)
end

function CReceiveSpringBossReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  return true
end

function CReceiveSpringBossReward:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSpringBossReward
