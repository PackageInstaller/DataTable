local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTBeforeAction, Super = System.NewClass("BSTBeforeAction", BattleStateTriggerServer)

function BSTBeforeAction:OnBeforeUseCard(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local upperTargets = card.cmdServer:GetUpperTargets()
  self:OnBeforeAction(eventData.castRoleUid, upperTargets)
end

function BSTBeforeAction:OnBeforeUseUltiSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if not castRole:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("触发行动前（唤醒体使用狂气爆发前）失败：找不到唤醒体", self.state.stateId, eventData.castRoleUid)
    return
  end
  local upperTargets = eventData.cmdServer:GetUpperTargets() or {}
  self:OnBeforeAction(eventData.castRoleUid, upperTargets)
end

function BSTBeforeAction:OnBeforeUseKeeperSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local upperTargets = eventData.cmdServer:GetUpperTargets() or {}
  self:OnBeforeAction(nil, upperTargets)
end

function BSTBeforeAction:OnBeforeMonsterAction(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local cmdServer = castRole.monsterBehaviorComp and castRole.monsterBehaviorComp.intentionCmdServer
  local upperTargets = cmdServer and cmdServer:GetUpperTargets() or {}
  self:OnBeforeAction(eventData.castRoleUid, upperTargets)
end

function BSTBeforeAction:OnBeforeUseOtherSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local upperTargets = eventData.cmdServer:GetUpperTargets() or {}
  self:OnBeforeAction(eventData.castRoleUid, upperTargets)
end

function BSTBeforeAction:OnBeforeAction(castRoleUid, upperTargets)
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(castRoleUid)
    },
    associator2 = upperTargets
  }
  self:Trigger(triggerData)
end

function BSTBeforeAction:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseCard, self.OnBeforeUseCard, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseUltiSkill, self.OnBeforeUseUltiSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseKeeperSkill, self.OnBeforeUseKeeperSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeMonsterAction, self.OnBeforeMonsterAction, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseOtherSkill, self.OnBeforeUseOtherSkill, self)
end

return BSTBeforeAction
