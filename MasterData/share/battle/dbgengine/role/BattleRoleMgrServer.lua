local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleUnitPlayer = require("Battle.DbgEngine.Role.BattleUnitPlayer")
local BattleUnitAwaker = require("Battle.DbgEngine.Role.BattleUnitAwaker")
local BattleUnitMonster = require("Battle.DbgEngine.Role.BattleUnitMonster")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BP = bc.BattleProperty
local BattleRoleMgr, Super = System.NewClass("BattleRoleMgr", BattleEngineComponent)

function BattleRoleMgr:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.roleList = {}
  self.hideRoleList = {}
  self.PVPPlayerList = {}
  self.camp2UniqueStateTid2RoleUid2StateUid = {}
  self.lockerUidToLockedUid = {}
  self.PVEAwakerList = {}
  self.PVEMonsterList = {}
  self.monsterClassMaxHp = {}
end

function BattleRoleMgr:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFMonsterCalcIntention, self.OnBFMonsterCalcIntention, self)
end

function BattleRoleMgr:GetPlayerList()
  return self.PVPPlayerList
end

function BattleRoleMgr:GetRoleTypeListByCamp(camp, roleType)
  local ret = {}
  for _, role in ipairs(self.roleList) do
    if role.camp == camp and role.roleType == roleType then
      table.insert(ret, role)
    end
  end
  return ret
end

function BattleRoleMgr:OnBattleBegin()
  if self.battleEngine:IsPVP() then
    self:OnBattleBegin_PVP()
  end
  if self.battleEngine:IsPVE() then
    self:OnBattleBegin_PVE()
  end
end

function BattleRoleMgr:OnBattleBegin_PVP()
end

function BattleRoleMgr:OnBattleBegin_PVE()
  local player = self:GetPlayer(bc.BattleCamp.Camp1)
  local extraData = {
    castRoleUid = player.uid
  }
  for _, awaker in ipairs(self.PVEAwakerList) do
    local ultiEnergyInit = awaker:GetProperty(BP.ulti_energy_init)
    awaker:GainUltiEnergy(ultiEnergyInit, extraData)
  end
  local monsterList = self:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  for _, monster in ipairs(monsterList) do
    monster.monsterBehaviorComp:CalcNextIntention()
    local monsterClass = monster.monsterBehaviorComp:GetMonsterClass()
    if not self.monsterClassMaxHp[monsterClass] then
      self.monsterClassMaxHp[monsterClass] = 0
    end
    local curValue = self.monsterClassMaxHp[monsterClass] + monster:GetProperty(BP.max_hp)
    self.monsterClassMaxHp[monsterClass] = curValue
  end
end

function BattleRoleMgr:GetMonsterClassMaxHp(monsterClass)
  return self.monsterClassMaxHp
end

function BattleRoleMgr:GetRoleByUid(roleUid)
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, roleUid
end

function BattleRoleMgr:GetPlayer(camp)
  if self.battleEngine:IsPVP() then
    camp = camp or bc.BattleCamp.Camp1
    for _, role in ipairs(self.PVPPlayerList) do
      if role.camp == camp then
        return role
      end
    end
  end
  if self.battleEngine:IsPVE() then
    for _, role in ipairs(self.roleList) do
      if role.camp == bc.BattleCamp.Camp1 and role.roleType == bc.RoleType.Player then
        return role
      end
    end
  end
  return nil
end

function BattleRoleMgr:GetAwakerByUid(uid)
  if self.battleEngine:IsPVE() then
    for _, awaker in ipairs(self.PVEAwakerList) do
      if awaker.uid == uid then
        return awaker
      end
    end
  end
  if self.battleEngine:IsPVP() then
    for _, role in ipairs(self.roleList) do
      if role.uid == uid then
        return role
      end
    end
  end
end

function BattleRoleMgr:GetAwakerByTid(tid, camp)
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Awaker) and role.tid == tid and (not camp or role.camp == camp) then
      return role
    end
  end
end

function BattleRoleMgr:GetMaxPropertyAwaker(propertyName)
  local target
  local targetValue = math.mininteger
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Awaker) then
      local value = role:GetProperty(propertyName)
      if targetValue < value then
        target = role
        targetValue = value
      end
    end
  end
  return target
end

function BattleRoleMgr:GetMinPropertyAwaker(propertyName)
  local target
  local targetValue = math.maxinteger
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Awaker) then
      local value = role:GetProperty(propertyName)
      if targetValue > value then
        target = role
        targetValue = value
      end
    end
  end
  return target
end

function BattleRoleMgr:GetOtherMaxPropertyAwaker(selfUid, propertyName)
  local target
  local targetValue = math.mininteger
  for _, role in ipairs(self.roleList) do
    if role.uid ~= selfUid and role:IsRoleType(bc.RoleType.Awaker) then
      local value = role:GetProperty(propertyName)
      if targetValue < value then
        target = role
        targetValue = value
      end
    end
  end
  return target
end

function BattleRoleMgr:GetOtherMinPropertyAwaker(selfUid, propertyName)
  local target
  local targetValue = math.maxinteger
  for _, role in ipairs(self.roleList) do
    if role.uid ~= selfUid and role:IsRoleType(bc.RoleType.Awaker) then
      local value = role:GetProperty(propertyName)
      if targetValue > value then
        target = role
        targetValue = value
      end
    end
  end
  return target
end

function BattleRoleMgr:GetRoleList()
  return self.roleList
end

function BattleRoleMgr:UpdateSkillArgs()
  for _, role in ipairs(self.roleList) do
    role:UpdateSkillArgs()
  end
end

function BattleRoleMgr:UpdateSilverKeyAwakeArgs()
  for _, role in ipairs(self.roleList) do
    role:UpdateSilverKeyAwakeArgs()
  end
end

function BattleRoleMgr:UpdateSchoolArgs()
  for _, role in ipairs(self.roleList) do
    if role.UpdateSchoolArgs then
      role:UpdateSchoolArgs()
    end
  end
end

function BattleRoleMgr:GetAliveRoleListByCamp(camp, filter)
  local roleList = {}
  for _, role in ipairs(self.roleList) do
    if filter and filter(role) then
    elseif role.camp == camp and role:HasHpBar() and not role:IsDead() then
      table.insert(roleList, role)
    end
  end
  return roleList
end

function BattleRoleMgr:GetAliveAllyListByRoleUid(roleUid)
  local role = self:GetRoleByUid(roleUid)
  if not role then
    return {}
  end
  local list = self:GetAliveRoleListByCamp(role.camp)
  for i = #list, 1, -1 do
    if list[i].uid == roleUid then
      table.remove(list, i)
      break
    end
  end
  return list
end

function BattleRoleMgr:GetAliveEnemyListByRoleUid(roleUid)
  local role = self:GetRoleByUid(roleUid)
  if not role then
    return {}
  end
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(role.camp)
  do return self.GetAliveRoleListByCamp, self end
  return self.GetAliveRoleListByCamp, self, enemyCamp
end

function BattleRoleMgr:GetMonsterByPos(pos)
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Monster) and role:GetBattleFieldPos() == pos and not role:IsDead() and not role:HpIs0() then
      return role
    end
  end
end

function BattleRoleMgr:GetAwakerByPos(camp, pos)
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Awaker) and role:GetCamp() == camp and role:GetBattleFieldPos() == pos then
      return role
    end
  end
end

local function sort_by_pos(roleA, roleB)
  return math.abs(roleA:GetBattleFieldPos()) < math.abs(roleB:GetBattleFieldPos())
end

function BattleRoleMgr:GetPosSortedRoleByCamp(camp, filter)
  local roleList = self:GetAliveRoleListByCamp(camp, filter)
  table.sort(roleList, sort_by_pos)
  return roleList
end

function BattleRoleMgr:ClearMonsters()
  local cleared = {}
  for _, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Monster then
      cleared[role.uid] = true
    end
  end
  for i = #self.roleList, 1, -1 do
    local role = self.roleList[i]
    if cleared[role.uid] then
      self.battleEngine.recordMgr:OnRemoveRole(role.uid)
      table.remove(self.roleList, i)
    end
  end
end

function BattleRoleMgr:GetCampRoleDataList(camp)
  local roleDataList = {}
  for _, role in ipairs(self.roleList) do
    if role:GetCamp() ~= camp then
    else
      table.insert(roleDataList, role:Serialize())
    end
  end
  for _, uid in ipairs(self.hideRoleList or {}) do
    local role = self.battleEngine:GetObj(uid)
    if role and role:GetCamp() == camp then
      table.insert(roleDataList, role:Serialize())
    end
  end
  return roleDataList
end

function BattleRoleMgr:SpawnAwaker(roleData)
  local role = BattleUnitAwaker(self.battleEngine, roleData)
  table.insert(self.roleList, role)
  if self.battleEngine:IsPVE() then
    table.insert(self.PVEAwakerList, role)
  end
  return role
end

function BattleRoleMgr:SpawnPlayer(roleData)
  local role = BattleUnitPlayer(self.battleEngine, roleData)
  table.insert(self.roleList, role)
  if self.battleEngine:IsPVP() then
    table.insert(self.PVPPlayerList, role)
  end
  return role
end

function BattleRoleMgr:SpawnMonster(roleData)
  local role = BattleUnitMonster(self.battleEngine, roleData)
  table.insert(self.roleList, role)
  return role
end

function BattleRoleMgr:GetMonsterVacantSeat()
  local vacant = {}
  local occupied = {}
  for _, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Monster and not role:IsDead() and not role:HpIs0() then
      occupied[role:GetBattleFieldPos()] = true
    end
  end
  local maxPosIndex = bc.TotalMonsterPos
  for i = 1, maxPosIndex do
    vacant[i] = not occupied[i]
  end
  return vacant
end

function BattleRoleMgr:GetMonsterCountByID(monsterID)
  local count = 0
  for _, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Monster and role.tid == monsterID then
      count = count + 1
    end
  end
  return count
end

function BattleRoleMgr:GetMonsterByID(monsterID)
  local list = {}
  for _, role in ipairs(self.roleList) do
    if not role:IsDead() and role.roleType == bc.RoleType.Monster and role.tid == monsterID then
      table.insert(list, role)
    end
  end
  return list
end

function BattleRoleMgr:GetHideMonster(tid)
  local list = {}
  for _, uid in ipairs(self.hideRoleList) do
    local monster = self.battleEngine:GetObj(uid)
    if monster.tid == tid then
      table.insert(list, monster)
    end
  end
  return list
end

function BattleRoleMgr:GetAwakerCountBySchool(schoolType, camp)
  local DT = self.battleEngine.battleDT
  local count = 0
  for _, awaker in ipairs(self.roleList) do
    if awaker:IsRoleType(bc.RoleType.Awaker) then
      local awakerCfg = DT.AwakerConfig[awaker.tid]
      if awakerCfg.School ~= schoolType then
      elseif self.battleEngine:IsPVP() and camp ~= awaker:GetCamp() then
      else
        count = count + 1
      end
    end
  end
  return count
end

function BattleRoleMgr:GetSpecialSchoolAwakerNum(constantKey, camp)
  if not constantKey or "" == constantKey then
    return 0
  end
  local awakerTidList = self.battleEngine.battleDT.GetOriginalConstant(constantKey)
  if type(awakerTidList) ~= "table" or 0 == #awakerTidList then
    return 0
  end
  local awakerTidMap = {}
  for _, awakerTid in ipairs(awakerTidList) do
    if type(awakerTid) == "number" then
      awakerTidMap[awakerTid] = true
    end
  end
  if not next(awakerTidMap) then
    return 0
  end
  local isPVP = self.battleEngine:IsPVP()
  local totalCount = 0
  for _, role in ipairs(self.roleList) do
    if not role:IsRoleType(bc.RoleType.Awaker) then
    else
      if isPVP then
        if camp and role:GetCamp() ~= camp then
          goto lbl_83
        end
      elseif role.camp ~= bc.BattleCamp.Camp1 then
        goto lbl_83
      end
      local awakerTid = role.tid
      if awakerTid and awakerTidMap[awakerTid] then
        totalCount = totalCount + 1
      end
    end
    ::lbl_83::
  end
  return totalCount
end

function BattleRoleMgr:SetCurCaster(castRoleUid)
  self.curCasterRoleUid = castRoleUid
end

function BattleRoleMgr:GetCurCaster()
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, self.curCasterRoleUid
end

function BattleRoleMgr:AfterAction(actionType)
  self.battleEngine.recordMgr:OnAfterAction(self.curCasterRoleUid, actionType)
end

function BattleRoleMgr:OnBFMonsterCalcIntention()
  local roleList = self:GetPosSortedRoleByCamp(bc.BattleCamp.Camp2)
  for _, role in ipairs(roleList) do
    if role:IsDead() or role:HpIs0() then
    else
      local ret = role.monsterBehaviorComp:CalcNextIntention()
      if ret then
        self.battleEngine:AddPassTime(0.4)
      end
    end
  end
end

function BattleRoleMgr:GenMonsterOrPlayerTarget(castRoleUid)
  local role = self:GetRoleByUid(castRoleUid)
  return role
end

function BattleRoleMgr:GetMonsterDimensionMax()
  local count = 0
  for _, role in ipairs(self.roleList) do
    if role.roleType == bc.RoleType.Monster then
      count = count + role:GetProperty(BP.monster_dimension_slot)
    end
  end
  return count
end

function BattleRoleMgr:OnSnapShot()
  local roleDataList = {}
  for _, role in ipairs(self.roleList) do
    table.insert(roleDataList, role:OnSnapShot())
  end
  for _, uid in ipairs(self.hideRoleList) do
    local obj = self.battleEngine:GetObj(uid)
    if obj then
      table.insert(roleDataList, obj:OnSnapShot())
    end
  end
  self.battleEngine:Debug("OnSnapShot: 角色数: %s, 隐藏数: %s", #roleDataList, #self.hideRoleList)
  return {
    roleDataList = roleDataList,
    hideRoleList = self.hideRoleList,
    monsterClassMaxHp = self.monsterClassMaxHp,
    tauntRole2StateUid = self.tauntRole2StateUid,
    lockerUidToLockedUid = self.lockerUidToLockedUid
  }
end

function BattleRoleMgr:OnRecover(roleData)
  self.roleList = {}
  self.PVEAwakerList = {}
  self.PVEMonsterList = {}
  self.tauntRole2StateUid = {}
  self.lockerUidToLockedUid = {}
  self.monsterClassMaxHp = {}
  self.hideRoleList = roleData.hideRoleList or {}
  for _, roleDataItem in ipairs(roleData.roleDataList) do
    local role
    if roleDataItem.roleType == bc.RoleType.Player then
      role = BattleUnitPlayer(self.battleEngine, roleDataItem)
    elseif roleDataItem.roleType == bc.RoleType.Awaker then
      role = BattleUnitAwaker(self.battleEngine, roleDataItem)
      if self.battleEngine:IsPVE() then
        table.insert(self.PVEAwakerList, role)
      end
    elseif roleDataItem.roleType == bc.RoleType.Monster then
      role = BattleUnitMonster(self.battleEngine, roleDataItem)
      table.insert(self.PVEMonsterList, role)
    else
      self.battleEngine:Warn("OnRecover 未知角色类型: %s", roleDataItem.roleType)
      goto lbl_111
    end
    if not table.contains(roleData.hideRoleList, roleDataItem.uid) then
      table.insert(self.roleList, role)
    end
    if role.OnRecover then
      role:OnRecover(roleDataItem)
      self.battleEngine:DebugS("OnRecover: {uid} {roleType} {monster_hide}", role.uid, role.roleType, role:GetProperty(BP.monster_hide))
    end
    ::lbl_111::
  end
  if roleData.monsterClassMaxHp then
    self.monsterClassMaxHp = table.deepclone(roleData.monsterClassMaxHp)
  else
    for _, monster in ipairs(self.PVEMonsterList) do
      local monsterClass = monster.monsterBehaviorComp:GetMonsterClass()
      if not self.monsterClassMaxHp[monsterClass] then
        self.monsterClassMaxHp[monsterClass] = 0
      end
      local maxHp = monster:GetProperty(bc.BattleProperty.max_hp)
      self.monsterClassMaxHp[monsterClass] = self.monsterClassMaxHp[monsterClass] + maxHp
    end
  end
  if roleData.tauntRole2StateUid then
    self.tauntRole2StateUid = table.deepclone(roleData.tauntRole2StateUid)
  end
  if roleData.lockerUidToLockedUid then
    self.lockerUidToLockedUid = table.deepclone(roleData.lockerUidToLockedUid)
  end
  self.battleEngine:Info("角色恢复完成: %s 个角色, %s 个隐藏角色", #self.roleList, #self.hideRoleList)
end

function BattleRoleMgr:Judgement_Alive(role, aliveTag)
  local isDead = role:IsDead() or role:HpIs0()
  if isDead and aliveTag == bc.PVPTargetTag.AliveOnly then
    return false
  end
  if not isDead and aliveTag == bc.PVPTargetTag.DeathOnly then
    return false
  end
  return true
end

function BattleRoleMgr:Judgement_Camp(role, camp)
  if not camp or camp == bc.BattleCamp.None then
    return true
  end
  return role.camp == camp
end

function BattleRoleMgr:Judgement_Pos(role, pos)
  return role:GetBattleFieldPos() == pos
end

function BattleRoleMgr:GetPVPRoleList(aliveTag, campTag, filter)
  local ret = {}
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Player) then
    elseif filter and filter(role) then
    else
      local alive = self:Judgement_Alive(role, aliveTag)
      local camp = self:Judgement_Camp(role, campTag)
      if alive and camp then
        table.insert(ret, role)
      end
    end
  end
  return ret
end

function BattleRoleMgr:GetTauntRole(camp)
  local DT = self.battleEngine.battleDT
  local tauntStateId = DT.BattleApi.PVPTauntState.Data
  local roleUid, _ = self:GetUniqueState(camp, tauntStateId)
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, roleUid
end

function BattleRoleMgr:GetSneakRole(camp)
  local DT = self.battleEngine.battleDT
  local sneakStateId = DT.BattleApi.PVPSneakState.Data
  local roleUid, _ = self:GetUniqueState(camp, sneakStateId)
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, roleUid
end

function BattleRoleMgr:GetLockerUidToLockedUid()
  return self.lockerUidToLockedUid
end

function BattleRoleMgr:GetUniqueState(camp, stateId)
  local stateList = self.camp2UniqueStateTid2RoleUid2StateUid[camp] or {}
  local uniqueStateInfo = stateList[stateId] or {}
  for roleUid, stateUid in pairs(uniqueStateInfo) do
    return roleUid, self.battleEngine:GetObj(stateUid)
  end
end

function BattleRoleMgr:ChangeUniqueStateRole(camp, roleUid, stateId, stateUid)
  local _, oldState = self:GetUniqueState(camp, stateId)
  if not self.camp2UniqueStateTid2RoleUid2StateUid[camp] then
    self.camp2UniqueStateTid2RoleUid2StateUid[camp] = {}
  end
  if oldState then
    oldState:LifeEnd()
    self.camp2UniqueStateTid2RoleUid2StateUid[camp][stateId] = nil
  end
  self.camp2UniqueStateTid2RoleUid2StateUid[camp][stateId] = {
    [roleUid] = stateUid
  }
end

function BattleRoleMgr:RemoveUniqueStateRole(camp, stateId, stateUid)
  local _, oldState = self:GetUniqueState(camp, stateId)
  if oldState and oldState.uid == stateUid and self.camp2UniqueStateTid2RoleUid2StateUid[camp] then
    self.camp2UniqueStateTid2RoleUid2StateUid[camp][stateId] = nil
  end
end

function BattleRoleMgr:GetRoleByPlayerId(playerId)
  for _, player in ipairs(self.PVPPlayerList) do
    if player.data.playerId == playerId then
      return player
    end
  end
end

function BattleRoleMgr:GetSyncAwakerProperties()
  local syncProperties = {}
  for _, awaker in ipairs(self.PVEAwakerList) do
    syncProperties[awaker.tid] = {
      ulti_energy = awaker.property:GetProperty(BP.ulti_energy)
    }
  end
  return syncProperties
end

function BattleRoleMgr:GetAwakerMotions()
  if self.battleEngine:IsPVP() then
    return
  end
  local awakerMotions = {}
  for _, awaker in ipairs(self.PVEAwakerList) do
    awakerMotions[awaker.tid] = awaker.data.motion
  end
  return awakerMotions
end

function BattleRoleMgr:GetAllMonsterDamageInfo()
  local monsterDamage, monsterDamageCount, uid2DamageInfo = self:GetMonsterDamage()
  local data = {
    totalDamage = monsterDamage,
    totalDamageCount = monsterDamageCount,
    damageOrder = uid2DamageInfo
  }
  return data
end

function BattleRoleMgr:GetMonsterDamage()
  local monsterDamage = 0
  local monsterDamageCount = 0
  if not self.battleEngine:IsPVE() then
    return monsterDamage, monsterDamageCount
  end
  local monsters = self:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  local uid2DamageInfo = {}
  for _, monster in ipairs(monsters) do
    local damageInfo = monster.monsterBehaviorComp:GetDamageInfoValue()
    local pos = math.abs(monster:GetBattleFieldPos())
    uid2DamageInfo[pos] = damageInfo
    monsterDamage = (damageInfo and damageInfo[1] or 0) + monsterDamage
    monsterDamageCount = (damageInfo and damageInfo[2] or 0) + monsterDamageCount
  end
  local player = self:GetPlayer(bc.BattleCamp.Camp1)
  local ctorData = {
    castRoleUid = player.uid
  }
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  local ret = cmdParser:GetValueByCmd("ExtraMonsterTotalStateDmg")
  if ret and tonumber(ret) > 0 then
    monsterDamage = monsterDamage + ret
    uid2DamageInfo[bc.ThreatVisualDamageType.PlayerState] = ret
  end
  local ret2 = cmdParser:GetValueByCmd("ExtraMonsterTotalTentacleDmg")
  if ret2 and tonumber(ret2) > 0 then
    monsterDamage = monsterDamage + ret2
    uid2DamageInfo[bc.ThreatVisualDamageType.MonsterTentacle] = ret2
  end
  return monsterDamage, monsterDamageCount, uid2DamageInfo
end

function BattleRoleMgr:UpdateMonsterIntention()
  if self.battleEngine:IsPVP() then
    return
  end
  local monsterRoleList = self:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  for _, monster in ipairs(monsterRoleList) do
    if monster.monsterBehaviorComp ~= nil then
      monster.monsterBehaviorComp:UpdateIntentionDamage()
    end
  end
  local monsterDamage, _, uid2DamageInfo = self:GetMonsterDamage()
  self.battleEngine.recordMgr:OnUpdateMonsterDamage(monsterDamage, uid2DamageInfo)
end

function BattleRoleMgr:GetPVPRoleByPos(pos, camp, aliveTag, posTag)
  if pos < 1 or pos > 4 then
    return
  end
  for _, role in ipairs(self.roleList) do
    if role:IsRoleType(bc.RoleType.Player) then
    else
      local aliveMatch = self:Judgement_Alive(role, aliveTag)
      local campMatch = self:Judgement_Camp(role, camp)
      local posMatch = self:Judgement_Pos(role, pos)
      if aliveMatch and campMatch and posMatch then
        return role
      end
    end
  end
  if posTag == bc.TargetPosDir.Motionless then
    return
  end
  if posTag == bc.TargetPosDir.Forward then
    pos = pos - 1
    do return self.GetPVPRoleByPos, self, pos, camp, aliveTag end
    return self.GetPVPRoleByPos, self, pos, camp, aliveTag, posTag, self:Judgement_Alive(role, aliveTag), self:Judgement_Camp(role, camp), self:Judgement_Pos(role, pos), self, role, pos
  end
  if posTag == bc.TargetPosDir.Backward then
    pos = pos + 1
    do return self.GetPVPRoleByPos, self, pos, camp, aliveTag end
    return self.GetPVPRoleByPos, self, pos, camp, aliveTag, posTag, self:Judgement_Alive(role, aliveTag), self:Judgement_Camp(role, camp), self:Judgement_Pos(role, pos), self, role, pos
  end
end

function BattleRoleMgr:MonsterHide(monsterUid, value)
  if value > 0 then
    for i, role in ipairs(self.roleList) do
      if role.uid == monsterUid then
        table.remove(self.roleList, i)
        break
      end
    end
    if not table.contains(self.hideRoleList, monsterUid) then
      table.insert(self.hideRoleList, monsterUid)
    end
  else
    local monster = self.battleEngine:GetObj(monsterUid)
    for i, uid in ipairs(self.hideRoleList) do
      if uid == monsterUid then
        table.remove(self.hideRoleList, i)
        break
      end
    end
    local exist = false
    for _, role in ipairs(self.roleList) do
      if role.uid == monsterUid then
        exist = true
        break
      end
    end
    if not exist then
      table.insert(self.roleList, monster)
    end
  end
end

return BattleRoleMgr
