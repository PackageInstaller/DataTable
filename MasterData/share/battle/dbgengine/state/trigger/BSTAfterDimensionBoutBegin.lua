local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterDimensionBoutBegin, Super = System.NewClass("BSTAfterDimensionBoutBegin", BattleStateTriggerServer)

function BSTAfterDimensionBoutBegin:OnBFAfterBoutBegin(isExtraBout)
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

function BSTAfterDimensionBoutBegin:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutBegin, self.OnBFAfterBoutBegin, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ImplementDimensionSpace, self.OnBFAfterBoutBegin, self)
end

return BSTAfterDimensionBoutBegin
