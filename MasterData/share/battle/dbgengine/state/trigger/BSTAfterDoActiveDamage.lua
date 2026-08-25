local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterDoActiveDamage, Super = System.NewClass("BSTAfterDoActiveDamage", BattleStateTriggerServer)

function BSTAfterDoActiveDamage:OnDoDamage(eventData)
  local castRole = self.battleEngine:GetObj(eventData.castRoleUid)
  if not castRole then
    self.battleEngine:Error("触发造成主动伤害后失败：找不到施法者", self.state.stateId, eventData.castRoleUid)
    return
  end
  local triggerCamp = castRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.castRoleUid) then
    return
  end
  if eventData.damageType ~= bc.DamageType.Active then
    return
  end
  local blockType = self.cbParams.triggerPara
  local triggerValue, triggerValue2
  if blockType == bc.DamageTriggerType.None then
    triggerValue = eventData.castDamage
  elseif blockType == bc.DamageTriggerType.AttachPostAction then
    local cmdServer
    if eventData.fromCmdServerUid then
      cmdServer = self.battleEngine:GetObj(eventData.fromCmdServerUid)
    end
    if not cmdServer or not cmdServer:IsAttachPost() then
      return
    end
    triggerValue = eventData.castDamage
    triggerValue2 = eventData.realDamage
  elseif blockType == bc.DamageTriggerType.Unblocked then
    if eventData.realDamage <= 0 then
      return
    end
    triggerValue = eventData.castDamage
    triggerValue2 = eventData.realDamage
  elseif blockType == bc.DamageTriggerType.CritDamage then
    if not eventData.isCrit then
      return
    end
    triggerValue = eventData.castDamage
  end
  local associator2 = castRole
  local triggerData = {
    associator = {
      self.battleEngine:GetObj(eventData.targetRoleUid)
    },
    associator2 = {associator2},
    triggerValue = triggerValue,
    triggerValue2 = triggerValue2
  }
  self:Trigger(triggerData)
end

function BSTAfterDoActiveDamage:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoDamage, self.OnDoDamage, self)
end

return BSTAfterDoActiveDamage
