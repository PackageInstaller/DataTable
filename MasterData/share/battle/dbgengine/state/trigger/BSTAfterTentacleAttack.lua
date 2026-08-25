local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterTentacleAttack, Super = System.NewClass("BSTAfterTentacleAttack", BattleStateTriggerServer)

function BSTAfterTentacleAttack:OnTentacleAttack(eventData)
  local castRoleUid = eventData.castRoleUid
  local castRole = self.battleEngine:GetObj(castRoleUid)
  if not castRole then
    self.battleEngine:Error("触发造成触腕伤害后失败：找不到施法者", self.state.stateId, castRoleUid)
    return
  end
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, castRoleUid) then
    return
  end
  local triggerData = {
    triggerValue = eventData.castDamage,
    associator = {
      self.battleEngine:GetObj(eventData.destRoleUid)
    }
  }
  self:Trigger(triggerData)
end

function BSTAfterTentacleAttack:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.TentacleAttack, self.OnTentacleAttack, self)
end

return BSTAfterTentacleAttack
