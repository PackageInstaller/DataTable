local CBattleKill = require("localprotocols.def.action.cbattlekill")

function CBattleKill:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CBattleKill Process")
  end
  battleWorld:OnCBattleKill(self)
end

return CBattleKill
