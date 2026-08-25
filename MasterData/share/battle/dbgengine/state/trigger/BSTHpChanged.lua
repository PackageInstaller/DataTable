local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTHpChanged, Super = System.NewClass("BSTHpChanged", BattleStateTriggerServer)

function BSTHpChanged:OnRoleHpChanged(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.uid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.uid) then
    return
  end
  local associator = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerData = {
    associator = {associator},
    triggerValue = eventData.newValue - eventData.oldValue
  }
  self:Trigger(triggerData)
end

function BSTHpChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleHpChanged, self.OnRoleHpChanged, self)
end

return BSTHpChanged
