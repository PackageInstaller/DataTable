local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CModule = dataclass("CModule", require("framework.net.protocol"))
CModule.ProtocolType = 1955
CModule.MaxSize = 65535
CModule.id = 0

function CModule:Ctor(client)
  CModule.super.Ctor(self, client)
end

function CModule:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CModule:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CModule
