local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenDungeonBox = dataclass("COpenDungeonBox", require("framework.net.protocol"))
COpenDungeonBox.ProtocolType = 1916
COpenDungeonBox.MaxSize = 65535
COpenDungeonBox.boxId = 0

function COpenDungeonBox:Ctor(client)
  COpenDungeonBox.super.Ctor(self, client)
end

function COpenDungeonBox:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.boxId) then
    return false
  end
  return true
end

function COpenDungeonBox:Unmarshal(buffer)
  local ret = true
  ret, self.boxId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenDungeonBox
