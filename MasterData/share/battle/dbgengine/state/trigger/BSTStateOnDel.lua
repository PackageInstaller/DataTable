local System = require("System.System")
local BattleStateTriggerServer = require("Battle.DbgEngine.State.Trigger.BattleStateTriggerServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BSTStateOnDel, Super = System.NewClass("BSTStateOnDel", BattleStateTriggerServer)

function BSTStateOnDel:StateOnDel(eventData)
  if self.state.isDeleted then
    return
  end
  local createArgs = eventData.createArgs
  local cfgKey
  if self.cbParams.triggerPara then
    cfgKey = "BSTStateOnDel." .. self.cbParams.triggerPara
  else
    cfgKey = "BSTStateOnDel"
  end
  local DT = self.battleEngine.battleDT
  local apiCfg = DT.BattleApi[cfgKey]
  if not apiCfg then
    return
  end
  local castRole = self.battleEngine:GetObj(createArgs.castRoleUid)
  if not castRole then
    self.battleEngine:Error("触发状态删除后失败：找不到施法者", self.state.stateId, createArgs.castRoleUid)
    return
  end
  local isCare = false
  if apiCfg.Data then
    if not self:TryTrigger(castRole:GetCamp(), eventData.castRoleUid) then
      return
    end
    local careStateIdList = string.split(apiCfg.Data, ",")
    for _, stateId in ipairs(careStateIdList) do
      if tonumber(stateId) == createArgs.stateId then
        isCare = true
        break
      end
    end
  else
    isCare = self.state.uid == eventData.stateUid
  end
  if not isCare then
    return
  end
  local targetState = self.battleEngine:GetObj(eventData.stateUid)
  local associator
  if targetState then
    associator = self.battleEngine:GetObj(targetState.owner.uid)
  else
    self.battleEngine:Error("触发状态删除后有误，找不到状态", self.state.stateId, eventData.stateUid)
    return
  end
  local triggerData = {
    triggerValue = createArgs.layer,
    associator = {associator},
    associator2 = {castRole}
  }
  self:Trigger(triggerData)
end

function BSTStateOnDel:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateOnDel, self.StateOnDel, self)
end

return BSTStateOnDel
