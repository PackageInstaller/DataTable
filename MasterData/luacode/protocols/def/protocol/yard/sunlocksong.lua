local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockSong = dataclass("SUnlockSong", require("framework.net.protocol"))
SUnlockSong.ProtocolType = 2384
SUnlockSong.MaxSize = 65535
SUnlockSong.id = 0

function SUnlockSong:Ctor(client)
  SUnlockSong.super.Ctor(self, client)
end

function SUnlockSong:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function SUnlockSong:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockSong
