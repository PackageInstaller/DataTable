local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BSTCardRemoveDimension, Super = System.NewClass("BSTCardRemoveDimension", BattleStateTriggerServer)

function BSTCardRemoveDimension:OnCardRemoveDimension(eventData)
  if self.state.isDeleted then
    return
  end
  local cardUidList = eventData.cardUidList
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local associator2 = self.battleEngine:GetObj(eventData.castRoleUid)
  local removeCount = 0
  local stateAwakerUid = self.state.owner:IsRoleType(bc.RoleType.Awaker) and self.state.owner.uid
  for _, cardUid in ipairs(cardUidList or {}) do
    local cardObj = self.battleEngine:GetObj(cardUid) or {}
    if cardObj and (not stateAwakerUid or cardObj.owner.uid == stateAwakerUid) then
      removeCount = removeCount + 1
    end
  end
  if removeCount > 0 then
    local triggerData = {
      associator = {player},
      triggerValue = removeCount,
      associator2 = {associator2}
    }
    self:Trigger(triggerData)
  end
end

function BSTCardRemoveDimension:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardRemoveDimension, self.OnCardRemoveDimension, self)
end

return BSTCardRemoveDimension
