local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterRunKeeperSkillCmd, Super = System.NewClass("BSTAfterRunKeeperSkillCmd", BattleStateTriggerServer)

function BSTAfterRunKeeperSkillCmd:AfterRunKeeperSkillCmd(eventData)
  if self.state.isDeleted then
    return
  end
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(curCamp) then
    return
  end
  local upperTargets = eventData.cmdServer:GetUpperTargets()
  local triggerData = {associator = upperTargets}
  self:Trigger(triggerData)
end

function BSTAfterRunKeeperSkillCmd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterRunKeeperSkillCmd, self.AfterRunKeeperSkillCmd, self)
end

return BSTAfterRunKeeperSkillCmd
