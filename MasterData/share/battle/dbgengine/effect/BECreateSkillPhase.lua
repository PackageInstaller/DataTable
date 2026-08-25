local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BECreateSkillPhase, Super = System.NewClass("BECreateSkillPhase", BattleEffectServer)

function BECreateSkillPhase:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BECreateSkillPhase:Dispose()
  Super.Dispose(self)
end

function BECreateSkillPhase:DoEffect()
  Super.DoEffect(self)
  local cmdServer = self.effectConfig.cmdServer
  cmdServer:SetIsDeleted(false)
  local upperTargets = cmdServer:GetUpperTargets()
  self.processingCmd = self.effectConfig.cmdServer
  self.beginTime = self.battleEngine:GetCurPassTime()
  if not self.effectConfig.skipPhase then
    self.processingCmd:GetSkillCastTime()
    self.processingCmd:OnEnterBeforePhase(upperTargets)
  end
  self.processingCmd:SendNotAwakerTimeline(self.effectConfig.skipTimeline)
  self.processingCmd:TriggerCmd(self.effectConfig.triggerData, self.effectConfig.skipPhase)
  self:__FireAfterCreateSkillPhase()
  local stateCfg = self.battleEngine.battleDT.State[self.processingCmd.stateId]
  local str = "执行指令: %s 成功"
  if self.processingCmd.stateId then
    str = string.format("[ %s ] ", stateCfg.CnID) .. str
  end
  local cmdCfg = self.battleEngine.battleDT.Cmd[self.processingCmd.cmdId]
  self.battleEngine:LogBattleWithTab(str, cmdCfg.CnID)
  return true
end

function BECreateSkillPhase:AfterEffect()
  if self:CheckSubEffectEmpty() then
    if not self.processingCmd.isDeleted then
      self.processingCmd:OnEnterFinishPhase()
      self.processingCmd:ClearStats()
      self:__FireSkillCmdFinish()
      do return self.RunSubEffect end
      return self.RunSubEffect, self
    else
      do return self.EffectEnd end
      return self.EffectEnd, self
    end
  else
    do return self.RunSubEffect end
    return self.RunSubEffect, self
  end
end

function BECreateSkillPhase:EffectEnd()
  if not self.effectConfig.skipPhase and self.processingCmd then
    local role = self.battleEngine:GetObj(self.processingCmd.castRoleUid)
    if role and role:NeedAfterPhase() then
      local curPassTime = self.battleEngine:GetCurPassTime()
      local duration = self.processingCmd:GetSkillDuration() or 0
      self.battleEngine:AddPassTime(math.max(0, self.beginTime + duration - curPassTime))
    end
  end
  do return Super.EffectEnd end
  return Super.EffectEnd, self, 0, self.battleEngine.AddPassTime, self.battleEngine, math.max(0, self.beginTime + duration - curPassTime)
end

function BECreateSkillPhase:__FireSkillCmdFinish()
  if not self:IsTriggerBST() then
    return
  end
  local eventData = {
    cmdServer = self.processingCmd
  }
  self.battleEngine.eventMgr:SendEvent(BattleLogicEvent.SkillCmdFinish, eventData)
end

function BECreateSkillPhase:__FireAfterCreateSkillPhase()
  if not self:IsTriggerBST() then
    return
  end
  local cardUid = self.effectConfig.cardUid
  local castRoleUid = self.effectConfig.castRoleUid
  local camp = self.effectConfig.camp
  local eventData = {
    cardUid = cardUid,
    castRoleUid = castRoleUid,
    camp = camp
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterCreateSkillPhase, eventData)
end

return BECreateSkillPhase
