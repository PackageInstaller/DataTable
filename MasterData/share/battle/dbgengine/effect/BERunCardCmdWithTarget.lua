local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BattleCmdCardListExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdCardListExp")
local BERunCardCmdWithTarget, Super = System.NewClass("BERunCardCmdWithTarget", BattleEffectServer)

function BERunCardCmdWithTarget:DoEffect()
  Super.DoEffect(self)
  if 0 == #self.targets then
    return false
  end
  self.totalEffectTimes = math.ceil(self.params[2] or 1)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BERunCardCmdWithTarget:__DoMultiEffect()
  local targetsExp = self.params[1]
  if not (targetsExp and targetsExp.is) or not targetsExp:is(BattleCmdTargetsExp) and not targetsExp:is(BattleCmdCardListExp) then
    return false
  end
  local upperTargets = targetsExp:GetTargetList()
  local loopTime = self.cmdServer:GetSkillLoopTime()
  if not loopTime or 0 == loopTime then
    self.battleEngine:AddPassTime(0.2)
  end
  for i, target in ipairs(self.targets) do
    local cmdServer = target:GetCardCmdServer()
    cmdServer:SetUpperTargets(upperTargets)
    local preCmdServer = target:GetCardPreCmdServer()
    if preCmdServer then
      preCmdServer:SetUpperTargets(upperTargets)
      local preCmdEffectConfig = {
        effectType = bc.BattleEffectType.BECreateSkillPhase,
        castRoleUid = self.cmdServer.castRoleUid,
        cardUid = target.uid,
        cmdServer = preCmdServer,
        skipPhase = true
      }
      self.battleEngine.effectMgr:CreateEffect(preCmdEffectConfig)
    end
    local delay = 1 == i and 0 or loopTime
    local cardEffectConfig = {
      effectType = bc.BattleEffectType.BECreateSkillPhase,
      castRoleUid = self.cmdServer.castRoleUid,
      cmdServer = cmdServer,
      cardUid = target.uid,
      skipPhase = true,
      BeforeDelay = delay
    }
    self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return true
end

return BERunCardCmdWithTarget
