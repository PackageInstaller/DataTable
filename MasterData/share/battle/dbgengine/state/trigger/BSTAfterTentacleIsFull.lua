local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterTentacleIsFull, _ = System.NewClass("BSTAfterTentacleIsFull", BattleStateTriggerServer)

function BSTAfterTentacleIsFull:OnTentacleIsFull(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local associator2 = self.battleEngine.roleMgr:GenMonsterOrPlayerTarget(eventData.castRoleUid)
  local triggerData = {
    associator = {
      self.battleEngine.roleMgr:GetPlayer(triggerCamp)
    },
    associator2 = {associator2},
    triggerValue = eventData.changeType
  }
  self:Trigger(triggerData)
end

function BSTAfterTentacleIsFull:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.TentacleIsFull, self.OnTentacleIsFull, self)
end

return BSTAfterTentacleIsFull
