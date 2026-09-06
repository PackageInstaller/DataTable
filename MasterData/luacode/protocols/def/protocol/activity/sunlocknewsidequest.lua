local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockNewSideQuest = dataclass("SUnlockNewSideQuest", require("framework.net.protocol"))
SUnlockNewSideQuest.ProtocolType = 2424
SUnlockNewSideQuest.MaxSize = 65536
SUnlockNewSideQuest.result = 0
SUnlockNewSideQuest.dungeonID = 0

function SUnlockNewSideQuest:Ctor(client)
  SUnlockNewSideQuest.super.Ctor(self, client)
end

function SUnlockNewSideQuest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonID) then
    return false
  end
  return true
end

function SUnlockNewSideQuest:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dungeonID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockNewSideQuest
