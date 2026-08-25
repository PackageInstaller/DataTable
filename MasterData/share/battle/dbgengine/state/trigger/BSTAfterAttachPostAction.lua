local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTAfterAttachPostAction, Super = System.NewClass("BSTAfterAttachPostAction", BattleStateTriggerServer)

function BSTAfterAttachPostAction:OnAfterAttachPostAction(eventData)
  local executorUid = eventData.executorUid
  local cmdServerUid = eventData.cmdServerUid
  local skillTid = eventData.skillTid
  local executor = self.battleEngine:GetObj(executorUid)
  if not executor then
    return
  end
  local cmdServer = self.battleEngine:GetObj(cmdServerUid)
  if not cmdServer then
    return
  end
  local producer = self.battleEngine.roleMgr:GetCurCaster()
  if not producer then
    return
  end
  local associator = {producer}
  local associator2 = {executor}
  local associator3 = {skillTid}
  local associator4 = cmdServer:GetUpperTargets()
  local triggerData = {
    associator = associator,
    associator2 = associator2,
    associator3 = associator3,
    associator4 = associator4
  }
  self:Trigger(triggerData)
end

function BSTAfterAttachPostAction:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterAttachPostAction, self.OnAfterAttachPostAction, self)
end

return BSTAfterAttachPostAction
