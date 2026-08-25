local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BattleCmdCardListExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdCardListExp")
local ForceConsumeMode = bc.ForceConsumeMode
local BERunCardAgain, Super = System.NewClass("BERunCardAgain", BattleEffectServer)

function BERunCardAgain:BuildTargetUidList(upperTargets)
  local targetUidList = {}
  for _, target in ipairs(upperTargets) do
    if target and target.uid then
      table.insert(targetUidList, target.uid)
    end
  end
  return targetUidList
end

function BERunCardAgain:ResolveUpperTargets(card)
  local targetsExp = self.params[1]
  if targetsExp and targetsExp.is and (targetsExp:is(BattleCmdTargetsExp) or targetsExp:is(BattleCmdCardListExp)) then
    local upperTargets = targetsExp:GetTargetList()
    if upperTargets and #upperTargets > 0 then
      return upperTargets
    end
  end
  if card and card.GetSkillTarget then
    local skillTargets = card:GetSkillTarget()
    if skillTargets and #skillTargets > 0 then
      return skillTargets
    end
  end
  return nil
end

function BERunCardAgain:ReplayOneCard(card, upperTargets)
  if not card or card.isDeleted then
    return false
  end
  local owner = card:GetOwner()
  if not owner then
    return false
  end
  local cmdServer = card:GetCardCmdServer()
  if not cmdServer then
    return false
  end
  card:ClearCmdServerStats()
  cmdServer:SetUpperTargets(upperTargets)
  local preCmdServer = card:GetCardPreCmdServer()
  if preCmdServer then
    preCmdServer:ClearStats()
    preCmdServer:SetUpperTargets(upperTargets)
  end
  cmdServer:SetMemberValue("ForceConsumeMode", ForceConsumeMode.IgnoreCost)
  local targetUidList = self:BuildTargetUidList(upperTargets)
  local chainOk = owner:AppendUseCardEffectChain(card.uid, targetUidList)
  if not chainOk then
    cmdServer:SetMemberValue("ForceConsumeMode", nil)
    return false
  end
  return true
end

function BERunCardAgain:DoEffect()
  Super.DoEffect(self)
  if 0 == #self.targets then
    return false
  end
  self.totalEffectTimes = math.ceil(self.params[2] or 1)
  self.leftEffectTimes = self.totalEffectTimes
  do return self.DoMultiEffect end
  return self.DoMultiEffect, self
end

function BERunCardAgain:__DoMultiEffect()
  local loopTime = self.cmdServer:GetSkillLoopTime()
  if not loopTime or 0 == loopTime then
    self.battleEngine:AddPassTime(0.2)
  end
  local hasSuccess = false
  for cardIndex, card in ipairs(self.targets) do
    local upperTargets = self:ResolveUpperTargets(card)
    if not upperTargets or 0 == #upperTargets then
      self.battleEngine:Warn("BERunCardAgain skip, no upper targets, cardUid=", card.uid)
    else
      if cardIndex > 1 and loopTime and loopTime > 0 then
        self.battleEngine:AddPassTime(loopTime)
      end
      if self:ReplayOneCard(card, upperTargets) then
        hasSuccess = true
      end
    end
  end
  self.leftEffectTimes = self.leftEffectTimes - 1
  return hasSuccess
end

return BERunCardAgain
