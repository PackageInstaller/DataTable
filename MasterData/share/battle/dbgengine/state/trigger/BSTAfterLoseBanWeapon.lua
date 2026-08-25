local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterLoseBanWeapon, _ = System.NewClass("BSTAfterLoseBanWeapon", BattleStateTriggerServer)

function BSTAfterLoseBanWeapon:OnBanPVPWeaponAction(eventData)
  if self.state.isDeleted then
    return
  end
  if self.state.owner.uid ~= eventData.targetRoleUid then
    return
  end
  if eventData.action ~= bc.BanPVPWeaponAction.Release then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterLoseBanWeapon:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BanPVPWeaponAction, self.OnBanPVPWeaponAction, self)
end

return BSTAfterLoseBanWeapon
