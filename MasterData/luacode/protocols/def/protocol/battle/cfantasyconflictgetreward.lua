local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictGetReward = dataclass("CFantasyConflictGetReward", require("framework.net.protocol"))
CFantasyConflictGetReward.ProtocolType = 4153
CFantasyConflictGetReward.MaxSize = 65535
CFantasyConflictGetReward.id = 0

function CFantasyConflictGetReward:Ctor(client)
  CFantasyConflictGetReward.super.Ctor(self, client)
end

function CFantasyConflictGetReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CFantasyConflictGetReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFantasyConflictGetReward
