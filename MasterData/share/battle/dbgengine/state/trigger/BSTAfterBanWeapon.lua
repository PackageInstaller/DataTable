local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTAfterBanWeapon, Super = System.NewClass("BSTAfterBanWeapon", BattleStateTriggerServer)

function BSTAfterBanWeapon:OnBanPVPWeaponAction(eventData)
  if self.state.isDeleted then
    return
  end
  if self.state.owner.uid ~= eventData.targetRoleUid then
    return
  end
  if eventData.action ~= bc.BanPVPWeaponAction.Ban then
    return
  end
  local triggerData = {}
  self:Trigger(triggerData)
end

function BSTAfterBanWeapon:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BanPVPWeaponAction, self.OnBanPVPWeaponAction, self)
end

return BSTAfterBanWeapon
