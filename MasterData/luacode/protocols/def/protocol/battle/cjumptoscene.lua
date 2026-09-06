local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CJumpToScene = dataclass("CJumpToScene", require("framework.net.protocol"))
CJumpToScene.ProtocolType = 1970
CJumpToScene.MaxSize = 65535
CJumpToScene.sceneId = 0

function CJumpToScene:Ctor(client)
  CJumpToScene.super.Ctor(self, client)
end

function CJumpToScene:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneId) then
    return false
  end
  return true
end

function CJumpToScene:Unmarshal(buffer)
  local ret = true
  ret, self.sceneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CJumpToScene
