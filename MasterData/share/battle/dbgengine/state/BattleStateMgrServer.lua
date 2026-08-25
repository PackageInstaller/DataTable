local System = require("System.System")
local BattleStateServer = require("Battle.DbgEngine.State.BattleStateServer")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleActionStatsUtil = require("Battle.DbgEngine.Stats.BattleActionStatsUtil")
local BattleStateMgrServer, Super = System.NewClass("BattleStateMgr", BattleEngineComponent)

function BattleStateMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleDead, self.OnRoleDead, self)
  self.ownerUid2StateList = {}
end

function BattleStateMgrServer:ctorData()
  local data = Super.ctorData(self)
  data.deletedCopyState = {}
  return data
end

function BattleStateMgrServer:GetState(target, stateId)
  local stateList = self.ownerUid2StateList[target.uid]
  if not stateList then
    return
  end
  for _, state in ipairs(stateList) do
    if not state.isDeleted and state.stateId == stateId then
      return state
    end
  end
end

function BattleStateMgrServer:GetStateByUid(targetUid, stateUid)
  local stateList = self.ownerUid2StateList[targetUid]
  if not stateList then
    return
  end
  for _, state in ipairs(stateList) do
    if not state.isDeleted and state.uid == stateUid then
      return state
    end
  end
end

function BattleStateMgrServer:GetStateByTypeLabel(targetUid, stateType)
  local target = self.battleEngine:GetObj(targetUid)
  local list = {}
  local stateList = self.ownerUid2StateList[target.uid] or {}
  for _, state in ipairs(stateList) do
    if not state.isDeleted and state.configData.TypeLabel == stateType then
      table.insert(list, state)
    end
  end
  return list
end

function BattleStateMgrServer:GetStateByDispelType(targetUid, dispelType)
  local target = self.battleEngine:GetObj(targetUid)
  local list = {}
  local stateList = self.ownerUid2StateList[target.uid] or {}
  for _, state in ipairs(stateList) do
    if state.isDeleted then
    elseif state.configData.IsBuff == bc.BuffType.None then
    elseif dispelType == bc.DispelType.Both or state.configData.IsBuff == bc.BuffType.Buff and dispelType == bc.DispelType.Buff or state.configData.IsBuff == bc.BuffType.Debuff and dispelType == bc.DispelType.Debuff then
      table.insert(list, state)
    end
  end
  return list
end

function BattleStateMgrServer:ClearDeletedState()
  for _, stateList in pairs(self.ownerUid2StateList) do
    for i = #stateList, 1, -1 do
      local state = stateList[i]
      if state.isDeleted then
        if state.createArgs.isCopy then
          table.insert(self.data.deletedCopyState, state:SerializeToSvr())
        end
        state:Dispose()
        table.remove(stateList, i)
      end
    end
  end
end

function BattleStateMgrServer:ClearBattleEndState()
  for _, stateList in pairs(self.ownerUid2StateList) do
    for i = #stateList, 1, -1 do
      local state = stateList[i]
      local stateCfg = self.battleEngine.battleDT.State[state.stateId]
      local clearCond = stateCfg.ClearCond or {}
      if table.contains(clearCond, "BSTBeforeBattleEnd") then
        state:LifeEnd()
      end
    end
  end
end

function BattleStateMgrServer:CreateState(target, createArgs)
  local stateCfg = self.battleEngine.battleDT.State[createArgs.stateId]
  if target:IsRoleType(bc.RoleType.Awaker) then
    createArgs.stateType = bc.StateType.Awaker
    if stateCfg.DeathHandling ~= bc.StateDeathHandling.NonWipe_ProhibitTrigger and stateCfg.DeathHandling ~= bc.StateDeathHandling.NonWipe_AllowTrigger and target:IsDead() then
      self.battleEngine:LogBattleWithTab("创建状态" .. createArgs.stateId .. "失败，目标已死亡`")
      return
    end
  elseif target:IsRoleType(bc.RoleType.Player, bc.RoleType.Monster) then
    createArgs.stateType = bc.StateType.Role
    if stateCfg.DeathHandling ~= bc.StateDeathHandling.NonWipe_ProhibitTrigger and stateCfg.DeathHandling ~= bc.StateDeathHandling.NonWipe_AllowTrigger and target:IsDead() then
      self.battleEngine:LogBattleWithTab("创建状态" .. createArgs.stateId .. "失败，目标已死亡`")
      return
    end
  elseif target:is(BattleCardServer) then
    createArgs.stateType = bc.StateType.Card
  else
    self.battleEngine:Error("创建状态" .. createArgs.stateId .. "失败，目标类型有误")
    return
  end
  local state = self:__CreateState(target, createArgs)
  if not state then
    self.battleEngine:Info("创建状态" .. createArgs.stateId .. "失败，没有层数或层数为0")
    return
  end
  if not createArgs.skipOnAdd then
    local eventData = {
      createArgs = createArgs,
      stateUid = state.uid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.StateOnAdd, eventData)
    BattleActionStatsUtil.RecordActionStats_AddState(self.battleEngine, state, createArgs)
  end
  return state
end

function BattleStateMgrServer:IsTeamUniqueState(stateId)
  local stageCfg = self.battleEngine.battleDT.State[stateId]
  for propertyName in pairs(stageCfg.ExistProperty or {}) do
    if bc.TeamUniqueStateProperty[propertyName] then
      return true
    end
  end
  return false
end

function BattleStateMgrServer:__CreateState(target, createArgs)
  if createArgs.layer and createArgs.layer <= 0 then
    return
  end
  if not self.ownerUid2StateList[target.uid] then
    self.ownerUid2StateList[target.uid] = {}
  end
  local oldState = self:GetState(target, createArgs.stateId)
  if oldState and not oldState.isDeleted then
    oldState:AddLayer(createArgs)
    return oldState
  end
  local state = BattleStateServer(target, createArgs)
  table.insert(self.ownerUid2StateList[target.uid], state)
  self.battleEngine:DebugS("CreateState: {stateId}, {ownerUid}, {uid}", createArgs.stateId, target.uid, createArgs.uid)
  state:AfterInit()
  local data = state:Serialize()
  if target:is(BattleCardServer) then
    self.battleEngine.recordMgr:OnAddCardState(data)
  else
    self.battleEngine.recordMgr:OnAddState(data)
  end
  if self:IsTeamUniqueState(createArgs.stateId) then
    self.battleEngine.roleMgr:ChangeUniqueStateRole(target.camp, target.uid, state.stateId, state.uid)
  end
  return state
end

function BattleStateMgrServer:OnSnapShot()
  local copyStateDataList = {}
  local battleStateDataList = {}
  for _, stateList in pairs(self.ownerUid2StateList) do
    for _, state in ipairs(stateList) do
      if not state.isDeleted then
        self.battleEngine:DebugS("OnSnapShot: {stateId}, {ownerUid}, {uid} {layer}", state.stateId, state.owner.uid, state.uid, state.data.layer)
        if state.createArgs.isCopy then
          table.insert(copyStateDataList, state:OnSnapShot())
        else
          table.insert(battleStateDataList, state:OnSnapShot())
        end
      end
    end
  end
  table.sort(copyStateDataList, function(a, b)
    return a.uid < b.uid
  end)
  table.sort(battleStateDataList, function(a, b)
    return a.uid < b.uid
  end)
  return {
    copyStateDataList = copyStateDataList,
    battleStateDataList = battleStateDataList,
    data = self.data
  }
end

function BattleStateMgrServer:OnRecover(stateData)
  if stateData.data then
    self.data = stateData.data
  end
  local copyStateDataList = stateData.copyStateDataList
  local battleStateDataList = stateData.battleStateDataList
  local stateDataList = {}
  for _, stateInfo in ipairs(copyStateDataList) do
    table.insert(stateDataList, stateInfo)
  end
  for _, stateInfo in ipairs(battleStateDataList) do
    table.insert(stateDataList, stateInfo)
  end
  self.ownerUid2StateList = {}
  for _, stateInfo in ipairs(stateDataList) do
    local targetOwner = self.battleEngine:GetObj(stateInfo.ownerUid)
    if not targetOwner then
      self.battleEngine:Warn("恢复状态失败: 找不到目标 ownerUid=%s stateId=%s", stateInfo.ownerUid, stateInfo.stateId)
    else
      stateInfo.skipInitProperty = true
      stateInfo.skipOnAdd = true
      stateInfo.isRecover = true
      local state = BattleStateServer(targetOwner, stateInfo)
      state:OnRecover(stateInfo)
      self.battleEngine:Info("恢复状态: stateId=%s, 原始uid=%s, ownerUid=%s, cmdServerUid=%s", stateInfo.stateId, stateInfo.uid, stateInfo.ownerUid, state.cmdServer and state.cmdServer.uid)
      if not self.ownerUid2StateList[targetOwner.uid] then
        self.ownerUid2StateList[targetOwner.uid] = {}
      end
      table.insert(self.ownerUid2StateList[targetOwner.uid], state)
    end
  end
  self.battleEngine:Info("状态恢复完成: %s 个状态", #stateDataList)
end

function BattleStateMgrServer:SerializeToServer()
  local list = {}
  local enternalCardUids = self.battleEngine.cardMgr:GetEnternalCardUids()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local deletedCopyStateUidMap = {}
  for _, stateData in ipairs(self.data.deletedCopyState) do
    deletedCopyStateUidMap[stateData.uid] = true
  end
  for uid, stateList in pairs(self.ownerUid2StateList) do
    if enternalCardUids[uid] then
    else
      for _, state in ipairs(stateList) do
        if state.isDeleted then
          if state.createArgs.isCopy and not deletedCopyStateUidMap[state.uid] then
            table.insert(list, state:SerializeToSvr())
          end
        elseif state.stateType == bc.StateType.Role then
          if state.owner.uid ~= player.uid then
          else
            table.insert(list, state:SerializeToSvr(true))
          end
        elseif state.stateType == bc.StateType.Awaker then
          local awaker = self.battleEngine:GetObj(state.owner.uid)
          if not awaker then
          elseif awaker.camp ~= bc.BattleCamp.Camp1 then
          else
            table.insert(list, state:SerializeToSvr(true))
          end
        elseif state.stateType == bc.StateType.Card then
          local card = self.battleEngine:GetObj(state.owner.uid)
          if card and card.isOrigin then
            table.insert(list, state:SerializeToSvr(false))
          end
        end
      end
    end
  end
  for _, stateData in ipairs(self.data.deletedCopyState) do
    table.insert(list, stateData)
  end
  return list
end

function BattleStateMgrServer:GetStateList()
  return self.ownerUid2StateList
end

function BattleStateMgrServer:Serialize()
  local ret = {}
  for _, stateList in pairs(self.ownerUid2StateList) do
    for _, state in ipairs(stateList) do
      if not state.isDeleted then
        table.insert(ret, state:Serialize())
      end
    end
  end
  return ret
end

function BattleStateMgrServer:GetStateNum(target, bc_buffType)
  local count = 0
  local stateList = self.ownerUid2StateList[target.uid]
  if not stateList then
    return count
  end
  for _, state in ipairs(stateList) do
    if bc_buffType == state:GetBuff() then
      count = count + 1
    end
  end
  return count
end

function BattleStateMgrServer:HasStateTypeNotNil(ownerUid)
  local owner = self.battleEngine:GetObj(ownerUid)
  if not owner then
    return false
  end
  local list = self.ownerUid2StateList[ownerUid]
  for _, state in ipairs(list or {}) do
    if state.isDeleted then
    else
      local stateCfg = self.battleEngine.battleDT.State[state.stateId]
      if stateCfg.IsBuff ~= nil then
        return true
      end
    end
  end
  return false
end

function BattleStateMgrServer:HasStateByType(ownerUid, isBuff)
  local owner = self.battleEngine:GetObj(ownerUid)
  if not owner then
    return false
  end
  local list = self.ownerUid2StateList[ownerUid]
  for _, state in ipairs(list or {}) do
    if state.isDeleted then
    else
      local stateCfg = self.battleEngine.battleDT.State[state.stateId]
      if stateCfg.IsBuff == isBuff then
        return true
      end
    end
  end
  return false
end

function BattleStateMgrServer:HasStateAllStateIds(ownerUid, list)
  local owner = self.battleEngine:GetObj(ownerUid)
  if not owner then
    return false
  end
  local ownerUidList = self.ownerUid2StateList[ownerUid]
  if not ownerUidList or 0 == #ownerUidList then
    return false
  end
  local has_list = {}
  for _, state in ipairs(ownerUidList) do
    if not state.isDeleted then
      has_list[state.stateId] = true
    end
  end
  for _, stateId in ipairs(list) do
    if not has_list[stateId] then
      return false
    end
  end
  return true
end

function BattleStateMgrServer:HasStateByStateIds(ownerUid, list)
  local owner = self.battleEngine:GetObj(ownerUid)
  if not owner then
    return false
  end
  local ownerUidList = self.ownerUid2StateList[ownerUid]
  if not ownerUidList or 0 == #ownerUidList then
    return false
  end
  local has_list = {}
  for _, state in ipairs(ownerUidList) do
    if not state.isDeleted then
      has_list[state.stateId] = true
    end
  end
  for _, stateId in ipairs(list) do
    if has_list[stateId] then
      return true
    end
  end
  return false
end

function BattleStateMgrServer:GetStateListByOwnerUid(ownerUid)
  return self.ownerUid2StateList[ownerUid] or {}
end

function BattleStateMgrServer:UpdateStateArgs()
  local updateList = {}
  for ownerUid, stateList in pairs(self.ownerUid2StateList) do
    local owner = self.battleEngine:GetObj(ownerUid)
    if owner and owner:is(BattleCardServer) and not bc.CardArgsSyncDeck[owner.deck] then
    else
      for _, state in ipairs(stateList) do
        if state.isDeleted then
        else
          local updateData = state:UpdateStateArgs()
          if updateData then
            updateList[state.uid] = updateData
          end
        end
      end
    end
  end
  self.battleEngine.recordMgr:OnUpdateStateArgs(updateList)
end

function BattleStateMgrServer:OnRoleDead(eventData)
  local stateList = self.ownerUid2StateList[eventData.roleUid] or {}
  for _, state in ipairs(stateList) do
    local cfg = self.battleEngine.battleDT.State[state.stateId]
    if not cfg.DeathHandling or cfg.DeathHandling == bc.StateDeathHandling.Wipe then
      state:LifeEnd()
    end
  end
end

function BattleStateMgrServer:RemoveState(state, showText)
  if not state then
    return
  end
  state:LifeEnd(showText)
  local eventData = {
    stateUid = state.uid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.StateRemoved, eventData)
end

local function CopyTypeMatch(isBuff, copyType)
  if 0 == copyType then
    return isBuff == bc.BuffType.Debuff
  end
  if 1 == copyType then
    return isBuff == bc.BuffType.Buff
  end
  if 2 == copyType then
    return isBuff == bc.BuffType.Buff or isBuff == bc.BuffType.Debuff
  end
  return false
end

function BattleStateMgrServer:GetStateByOwnerUidAndCopyType(ownerUid, copyType)
  local list = {}
  local owner = self.battleEngine:GetObj(ownerUid)
  if not owner then
    return list
  end
  local ownerStateList = self.ownerUid2StateList[ownerUid]
  for _, state in ipairs(ownerStateList or {}) do
    if state.isDeleted then
    else
      local stateCfg = self.battleEngine.battleDT.State[state.stateId]
      if CopyTypeMatch(stateCfg.IsBuff, copyType) then
        table.insert(list, state)
      end
    end
  end
  return list
end

return BattleStateMgrServer
