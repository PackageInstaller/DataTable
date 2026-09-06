local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBattleStart = dataclass("SBattleStart", require("framework.net.protocol"))
SBattleStart.ProtocolType = 1902
SBattleStart.MaxSize = 655350

function SBattleStart:Ctor(client)
  SBattleStart.super.Ctor(self, client)
  self.battleInfo = require("protocols.bean.protocol.battle.battleinfo").Create()
end

function SBattleStart:Marshal(buffer)
  if not self.battleInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SBattleStart:Unmarshal(buffer)
  local ret = true
  if not self.battleInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SBattleStart
