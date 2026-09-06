local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLockSong = dataclass("SLockSong", require("framework.net.protocol"))
SLockSong.ProtocolType = 2382
SLockSong.MaxSize = 65535

function SLockSong:Ctor(client)
  SLockSong.super.Ctor(self, client)
  self.id = {}
end

function SLockSong:Marshal(buffer)
  local length = table.slen(self.id)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id[i]) then
      return false
    end
  end
  return true
end

function SLockSong:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.id[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLockSong
