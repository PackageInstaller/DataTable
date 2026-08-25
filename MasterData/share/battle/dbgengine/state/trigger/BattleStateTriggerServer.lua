local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleStateTriggerServer, Super = System.NewClass("BattleStateTriggerServer")

function BattleStateTriggerServer:ctor(state, callback, cbParams, triggerType)
  Super.ctor(self, state)
  self.state = state
  self.battleEngine = state.battleEngine
  self.triggerValue = 0
  self.callback = callback
  self.cbParams = cbParams or {}
  self.triggerType = triggerType
  self.eventPriority = state.eventPriority
  self:RegisterCallbacks()
end

function BattleStateTriggerServer:Dispose()
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

function BattleStateTriggerServer:RegisterCallbacks()
end

function BattleStateTriggerServer:IsCare(careRoleUid, careAwakerUid, careCardUid)
  local DT = self.battleEngine.battleDT
  local triggerName = self.__name
  local cfg = DT.BattleApi[triggerName]
  if not cfg then
    return
  end
  local owner = self.state.owner
  if owner:IsRoleType(bc.RoleType.Player, bc.RoleType.Monster) then
    if careRoleUid ~= owner.uid then
      return false
    end
  elseif owner:IsRoleType(bc.RoleType.Awaker) then
    local player = self.owner:GetPlayer()
    if careRoleUid ~= player.uid then
      return false
    end
  elseif owner:is(BattleCardServer) and cfg.ApiType == bc.ApiType.CARD_TRIGGER then
    if careCardUid ~= owner.uid then
      return false
    end
  elseif owner:is(BattleCardServer) and cfg.ApiType == bc.ApiType.ROLE_TRIGGER then
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    if careRoleUid and careRoleUid ~= player.uid then
      return false
    end
  end
  return true
end

function BattleStateTriggerServer:TryTrigger(triggerCamp, roleUid)
  if self.state.isDeleted then
    return false
  end
  local owner = self.state.owner
  if roleUid and owner:IsRoleType(bc.RoleType.Monster) then
    return owner.uid == roleUid
  end
  if self.cbParams.isEnemy then
    return self.state.owner:GetCamp() ~= triggerCamp
  end
  return self.state.owner:GetCamp() == triggerCamp
end

function BattleStateTriggerServer:Trigger(triggerData)
  triggerData = triggerData or {}
  local DT = self.battleEngine.battleDT
  local name = self.cbParams.triggerFullName
  self.battleEngine:LogBattleWithTab("%s [ %s - uid %s ]  触发。触发器 [ %s ]", self.state.owner:GetBattleLogName(), self.state.configData.CnID, self.state.uid, DT.BattleApi[name].CnID)
  if self.triggerType == bc.StateTriggerType.Effect then
    local ignoreDead = self.state.configData.DeathHandling == bc.StateDeathHandling.NonWipe_AllowTrigger
    triggerData.ignoreDead = triggerData.ignoreDead == nil and ignoreDead or triggerData.ignoreDead
  end
  self.callback(self.state, self.cbParams, triggerData)
end

return BattleStateTriggerServer
