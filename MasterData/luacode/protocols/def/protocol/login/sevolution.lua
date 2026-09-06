local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEvolution = dataclass("SEvolution", require("framework.net.protocol"))
SEvolution.ProtocolType = 1066
SEvolution.MaxSize = 65535
SEvolution.roleId = 0
SEvolution.evolution = 0

function SEvolution:Ctor(client)
  SEvolution.super.Ctor(self, client)
end

function SEvolution:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.evolution) then
    return false
  end
  return true
end

function SEvolution:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.evolution = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SEvolution
