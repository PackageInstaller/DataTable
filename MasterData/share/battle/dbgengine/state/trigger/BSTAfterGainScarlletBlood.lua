local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterGainScarlletBlood, Super = System.NewClass("BSTAfterGainScarlletBlood", BattleStateTriggerServer)

function BSTAfterGainScarlletBlood:OnGainScarlletBlood(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  local associator2 = self.battleEngine.roleMgr:GenMonsterOrPlayerTarget(eventData.castRoleUid)
  local triggerData = {
    triggerValue = eventData.changedValue,
    associator = {castRole},
    associator2 = {associator2}
  }
  self:Trigger(triggerData)
end

function BSTAfterGainScarlletBlood:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.GainScarletBlood, self.OnGainScarlletBlood, self)
end

return BSTAfterGainScarlletBlood
