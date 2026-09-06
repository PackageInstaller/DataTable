local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenMusic = dataclass("COpenMusic", require("framework.net.protocol"))
COpenMusic.ProtocolType = 2385
COpenMusic.MaxSize = 65535
COpenMusic.albumId = 0

function COpenMusic:Ctor(client)
  COpenMusic.super.Ctor(self, client)
end

function COpenMusic:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.albumId) then
    return false
  end
  return true
end

function COpenMusic:Unmarshal(buffer)
  local ret = true
  ret, self.albumId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenMusic
