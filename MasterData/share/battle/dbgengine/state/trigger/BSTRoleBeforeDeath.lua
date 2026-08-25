local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTRoleBeforeDeath, Super = System.NewClass("BSTRoleBeforeDeath", BattleStateTriggerServer)

function BSTRoleBeforeDeath:OnRoleBeforeDeath(eventData)
  local target = self.battleEngine:GetObj(eventData.targetRoleUid)
  local triggerCamp = target:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.targetRoleUid) then
    return
  end
  if self.state.owner.uid ~= eventData.targetRoleUid then
    return
  end
  if target:GetProperty(bc.RoleProperty.hp) > 0 then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.castRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTRoleBeforeDeath:RegisterCallbacks()
  self.battleEngine:RegisterEventToHead(BattleLogicEvent.RoleBeforeDeath, self.OnRoleBeforeDeath, self)
end

return BSTRoleBeforeDeath
