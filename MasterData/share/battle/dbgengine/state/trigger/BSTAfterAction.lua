local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterAction, Super = System.NewClass("BSTAfterAction", BattleStateTriggerServer)

function BSTAfterAction:OnAfterUseCard(eventData)
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self:OnAfterAction(eventData.castRoleUid)
end

function BSTAfterAction:OnAfterUseUltiSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self:OnAfterAction(eventData.castRoleUid)
end

function BSTAfterAction:OnAfterUseKeeperSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self:OnAfterAction(eventData.castRoleUid)
end

function BSTAfterAction:OnAfterUseOtherSkill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self:OnAfterAction(eventData.castRoleUid)
end

function BSTAfterAction:OnAfterMonsterAction(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  self:OnAfterAction(eventData.castRoleUid)
end

function BSTAfterAction:OnAfterAction(castRoleUid)
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterAction:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseCard, self.OnAfterUseCard, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseUltiSkill, self.OnAfterUseUltiSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseKeeperSkill, self.OnAfterUseKeeperSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterMonsterAction, self.OnAfterMonsterAction, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseOtherSkill, self.OnAfterUseOtherSkill, self)
end

return BSTAfterAction
