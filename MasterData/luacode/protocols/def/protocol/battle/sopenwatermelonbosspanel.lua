local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenWatermelonBossPanel = dataclass("SOpenWatermelonBossPanel", require("framework.net.protocol"))
SOpenWatermelonBossPanel.ProtocolType = 4129
SOpenWatermelonBossPanel.MaxSize = 65535

function SOpenWatermelonBossPanel:Ctor(client)
  SOpenWatermelonBossPanel.super.Ctor(self, client)
  self.bosses = {}
end

function SOpenWatermelonBossPanel:Marshal(buffer)
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

function SOpenWatermelonBossPanel:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.bosses[i] = require("protocols.bean.protocol.battle.watermelonbossbean").Create()
    if not self.bosses[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenWatermelonBossPanel
