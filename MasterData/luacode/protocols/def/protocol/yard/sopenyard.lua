local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenYard = dataclass("SOpenYard", require("framework.net.protocol"))
SOpenYard.ProtocolType = 2351
SOpenYard.MaxSize = 65535
SOpenYard.sceneId = 0

function SOpenYard:Ctor(client)
  SOpenYard.super.Ctor(self, client)
end

function SOpenYard:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  return true
end

function SOpenYard:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenYard
