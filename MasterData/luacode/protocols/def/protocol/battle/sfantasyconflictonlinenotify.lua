local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictOnlineNotify = dataclass("SFantasyConflictOnlineNotify", require("framework.net.protocol"))
SFantasyConflictOnlineNotify.ProtocolType = 4154
SFantasyConflictOnlineNotify.MaxSize = 65535
SFantasyConflictOnlineNotify.award = 0

function SFantasyConflictOnlineNotify:Ctor(client)
  SFantasyConflictOnlineNotify.super.Ctor(self, client)
end

function SFantasyConflictOnlineNotify:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.award) then
    return false
  end
  return true
end

function SFantasyConflictOnlineNotify:Unmarshal(buffer)
  local ret = true
  ret, self.award = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SFantasyConflictOnlineNotify
