local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeScrollSceneState = dataclass("CChangeScrollSceneState", require("framework.net.protocol"))
CChangeScrollSceneState.ProtocolType = 4104
CChangeScrollSceneState.MaxSize = 65535
CChangeScrollSceneState.id = 0

function CChangeScrollSceneState:Ctor(client)
  CChangeScrollSceneState.super.Ctor(self, client)
end

function CChangeScrollSceneState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CChangeScrollSceneState:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeScrollSceneState
