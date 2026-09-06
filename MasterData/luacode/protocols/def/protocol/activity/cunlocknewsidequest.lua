local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockNewSideQuest = dataclass("CUnlockNewSideQuest", require("framework.net.protocol"))
CUnlockNewSideQuest.ProtocolType = 2423
CUnlockNewSideQuest.MaxSize = 65536
CUnlockNewSideQuest.unlockDungeonID = 0

function CUnlockNewSideQuest:Ctor(client)
  CUnlockNewSideQuest.super.Ctor(self, client)
end

function CUnlockNewSideQuest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockDungeonID) then
    return false
  end
  return true
end

function CUnlockNewSideQuest:Unmarshal(buffer)
  local ret = true
  ret, self.unlockDungeonID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockNewSideQuest
