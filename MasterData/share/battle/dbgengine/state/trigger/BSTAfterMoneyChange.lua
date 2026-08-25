local System = require("System.System")
local BattleConst = require("Battle.BattleConst")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterMoneyChange, Super = System.NewClass("BSTAfterMoneyChange", BattleStateTriggerServer)

function BSTAfterMoneyChange:OnChangeMoney(eventData)
  if self.state.isDeleted then
    return
  end
  local triggerData = {
    triggerValue = eventData.value,
    triggerValue2 = BattleConst.MoneyChangeSource.InBattle
  }
  self:Trigger(triggerData)
end

function BSTAfterMoneyChange:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ChangeMoney, self.OnChangeMoney, self)
end

return BSTAfterMoneyChange
