local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTActiveDamageKill, Super = System.NewClass("BSTActiveDamageKill", BattleStateTriggerServer)

function BSTActiveDamageKill:SetEnv()
  self.eventId = BattleLogicEvent.ActiveDamageKill
  self.triggerFunc = self.ActiveDamageKill
end

function BSTActiveDamageKill:ActiveDamageKill(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("主动伤害造成击杀触发器错误：找不到施法者", self.state.stateId, eventData.castRoleUid)
    return
  end
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if eventData.damageType ~= bc.DamageType.Active then
    return
  end
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    },
    associator2 = {castRole},
    triggerValue = eventData.overflowDamage
  }
  self:Trigger(triggerData)
end

function BSTActiveDamageKill:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ActiveDamageKill, self.ActiveDamageKill, self)
end

return BSTActiveDamageKill
