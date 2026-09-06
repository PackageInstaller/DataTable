local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeRougeTowerAutoExplore = dataclass("CChangeRougeTowerAutoExplore", require("framework.net.protocol"))
CChangeRougeTowerAutoExplore.ProtocolType = 2452
CChangeRougeTowerAutoExplore.MaxSize = 65535
CChangeRougeTowerAutoExplore.switchState = 0

function CChangeRougeTowerAutoExplore:Ctor(client)
  CChangeRougeTowerAutoExplore.super.Ctor(self, client)
end

function CChangeRougeTowerAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.switchState) then
    return false
  end
  return true
end

function CChangeRougeTowerAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.switchState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeRougeTowerAutoExplore
