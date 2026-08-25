local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BETargetRunTimeline, Super = System.NewClass("BETargetRunTimeline", BattleEffectServer)

function BETargetRunTimeline:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BETargetRunTimeline:DoEffect()
  Super.DoEffect(self)
  local timelinePath = self.params[1]
  local caster = self.cmdServer:GetCaster()
  local runType = bc.TimelineRunType.Target
  self.battleEngine.recordMgr:OnRunTimeline(caster.uid, self:GetTargetUids(), timelinePath, runType)
  return true
end

return BETargetRunTimeline
