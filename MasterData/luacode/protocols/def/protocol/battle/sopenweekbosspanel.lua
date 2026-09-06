local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenWeekBossPanel = dataclass("SOpenWeekBossPanel", require("framework.net.protocol"))
SOpenWeekBossPanel.ProtocolType = 4141
SOpenWeekBossPanel.MaxSize = 65535
SOpenWeekBossPanel.rankId = 0

function SOpenWeekBossPanel:Ctor(client)
  SOpenWeekBossPanel.super.Ctor(self, client)
  self.bosses = require("protocols.bean.protocol.battle.bossbean").Create()
end

function SOpenWeekBossPanel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rankId) then
    return false
  end
  if not self.bosses:Marshal(buffer) then
    return false
  end
  return true
end

function SOpenWeekBossPanel:Unmarshal(buffer)
  local ret = true
  ret, self.rankId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.bosses:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenWeekBossPanel
