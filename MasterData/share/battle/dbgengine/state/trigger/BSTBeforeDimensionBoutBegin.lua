local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeDimensionBoutBegin, Super = System.NewClass("BSTBeforeDimensionBoutBegin", BattleStateTriggerServer)

function BSTBeforeDimensionBoutBegin:OnBFBeforeBoutBegin(isExtraBout)
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  if not isExtraBout then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeDimensionBoutBegin:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutBegin, self.OnBFBeforeBoutBegin, self)
end

return BSTBeforeDimensionBoutBegin
