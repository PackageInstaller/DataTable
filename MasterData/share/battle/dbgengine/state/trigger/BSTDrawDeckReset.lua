local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTDrawDeckReset, Super = System.NewClass("BSTDrawDeckReset", BattleStateTriggerServer)

function BSTDrawDeckReset:OnShuffleCards(eventData)
  local triggerCamp = self.battleEngine.boutMgr:GetCurCamp()
  if not self:TryTrigger(triggerCamp) then
    return
  end
  local ownerCamp = eventData.ownerCamp or bc.BattleCamp.Camp1
  local ownerPlayer = self.battleEngine.roleMgr:GetPlayer(ownerCamp)
  local triggerData = {
    associator = ownerPlayer and {ownerPlayer} or {}
  }
  self:Trigger(triggerData)
end

function BSTDrawDeckReset:TryTrigger(triggerCamp, roleUid)
  if self.state.isDeleted then
    return false
  end
  local owner = self.state.owner
  if roleUid and owner:IsRoleType(bc.RoleType.Monster) then
    return owner.uid == roleUid
  end
  return true
end

function BSTDrawDeckReset:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.ShuffleCards, self.OnShuffleCards, self)
end

return BSTDrawDeckReset
