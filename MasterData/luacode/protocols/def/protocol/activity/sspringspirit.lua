local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpringSpirit = dataclass("SSpringSpirit", require("framework.net.protocol"))
SSpringSpirit.ProtocolType = 2582
SSpringSpirit.MaxSize = 65535
SSpringSpirit.spirit = 0
SSpringSpirit.lefttime = 0

function SSpringSpirit:Ctor(client)
  SSpringSpirit.super.Ctor(self, client)
end

function SSpringSpirit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spirit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lefttime) then
    return false
  end
  return true
end

function SSpringSpirit:Unmarshal(buffer)
  local ret = true
  ret, self.spirit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lefttime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringSpirit
