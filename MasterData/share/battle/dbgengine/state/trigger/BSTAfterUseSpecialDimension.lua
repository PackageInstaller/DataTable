local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterUseSpecialDimension, Super = System.NewClass("BSTAfterUseSpecialDimension", BattleStateTriggerServer)

function BSTAfterUseSpecialDimension:OnUseSpecialDimension(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local triggerData = {
    associator = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTAfterUseSpecialDimension:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseSpecialDimension, self.OnUseSpecialDimension, self)
end

return BSTAfterUseSpecialDimension
