local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockSong = dataclass("CUnlockSong", require("framework.net.protocol"))
CUnlockSong.ProtocolType = 2383
CUnlockSong.MaxSize = 65535
CUnlockSong.id = 0

function CUnlockSong:Ctor(client)
  CUnlockSong.super.Ctor(self, client)
end

function CUnlockSong:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CUnlockSong:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockSong
