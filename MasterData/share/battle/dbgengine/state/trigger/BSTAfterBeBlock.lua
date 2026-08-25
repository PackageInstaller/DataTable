local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBeBlock, Super = System.NewClass("BSTAfterBeBlock", BattleStateTriggerServer)

function BSTAfterBeBlock:OnBeBlock(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  local triggerData = {
    castRoleUid = eventData.castRoleUid,
    triggerValue = eventData.castValue,
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterBeBlock:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeBlock, self.OnBeBlock, self)
end

return BSTAfterBeBlock
