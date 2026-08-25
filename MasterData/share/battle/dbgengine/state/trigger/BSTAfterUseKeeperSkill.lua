local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterUseKeeperSkill, Super = System.NewClass("BSTAfterUseKeeperSkill", BattleStateTriggerServer)

function BSTAfterUseKeeperSkill:AfterUseKeeperSkill(eventData)
  if self.state.isDeleted then
    return
  end
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local upperTargets = eventData.cmdServer:GetUpperTargets()
  local cost = eventData.cmdServer:GetMemberValue("keeper_energy_cost")
  local triggerData = {
    associator = upperTargets,
    associator2 = {
      eventData.keeperSkill
    },
    triggerValue = cost
  }
  self:Trigger(triggerData)
end

function BSTAfterUseKeeperSkill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseKeeperSkill, self.AfterUseKeeperSkill, self)
end

return BSTAfterUseKeeperSkill
