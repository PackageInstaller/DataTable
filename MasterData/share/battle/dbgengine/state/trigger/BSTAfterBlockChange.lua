local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBlockChange, Super = System.NewClass("BSTAfterBlockChange", BattleStateTriggerServer)

function BSTAfterBlockChange:OnBlockChange(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local associator2 = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerData = {
    castRoleUid = eventData.castRoleUid,
    triggerValue = eventData.castValue,
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    },
    associator2 = {associator2}
  }
  self:Trigger(triggerData)
end

function BSTAfterBlockChange:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BlockChange, self.OnBlockChange, self)
end

return BSTAfterBlockChange
