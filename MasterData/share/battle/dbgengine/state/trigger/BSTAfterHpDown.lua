local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterHpDown, Super = System.NewClass("BSTAfterHpDown", BattleStateTriggerServer)

function BSTAfterHpDown:OnBeDamage(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if eventData.realDamage <= 0 then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    triggerValue = eventData.realDamage
  }
  self:Trigger(triggerData)
end

function BSTAfterHpDown:OnHpDown(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    },
    triggerValue = math.abs(eventData.deltaValue)
  }
  self:Trigger(triggerData)
end

function BSTAfterHpDown:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeDamage, self.OnBeDamage, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.HpDown, self.OnHpDown, self)
end

return BSTAfterHpDown
