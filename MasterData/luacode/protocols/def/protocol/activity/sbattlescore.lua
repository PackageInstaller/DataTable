local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBattleScore = dataclass("SBattleScore", require("framework.net.protocol"))
SBattleScore.ProtocolType = 2725
SBattleScore.MaxSize = 65535
SBattleScore.score = 0
SBattleScore.totalScore = 0

function SBattleScore:Ctor(client)
  SBattleScore.super.Ctor(self, client)
end

function SBattleScore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalScore) then
    return false
  end
  return true
end

function SBattleScore:Unmarshal(buffer)
  local ret = true
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBattleScore
