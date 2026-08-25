local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterSkillCmdFinish, Super = System.NewClass("BSTAfterSkillCmdFinish", BattleStateTriggerServer)

function BSTAfterSkillCmdFinish:OnSkillCmdFinish(eventData)
  if not eventData.cmdServer.cardUid then
    return
  end
  if self.state.owner.uid ~= eventData.cmdServer.cardUid then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cmdServer.cardUid)
  if not card then
    return
  end
  local triggerCamp = card:GetCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {
    associator = {card},
    associator2 = eventData.cmdServer.upperTargets
  }
  self:Trigger(triggerData)
end

function BSTAfterSkillCmdFinish:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.SkillCmdFinish, self.OnSkillCmdFinish, self)
end

return BSTAfterSkillCmdFinish
