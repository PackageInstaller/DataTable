local SBattleResult = require("localprotocols.def.action.sbattleresult")

function SBattleResult:Process(battleWorld)
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SBattleResult Process")
  end
  if battleWorld.OnSBattleResult then
    battleWorld:OnSBattleResult(self)
  end
end

return SBattleResult
