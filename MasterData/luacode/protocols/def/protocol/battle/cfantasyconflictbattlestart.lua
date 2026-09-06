local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictBattleStart = dataclass("CFantasyConflictBattleStart", require("framework.net.protocol"))
CFantasyConflictBattleStart.ProtocolType = 4159
CFantasyConflictBattleStart.MaxSize = 65535
CFantasyConflictBattleStart.enemyID = 0

function CFantasyConflictBattleStart:Ctor(client)
  CFantasyConflictBattleStart.super.Ctor(self, client)
end

function CFantasyConflictBattleStart:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.enemyID) then
    return false
  end
  return true
end

function CFantasyConflictBattleStart:Unmarshal(buffer)
  local ret = true
  ret, self.enemyID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFantasyConflictBattleStart
