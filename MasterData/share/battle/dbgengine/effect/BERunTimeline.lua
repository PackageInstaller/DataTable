local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BERunTimeline, Super = System.NewClass("BERunTimeline", BattleEffectServer)

function BERunTimeline:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BERunTimeline:DoEffect()
  Super.DoEffect(self)
  local timelinePath = self.params[1]
  local caster = self.cmdServer:GetCaster()
  local runType = bc.TimelineRunType.Caster
  self.battleEngine.recordMgr:OnRunTimeline(caster.uid, self:GetTargetUids(), timelinePath, runType)
  return true
end

return BERunTimeline
