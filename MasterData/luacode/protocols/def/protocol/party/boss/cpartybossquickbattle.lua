local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPartyBossQuickBattle = dataclass("CPartyBossQuickBattle", require("framework.net.protocol"))
CPartyBossQuickBattle.ProtocolType = 5045
CPartyBossQuickBattle.MaxSize = 65535
CPartyBossQuickBattle.bossid = 0

function CPartyBossQuickBattle:Ctor(client)
  CPartyBossQuickBattle.super.Ctor(self, client)
end

function CPartyBossQuickBattle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  return true
end

function CPartyBossQuickBattle:Unmarshal(buffer)
  local ret = true
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CPartyBossQuickBattle
