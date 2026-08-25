local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTBeforeBattleEndInPlayerBout, _ = System.NewClass("BSTBeforeBattleEndInPlayerBout", BattleStateTriggerServer)

function BSTBeforeBattleEndInPlayerBout:OnBFBattleEnd()
  if self.state.isDeleted then
    return
  end
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  if camp ~= bc.BattleCamp.Camp1 then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTBeforeBattleEndInPlayerBout:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBFBattleEnd, self)
end

return BSTBeforeBattleEndInPlayerBout
