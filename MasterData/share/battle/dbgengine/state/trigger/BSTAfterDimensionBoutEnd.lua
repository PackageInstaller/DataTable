local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDimensionBoutEnd, Super = System.NewClass("BSTAfterDimensionBoutEnd", BattleStateTriggerServer)

function BSTAfterDimensionBoutEnd:OnBFAfterBoutEnd(isExtraBout)
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

function BSTAfterDimensionBoutEnd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutEnd, self.OnBFAfterBoutEnd, self)
end

return BSTAfterDimensionBoutEnd
