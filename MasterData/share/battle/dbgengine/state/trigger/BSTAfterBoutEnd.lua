local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterBoutEnd, Super = System.NewClass("BSTAfterBoutEnd", BattleStateTriggerServer)

function BSTAfterBoutEnd:OnBFAfterBoutEnd()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterBoutEnd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutEnd, self.OnBFAfterBoutEnd, self)
end

return BSTAfterBoutEnd
