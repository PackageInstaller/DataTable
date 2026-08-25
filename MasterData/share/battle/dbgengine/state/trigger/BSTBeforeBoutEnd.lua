local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTBeforeBoutEnd, Super = System.NewClass("BSTBeforeBoutEnd", BattleStateTriggerServer)

function BSTBeforeBoutEnd:OnBeforeBoutEnd()
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeBoutEnd:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutEnd, self.OnBeforeBoutEnd, self)
end

return BSTBeforeBoutEnd
