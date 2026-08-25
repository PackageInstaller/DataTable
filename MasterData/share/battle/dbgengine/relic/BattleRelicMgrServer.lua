local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BP = bc.BattleProperty
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleRelicMgrServer, Super = System.NewClass("BattleRelicMgrServer", BattleEngineComponent)

function BattleRelicMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.data = {
    relics = battleEngine.data.relics,
    addRelic = {},
    removeRelic = {},
    battleEndRemove = {},
    battleEndAdd = {}
  }
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateOnAdd, self.OnStateOnAdd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBattleEnd, self)
end

function BattleRelicMgrServer:Serialize()
  return {
    relics = self.data.relics,
    addRelic = self.data.addRelic,
    removeRelic = self.data.removeRelic
  }
end

function BattleRelicMgrServer:OnSnapShot()
  return {
    data = self.data
  }
end

function BattleRelicMgrServer:OnRecover(relicData)
  if relicData and relicData.data then
    self.data = relicData.data
    self.battleEngine.data.relics = self.data.relics
  end
end

function BattleRelicMgrServer:GetBattleFinishData()
  if self.data.relics and next(self.data.relics) then
    for _, relic in ipairs(self.data.relics) do
      relic.stateUid2TargetUid = nil
    end
  end
  return self.data
end

function BattleRelicMgrServer:OnBattleEnd()
  local battleEndRemove = self.data.battleEndRemove
  if battleEndRemove and next(battleEndRemove) then
    for tid, _ in pairs(battleEndRemove) do
      self.battleEngine:InfoS("OnBattleEnd RemoveRelic {tid}", tid)
      self:RemoveRelic(tid)
    end
  end
  local battleEndAdd = self.data.battleEndAdd
  if battleEndAdd and next(battleEndAdd) then
    for tid, _ in pairs(battleEndAdd) do
      self.battleEngine:InfoS("OnBattleEnd AddRelic {tid}", tid)
      self:AddRelic(nil, tid)
    end
  end
end

function BattleRelicMgrServer:GetRelicByTid(tid, camp)
  camp = camp or bc.BattleCamp.Camp1
  for index, relic in ipairs(self.data.relics) do
    local relicCamp = relic.camp or bc.BattleCamp.Camp1
    if relic.tid == tid and relicCamp == camp then
      return relic, index
    end
  end
end

function BattleRelicMgrServer:OnStateOnAdd(eventData)
  if eventData and eventData.createArgs and eventData.createArgs.source and next(eventData.createArgs.source) and eventData.stateUid then
    local stateUid = eventData.stateUid
    for _, source in ipairs(eventData.createArgs.source) do
      if source.sourceType == bc.SourceType.Relic then
        local relicTid = source.tid
        local relic = self:GetRelicByTid(relicTid, source.camp)
        if not relic then
        else
          table.insert(relic.stateUids, stateUid)
          if not relic.stateUid2TargetUid then
            relic.stateUid2TargetUid = {}
          end
          relic.stateUid2TargetUid[stateUid] = eventData.createArgs.targetUid
          self.battleEngine:InfoS("OnStateOnAdd {relic}", table.tostring(relic))
        end
      end
    end
  end
end

function BattleRelicMgrServer:IsRelicFull()
  local player = self.battleEngine.roleMgr:GetPlayer()
  return self.battleEngine:GetRelicCount() >= player:GetProperty(BP.relic_num_limit)
end

function BattleRelicMgrServer:TryAddRelic(tid, camp)
  camp = camp or bc.BattleCamp.Camp1
  self.battleEngine:InfoS("TryAddRelic {relicTid} {camp}", tid, camp)
  if not self.data.relics then
    self.data.relics = {}
  end
  local relic = self:GetRelicByTid(tid, camp)
  if relic then
    self.battleEngine:InfoS("TryAddRelic {tid} exist", tid)
    return
  end
  local relicCfg = self.battleEngine.battleDT.RelicConfig[tid]
  if not relicCfg then
    self.battleEngine:InfoS("TryAddRelic no config {tid}", tid)
    return
  end
  if self:IsRelicFull() then
    self.battleEngine:InfoS("TryAddRelic full {tid}", tid)
    return
  end
  relic = {
    uid = self.battleEngine:GenUid(),
    tid = tid,
    stateUids = {},
    descArgs = {},
    stateUid2TargetUid = {},
    camp = camp
  }
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  local ctorData = {
    castRoleUid = player.uid
  }
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  for index, v in pairs(relicCfg.StatePara or {}) do
    if type(v) == "string" then
      relic.descArgs[index] = cmdParser:GetValueByCmd(v)
    end
  end
  return relic
end

function BattleRelicMgrServer:AddRelic(cmdServer, tid, life, camp)
  local relic, relicTid
  if type(tid) == "number" then
    relic = self:TryAddRelic(tid, camp)
    relicTid = tid
  else
    relic = tid
    relicTid = tid.tid
  end
  if not relic then
    return
  end
  table.insert(self.data.relics, relic)
  self.battleEngine.recordMgr:OnAddNewRelic(relic)
  if life and life == bc.RelicLife.Battle then
    local battleEndRemove = self.data.battleEndRemove
    battleEndRemove[relicTid] = true
  else
    self.data.addRelic[relicTid] = true
    self.data.removeRelic[relicTid] = nil
  end
  self.battleEngine:InfoS("AddRelic {relicTid} {relic}", relicTid, table.tostring(relic))
  self:AddRelicState(cmdServer, relicTid, camp)
  return relic
end

function BattleRelicMgrServer:AddRelicState(cmdServer, tid, camp)
  camp = camp or bc.BattleCamp.Camp1
  self.battleEngine:InfoS("AddRelicState {tid}", tid)
  local relicConfig = self.battleEngine.battleDT.RelicConfig[tid]
  if not cmdServer then
    local cmdCtorData = {
      castRoleUid = self.battleEngine.roleMgr:GetPlayer(camp) and self.battleEngine.roleMgr:GetPlayer(camp).uid
    }
    cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
  end
  for i = 1, 2 do
    local stateList = relicConfig["State" .. i]
    if not stateList or next(stateList) == nil then
    else
      local layer = relicConfig["StateLayer" .. i]
      for _, stateTid in pairs(stateList) do
        local effectType = bc.BattleEffectType.BEAddState
        local effectConfig = {
          effectType = effectType,
          source = {
            {
              sourceType = bc.SourceType.Relic,
              tid = tid,
              layer = layer,
              camp = camp
            }
          },
          params = {stateTid, layer},
          cmdServer = cmdServer,
          cmdCfg = {
            Target = relicConfig["StateTarget" .. i]
          },
          castRoleUid = cmdServer and cmdServer.castRoleUid,
          noDirectCmd = true
        }
        if relicConfig.StatePara and next(relicConfig.StatePara) then
          for _, param in ipairs(relicConfig.StatePara) do
            table.insert(effectConfig.params, param)
          end
        end
        self.battleEngine.effectMgr:CreateEffect(effectConfig)
      end
    end
  end
end

function BattleRelicMgrServer:RemoveRelic(tid, life, camp)
  camp = camp or bc.BattleCamp.Camp1
  local relic, index = self:GetRelicByTid(tid, camp)
  if not relic then
    self.battleEngine:InfoS("RemoveRelic {relicTid} no exist", tid)
    return
  end
  self.battleEngine:InfoS("RemoveRelic {relicTid} {relic}", tid, table.tostring(relic))
  if relic.stateUids and next(relic.stateUids) then
    for _, stateUid in ipairs(relic.stateUids) do
      if not relic.stateUid2TargetUid or not relic.stateUid2TargetUid[stateUid] then
        self.battleEngine:InfoS("RemoveRelic {relicTid} {stateUid} {relic} not relic stateUid2TargetUid", tid, stateUid, table.tostring(relic))
        local state = self.battleEngine:GetObj(stateUid)
        if state then
          self.battleEngine:InfoS("RemoveRelic SubLayerBySource {stateUid} {relic} not relic stateUid2TargetUid", tid, stateUid, table.tostring(relic))
          state:SubLayerBySource(bc.SourceType.Relic, tid, camp)
        end
      else
        local targetUid = relic.stateUid2TargetUid[stateUid]
        local state = self.battleEngine.stateMgr:GetStateByUid(targetUid, stateUid)
        self.battleEngine.stateMgr:RemoveState(state)
      end
    end
  end
  table.remove(self.data.relics, index)
  self.battleEngine.recordMgr:OnRemoveRelic(tid)
  if life and life == bc.RelicLife.Battle then
    local battleEndAdd = self.data.battleEndAdd
    battleEndAdd[tid] = true
  else
    self.data.addRelic[tid] = nil
    self.data.removeRelic[tid] = true
  end
  self.battleEngine:InfoS("RemoveRelic {relicTid} {relic}", tid, table.tostring(relic))
end

return BattleRelicMgrServer
