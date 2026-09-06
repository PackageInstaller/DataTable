local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenBossPanel = dataclass("SOpenBossPanel", require("framework.net.protocol"))
SOpenBossPanel.ProtocolType = 1951
SOpenBossPanel.MaxSize = 65535

function SOpenBossPanel:Ctor(client)
  SOpenBossPanel.super.Ctor(self, client)
  self.bosses = {}
end

function SOpenBossPanel:Marshal(buffer)
  local length = table.slen(self.bosses)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.bosses[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenBossPanel:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.bosses[i] = require("protocols.bean.protocol.battle.bossbean").Create()
    if not self.bosses[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBossPanel
