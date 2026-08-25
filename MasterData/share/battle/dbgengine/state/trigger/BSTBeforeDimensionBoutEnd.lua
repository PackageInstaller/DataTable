local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeDimensionBoutEnd, Super = System.NewClass("BSTBeforeDimensionBoutEnd", BattleStateTriggerServer)

function BSTBeforeDimensionBoutEnd:OnBFBeforeBoutEnd(isExtraBout)
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

function BSTBeforeDimensionBoutEnd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutEnd, self.OnBFBeforeBoutEnd, self)
end

return BSTBeforeDimensionBoutEnd
