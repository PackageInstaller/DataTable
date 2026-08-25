local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBoutBegin, Super = System.NewClass("BSTAfterBoutBegin", BattleStateTriggerServer)

function BSTAfterBoutBegin:OnBFAfterBoutBegin()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  self:Trigger()
end

function BSTAfterBoutBegin:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutBegin, self.OnBFAfterBoutBegin, self)
end

return BSTAfterBoutBegin
