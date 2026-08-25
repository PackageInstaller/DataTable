local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeUseSpecialDimension, Super = System.NewClass("BSTBeforeUseSpecialDimension", BattleStateTriggerServer)

function BSTBeforeUseSpecialDimension:OnUseSpecialDimension(eventData)
  local transcendentSkillId = self.battleEngine.battleDT.GetConstant("TranscendentCmd")
  if not transcendentSkillId or eventData.skillId ~= transcendentSkillId then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeUseSpecialDimension:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BeforeUseOtherSkill, self.OnUseSpecialDimension, self)
end

return BSTBeforeUseSpecialDimension
