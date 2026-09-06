local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpringBattleResult = dataclass("SSpringBattleResult", require("framework.net.protocol"))
SSpringBattleResult.ProtocolType = 2580
SSpringBattleResult.MaxSize = 65535
SSpringBattleResult.bossId = 0
SSpringBattleResult.stage = 0
SSpringBattleResult.score = 0

function SSpringBattleResult:Ctor(client)
  SSpringBattleResult.super.Ctor(self, client)
end

function SSpringBattleResult:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  return true
end

function SSpringBattleResult:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringBattleResult
