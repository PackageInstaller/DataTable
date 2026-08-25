local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local bc = require("Battle.BattleConst")
local BattleZoneUtil = require("Battle.Util.BattleZoneUtil")
local BP = bc.BattleProperty
local SchoolCompPVE, Super = System.NewClass("SchoolCompPVE", BattleComponent)

function SchoolCompPVE:ctor(entity, battleEngine)
  Super.ctor(self, entity)
  self.role = entity
  self.battleEngine = battleEngine
  self.schoolMap = {}
  self.schoolNum = 0
end

function SchoolCompPVE:GetSchool()
  local roleList = self.battleEngine.roleMgr:GetRoleTypeListByCamp(self.role.camp, bc.RoleType.Awaker)
  local schoolNum = 0
  local schoolMap = {}
  for _, role in ipairs(roleList) do
    if not role.configData.School then
    else
      local school = role.configData.School
      if not schoolMap[school] then
        schoolMap[school] = 1
        schoolNum = schoolNum + 1
      else
        schoolMap[school] = schoolMap[school] + 1
      end
    end
  end
  return schoolMap, schoolNum
end

function SchoolCompPVE:InitSchoolData()
  local schoolMap, schoolNum = self:GetSchool()
  self.schoolMap = schoolMap
  self.schoolNum = schoolNum
end

function SchoolCompPVE:InitSchoolState(needInitState)
  self:InitSchoolData()
  if needInitState then
    for school in pairs(self.schoolMap) do
      local target = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
      local ctorData = {
        castRoleUid = target.uid
      }
      local stateListStr = self.battleEngine:GetValByCondList(ctorData, school, "StateList", "SchoolConfig")
      if not stateListStr then
        return
      end
      local stateIds = type(stateListStr) == "string" and string.split(stateListStr, ",") or stateListStr
      for _, stateIdStr in ipairs(stateIds) do
        local stateId = tonumber(stateIdStr)
        if not stateId then
          self.battleEngine:Warn("[InitSchoolState] Invalid stateIdStr: {str}", stateIdStr)
        elseif self.battleEngine.stateMgr:GetState(target, stateId) then
        else
          local stateParaStr = self.battleEngine:GetValByCondList(ctorData, school, "StatePara", "SchoolConfig")
          local stateParams = stateParaStr and {stateParaStr} or {}
          self.battleEngine:Info("[InitSchoolState] Creating state: school=", school, " stateId=", stateId, " stateParaStr=", stateParaStr or "nil")
          local createArgs = {
            stateId = stateId,
            castRoleUid = target.uid,
            stateParams = stateParams
          }
          self.battleEngine.stateMgr:CreateState(target, createArgs)
          self.battleEngine:InfoS("[InitSchoolState] State {id} created successfully", stateId)
        end
      end
    end
  end
end

function SchoolCompPVE:GetTentacleCrit()
  do return BattleZoneUtil.GetTentacleCrit end
  return BattleZoneUtil.GetTentacleCrit, self.role
end

function SchoolCompPVE:CalcTentacleCrit(target)
  local certainCrit = self.role:GetProperty(BP.certain_crit)
  if certainCrit and certainCrit > 0 then
    return true
  end
  local crit = self:GetTentacleCrit()
  if target then
    local anti_crit = target:GetProperty(bc.BattleProperty.anti_crit) or 0
    crit = crit - anti_crit
  end
  local rand = self.battleEngine.rand:random(100)
  return crit > rand
end

function SchoolCompPVE:GetTentacleCritDmg()
  do return BattleZoneUtil.GetTentacleCritDmg end
  return BattleZoneUtil.GetTentacleCritDmg, self.role
end

function SchoolCompPVE:TentacleAttack()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(self.role.camp)
  local sortedEnemy = self.battleEngine.roleMgr:GetPosSortedRoleByCamp(enemyCamp)
  if 0 == #sortedEnemy then
    return
  end
end

function SchoolCompPVE:CalcTentacleDmg(tentacleDmg, target, paraPlus)
  local isCrit = self:CalcTentacleCrit(target)
  local critDmg = 0
  if isCrit then
    critDmg = self:GetTentacleCritDmg()
  end
  local keys = {
    BP.be_damage_per,
    BP.be_damage_per2,
    BP.be_damage_per3,
    BP.be_tentacle_damage_per
  }
  local targetBeDmgPer = 1
  for _, key in ipairs(keys) do
    targetBeDmgPer = targetBeDmgPer * (1 + target:GetProperty(key) / 100)
  end
  local targetVulnPer = target:GetProperty(BP.vulnerable_per)
  local targetBeDmgPlus = target:GetProperty(BP.be_damage_plus)
  local enemyTypeDmgPer = 0
  local enemyStateDmgPer = 1
  local enemyBuffDmgPer = 0
  local enemyDebuffDmgPer = 0
  local enemyBlockDmgPer = 0
  local enemyBlockBarrierDmgPer = 0
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local awakerList = player:GetAwakerList()
  local stateDmgPerProperties = {}
  for _, awaker in ipairs(awakerList) do
    enemyTypeDmgPer = awaker:GetDamagePer2MonsterType(target) + enemyTypeDmgPer
    awaker:GetTotalDamagePer2HasState(target, stateDmgPerProperties)
    enemyBuffDmgPer = awaker:GetDamagePer2BuffEnemy(target) + enemyBuffDmgPer
    enemyDebuffDmgPer = awaker:GetDamagePer2DebuffEnemy(target) + enemyDebuffDmgPer
    enemyBlockDmgPer = awaker:GetDamagePer2Block(target) + enemyBlockDmgPer
    enemyBlockBarrierDmgPer = awaker:GetDamagePer2BlockBarrier(target) + enemyBlockBarrierDmgPer
  end
  enemyTypeDmgPer = enemyTypeDmgPer / #awakerList
  for _, v in pairs(stateDmgPerProperties) do
    enemyStateDmgPer = enemyStateDmgPer * (1 + v / 100)
  end
  enemyBuffDmgPer = enemyBuffDmgPer / #awakerList
  enemyDebuffDmgPer = enemyDebuffDmgPer / #awakerList
  enemyBlockDmgPer = enemyBlockDmgPer / #awakerList
  enemyBlockBarrierDmgPer = enemyBlockBarrierDmgPer / #awakerList
  local finalDamage = math.ceil(tentacleDmg * (1 + critDmg / 100) * targetBeDmgPer * (1 + targetVulnPer / 100) * (1 + enemyTypeDmgPer / 100) * (1 + enemyBuffDmgPer / 100) * (1 + enemyDebuffDmgPer / 100) * (1 + enemyBlockDmgPer / 100) * (1 + enemyBlockBarrierDmgPer / 100) * enemyStateDmgPer + targetBeDmgPlus + paraPlus)
  finalDamage = math.max(finalDamage, 1)
  return finalDamage, isCrit
end

function SchoolCompPVE:GetSchoolArg(school)
  local ctorData = {
    castRoleUid = self.role.uid
  }
  local stateParaStr = self.battleEngine:GetValByCondList(ctorData, school, "StatePara", "SchoolConfig")
  if not stateParaStr then
    self.battleEngine:InfoS("[GetSchoolArg] school={school} StatePara is nil, return empty params", school)
    return {}
  end
  self.battleEngine:InfoS("[GetSchoolArg] school={school} StatePara raw={raw} type={type}", school, stateParaStr, type(stateParaStr))
  local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
  local cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  local params = cmdParser:GetValueByCmdList(stateParaStr)
  local paramsBeforeStr = table.tostring(params)
  self.battleEngine:InfoS("[GetSchoolArg] school={school} parsed params before ceil={params}", school, paramsBeforeStr)
  for i, v in ipairs(params) do
    if type(v) == "number" then
      params[i] = math.ceil(v)
    end
  end
  local paramsAfterStr = table.tostring(params)
  self.battleEngine:InfoS("[GetSchoolArg] school={school} final params after ceil={params}", school, paramsAfterStr)
  return params
end

function SchoolCompPVE:GetSchoolArgs()
  local params = {}
  for school in pairs(self.schoolMap) do
    params[school] = self:GetSchoolArg(school)
  end
  return params
end

function SchoolCompPVE:UpdateSchoolArgs()
  local schoolArgs = self:GetSchoolArgs()
  self.battleEngine.recordMgr:OnUpdateSchoolArgs(self.role.uid, schoolArgs)
end

function SchoolCompPVE:GetSchoolSpecialArgs()
  local schoolArgs = {}
  local tentacleCount = self.role:GetProperty(BP.tentacle_count)
  local player = self.role:GetPlayer()
  local tentacleDmg = player:GetTentacleDamage()
  local tentacleDmgShow = player:GetShowTentacleDamage()
  local stateIdsToAddCount = self.battleEngine.battleDT.GetOriginalConstant("tentacleAttackCount") or {}
  local tentacleCountAdd = 0
  for _, stateId in ipairs(stateIdsToAddCount) do
    local state = self.battleEngine.stateMgr:GetState(player, stateId)
    if state then
      tentacleCountAdd = tentacleCountAdd + state.data.layer
    end
  end
  local stateIdsToMulCount = self.battleEngine.battleDT.GetOriginalConstant("tentacleAttackCountMul") or {}
  local tentacleCountMul = 1
  for _, stateId in ipairs(stateIdsToMulCount) do
    local state = self.battleEngine.stateMgr:GetState(player, stateId)
    if state then
      tentacleCountMul = tentacleCountMul + state.data.layer
    end
  end
  schoolArgs[BP.tentacle_count] = (tentacleCount + tentacleCountAdd) * tentacleCountMul
  schoolArgs[BP.tentacle_dmg] = tentacleDmg
  schoolArgs[BP.tentacle_dmg_show] = tentacleDmgShow
  self.battleEngine:DebugS("GetSchoolSpecialArgs {tentacleCount} {tentacleCountAdd} {tentacleCountMul} {finalTentacleCount} {tentacleDmg} {tentacleDmgShow}", tentacleCount, tentacleCountAdd, tentacleCountMul, schoolArgs[BP.tentacle_count], tentacleDmg, tentacleDmgShow)
  return schoolArgs
end

function SchoolCompPVE:UpdateSchoolSpecialArgs()
  local schoolArgs = self:GetSchoolSpecialArgs()
  self.battleEngine.recordMgr:OnUpdateSchoolSpecialArgs(self.role.uid, schoolArgs)
end

function SchoolCompPVE:IsSchoolID(schoolID)
  local cnt = self.schoolMap and self.schoolMap[schoolID] or 0
  local ok = cnt >= 1
  self.battleEngine:InfoS("[IsSchoolID] query schoolID={id} count={cnt} ok={ok} map={map}", schoolID, cnt, ok, table.tostring(self.schoolMap))
  return ok
end

function SchoolCompPVE:GetSchoolMap()
  return self.schoolMap
end

return SchoolCompPVE
