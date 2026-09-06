local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNpcAppear = dataclass("SNpcAppear", require("framework.net.protocol"))
SNpcAppear.ProtocolType = 2005
SNpcAppear.MaxSize = 65535
SNpcAppear.sceneId = 0

function SNpcAppear:Ctor(client)
  SNpcAppear.super.Ctor(self, client)
  self.npcs = {}
end

function SNpcAppear:Marshal(buffer)
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

function SNpcAppear:Unmarshal(buffer)
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

return SNpcAppear
