local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SModule = dataclass("SModule", require("framework.net.protocol"))
SModule.ProtocolType = 1956
SModule.MaxSize = 65535
SModule.id = 0
SModule.statue = 0

function SModule:Ctor(client)
  SModule.super.Ctor(self, client)
end

function SModule:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.statue) then
    return false
  end
  return true
end

function SModule:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.statue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SModule
