local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNpcDisappear = dataclass("SNpcDisappear", require("framework.net.protocol"))
SNpcDisappear.ProtocolType = 2006
SNpcDisappear.MaxSize = 65535
SNpcDisappear.sceneId = 0

function SNpcDisappear:Ctor(client)
  SNpcDisappear.super.Ctor(self, client)
  self.npcs = {}
end

function SNpcDisappear:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  local length = table.slen(self.npcs)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.npcs[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SNpcDisappear:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.npcs[i] = require("protocols.bean.protocol.battle.dungeonnpc").Create()
    if not self.npcs[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SNpcDisappear
