local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BattleCmdCardListExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdCardListExp")
local BattleCmdStasticsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdStasticsExp")
local BattleCmdKeeperSkillExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdKeeperSkillExp")
local bc = require("Battle.BattleConst")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleCmdParser, Super = System.NewClass("BattleCmdParser", BattleComponent)
local BP = bc.BattleProperty

function BattleCmdParser:ctor(battleEngine, ctorData)
  Super.ctor(self)
  self.battleEngine = battleEngine
  self.configPara = ctorData.configPara
  self.castRoleUid = ctorData.castRoleUid
  self.cardUid = ctorData.cardUid
  self.skillConfigId = ctorData.skillConfigId
  self.skillLevel = ctorData.skillLevel or 1
  self.upperTargets = {}
  self.stateUid = ctorData.stateUid
  self.stateId = ctorData.stateId
  self.cmdServer = nil
  if ctorData.cmdServerUid then
    self.cmdServer = self.battleEngine:GetObj(ctorData.cmdServerUid)
  end
  self.hitTarget = nil
  self.upperTargets = {}
  self.lastEffectUid = nil
  self.memberValues = {}
  self.memberValueTypes = {}
  self.cmdFuncs = {}
  self.skillArgs = {}
end

function BattleCmdParser:UpdateCasterRoleUid(castRoleUid)
  if self.castRoleUid == castRoleUid then
    return
  end
  self.castRoleUid = castRoleUid
end

function BattleCmdParser:UpdateSkillArgs(skillArgs)
  self.skillArgs = skillArgs
end

function BattleCmdParser:__GetValueByCmd(cmdStr)
  if type(cmdStr) == "table" then
    return cmdStr
  end
  local value = tonumber(cmdStr)
  if value then
    return value
  end
  local cmdFunc = self.cmdFuncs[cmdStr]
  if not cmdFunc then
    local mt = {
      __index = System.fn(self, self.EnvMetaFunc)
    }
    local fenv = {}
    setmetatable(fenv, mt)
    cmdStr = cmdStr or "nil"
    cmdFunc = self.battleEngine:GetCmdFunc(cmdStr, fenv)
    if not cmdFunc then
      return 0
    end
    self.cmdFuncs[cmdStr] = cmdFunc
  end
  return cmdFunc
end

function BattleCmdParser:GetValueByCmdList(cmdList)
  local ret = {}
  for _, cmdStr in ipairs(cmdList) do
    table.insert(ret, self:GetValueByCmd(cmdStr))
  end
  return ret
end

function BattleCmdParser:GetValueByCmd(cmdStr)
  local cmdFunc = self:__GetValueByCmd(cmdStr)
  if type(cmdFunc) ~= "function" then
    return cmdFunc
  end
  local ret = table.pack(xpcall(cmdFunc, function(error)
    local cmdId = self.cmdServer and self.cmdServer.cmdId
    local stateId = self.stateId
    local str = string.format("指令 %s （状态 %s） 运行错误 %s. error: %s", cmdId, stateId, cmdStr, error)
    self.battleEngine:Error(str)
  end))
  local result = table.remove(ret, 1)
  if not result then
    return 0
  end
  do return table.unpack end
  return table.unpack, ret
end

function BattleCmdParser:GetValueListByCmd(cmdStr)
  local cmdFunc = self:__GetValueByCmd(cmdStr)
  if type(cmdFunc) ~= "function" then
    return {cmdFunc}
  end
  local ret = table.pack(xpcall(cmdFunc, function(error)
    local cmdId = self.cmdServer and self.cmdServer.cmdId
    local stateId = self.stateId
    local str = string.format("指令 %s （状态 %s） 运行错误 %s. error: %s", cmdId, stateId, cmdStr, error)
    self.battleEngine:Error(str)
  end))
  local result = table.remove(ret, 1)
  if not result then
    return {0}
  end
  return ret
end

local ApiType = {
  [bc.ApiType.TARGET] = function(parser, key)
    do return parser.GenerateTargetsExp, parser end
    return parser.GenerateTargetsExp, parser, key
  end,
  [bc.ApiType.CARD_DECK] = function(parser, key)
    do return parser.GenerateCardDeckExp, parser end
    return parser.GenerateCardDeckExp, parser, key
  end,
  [bc.ApiType.STASTICS] = function(parser, key)
    do return parser.GenerateStasticsExp, parser end
    return parser.GenerateStasticsExp, parser, key
  end,
  [bc.ApiType.KEEPER_SKILL] = function(parser, key)
    do return parser.GenerateKeeperSkillExp, parser end
    return parser.GenerateKeeperSkillExp, parser, key
  end,
  [bc.ApiType.FORMULA] = function(parser, key)
    local DT = parser.battleEngine.battleDT
    local apiCfg = DT.BattleApi[key]
    local formulaStr = apiCfg.Data
    local formulaValue = parser:GetValueByCmd(formulaStr)
    return formulaValue
  end,
  [bc.ApiType.CMD_MEMBER] = function(parser, key)
    do return parser.GetMemberValue, parser end
    return parser.GetMemberValue, parser, key
  end,
  [bc.ApiType.STR_VALUE] = function(_, key)
    return key
  end,
  [bc.ApiType.GLOBAL_VALUE] = function(parser, key)
    do return parser.GetGlobalValue, parser end
    return parser.GetGlobalValue, parser, key
  end,
  [bc.ApiType.GLOBAL_FUNC] = function(parser, key)
    if not parser[key] then
      parser.battleEngine:Error("函数变量" .. key .. "未定义")
      return key
    end
    do return System.fn, parser end
    return System.fn, parser, parser[key], key, "未定义"
  end,
  [bc.ApiType.FUNC] = function(parser, key)
    if not parser[key] then
      parser.battleEngine:Error("函数变量" .. key .. "未定义")
      return key
    end
    do return System.fn, parser end
    return System.fn, parser, parser[key], key, "未定义"
  end,
  [bc.ApiType.FUNC_ATTR] = function(_, key)
    return key
  end,
  [bc.ApiType.ATTR] = function(_, key)
    return key
  end,
  [bc.ApiType.AWAKER_ATTR] = function(_, key)
    return key
  end,
  [bc.ApiType.CARD_ATTR] = function(_, key)
    return key
  end,
  [bc.ApiType.STATS_ATTR] = function(_, key)
    return key
  end
}

function BattleCmdParser:EnvMetaFunc(_, key)
  if _G[key] then
    return _G[key]
  end
  local DT = self.battleEngine.battleDT
  if DT.CommonID[key] then
    return key
  end
  if not DT.BattleApi[key] then
    return key
  end
  local apiCfg = DT.BattleApi[key]
  if not apiCfg then
    self.battleEngine:Error("指令变量" .. key .. "找不到")
    return key
  end
  if ApiType[apiCfg.ApiType] then
    do return ApiType[apiCfg.ApiType], self end
    return ApiType[apiCfg.ApiType], self, key, key, "找不到", nil
  end
  self.battleEngine:Error("指令变量" .. key .. "找不到 ApiType=" .. apiCfg.ApiType)
  return key
end

function BattleCmdParser:SetMemberValue(key, value, valueType)
  self.memberValueTypes[key] = valueType or "number"
  self.memberValues[key] = value
end

function BattleCmdParser:GetMemberValue(key)
  if self.memberValues[key] == nil then
    if self.memberValueTypes[key] == "bool" then
      return false
    elseif self.memberValueTypes[key] == "number" then
      return 0
    elseif self.memberValues[key] == "table" then
      return {}
    else
      local str = string.format("GetMemberValue %s is nil and it's type is nil too, return 0", key)
      self.battleEngine:Warn(str)
      return 0
    end
  end
  return self.memberValues[key]
end

function BattleCmdParser:HasMemberValue(key)
  return self.memberValues[key] ~= nil
end

function BattleCmdParser:ClearMemberValues()
  self.memberValues = {}
  self.memberValueTypes = {}
end

function BattleCmdParser:RandomTarget(targetList, num)
  if not (targetList and num) or num <= 0 then
    return {}
  end
  local isClass = System.IsClass(targetList)
  local originType
  local list = targetList
  if isClass then
    if targetList.is and targetList:is(BattleCmdTargetsExp) then
      originType = "targets_exp"
      list = targetList.targets or {}
    elseif targetList.is and targetList:is(BattleCmdCardListExp) then
      originType = "card_list_exp"
      if targetList.GetCardList then
        list = targetList:GetCardList()
      elseif targetList.cardList then
        list = targetList.cardList
      end
    elseif targetList.targets then
      list = targetList.targets
    elseif targetList.GetAll then
      list = targetList:GetAll()
    elseif targetList.GetCardList then
      list = targetList:GetCardList()
    elseif targetList.cardList then
      list = targetList.cardList
    end
  end
  if type(list) ~= "table" or 0 == #list then
    return {}
  end
  local count = math.min(num, #list)
  local tmpList = {}
  for i, v in ipairs(list) do
    tmpList[i] = v
  end
  BattleUtilServer.Shuffle(self.battleEngine, tmpList)
  local randList = {}
  for i = 1, count do
    if not tmpList[i] then
      break
    end
    table.insert(randList, tmpList[i])
  end
  if not isClass then
    return randList
  end
  if "targets_exp" == originType then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, randList, nil, table.insert, randList, tmpList[i]
  elseif "card_list_exp" == originType then
    do return BattleCmdCardListExp, self end
    return BattleCmdCardListExp, self, randList, nil, table.insert, randList, tmpList[i]
  end
  return randList
end

local GlobalValueFunc = {
  LastConditionRet = function(parser)
    return parser.lastConditionRet and 1 or 0
  end,
  TriggerValue = function(parser)
    if parser.cmdServer == nil or nil == parser.cmdServer.triggerData then
      return 0
    end
    return parser.cmdServer.triggerData.triggerValue or 0
  end,
  TriggerValue2 = function(parser)
    if parser.cmdServer == nil or nil == parser.cmdServer.triggerData then
      return 0
    end
    return parser.cmdServer.triggerData.triggerValue2 or 0
  end,
  TriggerValue3 = function(parser)
    if parser.cmdServer == nil or nil == parser.cmdServer.triggerData then
      return 0
    end
    return parser.cmdServer.triggerData.triggerValue3 or 0
  end,
  TriggerValue4 = function(parser)
    if parser.cmdServer == nil or nil == parser.cmdServer.triggerData then
      return 0
    end
    return parser.cmdServer.triggerData.triggerValue4 or 0
  end,
  Layer = function(parser)
    if not parser.stateUid then
      return 0
    end
    local state = parser.battleEngine:GetObj(parser.stateUid)
    if not state then
      parser.battleEngine:Error("獲得狀態層數失敗：找不到狀態", parser.stateUid, parser.skillConfigId, parser.stateId)
      return 0
    end
    return state.data.layer
  end,
  ChangedLayer = function(parser)
    if not parser.stateUid then
      return 0
    end
    local state = parser.battleEngine:GetObj(parser.stateUid)
    if not state then
      parser.battleEngine:Error("獲得狀態變化層數失敗：找不到狀態", parser.stateUid, parser.skillConfigId, parser.stateId)
      return 0
    end
    return state.data.changedLayer
  end,
  CurBoutNum = function(parser)
    do return parser.battleEngine.boutMgr.GetBoutNum end
    return parser.battleEngine.boutMgr.GetBoutNum, parser.battleEngine.boutMgr
  end,
  MonsterNum = function(parser)
    return #parser.battleEngine.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  end,
  BattleType = function(parser)
    do return parser.battleEngine.GetBattleType end
    return parser.battleEngine.GetBattleType, parser.battleEngine
  end,
  TeamLevel = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetTeamLevel end
    return player.GetTeamLevel, player
  end,
  IsDimensionBout = function(parser)
    if parser.battleEngine.boutMgr.isExtraBout then
      return 1
    end
    local dimensionSpaceCond = parser.battleEngine.battleDT.BattleApi.dimensionSpaceState
    if dimensionSpaceCond and parser:GetValueByCmd(dimensionSpaceCond.Data) then
      return 1
    end
    return 0
  end,
  [BP.dimension_slot] = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.dimension_slot
  end,
  [BP.energy] = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local player = parser.battleEngine.roleMgr:GetPlayer(casterCamp)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.energy
  end,
  [BP.max_energy] = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local player = parser.battleEngine.roleMgr:GetPlayer(casterCamp)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.max_energy
  end,
  money = function(parser)
    do return parser.battleEngine.GetCurMoney end
    return parser.battleEngine.GetCurMoney, parser.battleEngine
  end,
  [BP.tentacle_dmg] = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local player = parser.battleEngine.roleMgr:GetPlayer(casterCamp)
    do return player.GetTentacleDamage end
    return player.GetTentacleDamage, player
  end,
  [BP.tentacle_dmg_show] = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local player = parser.battleEngine.roleMgr:GetPlayer(casterCamp)
    do return player.GetShowTentacleDamage end
    return player.GetShowTentacleDamage, player
  end,
  [BP.max_tentacle_count] = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.max_tentacle_count
  end,
  [BP.tentacle_count] = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.tentacle_count
  end,
  [BP.scarlet_blood_count] = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.scarlet_blood_count
  end,
  [BP.max_scarlet_blood_count] = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetProperty, player end
    return player.GetProperty, player, BP.max_scarlet_blood_count
  end,
  TeamAtk = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetTeamAtk end
    return player.GetTeamAtk, player
  end,
  BoutNum = function(parser)
    do return parser.battleEngine.boutMgr.GetBoutNum end
    return parser.battleEngine.boutMgr.GetBoutNum, parser.battleEngine.boutMgr
  end,
  TeamOccMaster = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetTeamOccMaster end
    return player.GetTeamOccMaster, player
  end,
  StageStar = function(parser)
    do return parser.battleEngine.GetStageStar end
    return parser.battleEngine.GetStageStar, parser.battleEngine
  end,
  CurCamp = function(parser)
    do return parser.battleEngine.boutMgr.GetCurCamp end
    return parser.battleEngine.boutMgr.GetCurCamp, parser.battleEngine.boutMgr
  end,
  PVPTeam1 = function(parser)
    if parser.battleEngine.boutMgr.initCamp == bc.BattleCamp.Camp1 then
      return bc.BattleCamp.Camp1
    else
      return bc.BattleCamp.Camp2
    end
  end,
  PVPTeam2 = function(parser)
    if parser.battleEngine.boutMgr.initCamp == bc.BattleCamp.Camp1 then
      return bc.BattleCamp.Camp2
    else
      return bc.BattleCamp.Camp1
    end
  end,
  CurrentCmdTargetCount = function(parser)
    local runningEffect = parser.battleEngine.effectMgr:GetRunningEffect()
    if not runningEffect then
      return 0
    end
    return #(runningEffect.targets or {})
  end,
  UnlockedKeeperSkillNum = function(parser)
    local player = parser.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    return #player.unlockedKeeperSkillList
  end,
  LockAwakenCardCount = function(parser)
    do return parser.battleEngine.GetLockAwakenCardCount end
    return parser.battleEngine.GetLockAwakenCardCount, parser.battleEngine
  end,
  UnlockAwakenCardCount = function(parser)
    do return parser.battleEngine.GetUnlockAwakenCardCount end
    return parser.battleEngine.GetUnlockAwakenCardCount, parser.battleEngine
  end,
  IsOutofStage = function(_)
    return false
  end,
  IsInStage = function(_)
    return false
  end,
  IsInBattle = function(_)
    return true
  end
}

function BattleCmdParser:GetGlobalValue(key)
  local sub = string.sub(key, 1, 3)
  if "Arg" == sub then
    local argIndex = tonumber(string.replace(key, "Arg", "", true))
    if self.skillArgs[argIndex] then
      return self.skillArgs[argIndex] or 0
    else
      local params = self:GetValueListByCmd(self.configPara)
      return params[argIndex] or 0
    end
  end
  sub = string.sub(key, 1, 8)
  if "StateArg" == sub then
    local argIndex = tonumber(string.replace(key, "StateArg", "", true))
    if self.stateUid then
      local state = self.battleEngine:GetObj(self.stateUid)
      if not state then
        self.battleEngine:Error("獲得狀態参数失敗：找不到狀態", self.stateUid, self.skillConfigId, self.stateId)
        return 0
      end
      return self:GetValueByCmd(state.stateParams[argIndex]) or 0
    else
      return 0
    end
  end
  if GlobalValueFunc[key] then
    do return GlobalValueFunc[key] end
    return GlobalValueFunc[key], self, self:GetValueByCmd(state.stateParams[argIndex]) or 0, self, state.stateParams[argIndex], self.stateUid, self.skillConfigId, self.stateId
  end
  return 0
end

local GenerateTargetFunc = {
  UpperTarget = function(parser)
    return parser.upperTargets
  end,
  TargetCmdOwner = function(parser)
    return {
      parser.battleEngine:GetObj(parser.castRoleUid)
    }
  end,
  CmdOwner = function(parser)
    if parser.stateUid then
      return {
        parser.battleEngine:GetObj(parser.stateUid)
      }
    elseif parser.cardUid then
      return {
        parser.battleEngine:GetObj(parser.cardUid)
      }
    end
    return {}
  end,
  CurCard = function(parser)
    return {
      parser.battleEngine:GetCurCard()
    }
  end,
  CurCardTarget = function(parser)
    local curCard = parser.battleEngine:GetCurCard()
    if not curCard or not curCard.GetSkillTarget then
      return {}
    end
    local targets = curCard:GetSkillTarget()
    if not targets then
      return {}
    end
    return targets
  end,
  OwnerCard = function(parser)
    return {
      parser.battleEngine:GetObj(parser.cardUid)
    }
  end,
  HitTarget = function(parser)
    return {
      parser.hitTarget
    }
  end,
  AllAwaker = function(parser)
    do return parser.GetAwakerListInParser end
    return parser.GetAwakerListInParser, parser
  end,
  GetAllAwakenCardList = function(parser)
    do return parser.GetAllAwakenCardList end
    return parser.GetAllAwakenCardList, parser
  end,
  MinEngergyAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetMinPropertyAwaker(BP.ulti_energy)
    return {target}
  end,
  MaxEngergyAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetMaxPropertyAwaker(BP.ulti_energy)
    return {target}
  end,
  MaxUEAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetMaxPropertyAwaker(BP.ulti_energy)
    return {target}
  end,
  MinUEAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetMinPropertyAwaker(BP.ulti_energy)
    return {target}
  end,
  OtherMaxUEAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetOtherMaxPropertyAwaker(parser.castRoleUid, BP.ulti_energy)
    return {target}
  end,
  OtherMinUEAwaker = function(parser)
    local target = parser.battleEngine.roleMgr:GetOtherMinPropertyAwaker(parser.castRoleUid, BP.ulti_energy)
    return {target}
  end,
  RandomAwaker = function(parser)
    local targets = parser:GetAwakerListInParser()
    local idx = parser.battleEngine.rand:random(1, #targets)
    return {
      targets[idx]
    }
  end,
  OtherAwaker = function(parser)
    local camp = parser:GetCasterCamp()
    local player = parser.battleEngine.roleMgr:GetPlayer(camp)
    local allAwakers = player:GetAwakerList()
    local targets = {}
    for _, awaker in ipairs(allAwakers) do
      if awaker.uid ~= parser.castRoleUid then
        table.insert(targets, awaker)
      end
    end
    return targets
  end,
  CmdCaster = function(parser)
    local caster = parser.battleEngine.roleMgr:GetRoleByUid(parser.castRoleUid)
    return {caster}
  end,
  PlayerRole = function(parser)
    local casterCamp = parser:GetCasterCamp()
    return {
      parser.battleEngine.roleMgr:GetPlayer(casterCamp)
    }
  end,
  PlayerRoleEnemy = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
    return {
      parser.battleEngine.roleMgr:GetPlayer(enemyCamp)
    }
  end,
  AllEnemy = function(parser)
    return parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
  end,
  AllEnemy2 = function(parser)
    return parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
  end,
  AllEnemyWithoutMainTarget = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local mainTarget = parser:GetMemberValue("TempMainTarget")
    if not mainTarget or 0 == mainTarget then
      return allEnemy
    end
    local result = {}
    for _, enemy in ipairs(allEnemy) do
      if enemy ~= mainTarget then
        table.insert(result, enemy)
      end
    end
    return result
  end,
  MinHpEnemy = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local t, t_hp
    for _, enemy in ipairs(allEnemy) do
      local e_hp = enemy:GetProperty(BP.hp)
      if not t or t_hp > e_hp then
        t = enemy
        t_hp = e_hp
      end
    end
    return {t}
  end,
  MaxHpEnemy = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local t, t_hp
    for _, enemy in ipairs(allEnemy) do
      local e_hp = enemy:GetProperty(BP.hp)
      if not t or t_hp < e_hp then
        t = enemy
        t_hp = e_hp
      end
    end
    return {t}
  end,
  MaxDamageEnemy = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local maxDamageEnemy, maxDamageValue
    for _, enemy in ipairs(allEnemy) do
      if not enemy.monsterBehaviorComp then
      else
        local damageInfo = enemy.monsterBehaviorComp:GetDamageInfoValue()
        local damageValue = damageInfo and damageInfo[1] or 0
        if not maxDamageEnemy or maxDamageValue < damageValue or damageValue == maxDamageValue and enemy.uid < maxDamageEnemy.uid then
          maxDamageEnemy = enemy
          maxDamageValue = damageValue
        end
      end
    end
    return {maxDamageEnemy}
  end,
  RandomEnemy = function(parser)
    local battleEngine = parser.battleEngine
    local allEnemy = battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local rand = battleEngine.rand:random(1, math.max(1, #allEnemy))
    local target = allEnemy[rand]
    return {target}
  end,
  AllAlly = function(parser)
    local caster = parser.battleEngine:GetObj(parser.castRoleUid)
    if not caster then
      parser.battleEngine:Error("获取所有友方目标失败：找不到施法者", parser.castRoleUid, parser.skillConfigId, parser.stateId)
      return {}
    end
    return parser.battleEngine.roleMgr:GetAliveRoleListByCamp(caster.camp) or {}
  end,
  RandomAlly = function(parser)
    local battleEngine = parser.battleEngine
    local caster = battleEngine:GetObj(parser.castRoleUid)
    if not caster then
      parser.battleEngine:Error("获取随机友方目标失败：找不到施法者", parser.castRoleUid, parser.skillConfigId, parser.stateId)
      return {}
    end
    local allAlly = battleEngine.roleMgr:GetAliveRoleListByCamp(caster.camp) or {}
    local idx = battleEngine.rand:random(1, math.max(1, #allAlly))
    local target = allAlly[idx]
    return {target}
  end,
  OtherAlly = function(parser)
    return parser.battleEngine.roleMgr:GetAliveAllyListByRoleUid(parser.castRoleUid) or {}
  end,
  FrontAlly = function(parser)
    local caster = parser.battleEngine:GetObj(parser.castRoleUid)
    if not caster then
      parser.battleEngine:Error("获取前排友方目标失败：找不到施法者", parser.castRoleUid, parser.skillConfigId, parser.stateId)
      return {}
    end
    local allEnemy = parser.battleEngine.roleMgr:GetPosSortedRoleByCamp(caster.camp) or {}
    return {
      allEnemy[1]
    }
  end,
  MinHpAlly = function(parser)
    local caster = parser.battleEngine:GetObj(parser.castRoleUid)
    if not caster then
      parser.battleEngine:Error("获取血量最低友方目标失败：找不到施法者", parser.castRoleUid, parser.skillConfigId, parser.stateId)
      return {}
    end
    local AllAlly = parser.battleEngine.roleMgr:GetAliveRoleListByCamp(caster.camp) or {}
    local t, t_hp
    for _, ally in ipairs(AllAlly) do
      local e_hp = ally:GetProperty(BP.hp)
      if not t or t_hp > e_hp then
        t = ally
        t_hp = e_hp
      end
    end
    return {t}
  end,
  MaxHpAlly = function(parser)
    local caster = parser.battleEngine:GetObj(parser.castRoleUid)
    if not caster then
      parser.battleEngine:Error("获取血量最高友方目标失败：找不到施法者", parser.castRoleUid, parser.skillConfigId, parser.stateId)
      return {}
    end
    local AllAlly = parser.battleEngine.roleMgr:GetAliveRoleListByCamp(caster.camp) or {}
    local t, t_hp
    for _, ally in ipairs(AllAlly) do
      local e_hp = ally:GetProperty(BP.hp)
      if not t or t_hp < e_hp then
        t = ally
        t_hp = e_hp
      end
    end
    return {t}
  end,
  CurCaster = function(parser)
    local caster = parser.battleEngine.roleMgr:GetCurCaster()
    return {caster}
  end,
  EquipOwnerAwaker = function(parser)
    return {
      parser.battleEngine:GetObj(parser.castRoleUid)
    }
  end,
  TrinketOwnerAwaker = function(parser)
    return {
      parser.battleEngine:GetObj(parser.castRoleUid)
    }
  end,
  FrontEnemy = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
    local lockedRole = parser:__GetLockedEnemyByCaster()
    if lockedRole then
      return {lockedRole}
    end
    local tauntRole = parser.battleEngine.roleMgr:GetTauntRole(enemyCamp)
    if tauntRole then
      return {tauntRole}
    end
    
    local function filter(role)
      return 0 ~= role:GetProperty(BP.sneak)
    end
    
    local sortedEnemy = parser.battleEngine.roleMgr:GetPosSortedRoleByCamp(enemyCamp, filter) or {}
    return {
      sortedEnemy[1]
    }
  end,
  FrontAlly = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local tauntRole = parser.battleEngine.roleMgr:GetTauntRole(casterCamp)
    if tauntRole then
      return {tauntRole}
    end
    local sortedAlly = parser.battleEngine.roleMgr:GetPosSortedRoleByCamp(casterCamp) or {}
    return {
      sortedAlly[1]
    }
  end,
  BackEnemy = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
    local tauntRole = parser.battleEngine.roleMgr:GetTauntRole(enemyCamp)
    if tauntRole then
      return {tauntRole}
    end
    
    local function filter(role)
      return 0 ~= role:GetProperty(BP.sneak)
    end
    
    local sortedEnemy = parser.battleEngine.roleMgr:GetPosSortedRoleByCamp(enemyCamp, filter) or {}
    return {
      sortedEnemy[#sortedEnemy]
    }
  end,
  BackAlly = function(parser)
    local casterCamp = parser:GetCasterCamp()
    local tauntRole = parser.battleEngine.roleMgr:GetTauntRole(casterCamp)
    if tauntRole then
      return {tauntRole}
    end
    local sortedAlly = parser.battleEngine.roleMgr:GetPosSortedRoleByCamp(casterCamp) or {}
    return {
      sortedAlly[#sortedAlly]
    }
  end,
  LastTarget = function(parser)
    local effectObj = parser.battleEngine:GetObj(parser.lastEffectUid)
    return effectObj and effectObj.targets or {}
  end,
  StateOwner = function(parser)
    local targets
    if parser.stateUid then
      local state = parser.battleEngine:GetObj(parser.stateUid)
      if not state then
        parser.battleEngine:Error("获取状态拥有者目标失败：找不到状态", parser.stateUid, parser.skillConfigId, parser.stateId)
        return {}
      end
      targets = {
        state.owner
      }
    else
      targets = {}
    end
    return targets
  end,
  StateCaster = function(parser)
    if parser.stateUid then
      local state = parser.battleEngine:GetObj(parser.stateUid)
      if not state then
        parser.battleEngine:Error("获取状态施加者目标失败：找不到状态", parser.stateUid, parser.skillConfigId, parser.stateId)
        return {}
      end
      return {
        parser.battleEngine:GetObj(state.castRoleUid)
      }
    end
    return {}
  end,
  TriggerAssociator = function(parser)
    return parser.cmdServer.triggerData.associator
  end,
  TriggerAssociator2 = function(parser)
    return parser.cmdServer.triggerData.associator2
  end,
  TriggerAssociator3 = function(parser)
    return parser.cmdServer.triggerData.associator3
  end,
  TriggerAssociator4 = function(parser)
    return parser.cmdServer.triggerData.associator4
  end,
  ChooseAwaker = function(parser)
    do return parser.ChooseAwaker, parser end
    return parser.ChooseAwaker, parser, false
  end,
  ChooseOtherAwaker = function(parser)
    do return parser.ChooseAwaker, parser end
    return parser.ChooseAwaker, parser, true
  end,
  SelectCmdCaster = function(parser)
    do return parser.SelectCmdCaster end
    return parser.SelectCmdCaster, parser
  end,
  SelectFrontEnemy = function(parser)
    do return parser.SelectFrontEnemy end
    return parser.SelectFrontEnemy, parser
  end,
  SelectRandomEnemy = function(parser)
    do return parser.SelectRandomEnemy end
    return parser.SelectRandomEnemy, parser
  end,
  SelectRandomAlly = function(parser)
    do return parser.SelectRandomAlly end
    return parser.SelectRandomAlly, parser
  end,
  SelectAllOtherAwaker = function(parser)
    do return parser.SelectAllOtherAwaker end
    return parser.SelectAllOtherAwaker, parser
  end,
  MaxHpAndBlockEnemy = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local t, t_hp
    for _, enemy in ipairs(allEnemy) do
      local e_hp = enemy:GetProperty(BP.hp)
      local e_block = enemy:GetProperty(BP.block)
      local total = e_hp + e_block
      if not t or t_hp < total then
        t = enemy
        t_hp = total
      end
    end
    return {t}
  end,
  MinHpAndBlockEnemy = function(parser)
    local allEnemy = parser.battleEngine.roleMgr:GetAliveEnemyListByRoleUid(parser.castRoleUid) or {}
    local t, t_hp
    for _, enemy in ipairs(allEnemy) do
      local e_hp = enemy:GetProperty(BP.hp)
      local e_block = enemy:GetProperty(BP.block)
      local total = e_hp + e_block
      if not t or t_hp > total then
        t = enemy
        t_hp = total
      end
    end
    return {t}
  end,
  MaxHpAndBlockAlly = function(parser)
    local allAlly = parser.battleEngine.roleMgr:GetAliveRoleListByCamp(parser.castRoleUid) or {}
    local t, t_hp
    for _, ally in ipairs(allAlly) do
      local e_hp = ally:GetProperty(BP.hp)
      local e_block = ally:GetProperty(BP.block)
      local total = e_hp + e_block
      if not t or t_hp < total then
        t = ally
        t_hp = total
      end
    end
    return {t}
  end,
  MinHpAndBlockAlly = function(parser)
    local allAlly = parser.battleEngine.roleMgr:GetAliveRoleListByCamp(parser.castRoleUid) or {}
    local t, t_hp
    for _, ally in ipairs(allAlly) do
      local e_hp = ally:GetProperty(BP.hp)
      local e_block = ally:GetProperty(BP.block)
      local total = e_hp + e_block
      if not t or t_hp > total then
        t = ally
        t_hp = total
      end
    end
    return {t}
  end,
  RandomEnemy_IncludeDeath = function(parser)
    local battleEngine = parser.battleEngine
    local camp = parser:GetCasterCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
    local allEnemy = battleEngine.roleMgr:GetPVPRoleList(nil, enemyCamp) or {}
    local rand = battleEngine.rand:random(1, math.max(1, #allEnemy))
    local target = allEnemy[rand]
    return {target}
  end,
  AllAlly_IncludeDeath = function(parser)
    local battleEngine = parser.battleEngine
    local camp = parser:GetCasterCamp()
    return battleEngine.roleMgr:GetPVPRoleList(nil, camp) or {}
  end,
  RandomAlly_IncludeDeath = function(parser)
    local battleEngine = parser.battleEngine
    local camp = parser:GetCasterCamp()
    local allAlly = battleEngine.roleMgr:GetPVPRoleList(nil, camp) or {}
    local rand = battleEngine.rand:random(1, math.max(1, #allAlly))
    local target = allAlly[rand]
    return {target}
  end,
  OtherAlly_IncludeDeath = function(parser)
    local battleEngine = parser.battleEngine
    local camp = parser:GetCasterCamp()
    local allAlly = battleEngine.roleMgr:GetPVPRoleList(nil, camp) or {}
    local caster = parser.battleEngine:GetObj(parser.castRoleUid)
    for i = #allAlly, 1, -1 do
      if allAlly[i].uid == caster.uid then
        table.remove(allAlly, i)
        break
      end
    end
    return allAlly
  end,
  AllEnemy_IncludeDeath = function(parser)
    local battleEngine = parser.battleEngine
    local camp = parser:GetCasterCamp()
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
    return battleEngine.roleMgr:GetPVPRoleList(nil, enemyCamp) or {}
  end,
  TempTarget1 = function(parser)
    local t = parser:GetMemberValue("TempTarget1")
    if 0 == t then
      return {}
    end
    return t
  end,
  TempTarget2 = function(parser)
    local t = parser:GetMemberValue("TempTarget2")
    if 0 == t then
      return {}
    end
    return t
  end,
  TempTarget3 = function(parser)
    local t = parser:GetMemberValue("TempTarget3")
    if 0 == t then
      return {}
    end
    return t
  end,
  TempTarget4 = function(parser)
    local t = parser:GetMemberValue("TempTarget4")
    if 0 == t then
      return {}
    end
    return t
  end,
  TempTarget5 = function(parser)
    local t = parser:GetMemberValue("TempTarget5")
    if 0 == t then
      return {}
    end
    return t
  end,
  TempMainTarget = function(parser)
    local t = parser:GetMemberValue("TempMainTarget")
    if 0 == t or not t then
      return {}
    end
    return {t}
  end
}

function BattleCmdParser:__GenerateTargetByFunc(targetType)
  local exp = self:GetValueByCmd(targetType)
  if exp == bc.YIELD_FLAG then
    return exp
  end
  if type(exp) == "table" and exp.is and exp:is(BattleCmdCardListExp) then
    return exp.cardList
  elseif type(exp) == "table" and exp.is and exp:is(BattleCmdTargetsExp) then
    return exp.targets
  end
  return exp
end

function BattleCmdParser:GenerateTargetsExp(targetType)
  if not targetType then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil
  end
  if bc.CardDeck[targetType] or bc.CardDeckApi[targetType] then
    do return self.GetValueByCmd, self end
    return self.GetValueByCmd, self, targetType, nil, nil
  end
  if string.find(targetType, ".", 0, true) or string.match(targetType, "%b()") then
    do return self.GetValueByCmd, self end
    return self.GetValueByCmd, self, targetType, 0, true
  end
  local targets = {}
  local data
  if GenerateTargetFunc[targetType] then
    targets, data = GenerateTargetFunc[targetType](self)
  end
  if targets == bc.YIELD_FLAG then
    return targets, data
  end
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, targets
end

function BattleCmdParser:ChooseAwaker(selectOtherAwaker)
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local player = caster:GetPlayer()
  local awakerList = player:GetAwakerList()
  local targetUids = {}
  for _, awaker in ipairs(awakerList) do
    if selectOtherAwaker and awaker.uid == self.castRoleUid then
    else
      table.insert(targetUids, awaker.uid)
    end
  end
  if self.battleEngine:GetTimeoutFlag() then
    local idx = self.battleEngine.rand:random(#targetUids)
    local selectAwaker = self.battleEngine:GetObj(targetUids[idx])
    local targets = {selectAwaker}
    return targets
  end
  local data = {
    selectOtherAwaker = selectOtherAwaker,
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    targetSelectType = bc.TargetSelectType.Awaker,
    targetUids = targetUids,
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:CondChooseAwaker(desc, selectNum, selectLogic, stateList, stateCondType, selectOtherAwaker)
  selectNum = selectNum or 1
  selectLogic = selectLogic or 0
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local player = caster:GetPlayer()
  local awakerList = player:GetAwakerList()
  local targetUids = {}
  for _, awaker in ipairs(awakerList) do
    if 1 == selectOtherAwaker and awaker.uid == self.castRoleUid then
    else
      if stateList and #stateList > 0 then
        local stateMgr = self.battleEngine.stateMgr
        if 0 == stateCondType then
          if not stateMgr:HasStateAllStateIds(awaker.uid, stateList) then
            goto lbl_63
          end
        elseif 1 == stateCondType and stateMgr:HasStateByStateIds(awaker.uid, stateList) then
          goto lbl_63
        end
      end
      table.insert(targetUids, awaker.uid)
    end
    ::lbl_63::
  end
  if self.battleEngine:GetTimeoutFlag() then
    local idx = self.battleEngine.rand:random(#targetUids)
    local selectAwaker = self.battleEngine:GetObj(targetUids[idx])
    local targets = {selectAwaker}
    return targets
  end
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    targetSelectType = bc.TargetSelectType.Awaker,
    targetUids = targetUids,
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId,
    desc = desc,
    selectNum = selectNum,
    selectLogic = selectLogic,
    stateList = stateList,
    stateCondType = stateCondType,
    selectOtherAwaker = selectOtherAwaker
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:GetAllAwakenCardList()
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local player = caster:GetPlayer()
  local awakerList = player:GetAwakerList()
  local allCards = self.battleEngine.cardMgr:GetAllCardList()
  local cardMap = {}
  for _deck, cardList in pairs(allCards) do
    for _, cardUid in ipairs(cardList) do
      local card = self.battleEngine:GetObj(cardUid)
      local tid = card:GetID()
      cardMap[tid] = true
    end
  end
  local retCardList = {}
  local DT = self.battleEngine.battleDT
  local awakerConf = DT.AwakerConfig
  local skillConf = DT.Skill
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  for _, awaker in ipairs(awakerList) do
    local tid = awaker:GetID()
    local cardList = awakerConf[tid].SkillList
    for _, skillId in ipairs(cardList) do
      local types = skillConf[skillId].Type
      if table.contains(types, bc.SkillType.Card_Awake) and not cardMap[skillId] then
        local cardOriInfo = self.battleEngine:GetCardInfo(skillId)
        local cardInfo = {
          tid = skillId,
          level = cardOriInfo.level,
          camp = camp
        }
        table.insert(retCardList, cardInfo)
      end
    end
  end
  local ret = self.battleEngine.cardMgr:CreateCardsByID(retCardList, self)
  do return ret.GetTargetList end
  return ret.GetTargetList, ret, self, ipairs(cardList)
end

function BattleCmdParser:GetFirstAwaker()
  local awakerList = self:GetAwakerListInParser()
  return awakerList[1]
end

function BattleCmdParser:GenerateCardDeckExp(deckType)
  local cardDeck = deckType
  local exp = BattleCmdCardListExp(self, cardDeck)
  return exp
end

function BattleCmdParser:GenerateStasticsExp(type)
  local exp = BattleCmdStasticsExp(self, type)
  return exp
end

function BattleCmdParser:GenerateKeeperSkillExp(type)
  local exp = BattleCmdKeeperSkillExp(self, type)
  return exp
end

function BattleCmdParser:GetMonsterCountByID(monsterID)
  do return self.battleEngine.roleMgr.GetMonsterCountByID, self.battleEngine.roleMgr end
  return self.battleEngine.roleMgr.GetMonsterCountByID, self.battleEngine.roleMgr, monsterID
end

function BattleCmdParser:GetMonsterIntention(targetsExp, relativeIndex)
  relativeIndex = tonumber(relativeIndex) or 0
  local monster
  if nil == targetsExp then
    return 0
  end
  if System.IsClass(targetsExp) and targetsExp.is and targetsExp:is(BattleCmdTargetsExp) then
    local targets = targetsExp:GetTargetList()
    monster = targets and targets[1]
  elseif type(targetsExp) == "table" and nil == targetsExp.is then
    monster = targetsExp[1]
  else
    monster = targetsExp
  end
  if not monster or not monster.monsterBehaviorComp then
    return 0
  end
  local behaviorComp = monster.monsterBehaviorComp
  local intention
  if behaviorComp.GetIntention then
    intention = behaviorComp:GetIntention()
  else
    intention = behaviorComp.intention
  end
  if not intention or 0 == intention then
    return 0
  end
  local cfg = monster.configData or {}
  local skillListType = behaviorComp.skillListType
  local list = skillListType and cfg[skillListType] or {}
  if type(list) ~= "table" or 0 == #list then
    return intention
  end
  local curIndex
  for i, skillId in ipairs(list) do
    if skillId == intention then
      curIndex = i
      break
    end
  end
  if not curIndex or curIndex <= 0 then
    curIndex = behaviorComp.skillIndex or 1
  end
  if curIndex <= 0 then
    curIndex = 1
  elseif curIndex > #list then
    curIndex = #list
  end
  local targetIndex = curIndex + relativeIndex
  if targetIndex < 1 then
    targetIndex = 1
  elseif targetIndex > #list then
    targetIndex = #list
  end
  return list[targetIndex] or 0
end

function BattleCmdParser:GetAwakerCountBySchool(schoolType)
  local camp = self:GetCasterCamp()
  do return self.battleEngine.roleMgr.GetAwakerCountBySchool, self.battleEngine.roleMgr, schoolType end
  return self.battleEngine.roleMgr.GetAwakerCountBySchool, self.battleEngine.roleMgr, schoolType, camp
end

function BattleCmdParser:GetSpecialSchoolAwakerNum(constantKey)
  local camp = self:GetCasterCamp()
  do return self.battleEngine.roleMgr.GetSpecialSchoolAwakerNum, self.battleEngine.roleMgr, constantKey end
  return self.battleEngine.roleMgr.GetSpecialSchoolAwakerNum, self.battleEngine.roleMgr, constantKey, camp
end

function BattleCmdParser:GetAwakerListBySchool(school)
  local awakerList = self:GetAwakerListInParser()
  local ret = {}
  for _, awaker in ipairs(awakerList) do
    if awaker:GetSchoolConfigId() == school then
      table.insert(ret, awaker)
    end
  end
  return ret
end

function BattleCmdParser:GetAwakerListByAim(Type)
  local awakerList = self:GetAwakerListInParser()
  local ret = {}
  for _, awaker in ipairs(awakerList) do
    if awaker:GetAwakerType() == Type then
      table.insert(ret, awaker)
    end
  end
  return ret
end

function BattleCmdParser:SelectKeeperSkill(desc, exceptUnlocked, num, exceptSelected, exceptOrigin, fillBlank)
  exceptOrigin = exceptOrigin or 0
  exceptUnlocked = exceptUnlocked or 0
  exceptSelected = exceptSelected or 0
  fillBlank = tonumber(fillBlank) or 0
  local selectNum = 1
  local isMust = true
  local minNum = isMust and selectNum or 0
  num = num or 1
  local casterCamp = self:GetCasterCamp()
  local player = self.battleEngine.roleMgr:GetPlayer(casterCamp)
  local skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  local stateId = self.cmdServer and self.cmdServer.stateId
  local curKeeperSkillId
  if skillConfigId then
    local skillCfg = self.battleEngine.battleDT.Skill[skillConfigId]
    if skillCfg.Type[1] == bc.SkillType.Keeper_Skill then
      curKeeperSkillId = skillConfigId
    end
  end
  local exceptSelectedSourceId
  if 1 == exceptSelected then
    exceptSelectedSourceId = stateId or skillConfigId
  end
  local keeperSkills = player:GetUnlockedKeeperSkillInfos(exceptUnlocked, num, curKeeperSkillId, exceptSelectedSourceId, exceptOrigin, fillBlank)
  if 0 == #keeperSkills then
    return {}
  end
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    selectNum = selectNum,
    targetUids = keeperSkills,
    targetSelectType = bc.TargetSelectType.KeeperSkill,
    minNum = minNum,
    desc = desc,
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = skillConfigId
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:RandUnlockKeeperSkill(num, fillBlank, exceptUsed, exceptOrigin, sourceId)
  if not self.battleEngine:IsPVE() then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  num = tonumber(num) or 1
  fillBlank = tonumber(fillBlank) or 1
  exceptUsed = tonumber(exceptUsed) or 1
  exceptOrigin = tonumber(exceptOrigin) or 1
  sourceId = tonumber(sourceId) or 0
  if 0 == sourceId then
    sourceId = self.cmdServer and (self.cmdServer.skillConfigId or self.cmdServer.stateId) or 0
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player or num <= 0 then
    local emptyResultExp = BattleCmdTargetsExp(self, {})
    emptyResultExp.randUnlockPackNum = math.max(num, 0)
    return emptyResultExp
  end
  if not self.randUnlockOfferedTidMap then
    self.randUnlockOfferedTidMap = {}
  end
  local DT = self.battleEngine.battleDT
  local excludeList = DT.GetOriginalConstant("RandUnlockKeeperSkillExcludeList", {})
  local usedKeeperSkillIdList = {}
  if 1 == exceptUsed and sourceId and player.data.randUnlockKeeperSkillUsed then
    usedKeeperSkillIdList = player.data.randUnlockKeeperSkillUsed[sourceId] or {}
  end
  local originKeeperSkillId = player.data.skillId
  local candidatePool = {}
  local candidateTidSet = {}
  for _, unlockedKeeperSkill in ipairs(player.unlockedKeeperSkillList or {}) do
    local keeperSkillId = unlockedKeeperSkill:GetData("tid")
    if table.contains(excludeList, keeperSkillId) then
    elseif 1 == exceptOrigin and keeperSkillId == originKeeperSkillId then
    elseif 1 == exceptUsed and table.contains(usedKeeperSkillIdList, keeperSkillId) then
    elseif self.randUnlockOfferedTidMap[keeperSkillId] or candidateTidSet[keeperSkillId] then
    else
      candidateTidSet[keeperSkillId] = true
      table.insert(candidatePool, {keeperSkillId = keeperSkillId, isBlankMemory = false})
    end
  end
  if 1 == fillBlank then
    local blankMemorySkillIdList = string.split(DT.BattleApi.KeeperSkillBlankMemory.Data, ",") or {}
    for _, blankSkillIdStr in ipairs(blankMemorySkillIdList) do
      local blankKeeperSkillId = tonumber(blankSkillIdStr)
      if blankKeeperSkillId and not self.randUnlockOfferedTidMap[blankKeeperSkillId] and not candidateTidSet[blankKeeperSkillId] then
        candidateTidSet[blankKeeperSkillId] = true
        table.insert(candidatePool, {keeperSkillId = blankKeeperSkillId, isBlankMemory = true})
      end
    end
  end
  BattleUtilServer.Shuffle(self.battleEngine, candidatePool)
  local keeperSkillResultList = {}
  for _, candidateEntry in ipairs(candidatePool) do
    if num <= #keeperSkillResultList then
      break
    end
    local keeperSkillId = candidateEntry.keeperSkillId
    local keeperSkillCopy = player:CreateKeeperSkill(keeperSkillId, {
      randUnlockSourceId = sourceId,
      isBlankMemory = candidateEntry.isBlankMemory
    })
    if nil ~= keeperSkillCopy then
      table.insert(keeperSkillResultList, keeperSkillCopy)
      self.randUnlockOfferedTidMap[keeperSkillId] = true
    end
  end
  local resultExp = BattleCmdTargetsExp(self, keeperSkillResultList)
  resultExp.randUnlockPackNum = num
  return resultExp
end

function BattleCmdParser:OnSelectRandUnlockKeeperSkillDropPack(targetList)
  if not (self.battleEngine:IsPVE() and targetList) or not next(targetList) then
    return
  end
  local firstTarget = targetList[1]
  if not (firstTarget and firstTarget.GetData) or not firstTarget.GetCmdServer then
    return
  end
  if not firstTarget.data or firstTarget.data.randUnlockSourceId == nil then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player then
    return
  end
  local effectiveSourceId = firstTarget.data.randUnlockSourceId
  player:OnSelectRandUnlockKeeperSkillPack(effectiveSourceId, targetList)
end

function BattleCmdParser:SelectCard(cardListExp, selectNum, isMustNum, desc)
  do return self.ChooseCardDesignateEnchantList, self, cardListExp, nil, desc, selectNum end
  return self.ChooseCardDesignateEnchantList, self, cardListExp, nil, desc, selectNum, isMustNum
end

function BattleCmdParser:GetCardByID(cardID, num, levelType)
  levelType = levelType or bc.GetCardByIDType.CastSkillLevel
  local level
  if levelType == bc.GetCardByIDType.CastSkillLevel then
    level = self:GetSkillLevel()
  else
    level = self.battleEngine.cardMgr:GetCardLevelByID(cardID)
  end
  local camp = self:GetCasterCamp()
  if self.battleEngine:IsPVE() then
    camp = bc.BattleCamp.Camp1
  end
  local cardData = {
    tid = cardID,
    num = num,
    level = level,
    camp = camp
  }
  do return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, {cardData} end
  return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, {cardData}, self
end

function BattleCmdParser:GetCardLevelByID(cardID)
  if not cardID or 0 == cardID then
    return 0
  end
  local level = self.battleEngine.cardMgr:GetCardLevelByID(cardID)
  if not level then
    return 0
  end
  return level
end

function BattleCmdParser:EnchantCard(cmdCardListExp, num, enchant)
  self.battleEngine:InfoS("EnchantCard {cmdCardListExp} {num} {enchant}", cmdCardListExp, num, enchant)
  local res = {}
  local cardList = cmdCardListExp.cardList
  if cardList and next(cardList) then
    res = self.battleEngine:RandomNumFromList(cardList, num)
  else
    self.battleEngine:InfoS("EnchantCard no cardList")
  end
  if res and next(res) and enchant then
    local runeId = self:GetValueByCmd(enchant)
    for _, card in ipairs(res) do
      self:PutEnchant(card, enchant)
    end
  end
  cmdCardListExp.cardList = res
  return cmdCardListExp
end

function BattleCmdParser:PutEnchant(card, enchantTid)
  local enchantCfg = self.battleEngine.battleDT.EnchantConfig[enchantTid]
  card:AddRune(enchantTid)
  if enchantCfg.State and #enchantCfg.State > 0 then
    for _, stateTid in pairs(enchantCfg.State) do
      self.battleEngine:InfoS("PutEnchant add stete {enchantCfg} {cardTid} {stateTid}", enchantCfg.ID, card.tid, stateTid)
      local createArgs = {
        stateId = stateTid,
        layer = 1,
        castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
        targetUid = card.uid,
        targetRoleUid = card.uid,
        stateParams = enchantCfg.StatePara or {},
        cmdServerUid = self.cmdServer and self.cmdServer.uid
      }
      self.battleEngine.stateMgr:CreateState(card, createArgs)
    end
  end
  self.battleEngine.recordMgr:OnChangeCard(card:Serialize())
end

function BattleCmdParser:GetKeeperSkillByID(keeperSkillID)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local keeperSkill = player:CreateKeeperSkill(keeperSkillID)
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, {keeperSkill}, keeperSkill
end

function BattleCmdParser:GetTeamKeeperSkill()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil
  end
  local skillId = player:GetKeeperSkillIdAndChangeType()
  do return self.GetKeeperSkillByID, self end
  return self.GetKeeperSkillByID, self, skillId
end

function BattleCmdParser:GetCardListByID(cardIDList, levelType)
  levelType = levelType or bc.GetCardByIDType.CastSkillLevel
  local level
  if type(levelType) == "number" then
    level = levelType
  elseif levelType == bc.GetCardByIDType.CastSkillLevel then
    level = self:GetSkillLevel()
  end
  local camp = self:GetCasterCamp()
  if self.battleEngine:IsPVE() then
    camp = bc.BattleCamp.Camp1
  end
  local list = {}
  for _, cardID in ipairs(cardIDList) do
    local lv = level or self.battleEngine.cardMgr:GetCardLevelByID(cardID)
    local cardData = {
      tid = cardID,
      num = 1,
      level = lv,
      camp = camp
    }
    table.insert(list, cardData)
  end
  do return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list end
  return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list, self, nil, nil, self.battleEngine.cardMgr:GetCardLevelByID(cardID), {
    tid = cardID,
    num = 1,
    level = lv,
    camp = camp
  }, table.insert, list, cardData
end

function BattleCmdParser:IsHaveMonster(pos)
  local monster = self.battleEngine.roleMgr:GetMonsterByPos(pos)
  return monster and 1 or 0
end

function BattleCmdParser:IsHaveAwaker(awakerTid)
  local awaker = self.battleEngine.roleMgr:GetAwakerByTid(awakerTid, bc.BattleCamp.Camp1)
  return awaker and true or false
end

function BattleCmdParser:GetEffectiveLevel()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local playerLevel = player.level
  local awakerAvgLevel = player:GetTeamLevel()
  if playerLevel <= awakerAvgLevel then
    do return math.ceil end
    return math.ceil, (awakerAvgLevel + playerLevel) / 2
  else
    return playerLevel
  end
end

function BattleCmdParser:GetAccountLevelArgByAccoutLevel(name)
  local DT = self.battleEngine.battleDT
  local effectiveLevel = self:GetEffectiveLevel()
  local levelCfg = DT.AcountLevelConfig[effectiveLevel]
  if not levelCfg then
    return 0
  end
  return levelCfg[name] or 0
end

function BattleCmdParser:GetAccountPower()
  do return self.GetAccountLevelArgByAccoutLevel, self end
  return self.GetAccountLevelArgByAccoutLevel, self, "AccountPower"
end

function BattleCmdParser:GetAccountDamagePower()
  do return self.GetAccountLevelArgByAccoutLevel, self end
  return self.GetAccountLevelArgByAccoutLevel, self, "AccountDamagePower"
end

function BattleCmdParser:GetAccountSkillMultiplier()
  do return self.GetAccountLevelArgByAccoutLevel, self end
  return self.GetAccountLevelArgByAccoutLevel, self, "SkillMultiplier"
end

function BattleCmdParser:GetAccountStageGrow()
  local baseStageGrow = self:GetAccountLevelArgByAccoutLevel("StageGrow")
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local modifyGrowthStrength = player:GetProperty("ModifyGrowthStrength") or 0
  local finalStageGrow = baseStageGrow * (1 + modifyGrowthStrength / 100)
  self.battleEngine:DebugS("GetAccountStageGrow: {baseStageGrow} {modifyGrowthStrength} {finalStageGrow}", baseStageGrow, modifyGrowthStrength, finalStageGrow)
  return finalStageGrow
end

function BattleCmdParser:GetAccountMethysisPower()
  do return self.GetAccountLevelArgByAccoutLevel, self end
  return self.GetAccountLevelArgByAccoutLevel, self, "AccountMethysisPower"
end

function BattleCmdParser:GetRefiningLevel()
  return 1
end

function BattleCmdParser:GetRelicCount(quality)
  do return self.battleEngine.GetRelicCount, self.battleEngine end
  return self.battleEngine.GetRelicCount, self.battleEngine, quality
end

function BattleCmdParser:GetAwakerPotencyPower()
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if not awaker:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("获取唤醒体启灵强度失败：找不到唤醒体", self.castRoleUid, self.skillConfigId, self.stateId)
    return 0
  end
  do return awaker.GetPotencyPower end
  return awaker.GetPotencyPower, awaker, "获取唤醒体启灵强度失败：找不到唤醒体", self.castRoleUid, self.skillConfigId, self.stateId
end

function BattleCmdParser:GetAwakerNormalUltiCost(awakerTid)
  local awaker
  if awakerTid then
    local caster = self.battleEngine:GetObj(self.castRoleUid)
    local camp = caster and caster:GetCamp() or bc.BattleCamp.Camp1
    awaker = self.battleEngine.roleMgr:GetAwakerByTid(awakerTid, camp)
  else
    awaker = self.battleEngine:GetObj(self.castRoleUid)
  end
  if not awaker or not awaker:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("GetAwakerNormalUltiCost: 找不到唤醒体", awakerTid or self.castRoleUid)
    return 0
  end
  do return awaker.GetUltiCost end
  return awaker.GetUltiCost, awaker, "GetAwakerNormalUltiCost: 找不到唤醒体", awakerTid or self.castRoleUid, awakerTid, camp
end

function BattleCmdParser:GetAwakerUpgradeConfigByStageLevel(stageLevel)
  if not stageLevel or stageLevel <= 0 then
    return
  end
  local battleEngine = self.battleEngine
  local cacheMap = battleEngine.awakerUpgradeCfgByStageLevel
  if not cacheMap then
    cacheMap = {}
    battleEngine.awakerUpgradeCfgByStageLevel = cacheMap
  end
  local cached = cacheMap[stageLevel]
  if nil ~= cached then
    return cached or nil
  end
  local upgradeMap = battleEngine.battleDT.AwakerUpgrade
  local upgradeCfg
  for level = stageLevel, 1, -1 do
    upgradeCfg = upgradeMap[level]
    if upgradeCfg then
      break
    end
  end
  cacheMap[stageLevel] = upgradeCfg or false
  return upgradeCfg
end

function BattleCmdParser:GetAwakerLevelArgByStageLevel(name)
  local DT = self.battleEngine.battleDT
  local stageId = self.battleEngine:GetStageId()
  local difficultyId = self.battleEngine:GetDifficultyId()
  local stageCfg = DT.Stage[stageId]
  local StageLevelKey = "StageLevel"
  local stageLevel = stageCfg and stageCfg[StageLevelKey] or 0
  if difficultyId and difficultyId > 0 then
    local difficultyCfg = DT.StageDifficulty[difficultyId]
    stageLevel = difficultyCfg and difficultyCfg[StageLevelKey] or stageLevel
  end
  local upgradeCfg = self:GetAwakerUpgradeConfigByStageLevel(stageLevel)
  if not upgradeCfg then
    return 0
  end
  return upgradeCfg[name] or 0
end

function BattleCmdParser:GetStagePower()
  do return self.GetAwakerLevelArgByStageLevel, self end
  return self.GetAwakerLevelArgByStageLevel, self, "StagePower"
end

function BattleCmdParser:GetStageAtkPower()
  do return self.GetAwakerLevelArgByStageLevel, self end
  return self.GetAwakerLevelArgByStageLevel, self, "StageAtkPower"
end

function BattleCmdParser:GetStageHpPower()
  do return self.GetAwakerLevelArgByStageLevel, self end
  return self.GetAwakerLevelArgByStageLevel, self, "StageHpPower"
end

function BattleCmdParser:GetStageDefPower()
  do return self.GetAwakerLevelArgByStageLevel, self end
  return self.GetAwakerLevelArgByStageLevel, self, "StageDefPower"
end

function BattleCmdParser:GetTeamSkillMultiplier()
  do return self.GetAwakerLevelArgByAwakerAvgLevel, self end
  return self.GetAwakerLevelArgByAwakerAvgLevel, self, "SkillMultiplier"
end

function BattleCmdParser:GetAwakerLevelArgByAwakerAvgLevel(name)
  local DT = self.battleEngine.battleDT
  local effectiveLevel = self:GetEffectiveLevel()
  local cfg = DT.AwakerUpgrade[effectiveLevel]
  if not cfg then
    return 0
  end
  return cfg[name] or 0
end

function BattleCmdParser:GetBreakLevel()
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if not awaker or not awaker:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("获取唤醒体突破等级失败：找不到唤醒体", self.castRoleUid, self.skillConfigId, self.stateId)
    return 0
  end
  local breakLevel, _ = awaker:GetBreakSkillAndPotencyLevel()
  return breakLevel
end

function BattleCmdParser:GetPotencyLevel()
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if not awaker or not awaker:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("获取唤醒体启灵等级失败：找不到唤醒体了", self.castRoleUid, self.skillConfigId, self.stateId)
    return 0
  end
  local _, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  return potencyLevel
end

function BattleCmdParser:GetCharPotencyLv(awakerTid)
  local casterCamp = self:GetCasterCamp()
  local awaker = self.battleEngine.roleMgr:GetAwakerByTid(awakerTid, casterCamp)
  if not awaker then
    return 0
  end
  local _, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  return potencyLevel
end

function BattleCmdParser:GetSkillLevel()
  return self.skillLevel
end

function BattleCmdParser:GetAwakerNumByState(stateTid)
  if not stateTid or 0 == stateTid then
    return 0
  end
  local awakerList = self:GetAwakerListInParser()
  local totalCount = 0
  for _, awaker in ipairs(awakerList) do
    if self.battleEngine.stateMgr:HasStateByStateIds(awaker.uid, {stateTid}) then
      totalCount = totalCount + 1
    end
  end
  if totalCount > 4 then
    totalCount = 4
  end
  return totalCount
end

function BattleCmdParser:GetMonsterByPos(pos)
  local monster = self.battleEngine.roleMgr:GetMonsterByPos(pos)
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, {monster}, monster
end

function BattleCmdParser:GetAwakerByPos(pos)
  local awaker = self.battleEngine.roleMgr:GetAwakerByPos(bc.BattleCamp.Camp1, pos)
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, {awaker}, awaker
end

function BattleCmdParser:GetAwakerByPosPVP(pos)
  local role = self.battleEngine.roleMgr:GetPVPRoleByPos(pos)
  local targetsExp = BattleCmdTargetsExp(self, {role})
  return targetsExp
end

function BattleCmdParser:GetAllyTargetByPos(pos, aliveTag, posTag)
  local camp = self:GetCasterCamp()
  local role = self.battleEngine.roleMgr:GetPVPRoleByPos(pos, camp, aliveTag, posTag)
  local targetsExp = BattleCmdTargetsExp(self, {role})
  return targetsExp
end

function BattleCmdParser:GetEnemyTargetByPos(pos, aliveTag, posTag)
  local camp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
  local role = self.battleEngine.roleMgr:GetPVPRoleByPos(pos, enemyCamp, aliveTag, posTag)
  local targetsExp = BattleCmdTargetsExp(self, {role})
  return targetsExp
end

function BattleCmdParser:GetAwakerByID(dollId, campTag)
  local awaker = self.battleEngine.roleMgr:GetAwakerByTid(dollId, campTag)
  local targetsExp = BattleCmdTargetsExp(self, {awaker})
  return targetsExp
end

function BattleCmdParser:GetMonsterByID(monsterID)
  local list = self.battleEngine.roleMgr:GetMonsterByID(monsterID)
  local targetsExp = BattleCmdTargetsExp(self, list)
  return targetsExp
end

function BattleCmdParser:GetByUniqueID(uid)
  local obj = self.battleEngine:GetObj(uid)
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, {obj}, obj
end

function BattleCmdParser:GetHideMonster(tid)
  local list = self.battleEngine.roleMgr:GetHideMonster(tid)
  local targetsExp = BattleCmdTargetsExp(self, list)
  return targetsExp
end

function BattleCmdParser:GetSkillType()
  if not self.skillConfigId then
    return false
  end
  local skillTypes = self.cmdServer:GetSkillType()
  return skillTypes[1] == bc.SkillType.Ulti_Skill
end

function BattleCmdParser:GetIsCard()
  if not self.skillConfigId then
    return false
  end
  local skillTypes = self.cmdServer:GetSkillType()
  return skillTypes[1] ~= bc.SkillType.Ulti_Skill
end

function BattleCmdParser:GetRelicCountByID(id)
  do return self.battleEngine.GetRelicCountByID, self.battleEngine end
  return self.battleEngine.GetRelicCountByID, self.battleEngine, id
end

function BattleCmdParser:GetOriginHistoryCard(cardTypes, endNum, beginNum, needNum, skipSameID, exceptCardTypes)
  local historyType = bc.HistoryType.Origin
  local ret = self.battleEngine.cardMgr:GetBoutHistoryCard(historyType, cardTypes, endNum, beginNum, needNum, skipSameID, exceptCardTypes)
  local targetsExp = BattleCmdCardListExp(self, ret)
  return targetsExp
end

function BattleCmdParser:GetCopyHistoryCard(cardTypes, endNum, beginNum, needNum, skipSameID, exceptCardTypes, exceptStateTids)
  local historyType = bc.HistoryType.Copy
  local ret = self.battleEngine.cardMgr:GetBoutHistoryCard(historyType, cardTypes, endNum, beginNum, needNum, skipSameID, exceptCardTypes, exceptStateTids)
  local targetsExp = BattleCmdCardListExp(self, ret)
  return targetsExp
end

function BattleCmdParser:GetCurCmdShowDamage(value, paraPlusName, casterExp, targetExp)
  if not self.cmdServer then
    return 0
  end
  local caster
  if casterExp then
    caster = casterExp:GetTargetList()[1]
    if not caster then
      return 0
    end
  end
  local target
  if targetExp then
    target = targetExp:GetTargetList()[1]
    if not target then
      return 0
    end
  end
  local showDamage = self.cmdServer:__GetShowDamage(value, paraPlusName, caster)
  if target then
    do return self.cmdServer.__GetFinalDamage, self.cmdServer, showDamage, target end
    return self.cmdServer.__GetFinalDamage, self.cmdServer, showDamage, target, false
  end
  return showDamage
end

function BattleCmdParser:GetCurCmdShowBlock(value, paraPlusName, casterExp, targetExp)
  if not self.cmdServer then
    return 0
  end
  local caster
  if casterExp then
    caster = casterExp:GetTargetList()[1]
    if not caster then
      return 0
    end
  end
  local target
  if targetExp then
    target = targetExp:GetTargetList()[1]
    if not target then
      return 0
    end
  end
  local showBlock = self.cmdServer:__GetShowBlock(value, paraPlusName, caster)
  if target then
    do return self.cmdServer.__GetFinalBlock, self.cmdServer, showBlock end
    return self.cmdServer.__GetFinalBlock, self.cmdServer, showBlock, target
  end
  return showBlock
end

function BattleCmdParser:GetCurCmdShowHeal(value, paraPlusName, casterExp, targetExp)
  if not self.cmdServer then
    return 0
  end
  local caster
  if casterExp then
    caster = casterExp:GetTargetList()[1]
    if not caster then
      return 0
    end
  end
  local target
  if targetExp then
    target = targetExp:GetTargetList()[1]
    if not target then
      return 0
    end
  end
  local showHeal = self.cmdServer:__GetShowHeal(value, paraPlusName, caster)
  if target then
    do return self.cmdServer.__GetFinalHeal, self.cmdServer, showHeal end
    return self.cmdServer.__GetFinalHeal, self.cmdServer, showHeal, target
  end
  return showHeal
end

function BattleCmdParser:GetCurCmdShowUltiEnergy(value, paraPlusName, casterExp, targetExp)
  if not self.cmdServer then
    return 0
  end
  local caster
  if casterExp then
    caster = casterExp:GetTargetList()[1]
    if not caster then
      return 0
    end
  end
  local target
  if targetExp then
    target = targetExp:GetTargetList()[1]
    if not target then
      return 0
    end
  end
  local showEnergy = self.cmdServer:__GetShowUltiEnergy(value, paraPlusName, caster)
  if target then
    do return self.cmdServer.__GetFinalUltiEnergy, self.cmdServer, showEnergy end
    return self.cmdServer.__GetFinalUltiEnergy, self.cmdServer, showEnergy, target
  end
  return showEnergy
end

function BattleCmdParser:GetCurCmdShowBlood(value)
  if not self.cmdServer then
    return 0
  end
  do return self.cmdServer.GetShowScarletBlood, self.cmdServer end
  return self.cmdServer.GetShowScarletBlood, self.cmdServer, value
end

function BattleCmdParser:GetCasterCamp()
  local castRole = self.battleEngine:GetObj(self.castRoleUid)
  return castRole.camp
end

function BattleCmdParser:PVPLastUseCard(cardType, boutNum, num, crossBout, skipNum, ignoreDead)
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  ignoreDead = ignoreDead or 1
  do return self.LastUseCard, self, camp, cardType, boutNum, num, crossBout, skipNum end
  return self.LastUseCard, self, camp, cardType, boutNum, num, crossBout, skipNum, ignoreDead
end

function BattleCmdParser:PVPEnemyLastUseCard(cardType, boutNum, num, crossBout, skipNum, ignoreDead)
  local camp = bc.BattleCamp:GetEnemyCamp(self.battleEngine.boutMgr:GetCurCamp())
  ignoreDead = ignoreDead or 1
  do return self.LastUseCard, self, camp, cardType, boutNum, num, crossBout, skipNum end
  return self.LastUseCard, self, camp, cardType, boutNum, num, crossBout, skipNum, ignoreDead
end

function BattleCmdParser:LastUseCard(camp, cardType, boutNum, num, crossBout, skipNum, ignoreDead)
  local newCardList = {}
  local battleEngine = self.battleEngine
  local ret = {}
  local needNum = (num or 1) + (skipNum or 0)
  local curBout = battleEngine.boutMgr:GetBoutNum() - (boutNum or 0)
  local boutFlag = curBout >= 1
  while boutFlag and needNum > #ret do
    local key = battleEngine.statsMgr:GetUseCardOrderKey(curBout, camp)
    local cardOrder = battleEngine.statsMgr:GetStats("BattleStats", key)
    if cardOrder and type(cardOrder) == "table" and next(cardOrder) then
      for i = #cardOrder, 1, -1 do
        local cardUid = cardOrder[i]
        local card = self.battleEngine:GetObj(cardUid)
        if not card then
        elseif not card:CardTypeMatch(cardType) then
        elseif 1 == ignoreDead and card.owner and card.owner:IsRoleType(bc.RoleType.Awaker) and card.owner:IsDead() then
        else
          table.insert(ret, {
            tid = card.data.tid,
            owner = card.owner
          })
          if needNum <= #ret then
            break
          end
        end
      end
    end
    curBout = curBout - 1
    boutFlag = crossBout
  end
  if skipNum then
    local result = {}
    for i = skipNum + 1, #ret do
      table.insert(result, ret[i])
    end
    ret = result
  end
  for _, info in ipairs(ret) do
    local cfgId = info.tid
    local owner = info.owner
    local card = self.battleEngine.cardMgr:CreateTempCard(tonumber(cfgId), 1, camp, owner)
    table.insert(newCardList, card)
  end
  local exp = BattleCmdCardListExp(self, newCardList)
  return exp
end

function BattleCmdParser:SelectAwaker(aliveTag)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag)
  local targetUids = {}
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local lockedRole = self:__GetLockedEnemyByCaster()
  local tauntRole, sneakRole
  if not lockedRole then
    tauntRole = self.battleEngine.roleMgr:GetTauntRole(enemyCamp)
    sneakRole = self.battleEngine.roleMgr:GetSneakRole(enemyCamp)
  end
  for _, role in ipairs(roleList) do
    if lockedRole and role:GetCamp() == enemyCamp and role.uid ~= lockedRole.uid then
    elseif tauntRole and role.uid ~= tauntRole.uid and role.camp == enemyCamp then
    elseif sneakRole and role.uid == sneakRole.uid and role.camp == enemyCamp then
    else
      table.insert(targetUids, role.uid)
    end
  end
  local targetType = DT.BattleApi.SelectAwaker.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, nil, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectMaxHpEnemy(blockTag)
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(bc.PVPTargetTag.AliveOnly, enemyCamp)
  local targetUids = {}
  if #roleList > 0 then
    table.sort(roleList, function(a, b)
      local aValue = a.property:GetProperty(BP.hp)
      local bValue = b.property:GetProperty(BP.hp)
      if blockTag then
        aValue = aValue + a.property:GetProperty(BP.block)
        bValue = bValue + b.property:GetProperty(BP.block)
      end
      if aValue == bValue then
        return a.uid < b.uid
      end
      return aValue > bValue
    end)
    targetUids = {
      roleList[1].uid
    }
  end
  local targetType = DT.BattleApi.SelectMaxHpEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids
end

function BattleCmdParser:SelectMinHpEnemy(blockTag)
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(bc.PVPTargetTag.AliveOnly, enemyCamp)
  local targetUids = {}
  if #roleList > 0 then
    table.sort(roleList, function(a, b)
      local aValue = a.property:GetProperty(BP.hp)
      local bValue = b.property:GetProperty(BP.hp)
      if blockTag then
        aValue = aValue + a.property:GetProperty(BP.block)
        bValue = bValue + b.property:GetProperty(BP.block)
      end
      return aValue < bValue
    end)
    targetUids = {
      roleList[1].uid
    }
  end
  local targetType = DT.BattleApi.SelectMinHpEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids
end

function BattleCmdParser:SelectAlly(aliveTag)
  local casterCamp = self:GetCasterCamp()
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, casterCamp)
  local targetUids = {}
  for _, role in ipairs(roleList) do
    table.insert(targetUids, role.uid)
  end
  local targetType = DT.BattleApi.SelectAlly.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, nil, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectEnemy(aliveTag)
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local lockedRole = self:__GetLockedEnemyByCaster()
  
  local function filter(role)
    return 0 ~= role:GetProperty(BP.sneak)
  end
  
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, enemyCamp, filter)
  local tauntRole = self.battleEngine.roleMgr:GetTauntRole(enemyCamp)
  local targetUids = {}
  if lockedRole then
    targetUids = {
      lockedRole.uid
    }
  elseif tauntRole then
    targetUids = {
      tauntRole.uid
    }
  else
    for _, role in ipairs(roleList) do
      table.insert(targetUids, role.uid)
    end
  end
  local targetType = DT.BattleApi.SelectEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, nil, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectCmdCaster()
  local DT = self.battleEngine.battleDT
  local targetType = DT.BattleApi.SelectCmdCaster.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, {
    self.castRoleUid
  }, self.castRoleUid
end

function BattleCmdParser:SelectFrontEnemy()
  local aliveTag = bc.PVPTargetTag.AliveOnly
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local lockedRole = self:__GetLockedEnemyByCaster()
  
  local function filter(role)
    return 0 ~= role:GetProperty(BP.sneak)
  end
  
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, enemyCamp, filter)
  local targetUids = {}
  local tauntRole = self.battleEngine.roleMgr:GetTauntRole(enemyCamp)
  if lockedRole then
    targetUids = {
      lockedRole.uid
    }
  elseif tauntRole then
    targetUids = {
      tauntRole.uid
    }
  elseif #roleList > 0 then
    targetUids = {
      roleList[1].uid
    }
  end
  local targetType = DT.BattleApi.SelectFrontEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids
end

function BattleCmdParser:SelectRandomEnemy()
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(bc.PVPTargetTag.AliveOnly, enemyCamp)
  local targetUids = {}
  if #roleList > 0 then
    local rand = self.battleEngine.rand:random(1, #roleList)
    targetUids = {
      roleList[rand].uid
    }
  end
  local targetType = DT.BattleApi.SelectRandomEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType, targetUids end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, true
end

function BattleCmdParser:SelectRandomAlly()
  local casterCamp = self:GetCasterCamp()
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(bc.PVPTargetTag.AliveOnly, casterCamp)
  local targetUids = {}
  if #roleList > 0 then
    local rand = self.battleEngine.rand:random(1, #roleList)
    targetUids = {
      roleList[rand].uid
    }
  end
  local targetType = DT.BattleApi.SelectRandomAlly.ID
  do return self.__SelectPVPAwakerTargets, self, targetType, targetUids end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, true
end

function BattleCmdParser:SelectAllAlly(aliveTag)
  local casterCamp = self:GetCasterCamp()
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, casterCamp)
  local targetUids = {}
  for _, role in ipairs(roleList) do
    table.insert(targetUids, role.uid)
  end
  local targetType = DT.BattleApi.SelectAllAlly.ID
  do return self.__SelectPVPAwakerTargets, self, targetType, targetUids end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, true, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectAllEnemy(aliveTag)
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, enemyCamp)
  local targetUids = {}
  for _, role in ipairs(roleList) do
    table.insert(targetUids, role.uid)
  end
  local targetType = DT.BattleApi.SelectAllEnemy.ID
  do return self.__SelectPVPAwakerTargets, self, targetType, targetUids end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, true, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectAllOtherAwaker(aliveTag)
  local DT = self.battleEngine.battleDT
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, nil)
  local lockedRole = self:__GetLockedEnemyByCaster()
  local casterCamp = self:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  local tauntRole
  if not lockedRole then
    tauntRole = self.battleEngine.roleMgr:GetTauntRole(enemyCamp)
  end
  local targetUids = {}
  for _, role in ipairs(roleList) do
    if role.uid == self.castRoleUid then
    elseif lockedRole and role:GetCamp() == enemyCamp and role.uid ~= lockedRole.uid then
    elseif tauntRole and role:GetCamp() == enemyCamp and role.uid ~= tauntRole.uid then
    else
      table.insert(targetUids, role.uid)
    end
  end
  local targetType = DT.BattleApi.SelectAllOtherAwaker.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, nil, table.insert, targetUids, role.uid
end

function BattleCmdParser:SelectTarget(candidateTargets, ignoreAttrList)
  if not self.battleEngine:IsPVP() then
    self.battleEngine.logger:ErrorS("SelectTarget only support PVP {skillConfigId}", self.cmdServer and self.cmdServer.skillConfigId or "nil")
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, self.cmdServer and self.cmdServer.skillConfigId or "nil", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local candidateList = self:_SetOpsNormalizeList(candidateTargets)
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(self:GetCasterCamp())
  local roleMgr = self.battleEngine.roleMgr
  local DT = self.battleEngine.battleDT
  local lockedRole = self:__GetLockedEnemyByCaster()
  local tauntRole, sneakRole
  if not lockedRole then
    if not table.contains(ignoreAttrList, "taunt") then
      tauntRole = roleMgr:GetTauntRole(enemyCamp)
    end
    if not table.contains(ignoreAttrList, "sneak") then
      sneakRole = roleMgr:GetSneakRole(enemyCamp)
    end
  end
  local targetUids = {}
  local uidSet = {}
  for _, role in ipairs(candidateList) do
    if not (role and role.uid) or uidSet[role.uid] then
    elseif role.camp == enemyCamp then
      if lockedRole and role.uid ~= lockedRole.uid then
      elseif tauntRole and role.uid ~= tauntRole.uid then
      elseif sneakRole and role.uid == sneakRole.uid then
      else
        uidSet[role.uid] = true
        table.insert(targetUids, role.uid)
      end
    end
  end
  if 0 == #targetUids then
    self.battleEngine.logger:ErrorS("SelectTarget empty targetUids {skillConfigId} {ignoreAttrList}", self.cmdServer and self.cmdServer.skillConfigId or "nil", table.tostring(ignoreAttrList))
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, self.cmdServer and self.cmdServer.skillConfigId or "nil", table.tostring(ignoreAttrList)
  end
  local targetType = DT.BattleApi.SelectTarget.ID
  do return self.__SelectPVPAwakerTargets, self, targetType end
  return self.__SelectPVPAwakerTargets, self, targetType, targetUids, table.tostring(ignoreAttrList)
end

function BattleCmdParser:__SelectPVPAwakerTargets(targetType, targetUids, replaceClientTarget)
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  if self.battleEngine:GetTimeoutFlag() then
    local idx = self.battleEngine.rand:random(#targetUids)
    local selectAwaker = self.battleEngine:GetObj(targetUids[idx])
    local targets = {selectAwaker}
    return targets
  end
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect and runningEffect.uid,
    targetUids = targetUids,
    targetSelectType = bc.TargetSelectType.Awaker,
    targetType = targetType,
    camp = self:GetCasterCamp(),
    cancelable = runningEffect and runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
  if self.battleEngine:GetTargetFlag() then
    data.replaceClientTarget = replaceClientTarget
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:PVPAllAwaker(aliveTag)
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag)
  return roleList
end

function BattleCmdParser:PVPGenCardListByType(cardType, num)
  local casterCamp = self:GetCasterCamp()
  local ret = {}
  local needNum = num or 1
  local newCardList = {}
  local DT = self.battleEngine.battleDT
  local now = BattleUtilServer.GetCurTime(self.battleEngine)
  if DT.PVPSkillProcessed and DT.PVPSkillProcessed.type2Cfgs and DT.PVPSkillProcessed.type2Cfgs[cardType] then
    local cfgIds = table.clone(DT.PVPSkillProcessed.type2Cfgs[cardType])
    for i = #cfgIds, 1, -1 do
      if not BattleUtilServer.IsPVPSkillOpen(self.battleEngine, cfgIds[i], now) then
        table.remove(cfgIds, i)
      end
    end
    local retIds
    if needNum >= #cfgIds then
      retIds = cfgIds
    else
      local indexs = BattleUtilServer.GetRandomNNum(self.battleEngine, #cfgIds, needNum)
      retIds = {}
      for _, index in ipairs(indexs) do
        table.insert(retIds, cfgIds[index])
      end
    end
    for _, cfgId in ipairs(retIds) do
      local card = self.battleEngine.cardMgr:CreateTempCard(cfgId, 1, casterCamp)
      table.insert(ret, card)
      table.insert(newCardList, card:Serialize())
    end
    self.battleEngine.recordMgr:OnAddNewCard(newCardList, bc.CardDeck.NoneDeck, true, casterCamp)
    local exp = BattleCmdCardListExp(self, ret)
    return exp
  end
end

function BattleCmdParser:PVPGenCardListBySlot(num, slotList, exclusive)
  local casterCamp = self:GetCasterCamp()
  local ret = {}
  local needNum = num or 1
  local newCardList = {}
  local DT = self.battleEngine.battleDT
  local now = BattleUtilServer.GetCurTime(self.battleEngine)
  if type(slotList) ~= "table" then
    slotList = {slotList}
  end
  if not DT.PVPSkillProcessed or not DT.PVPSkillProcessed.slot2Cfgs then
    self.battleEngine.logger:ErrorS("PVPGenCardListBySlot: not find PVPSkillProcessed.slot2Cfgs")
    return
  end
  local slot2Cfgs = DT.PVPSkillProcessed.slot2Cfgs
  local cfgIds = {}
  local skillIdSet = {}
  for _, slot in ipairs(slotList) do
    local slotSkillIds = slot2Cfgs[slot]
    if slotSkillIds then
      for _, skillId in ipairs(slotSkillIds) do
        local skillCfg = DT.Skill[skillId]
        if skillCfg and not skillIdSet[skillId] and BattleUtilServer.IsAwakerOpen(DT, skillCfg.AwakerID, now) then
          table.insert(cfgIds, skillId)
          skillIdSet[skillId] = true
        end
      end
    end
  end
  if not next(cfgIds) then
    self.battleEngine.logger:ErrorS("PVPGenCardListBySlot: not find skillId")
    return
  end
  exclusive = self:GetValueByCmd(exclusive)
  local retIds = {}
  if 1 == exclusive then
    for _ = 1, needNum do
      local randomIndex = self.battleEngine.rand:random(1, #cfgIds)
      table.insert(retIds, cfgIds[randomIndex])
    end
  elseif needNum >= #cfgIds then
    retIds = cfgIds
  else
    local randomIndexList = BattleUtilServer.GetRandomNNum(self.battleEngine, #cfgIds, needNum)
    for _, randomIndex in ipairs(randomIndexList) do
      table.insert(retIds, cfgIds[randomIndex])
    end
  end
  for _, cfgId in ipairs(retIds) do
    local card = self.battleEngine.cardMgr:CreateTempCard(cfgId, 1, casterCamp)
    table.insert(ret, card)
    table.insert(newCardList, card:Serialize())
  end
  self.battleEngine.recordMgr:OnAddNewCard(newCardList, bc.CardDeck.NoneDeck, true, casterCamp)
  do return BattleCmdCardListExp, self end
  return BattleCmdCardListExp, self, ret, bc.CardDeck.NoneDeck, true, casterCamp, self.battleEngine.cardMgr:CreateTempCard(cfgId, 1, casterCamp), table.insert, newCardList, card:Serialize()
end

function BattleCmdParser:GetAwakerListInParser()
  local battleEngine = self.battleEngine
  local list = {}
  if battleEngine:IsPVP() then
    local casterCamp = self:GetCasterCamp()
    local player = battleEngine.roleMgr:GetPlayer(casterCamp)
    list = player:GetAwakerList()
  end
  if battleEngine:IsPVE() then
    local player = battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    list = player:GetAwakerList()
  end
  return list
end

function BattleCmdParser:GetResonanceLevel(tid)
  local list = self.battleEngine:GetData("talentList") or {}
  for _, v in pairs(list) do
    if v.tid == tid then
      return v.lv or 0
    end
  end
  return 0
end

function BattleCmdParser:Random(min, max)
  if not max then
    do return self.battleEngine.rand.random, self.battleEngine.rand end
    return self.battleEngine.rand.random, self.battleEngine.rand, min, nil
  else
    do return self.battleEngine.rand.random, self.battleEngine.rand, min end
    return self.battleEngine.rand.random, self.battleEngine.rand, min, max
  end
end

function BattleCmdParser:SetOps(list1, list2, opType)
  local a, originTypeA = self:_SetOpsNormalizeList(list1)
  local b, originTypeB = self:_SetOpsNormalizeList(list2)
  opType = tonumber(opType) or bc.SetOpsType.Union
  local result = {}
  local inA, inB = {}, {}
  for _, v in ipairs(a) do
    local k = self:_SetOpsGetKey(v)
    if nil ~= k and not inA[k] then
      inA[k] = v
    end
  end
  for _, v in ipairs(b) do
    local k = self:_SetOpsGetKey(v)
    if nil ~= k and not inB[k] then
      inB[k] = v
    end
  end
  if opType == bc.SetOpsType.Union then
    local exist = {}
    for _, v in ipairs(a) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
    for _, v in ipairs(b) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
  elseif opType == bc.SetOpsType.Intersection then
    local added = {}
    for _, v in ipairs(a) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and inB[k] and not added[k] then
        table.insert(result, v)
        added[k] = true
      end
    end
  elseif opType == bc.SetOpsType.Difference then
    for _, v in ipairs(a) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not inB[k] then
        table.insert(result, v)
      end
    end
  elseif opType == bc.SetOpsType.SymmetricDifference then
    local exist = {}
    for _, v in ipairs(a) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not inB[k] and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
    for _, v in ipairs(b) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not inA[k] and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
  else
    local exist = {}
    for _, v in ipairs(a) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
    for _, v in ipairs(b) do
      local k = self:_SetOpsGetKey(v)
      if nil ~= k and not exist[k] then
        table.insert(result, v)
        exist[k] = true
      end
    end
  end
  local finalResult = result
  if originTypeA and originTypeA == originTypeB then
    if "targets_exp" == originTypeA then
      finalResult = BattleCmdTargetsExp(self, result)
    elseif "card_list_exp" == originTypeA then
      finalResult = BattleCmdCardListExp(self, result)
    end
  end
  return finalResult
end

function BattleCmdParser:_SetOpsNormalizeList(src)
  local originType
  if not src then
    return {}, originType
  end
  if System.IsClass(src) then
    if src.is and src:is(BattleCmdTargetsExp) then
      originType = "targets_exp"
      return src.targets or {}, originType
    elseif src.is and src:is(BattleCmdCardListExp) then
      originType = "card_list_exp"
      if src.GetCardList then
        return src:GetCardList(), originType
      elseif src.cardList then
        return src.cardList, originType
      end
    elseif src.targets then
      return src.targets, originType
    elseif src.GetAll then
      return src:GetAll(), originType
    elseif src.GetCardList then
      return src:GetCardList(), originType
    elseif src.cardList then
      return src.cardList, originType
    end
  end
  if type(src) ~= "table" then
    return {}, originType
  end
  return src, originType
end

function BattleCmdParser:_SetOpsGetKey(obj)
  if not obj or type(obj) ~= "table" then
    return obj
  end
  return obj.uid or obj.tid or obj
end

function BattleCmdParser:GetCurDeathResistCoff()
  if self.battleEngine:IsPVE() then
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    do return player.GetDeathResitCoff end
    return player.GetDeathResitCoff, player
  end
  return 0
end

function BattleCmdParser:GetCardByAwakerListAndSlot(targetsExp, slots, levelType)
  levelType = levelType or bc.GetCardByIDType.CastSkillLevel
  if type(slots) ~= "table" then
    slots = {slots}
  end
  local list = {}
  local targets = {}
  if not targetsExp.targets then
    for _, exp in ipairs(targetsExp) do
      for _, target in ipairs(exp.targets) do
        table.insert(targets, target)
      end
    end
  else
    targets = targetsExp.targets
  end
  local camp = self:GetCasterCamp()
  for _, awaker in ipairs(targets) do
    if not awaker.GetSlotCards then
      self.battleEngine:Error("获取槽位卡牌失败：目标不是唤醒体")
    else
      local targetSlotCards = awaker:GetSlotCards()
      if not targetSlotCards then
        self.battleEngine:Error("获取槽位卡牌失败：找不到槽位卡牌")
      else
        local level = 1
        if type(levelType) == "number" then
          level = levelType
        end
        if levelType == bc.GetCardByIDType.CastSkillLevel then
          level = self.cmdParser:GetSkillLevel()
        end
        for _, slot in ipairs(slots) do
          local slotCard = targetSlotCards[slot]
          if slotCard then
            if levelType == bc.GetCardByIDType.SlotCardLevel then
              level = slotCard.level
            end
            local card = self.battleEngine.cardMgr:CreateCardByID(slotCard.tid, level, bc.CardDeck.NoneDeck, camp)
            table.insert(list, card)
          end
        end
      end
    end
  end
  local newCardList = {}
  for _, card in ipairs(list) do
    table.insert(newCardList, card:Serialize())
  end
  self.battleEngine.recordMgr:OnAddNewCard(newCardList, bc.CardDeck.NoneDeck, true, camp)
  local exp = BattleCmdCardListExp(self, list)
  return exp
end

function BattleCmdParser:GetGlobalVariable(argKey)
  do return self.battleEngine.GetGlobalVariable, self.battleEngine end
  return self.battleEngine.GetGlobalVariable, self.battleEngine, argKey
end

function BattleCmdParser:GetAwakerByProperty(propertyName, campTag, orderTag, hasStateList, method, aliveTag)
  if not hasStateList or type(hasStateList) ~= "table" then
    hasStateList = {hasStateList}
  end
  if type(propertyName) ~= "table" then
    propertyName = {propertyName}
  end
  aliveTag = aliveTag or bc.PVPTargetTag.AliveOnly
  local casterCamp = self:GetCasterCamp()
  local needCamp = casterCamp
  if campTag == bc.PVPTargetTag.AllyAwaker then
    needCamp = casterCamp
  elseif campTag == bc.PVPTargetTag.EnemyAwaker then
    needCamp = bc.BattleCamp:GetEnemyCamp(casterCamp)
  end
  local roleList = self.battleEngine.roleMgr:GetRoleList()
  local awakerList = {}
  for _, role in ipairs(roleList) do
    if not role:IsRoleType(bc.RoleType.Awaker) then
    elseif role:GetCamp() ~= needCamp then
    elseif not self.battleEngine.roleMgr:Judgement_Alive(role, aliveTag) then
    else
      table.insert(awakerList, role)
    end
  end
  local sortFunc
  if "MaxProperty" == orderTag then
    function sortFunc(a, b)
      local aTotalPro, bTotalPro
      
      local aPos = a:GetBattleFieldPos()
      local bPos = b:GetBattleFieldPos()
      for _, p in ipairs(propertyName) do
        local aPro = a:GetProperty(p) or 0
        local bPro = b:GetProperty(p) or 0
        if "Subtraction" == method then
          aTotalPro = aTotalPro and aTotalPro - aPro or aPro
          bTotalPro = bTotalPro and bTotalPro - bPro or bPro
        else
          aTotalPro = aTotalPro and aTotalPro + aPro or aPro
          bTotalPro = bTotalPro and bTotalPro + bPro or bPro
        end
      end
      if aTotalPro == bTotalPro then
        return aPos < bPos
      else
        return aTotalPro > bTotalPro
      end
    end
  elseif "MinProperty" == orderTag then
    function sortFunc(a, b)
      local aTotalPro, bTotalPro
      
      local aPos = a:GetBattleFieldPos()
      local bPos = b:GetBattleFieldPos()
      for _, p in ipairs(propertyName) do
        local aPro = a:GetProperty(p) or 0
        local bPro = b:GetProperty(p) or 0
        if "Subtraction" == method then
          aTotalPro = aTotalPro and aTotalPro - aPro or aPro
          bTotalPro = bTotalPro and bTotalPro - bPro or bPro
        else
          aTotalPro = aTotalPro and aTotalPro + aPro or aPro
          bTotalPro = bTotalPro and bTotalPro + bPro or bPro
        end
      end
      if aTotalPro == bTotalPro then
        return aPos < bPos
      else
        return aTotalPro < bTotalPro
      end
    end
  end
  if sortFunc then
    table.sort(awakerList, sortFunc)
  end
  if next(hasStateList) ~= nil then
    for _, awaker in ipairs(awakerList) do
      if self.battleEngine.stateMgr:HasStateByStateIds(awaker.uid, hasStateList) then
        local exp = BattleCmdCardListExp(self, {awaker})
        return exp
      end
    end
  end
  local exp = BattleCmdCardListExp(self, {
    awakerList[1]
  })
  return exp
end

function BattleCmdParser:GetAwakerList(campTag, aliveTag)
  local camp = self:GetCasterCamp()
  if campTag == bc.PVPTargetTag.EnemyAwaker then
    camp = bc.BattleCamp:GetEnemyCamp(camp)
  end
  local awakerList = self.battleEngine.roleMgr:GetPVPRoleList(aliveTag, camp) or {}
  local exp = BattleCmdTargetsExp(self, awakerList)
  return exp
end

function BattleCmdParser:GetCardListMultiExp(targetsExpList, num)
  local cardList = {}
  local cardDict = {}
  for _, targetsExp in ipairs(targetsExpList) do
    for _, card in ipairs(targetsExp:GetCardList()) do
      local uid = card:GetUid()
      if not cardDict[uid] then
        table.insert(cardList, card)
        cardDict[uid] = true
      end
    end
  end
  cardList = BattleCmdCardListExp._GetCardByPos(self.battleEngine, cardList, "RANDOM", num)
  do return BattleCmdCardListExp, self end
  return BattleCmdCardListExp, self, cardList, "RANDOM", num, nil, ipairs(targetsExp:GetCardList())
end

function BattleCmdParser:IsSuperUtlSkill()
  if not self:HasMemberValue("SuperUtliSkill") then
    return 0
  end
  return 1 == tonumber(self:GetMemberValue("SuperUtliSkill")) and 1 or 0
end

function BattleCmdParser:thisSkillIgnoreCost()
  return self:HasMemberValue("SkillIgnoreCost") and 1 or 0
end

function BattleCmdParser:GetShowPoison(value)
  local curValue = self.cmdServer:__GetShowPoison(value)
  return curValue
end

function BattleCmdParser:GetShowCounterattack(value)
  local curValue = self.cmdServer:__GetShowPoison(value)
  return curValue
end

function BattleCmdParser:RandomSelectCardDropPackIndexes(packCount, selectMinNum, selectMaxNum)
  if packCount <= 0 then
    return {}
  end
  selectMinNum = selectMinNum or 0
  selectMaxNum = selectMaxNum or selectMinNum
  if packCount < selectMaxNum then
    selectMaxNum = packCount
  end
  if selectMinNum > selectMaxNum then
    selectMinNum = selectMaxNum
  end
  local selectNum = self.battleEngine.rand:random(selectMinNum, selectMaxNum)
  local indexList = {}
  for packIndex = 1, packCount do
    table.insert(indexList, packIndex)
  end
  BattleUtilServer.Shuffle(self.battleEngine, indexList)
  local packIndexList = {}
  for pickIndex = 1, selectNum do
    table.insert(packIndexList, indexList[pickIndex])
  end
  return packIndexList
end

function BattleCmdParser:ExpandCardDropPackIndexList(packListData, packIndexList)
  local indexToPack = {}
  for _, packData in ipairs(packListData or {}) do
    indexToPack[packData.index] = packData
  end
  local selectedIndexSet = {}
  local cardList = {}
  local cardUidSet = {}
  for _, packIndex in ipairs(packIndexList or {}) do
    if selectedIndexSet[packIndex] then
      self.battleEngine:ErrorS("GetCardBySelectDrop duplicate packIndex {packIndex}", packIndex)
      return nil
    end
    selectedIndexSet[packIndex] = true
    local packData = indexToPack[packIndex]
    if not packData then
      self.battleEngine:ErrorS("GetCardBySelectDrop invalid packIndex {packIndex}", packIndex)
      return nil
    end
    for _, cardUid in ipairs(packData.cardUids or {}) do
      if not cardUidSet[cardUid] then
        cardUidSet[cardUid] = true
        local card = self.battleEngine:GetObj(cardUid)
        if card then
          table.insert(cardList, card)
        end
      end
    end
  end
  return cardList
end

function BattleCmdParser:ExpandKeeperSkillDropPackIndexList(packListData, packIndexList)
  local indexToPack = {}
  for _, packData in ipairs(packListData or {}) do
    indexToPack[packData.index] = packData
  end
  local selectedIndexSet = {}
  local keeperSkillList = {}
  local keeperSkillUidSet = {}
  for _, packIndex in ipairs(packIndexList or {}) do
    if selectedIndexSet[packIndex] then
      self.battleEngine:ErrorS("GetKeeperSkillBySelectDrop duplicate packIndex {packIndex}", packIndex)
      return nil
    end
    selectedIndexSet[packIndex] = true
    local packData = indexToPack[packIndex]
    if not packData then
      self.battleEngine:ErrorS("GetKeeperSkillBySelectDrop invalid packIndex {packIndex}", packIndex)
      return nil
    end
    for _, keeperSkillUid in ipairs(packData.keeperSkillUids or {}) do
      if not keeperSkillUidSet[keeperSkillUid] then
        keeperSkillUidSet[keeperSkillUid] = true
        local keeperSkill = self.battleEngine:GetObj(keeperSkillUid)
        if keeperSkill then
          table.insert(keeperSkillList, keeperSkill)
        end
      end
    end
  end
  return keeperSkillList
end

function BattleCmdParser:ValidateCardDropPackIndexList(yieldData, packIndexList)
  packIndexList = packIndexList or {}
  local selectCount = #packIndexList
  local selectMinNum = yieldData.selectMinNum or 0
  local selectMaxNum = yieldData.selectMaxNum or selectMinNum
  if selectCount < selectMinNum or selectCount > selectMaxNum then
    self.battleEngine:ErrorS("GetCardBySelectDrop select count invalid {selectCount} {selectMinNum} {selectMaxNum}", selectCount, selectMinNum, selectMaxNum)
    return false
  end
  local cardList = self:ExpandCardDropPackIndexList(yieldData.packList, packIndexList)
  if not cardList then
    return false
  end
  return true
end

function BattleCmdParser:ValidateKeeperSkillDropPackIndexList(yieldData, packIndexList)
  packIndexList = packIndexList or {}
  local selectCount = #packIndexList
  local selectMinNum = yieldData.selectMinNum or 0
  local selectMaxNum = yieldData.selectMaxNum or selectMinNum
  if selectCount < selectMinNum or selectCount > selectMaxNum then
    self.battleEngine:ErrorS("GetKeeperSkillBySelectDrop select count invalid {selectCount} {selectMinNum} {selectMaxNum}", selectCount, selectMinNum, selectMaxNum)
    return false
  end
  local keeperSkillList = self:ExpandKeeperSkillDropPackIndexList(yieldData.packList, packIndexList)
  if not keeperSkillList then
    return false
  end
  return true
end

function BattleCmdParser:GetCardBySelectDrop(packCount, selectMaxNum, isMustNum, title, packList, showCardList)
  if not packList or type(packList) ~= "table" then
    do return BattleCmdCardListExp, self end
    return BattleCmdCardListExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  packCount = tonumber(packCount) or #packList
  selectMaxNum = tonumber(selectMaxNum) or 1
  local selectMinNum = 1 == isMustNum and 1 or 0
  selectMaxNum = math.max(selectMinNum, selectMaxNum)
  local effectivePackCount = math.min(packCount, #packList)
  if effectivePackCount <= 0 then
    do return BattleCmdCardListExp, self end
    return BattleCmdCardListExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local defaultShowCardId = self.battleEngine.battleDT:GetConstant("SelectDropDefaultShowCard", 144442)
  local packListData = {}
  for packIndex = 1, effectivePackCount do
    local cardList, _ = self:_SetOpsNormalizeList(packList[packIndex])
    local cardUids = {}
    for _, card in ipairs(cardList or {}) do
      if card and card.uid then
        table.insert(cardUids, card.uid)
      end
    end
    table.insert(packListData, {
      index = packIndex,
      cardUids = cardUids,
      showCardId = showCardList and showCardList[packIndex] or defaultShowCardId
    })
  end
  if self.battleEngine:GetTimeoutFlag() then
    local packIndexList = self:RandomSelectCardDropPackIndexes(effectivePackCount, selectMinNum, selectMaxNum)
    local cardList = self:ExpandCardDropPackIndexList(packListData, packIndexList) or {}
    do return BattleCmdCardListExp, self end
    return BattleCmdCardListExp, self, cardList, self:_SetOpsNormalizeList(packList[packIndex])
  end
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    targetSelectType = bc.TargetSelectType.CardDrop,
    packList = packListData,
    selectMaxNum = selectMaxNum,
    selectMinNum = selectMinNum,
    title = title or "",
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:GetKeeperSkillBySelectDrop(packCount, selectMaxNum, isMustNum, title, packList, showCardList)
  if not packList or type(packList) ~= "table" then
    self.randUnlockOfferedTidMap = {}
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  packCount = tonumber(packCount) or #packList
  selectMaxNum = tonumber(selectMaxNum) or 1
  local selectMinNum = 1 == isMustNum and 1 or 0
  selectMaxNum = math.max(selectMinNum, selectMaxNum)
  local effectivePackCount = math.min(packCount, #packList)
  if effectivePackCount <= 0 then
    self.randUnlockOfferedTidMap = {}
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  self:__SpreadKeeperSkillsAcrossPacks(packList, effectivePackCount)
  local defaultShowCardId = self.battleEngine.battleDT:GetConstant("SelectDropDefaultShowCard", 144442)
  local packListData = {}
  for packIndex = 1, effectivePackCount do
    local packItemList, _ = self:_SetOpsNormalizeList(packList[packIndex])
    local showCardId = showCardList and showCardList[packIndex] or defaultShowCardId
    local keeperSkillUids = {}
    local keeperSkillInfos = {}
    for _, packItem in ipairs(packItemList or {}) do
      if packItem and packItem.uid then
        table.insert(keeperSkillUids, packItem.uid)
      end
      if packItem and packItem.GetClientInfo then
        table.insert(keeperSkillInfos, packItem:GetClientInfo())
      end
    end
    table.insert(packListData, {
      index = packIndex,
      keeperSkillUids = keeperSkillUids,
      keeperSkillInfos = keeperSkillInfos,
      showCardId = showCardId
    })
  end
  self.randUnlockOfferedTidMap = {}
  if self.battleEngine:GetTimeoutFlag() then
    local packIndexList = self:RandomSelectCardDropPackIndexes(effectivePackCount, selectMinNum, selectMaxNum)
    local keeperSkillList = self:ExpandKeeperSkillDropPackIndexList(packListData, packIndexList) or {}
    self:OnSelectRandUnlockKeeperSkillDropPack(keeperSkillList)
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, keeperSkillList, self:_SetOpsNormalizeList(packList[packIndex])
  end
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    targetSelectType = bc.TargetSelectType.KeeperSkillDrop,
    packList = packListData,
    selectMaxNum = selectMaxNum,
    selectMinNum = selectMinNum,
    title = title or "",
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:ChooseCardDesignateEnchantList(cardListExp, enchantTid, desc, selectNum, isMustNum)
  local targetUids = {}
  for _, card in ipairs(cardListExp:GetTargetList()) do
    table.insert(targetUids, card.uid)
  end
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  local isMust = nil == isMustNum or 1 == tonumber(isMustNum)
  local minNum = isMust and selectNum or 0
  if self.battleEngine:GetTimeoutFlag() then
    local num = self.battleEngine.rand:random(minNum, selectNum)
    targetUids = table.clone(targetUids)
    BattleUtilServer.Shuffle(self.battleEngine, targetUids)
    local targets = {}
    for i = 1, num do
      if targetUids and targetUids[i] then
        local card = self.battleEngine:GetObj(targetUids[i])
        table.insert(targets, card)
      end
    end
    do return BattleCmdCardListExp, self end
    return BattleCmdCardListExp, self, targets, card.uid, self.battleEngine:GetObj(targetUids[i]), table.insert, targets, card
  end
  local data = {
    castRoleUid = self.castRoleUid,
    effectUid = runningEffect.uid,
    selectNum = selectNum,
    targetUids = targetUids,
    targetSelectType = bc.TargetSelectType.Card,
    minNum = minNum,
    desc = desc,
    cancelable = runningEffect:GetEffectConfig("cancelable"),
    skillConfigId = self.cmdServer and self.cmdServer.skillConfigId,
    enchantTid = enchantTid
  }
  if self.battleEngine:GetTargetFlag() then
    return bc.YIELD_FLAG, data
  end
  self.battleEngine.recordMgr:OnSelectTargets(data)
  self.battleEngine.effectMgr:Yield(BattleCommand.lg_SelectTargets, data)
  return bc.YIELD_FLAG
end

function BattleCmdParser:GetCardByDrop(dropTid, num, exclusive)
  if self.battleEngine.data.isMock then
    local list = {}
    local camp = self.battleEngine.boutMgr:GetCurCamp()
    for i = 1, 10 do
      local cardInfo = {
        tid = 4677,
        level = 1,
        camp = camp
      }
      table.insert(list, cardInfo)
    end
    do return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list end
    return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list, self, {
      tid = 4677,
      level = 1,
      camp = camp
    }, table.insert, list, cardInfo, nil, nil, nil, nil, nil, nil
  end
  local DropPrize = require("Module.DropPrize")
  DropPrize.SetRandomFunc(function(a, b)
    do return self.battleEngine.rand.random, self.battleEngine.rand, a end
    return self.battleEngine.rand.random, self.battleEngine.rand, a, b
  end)
  dropTid = tonumber(dropTid)
  local dropPrizeList, exclusiveCards
  if 1 == exclusive then
    local exclusiveDropCards = self.battleEngine.__exclusiveDropCards
    if not exclusiveDropCards then
      exclusiveDropCards = {
        [dropTid] = {}
      }
      self.battleEngine.__exclusiveDropCards = exclusiveDropCards
    end
    exclusiveCards = exclusiveDropCards[dropTid] or {}
    exclusiveDropCards[dropTid] = exclusiveCards
    dropPrizeList = DropPrize.GetAward(dropTid, nil, function(dropItem)
      return exclusiveCards[dropItem]
    end)
  else
    dropPrizeList = DropPrize.GetAward(dropTid)
  end
  if not dropPrizeList or not dropPrizeList[1] then
    return {}
  end
  local items = dropPrizeList[1].items
  items = self.battleEngine:RandomNumFromList(items, num)
  local list = {}
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  for _, item in ipairs(items) do
    if exclusiveCards then
      exclusiveCards[item.tid] = true
    end
    local cardInfo = {
      tid = item.tid,
      level = self.skillLevel,
      camp = camp
    }
    table.insert(list, cardInfo)
  end
  do return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list end
  return self.battleEngine.cardMgr.CreateCardsByID, self.battleEngine.cardMgr, list, self, nil, nil, {
    tid = item.tid,
    level = self.skillLevel,
    camp = camp
  }, table.insert, list, cardInfo
end

function BattleCmdParser:GetSilverKey()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local num = player and #player.data.unlockedKeeperSkillItems or 0
  self.battleEngine:DebugS("GetSilverKey {num}", num)
  return num
end

function BattleCmdParser:Archivenotch()
  local DT = self.battleEngine.battleDT
  local stageId = self.battleEngine:GetStageId()
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return 0
  end
  local stageGroupCfg = DT.StageGroup[stageCfg.BelongGroup]
  if not stageGroupCfg or stageGroupCfg.StageChapterText ~= "StageChapterStarsCameRight" then
    return 0
  end
  local silverKey = self:GetSilverKey()
  self.battleEngine:DebugS("Archivenotch {stageId} {silverKey}", stageId, silverKey)
  do return math.min, silverKey end
  return math.min, silverKey, 50, stageId, silverKey
end

function BattleCmdParser:GetLockedEnemy(lockerExp)
  local lockerRole = lockerExp:GetFirstTarget()
  if not lockerRole then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil, nil, nil
  end
  local lockMap = self.battleEngine.roleMgr:GetLockerUidToLockedUid()
  local lockedUid = lockMap[lockerRole.uid]
  local lockedRole = self.battleEngine:GetObj(lockedUid)
  if not lockedRole then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil
  end
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, {lockedRole}, lockedRole
end

function BattleCmdParser:GetLockingAwakers(lockedExp)
  local lockedRole = lockedExp:GetFirstTarget()
  if not lockedRole then
    do return BattleCmdTargetsExp, self end
    return BattleCmdTargetsExp, self, {}, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local lockedUid = lockedRole.uid
  local lockMap = self.battleEngine.roleMgr:GetLockerUidToLockedUid()
  local lockerList = {}
  for lockerUid, targetLockedUid in pairs(lockMap) do
    if targetLockedUid == lockedUid then
      local lockerRole = self.battleEngine:GetObj(lockerUid)
      if lockerRole then
        table.insert(lockerList, lockerRole)
      end
    end
  end
  do return BattleCmdTargetsExp, self end
  return BattleCmdTargetsExp, self, lockerList, pairs(lockMap)
end

function BattleCmdParser:AddTag(targetsExp, tag)
  local targets = targetsExp:GetTargetList()
  for _, target in ipairs(targets) do
    if target.tagManager then
      target.tagManager:AddTag(tag)
    end
  end
end

function BattleCmdParser:RemoveTag(targetsExp, tag)
  local targets = targetsExp:GetTargetList()
  for _, target in ipairs(targets) do
    if target.tagManager then
      target.tagManager:RemoveTag(tag)
    end
  end
end

function BattleCmdParser:GetAllMonsterDamageCount()
  local _, count = self.battleEngine.roleMgr:GetMonsterDamage()
  return count
end

function BattleCmdParser:GetAllMonsterDamageValue()
  local damage, _ = self.battleEngine.roleMgr:GetMonsterDamage()
  return damage
end

function BattleCmdParser:CheckInStage()
  return false
end

function BattleCmdParser:__SpreadKeeperSkillsAcrossPacks(packList, packCount)
  if not packList or type(packList) ~= "table" then
    return
  end
  local effectivePackCount = math.min(tonumber(packCount) or #packList, #packList)
  if effectivePackCount <= 1 then
    return
  end
  local packSlotList = {}
  local allKeeperSkillList = {}
  for packIndex = 1, effectivePackCount do
    local packExp = packList[packIndex]
    local packItemList, _ = self:_SetOpsNormalizeList(packExp)
    if not packItemList then
      packItemList = {}
      if packExp and type(packExp) == "table" and packExp.is and packExp:is(BattleCmdTargetsExp) then
        packExp.targets = packItemList
      end
    end
    local packCapacity = tonumber(packExp and packExp.randUnlockPackNum) or 0
    if packCapacity <= 0 then
      packCapacity = #packItemList
    end
    for itemIndex = 1, #packItemList do
      local keeperSkill = packItemList[itemIndex]
      if keeperSkill then
        table.insert(allKeeperSkillList, keeperSkill)
      end
    end
    for itemIndex = #packItemList, 1, -1 do
      packItemList[itemIndex] = nil
    end
    table.insert(packSlotList, {targets = packItemList, capacity = packCapacity})
  end
  local keeperSkillIndex = 1
  local hasProgress = true
  while keeperSkillIndex <= #allKeeperSkillList and hasProgress do
    hasProgress = false
    for _, packSlot in ipairs(packSlotList) do
      if keeperSkillIndex > #allKeeperSkillList then
        break
      end
      if #packSlot.targets < packSlot.capacity then
        table.insert(packSlot.targets, allKeeperSkillList[keeperSkillIndex])
        keeperSkillIndex = keeperSkillIndex + 1
        hasProgress = true
      end
    end
  end
end

function BattleCmdParser:__GetLockedEnemyByCaster()
  local lockMap = self.battleEngine.roleMgr:GetLockerUidToLockedUid()
  local lockedUid = lockMap[self.castRoleUid]
  local lockedRole = self.battleEngine:GetObj(lockedUid)
  return lockedRole
end

return BattleCmdParser
