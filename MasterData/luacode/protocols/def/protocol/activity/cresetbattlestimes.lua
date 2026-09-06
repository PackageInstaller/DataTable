local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CResetBattlesTimes = dataclass("CResetBattlesTimes", require("framework.net.protocol"))
CResetBattlesTimes.ProtocolType = 2637
CResetBattlesTimes.MaxSize = 65535
CResetBattlesTimes.bossId = 0

function CResetBattlesTimes:Ctor(client)
  CResetBattlesTimes.super.Ctor(self, client)
end

function CResetBattlesTimes:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  return true
end

function CResetBattlesTimes:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CResetBattlesTimes
