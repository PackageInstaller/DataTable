local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEEndBout, Super = System.NewClass("BEEndBout", BattleEffectServer)

function BEEndBout:DoEffect()
  local boutMgr = self.battleEngine.boutMgr
  if not boutMgr then
    self.battleEngine.logger:WarningS("BEEndBout skip: boutMgr is nil")
    return true
  end
  if boutMgr.phase ~= bc.BoutPhase.Action then
    self.battleEngine.logger:WarningS("BEEndBout skip: not in Action phase {phase}", boutMgr.phase)
    return true
  end
  if self.battleEngine.pendingForceEndBout then
    self.battleEngine.logger:InfoS("BEEndBout skip: already pending")
    return true
  end
  self.battleEngine.pendingForceEndBout = true
  self.battleEngine:LogBattleWithTab("设置回合结束")
  return true
end

return BEEndBout
