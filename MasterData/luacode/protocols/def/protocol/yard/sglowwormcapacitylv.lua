local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGlowwormCapacityLv = dataclass("SGlowwormCapacityLv", require("framework.net.protocol"))
SGlowwormCapacityLv.ProtocolType = 2341
SGlowwormCapacityLv.MaxSize = 65535
SGlowwormCapacityLv.glowwormLevel = 0

function SGlowwormCapacityLv:Ctor(client)
  SGlowwormCapacityLv.super.Ctor(self, client)
end

function SGlowwormCapacityLv:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.glowwormLevel) then
    return false
  end
  return true
end

function SGlowwormCapacityLv:Unmarshal(buffer)
  local ret = true
  ret, self.glowwormLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGlowwormCapacityLv
