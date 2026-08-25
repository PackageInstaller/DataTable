local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BSTHpperChanged, Super = System.NewClass("BSTHpperChanged", BattleStateTriggerServer)

function BSTHpperChanged:OnRoleperHpChanged(eventData)
  local targetRole = self.battleEngine:GetObj(eventData.uid)
  local triggerCamp = targetRole:GetCamp()
  if not self:TryTrigger(triggerCamp, eventData.uid) then
    return
  end
  local associator = self.battleEngine:GetObj(eventData.castRoleUid)
  if not eventData.max_hp or 0 == eventData.max_hp then
    return
  end
  local changeVal = BattleUtilServer.KeepXDecimal((eventData.newValue / eventData.max_hp - eventData.oldValue / eventData.max_hp) * 100)
  if eventData.propertyName == BP.max_hp then
    if not (eventData.newValue and eventData.oldValue) or 0 == eventData.newValue or 0 == eventData.oldValue then
      return
    end
    changeVal = BattleUtilServer.KeepXDecimal((eventData.hp / eventData.newValue - eventData.hp / eventData.oldValue) * 100)
  end
  local triggerData = {
    associator = {associator},
    triggerValue = changeVal
  }
  self:Trigger(triggerData)
end

function BSTHpperChanged:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleHpperChanged, self.OnRoleperHpChanged, self)
end

return BSTHpperChanged
