local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveSpringBossReward = dataclass("SReceiveSpringBossReward", require("framework.net.protocol"))
SReceiveSpringBossReward.ProtocolType = 2585
SReceiveSpringBossReward.MaxSize = 65535
SReceiveSpringBossReward.bossId = 0

function SReceiveSpringBossReward:Ctor(client)
  SReceiveSpringBossReward.super.Ctor(self, client)
end

function SReceiveSpringBossReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  return true
end

function SReceiveSpringBossReward:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveSpringBossReward
