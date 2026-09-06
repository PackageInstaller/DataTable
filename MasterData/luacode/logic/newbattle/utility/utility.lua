local Utility = {}
Utility.SkillEffectCampType = {
  OwnSide = 1,
  Enemy = 2,
  Both = 3
}
Utility.SkillUseFailedType = {
  PowerNotEnough = 1,
  UsingOtherSkill = 2,
  SkillInCD = 3,
  CanNotUseSkillBuff = 4,
  NotInPoint = 5
}

local function calculationcdtime(cdtime, entity)
  local attackspeed = fixedpoint.min(5, fixedpoint.max(entity:GetComponent(BattleECS.Components.AttackComponent)._attackSpeed, fixedpoint("-0.8")))
  return fixedpoint.floor(cdtime / (1 + attackspeed))
end

function Utility.IsInCD(entity, skillid)
  if #entity:GetComponent(BattleECS.Components.SkillComponent)._skillList > 0 then
    local flag = true
    local skill
    local skillList = {}
    for _, v in ipairs(skillid) do
      local skillInfo
      for _, skillTable in ipairs(entity:GetComponent(BattleECS.Components.SkillComponent)._skillList) do
        if v == skillTable.skillId then
          skillInfo = skillTable
          break
        end
      end
      if skillInfo then
        if skillInfo.currentTime >= calculationcdtime(skillInfo.cdTime, entity) then
          flag = false
          skill = v
        end
      else
        LogErrorFormat("Utility", "entity not has this skillid:%s", v)
      end
    end
    return flag, skill
  end
end

function Utility.IsHasRateSkill(battleWorld, skillid, data)
  local record = BattleECS.Utility.DataUtility.cSkillRateCfgTable[skillid]
  if record then
    local skillRateList = {}
    for index, rateSkill in ipairs(record.skillid) do
      local formula = record.skillrate[index]
      local findAttrInFormula = false
      local paramterAddTable = {
        "passiveskill",
        "evolution",
        "exclusivelv"
      }
      for _, v in ipairs(paramterAddTable) do
        local i = 0
        while true do
          if v == "evolution" then
            BattleECS.Utility.DataUtility.SkillRateFormulaVariables.evolution = data.typeComponentA._evolutionLevel
            break
          elseif v == "exclusivelv" then
            BattleECS.Utility.DataUtility.SkillRateFormulaVariables.exclusivelv = data.typeComponentA._exclusiveLevel
            break
          end
          i = string.find(formula, v .. "a", i + 1)
          if i == nil then
            break
          end
          findAttrInFormula = true
          if v == "passiveskill" then
            BattleECS.Utility.DataUtility.SkillRateFormulaVariables.passiveskilla = data.skillComponentA._isHasPassiveSkillParamter
          end
        end
      end
      local result = fixedpoint_zero
      local func
      if BattleECS.Utility.DataUtility.CSkillRateCfgFunc[skillid] and BattleECS.Utility.DataUtility.CSkillRateCfgFunc[skillid][rateSkill] then
        func = BattleECS.Utility.DataUtility.CSkillRateCfgFunc[skillid][rateSkill]
      end
      if func then
        result = func()
      elseif not findAttrInFormula then
        result = fixedpoint(formula)
      else
        LogErrorFormat("Utility", "function loading failed skillid %s rateSkill %s formula %s, table is cskillratecfg", skillid, rateSkill, formula)
      end
      if not fixedpoint.judgetype(result) then
        result = fixedpoint(result)
      end
      skillRateList[index] = result
    end
    local upRate, downRate = 0, 0
    local totalRate = 0
    for _, r in ipairs(skillRateList) do
      totalRate = totalRate + r
    end
    local tagRate = battleWorld._randomPcg(1, 100)
    for i, skillid in ipairs(record.skillid) do
      upRate = downRate
      downRate = upRate + skillRateList[i] / totalRate
      if tagRate > upRate * 100 and tagRate <= downRate * 100 then
        return true, tonumber(skillid)
      end
    end
  end
  return false
end

function Utility.IsYeRenBiaoJi(skillid)
  return skillid == 6014301 or skillid == 6014302 or skillid == 6014303 or skillid == 6014304 or skillid == 6014305
end

function Utility.IsYuZiZhaoHuan(skillid)
  return skillid == 6060101 or skillid == 6060102 or skillid == 6060103 or skillid == 6060104 or skillid == 6060105
end

function Utility.IsLiuGuangZhan(skillid)
  return skillid == 6013101 or skillid == 6013102 or skillid == 6013103 or skillid == 6013104 or skillid == 6013105
end

function Utility.IsMoLiZhenDang(skillid)
  return skillid == 6000301 or skillid == 6000302 or skillid == 6000303 or skillid == 6000304 or skillid == 6000305
end

function Utility.IsShiKongZhiMen(skillid)
  return skillid == 6000501 or skillid == 6000502 or skillid == 6000503 or skillid == 6000504 or skillid == 6000505
end

function Utility.IsShiBuKeDang(skillid)
  return skillid == 6011101 or skillid == 6011102 or skillid == 6011103 or skillid == 6011104 or skillid == 6011105
end

function Utility.IsRouGuang(skillid)
  return skillid == 6002101 or skillid == 6002102 or skillid == 6002103 or skillid == 6002104 or skillid == 6002105
end

function Utility.IsYingXiSkill(skillid)
  return skillid == 6014101 or skillid == 6014102 or skillid == 6014103 or skillid == 6014104 or skillid == 6014105
end

function Utility.IsLiuXingZhan(skillid)
  return skillid == 6013201 or skillid == 6013202 or skillid == 6013203 or skillid == 6013204 or skillid == 6013205
end

function Utility.IsSkillTypeEffectNeedDiffTarget(skillid)
  return skillid == 6069101 or skillid == 6069102 or skillid == 6069103 or skillid == 6069104 or skillid == 6069105 or skillid == 6098101 or skillid == 6098102 or skillid == 6098103 or skillid == 6098104 or skillid == 6098105
end

function Utility.IsShiKongZhiMenEffect(effectId)
  return effectId == 600050106 or effectId == 600050106 or effectId == 600050106 or effectId == 600050106 or effectId == 600050106
end

function Utility.IsShiXiangGuiSiWangGuangXian(skillid)
  return skillid == 201008
end

function Utility.IsLingShouChongJi(skillid)
  return skillid == 6070201 or skillid == 6070202 or skillid == 6070203 or skillid == 6070204 or skillid == 6070205
end

function Utility.IsAiSheLei1Skill(skillid)
  return skillid == 6084101 or skillid == 6084102 or skillid == 6084103 or skillid == 6084104 or skillid == 6084105
end

function Utility.IsAiSheLei2Skill(skillid)
  return skillid == 6084201 or skillid == 6084202 or skillid == 6084203 or skillid == 6084204 or skillid == 6084205
end

function Utility.GetSkillAttackNumber(skillid)
  return BattleECS.Utility.DataUtility.cskillTable[skillid].collideTime
end

function Utility.IsSkillHasCollider(skillid)
  return BattleECS.Utility.DataUtility.cskillTable[skillid].colliderOrNot == 1
end

function Utility.ClearSkillCurrentTime(entity, skillid)
  local skillComponnet = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponnet then
    for _, v in ipairs(skillComponnet._skillList) do
      if skillid == v.skillId then
        v.currentTime = 0
        break
      end
    end
  end
end

function Utility.ClearEntityAllSkillCurrentTime(entity)
  local skillComponnet = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponnet then
    for _, v in ipairs(skillComponnet._skillList) do
      v.currentTime = 0
    end
  end
end

function Utility.IsMonsterSkillInCD(entity, skillid)
  local skillComponnet = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponnet then
    for _, v in ipairs(skillComponnet._skillList) do
      if skillid == v.skillId then
        if Utility.IsAttackSkill(skillid) then
          if v.currentTime >= calculationcdtime(v.cdTime, entity) then
            return false
          end
        elseif v.currentTime >= v.cdTime then
          return false
        end
      end
    end
  end
  return true
end

function Utility.SetSkillID(entity, id)
  local originalSkillId = entity:GetComponent(BattleECS.Components.SkillComponent)._skillId
  if Utility.IsUseSkill(originalSkillId) and Utility.IsAttackSkill(id) then
    return
  end
  entity:GetComponent(BattleECS.Components.SkillComponent)._skillId = id
end

function Utility.SetSkillIsCostPowerState(entity, state)
  entity:GetComponent(BattleECS.Components.SkillComponent)._isCostPower = state
end

function Utility.SetSkillComponnetPassiveSkillList(entity, skillStruct, targetEntity, isRoleDeadAlsoCanUsePassiveSkill)
  local id
  if skillStruct.skillid then
    id = skillStruct.skillid
  elseif skillStruct.skillgroupid then
    local record = BattleECS.Utility.DataUtility.cBuffLinkSkillGroupCfgTable[skillStruct.skillgroupid]
    if record then
      local lv
      local skillList = entity:GetComponent(BattleECS.Components.SkillComponent)._skillList
      for _, v in ipairs(skillList) do
        local r = BattleECS.Utility.DataUtility.cSkillItemTable[v.skillId]
        if r and r.itemId == tonumber(record.skillitemid) then
          lv = r.lv
          break
        end
      end
      if lv then
        id = tonumber(record.skilllv[lv])
      else
        LogErrorFormat("Utility", "cbufflinkskillgroupcfg skillgroupid %s 的 skillitemid %s 不在 cskillitem 中", skillStruct.skillgroupid, record.skillitemid)
      end
    else
      LogErrorFormat("Utility", "cbufflinkskillcfg 中存在一项 skillid 为空，同时skillgroupid %s 也不在 cbufflinkskillgroupcfg 中", skillStruct.skillgroupid)
    end
  end
  if id then
    table.insert(entity:GetComponent(BattleECS.Components.SkillComponent)._passiveSkillList, {
      id = id,
      target = targetEntity,
      isRoleDeadAlsoCanUsePassiveSkill = isRoleDeadAlsoCanUsePassiveSkill
    })
  end
end

function Utility.IfSkillTargetIsPassiveSkillTarget(skillId, camp)
  local campType = {AttackOrderToEmery = 1, AttackOrderToOur = 2}
  local config = BattleECS.Utility.DataUtility.cskillTable[skillId]
  if config then
    if camp == campType.AttackOrderToOur then
      return config.attackOrderToOur == 17
    elseif camp == campType.AttackOrderToEmery then
      return config.attackOrderToEmery == 17
    end
  end
  return false
end

function Utility.GetSkillEffectEntity(skillid, useSkillEntityId, battleWorld)
  local entity
  for i, e in ipairs(battleWorld._entitys) do
    if e._entityId == useSkillEntityId then
      entity = e
      break
    end
  end
  if entity then
    local list = {}
    local config = BattleECS.Utility.DataUtility.cskillTable[skillid]
    local useSkillEntitycamp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
    if Utility.GetSkillEffectCamp(skillid) == Utility.SkillEffectCampType.OwnSide then
      if useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Left then
        local efffectEntityNum = math.min(config.targetNumberToOur, table.nums(battleWorld._leftPlayerList) + table.nums(battleWorld._leftPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._leftPlayerList) do
          if not Utility.IsRoleDead(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._leftPlayerSummonList) do
          if not Utility.IsRoleDead(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToOur, entity)
        for _, v in ipairs(rankList) do
          if (config.attackOrderToOur ~= 18 or v._entityId ~= useSkillEntityId) and efffectEntityNum > table.nums(list) then
            table.insert(list, v)
          end
        end
      elseif useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Right then
        local efffectEntityNum = math.min(config.targetNumberToOur, table.nums(battleWorld._rightPlayerList) + table.nums(battleWorld._rightPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._rightPlayerList) do
          if not Utility.IsRoleDead(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._rightPlayerSummonList) do
          if not Utility.IsRoleDead(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToOur, entity)
        for _, v in ipairs(rankList) do
          if (config.attackOrderToOur ~= 18 or v._entityId ~= useSkillEntityId) and efffectEntityNum > table.nums(list) then
            table.insert(list, v)
          end
        end
      end
    elseif Utility.GetSkillEffectCamp(skillid) == Utility.SkillEffectCampType.Enemy then
      if useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Left then
        local efffectEntityNum = math.min(config.targetNumberToEmery, table.nums(battleWorld._rightPlayerList) + table.nums(battleWorld._rightPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._rightPlayerList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._rightPlayerSummonList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToEmery, entity)
        if config.attackOrderToEmery == 5 then
          if table.nums(rankList) > 0 then
            if table.nums(rankList) == 1 then
              table.insert(list, rankList[1])
            else
              local random = battleWorld._randomPcg(1, table.nums(rankList))
              local entity = rankList[random]
              table.insert(list, entity)
            end
          end
        else
          for _, v in ipairs(rankList) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        end
      elseif useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Right then
        local efffectEntityNum = math.min(config.targetNumberToEmery, table.nums(battleWorld._leftPlayerList) + table.nums(battleWorld._leftPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._leftPlayerList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._leftPlayerSummonList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToEmery, entity)
        if config.attackOrderToEmery == 5 then
          if table.nums(rankList) > 0 then
            if table.nums(rankList) == 1 then
              table.insert(list, rankList[1])
            else
              local random = battleWorld._randomPcg(1, table.nums(rankList))
              local entity = rankList[random]
              table.insert(list, entity)
            end
          end
        else
          for _, v in ipairs(rankList) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        end
      end
    elseif Utility.GetSkillEffectCamp(skillid) == Utility.SkillEffectCampType.Both then
      if useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Left then
        local efffectEntityNum = math.min(config.targetNumberToEmery, table.nums(battleWorld._rightPlayerList) + table.nums(battleWorld._rightPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._rightPlayerList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._rightPlayerSummonList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToEmery, entity)
        for _, v in ipairs(rankList) do
          if efffectEntityNum > table.nums(list) then
            table.insert(list, v)
          end
        end
      else
        local efffectEntityNum = math.min(config.targetNumberToEmery, table.nums(battleWorld._leftPlayerList) + table.nums(battleWorld._leftPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._leftPlayerList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) then
            table.insert(record, v)
          end
        end
        for _, v in ipairs(battleWorld._leftPlayerSummonList) do
          if BattleECS.Utility.BuffUtility.IsCanBeChosenInDifferentCampSkill(v) then
            table.insert(record, v)
          end
        end
        local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToEmery, entity)
        if config.attackOrderToEmery == 5 then
          if table.nums(rankList) > 0 then
            if table.nums(rankList) == 1 then
              table.insert(list, rankList[1])
            else
              local random = battleWorld._randomPcg(1, table.nums(rankList))
              local entity = rankList[random]
              table.insert(list, entity)
            end
          end
        else
          for _, v in ipairs(rankList) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        end
      end
    end
    return list
  end
end

function Utility.GetSkillOurCampEntityList(skillid, useSkillEntityId, battleWorld)
  local entity
  for i, e in ipairs(battleWorld._entitys) do
    if e._entityId == useSkillEntityId then
      entity = e
      break
    end
  end
  if entity then
    local list = {}
    local config = BattleECS.Utility.DataUtility.cskillTable[skillid]
    if not config then
      LogErrorFormat("Utility", "skillid %s is not in cskill", skillid)
    end
    if config.targetNumberToOur > 0 then
      local useSkillEntitycamp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      if useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Left then
        local efffectEntityNum = math.min(config.targetNumberToOur, table.nums(battleWorld._leftPlayerList) + table.nums(battleWorld._leftPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._leftPlayerList) do
          if config.attackOrderToOur == 7 then
            if Utility.IsRoleDead(v) and v:GetComponent(BattleECS.Components.TypeComponent)._roleID ~= 20054 then
              table.insert(record, v)
            end
          elseif (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and BattleECS.Utility.BuffUtility.IsCanBeChosenInSameCampSkill(v) then
            table.insert(record, v)
          end
        end
        if config.attackOrderToOur ~= 7 then
          for _, v in ipairs(battleWorld._leftPlayerSummonList) do
            if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and BattleECS.Utility.BuffUtility.IsCanBeChosenInSameCampSkill(v) then
              table.insert(record, v)
            end
          end
          local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToOur, entity)
          for _, v in ipairs(rankList) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        else
          for _, v in ipairs(record) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        end
      elseif useSkillEntitycamp == BattleECS.Components.TypeComponent.CampType.Right then
        local efffectEntityNum = math.min(config.targetNumberToOur, table.nums(battleWorld._rightPlayerList) + table.nums(battleWorld._rightPlayerSummonList))
        local record = {}
        for _, v in ipairs(battleWorld._rightPlayerList) do
          if config.attackOrderToOur == 7 then
            if Utility.IsRoleDead(v) then
              table.insert(record, v)
            end
          elseif (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and BattleECS.Utility.BuffUtility.IsCanBeChosenInSameCampSkill(v) and not Utility.IsEntityEscape(v) then
            table.insert(record, v)
          end
        end
        if config.attackOrderToOur ~= 7 then
          for _, v in ipairs(battleWorld._rightPlayerSummonList) do
            if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and BattleECS.Utility.BuffUtility.IsCanBeChosenInSameCampSkill(v) then
              table.insert(record, v)
            end
          end
          local rankList = Utility.GetSkillEffectRankEntityList(skillid, record, config.attackOrderToOur, entity)
          for _, v in ipairs(rankList) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        else
          for _, v in ipairs(record) do
            if efffectEntityNum > table.nums(list) then
              table.insert(list, v)
            end
          end
        end
      end
    end
    return list
  end
end

function Utility.GetSkillEffectRankEntityList(skillid, entitylist, rankType, useSkillEntity)
  local list = entitylist
  if rankType == 1 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.HpComponent)._currentHp < b:GetComponent(BattleECS.Components.HpComponent)._currentHp
    end)
  elseif rankType == 2 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.HpComponent)._currentHp > b:GetComponent(BattleECS.Components.HpComponent)._currentHp
    end)
  elseif rankType == 3 and 1 < table.nums(list) then
    if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    else
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    end
  elseif rankType == 4 and 1 < table.nums(list) then
    if useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._isImaged then
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    else
      table.sort(list, function(a, b)
        if a:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x < b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        else
          return a:GetComponent(BattleECS.Components.PositionComponent)._position.x > b:GetComponent(BattleECS.Components.PositionComponent)._position.x
        end
      end)
    end
  elseif rankType == 6 then
    list = {}
    table.insert(list, useSkillEntity)
  elseif rankType == 8 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.HpComponent)._currentHp / a:GetComponent(BattleECS.Components.HpComponent)._maxHp < b:GetComponent(BattleECS.Components.HpComponent)._currentHp / b:GetComponent(BattleECS.Components.HpComponent)._maxHp
    end)
  elseif rankType == 9 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.HpComponent)._currentHp / a:GetComponent(BattleECS.Components.HpComponent)._maxHp > b:GetComponent(BattleECS.Components.HpComponent)._currentHp / b:GetComponent(BattleECS.Components.HpComponent)._maxHp
    end)
  elseif rankType == 11 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.AttackComponent)._attack > b:GetComponent(BattleECS.Components.AttackComponent)._attack
    end)
  elseif rankType == 12 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.AttackComponent)._attack < b:GetComponent(BattleECS.Components.AttackComponent)._attack
    end)
  elseif rankType == 13 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.DefenseComponent)._attackDefense > b:GetComponent(BattleECS.Components.DefenseComponent)._attackDefense
    end)
  elseif rankType == 14 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.DefenseComponent)._attackDefense < b:GetComponent(BattleECS.Components.DefenseComponent)._attackDefense
    end)
  elseif rankType == 15 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.DefenseComponent)._magicDefense > b:GetComponent(BattleECS.Components.DefenseComponent)._magicDefense
    end)
  elseif rankType == 16 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      return a:GetComponent(BattleECS.Components.DefenseComponent)._magicDefense < b:GetComponent(BattleECS.Components.DefenseComponent)._magicDefense
    end)
  elseif rankType == 17 then
    list = {}
  elseif rankType == 19 and 1 < table.nums(list) then
    table.sort(list, function(a, b)
      if a._entityId == useSkillEntity._entityId then
        return true
      end
      if b._entityId == useSkillEntity._entityId then
        return false
      end
      return a:GetComponent(BattleECS.Components.HpComponent)._currentHp / a:GetComponent(BattleECS.Components.HpComponent)._maxHp < b:GetComponent(BattleECS.Components.HpComponent)._currentHp / b:GetComponent(BattleECS.Components.HpComponent)._maxHp
    end)
  end
  return list
end

function Utility.GetSkillEffectCamp(skillid)
  local config = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if config then
    if config.targetNumberToEmery > 0 then
      if 0 < config.targetNumberToOur then
        return Utility.SkillEffectCampType.Both
      else
        return Utility.SkillEffectCampType.Enemy
      end
    elseif 0 < config.targetNumberToOur then
      return Utility.SkillEffectCampType.OwnSide
    end
  end
end

function Utility.IsSkillHasNoColliderEffect(skillid)
  local config = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid]
  if config then
    return #config.noColliderEffectAtk > 0
  end
end

function Utility.SkillIsHasPowerExpended(skillid)
  local config = BattleECS.Utility.DataUtility.cSkillCostTable[skillid]
  if config then
    return config.OrderCost ~= 0 or config.ChaosCost ~= 0 or config.pureCost ~= ""
  end
  return false
end

function Utility.IsSkillNeedInitAnimationEventComponentInfo(entity, skillid)
  if entity:GetComponent(BattleECS.Components.TypeComponent)._summonName == "partner" then
    return false
  end
  local roleid = entity:GetComponent(BattleECS.Components.TypeComponent)._roleID
  if BattleECS.Utility.DataUtility.cMonsterCfgTable[roleid] then
    return true
  end
  if BattleECS.Utility.DataUtility.roleConfigTable[roleid] then
    if not Utility.IsAttackSkill(skillid) then
      return true
    else
      return false
    end
  end
end

function Utility.IsToTargetXPoint(entity)
  local component = entity:GetComponent(BattleECS.Components.TypeComponent)
  if component and component._isImaged then
    return true
  end
  local component = entity:GetComponent(BattleECS.Components.PositionComponent)
  if component then
    local targetpoint = component._targetPos
    local camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
    local pos = component._position
    if component._targetPos.x then
      if camp == BattleECS.Components.TypeComponent.CampType.Left then
        if pos.x <= targetpoint.x + 1 and pos.x >= targetpoint.x - 1 then
          return true
        else
          return false
        end
      elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
        if pos.x <= targetpoint.x + 1 and pos.x >= targetpoint.x - 1 then
          return true
        else
          return false
        end
      end
    else
      return true
    end
  else
    return true
  end
end

function Utility.ShiXiangGuiBattleEndMoveFun(entity)
  if entity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Left then
    local component = entity:GetComponent(BattleECS.Components.PositionComponent)
    if component and component._targetPos.x and component._position.x < component._targetPos.x then
      component._position.x = component._targetPos.x
    end
  end
end

function Utility.GetSkillEffectSocketPoint(prefabName, socket)
  local data = {
    x = 0,
    y = 0,
    z = 0
  }
  local str = string.lower(prefabName)
  local prefabData = require("data.battledata.npcshapedata." .. str)
  if not prefabData[socket] then
    LogInfoFormat("utility", "no npcshapedata with prefabname '%s' socket %s", str, socket)
  else
    data.x = prefabData[socket].x
    data.y = prefabData[socket].y
    data.z = prefabData[socket].z
  end
  return data
end

function Utility.GetEntityShapeRecorder(entity)
  local entityTypeCom = entity:GetComponent(BattleECS.Components.TypeComponent)
  if entityTypeCom._changeShapeID ~= 0 then
    local shapeID = entityTypeCom._changeShapeID
    local shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[shapeID]
    return {
      assetBundleName = shapeRecorder.assetBundleName,
      prefabName = shapeRecorder.prefabName
    }
  else
    return {
      assetBundleName = entityTypeCom._oriShapeAssetBundleName,
      prefabName = entityTypeCom._oriShapePrefabName
    }
  end
end

function Utility.ReturnEffectRad(entity, targetEntity, point, targetpoint)
  if entity._entityId == targetEntity._entityId then
    return 0, 0
  end
  local position = entity:GetComponent(BattleECS.Components.PositionComponent)._position
  local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(entity)
  local qDPath = Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, point)
  local tDPath = {}
  shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(targetEntity)
  if targetpoint then
    tDPath = Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, targetpoint)
  else
    tDPath = Utility.GetSkillEffectSocketPoint(shapeRecorder.prefabName, "HitPoint")
  end
  local x = 0
  local y = 0
  if entity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
    x = position.x - qDPath.x
    y = position.y + qDPath.y
  else
    x = position.x + qDPath.x
    y = position.y + qDPath.y
  end
  local tarPosition = targetEntity:GetComponent(BattleECS.Components.PositionComponent)._position
  if targetEntity:GetComponent(BattleECS.Components.TypeComponent)._camp == BattleECS.Components.TypeComponent.CampType.Right then
    local tarX = tarPosition.x - tDPath.x
    local tarY = tarPosition.y + tDPath.y
    local distance = fixedpoint.sqrt(fixedpoint.square((tarY - y) / 1000) + fixedpoint.square((tarX - x) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - y) / distance
    local changeValueForCalculate = sin / (1 + fixedpoint.sqrt(1 - fixedpoint.square(sin)))
    local rad = 2 * fixedpoint.atan2f(changeValueForCalculate, 1)
    local degree = fixedpoint.deg(rad)
    return rad, sin, degree
  else
    local tarX = tarPosition.x + tDPath.x
    local tarY = tarPosition.y + tDPath.y
    local distance = fixedpoint.sqrt(fixedpoint.square((tarY - y) / 1000) + fixedpoint.square((tarX - x) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - y) / distance
    local changeValueForCalculate = sin / (1 + fixedpoint.sqrt(1 - fixedpoint.square(sin)))
    local rad = 2 * fixedpoint.atan2f(changeValueForCalculate, 1)
    local degree = fixedpoint.deg(rad)
    return rad, -sin, degree
  end
end

function Utility.ReturnEffectRadByTargetXY(qX, qY, tX, tY, tarCamp)
  local x = qX
  local y = qY
  local tarX = tX
  local tarY = tY
  if tarCamp == BattleECS.Components.TypeComponent.CampType.Right then
    local distance = fixedpoint.sqrt(fixedpoint.square((tarY - y) / 1000) + fixedpoint.square((tarX - x) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - y) / distance
    local rad = fixedpoint.deg(fixedpoint.atan2f(sin, 1))
    return rad, sin
  else
    local distance = fixedpoint.sqrt(fixedpoint.square((tarY - y) / 1000) + fixedpoint.square((tarX - x) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - y) / distance
    local rad = fixedpoint.deg(fixedpoint.atan2f(sin, 1))
    return rad, -sin
  end
end

function Utility.GetRandomPosition(random, randomFun)
  local num = randomFun(1, 3)
  while num == random do
    num = randomFun(1, 3)
  end
  local pos = {}
  for i = 1, 3 do
    pos[i] = {}
    pos[i] = string.split(BattleECS.Utility.DataUtility.cBattleConstCfgTable[18 + i].attr, ";")
  end
  local xD = (fixedpoint(pos[num][2]) - fixedpoint(pos[num][1])) * 1000
  local yD = (fixedpoint(pos[num][4]) - fixedpoint(pos[num][3])) * 1000
  local x = fixedpoint(pos[num][1]) * 1000 + randomFun(1, 1000) * xD // 1000
  local y = fixedpoint(pos[num][3]) * 1000 + randomFun(1, 1000) * yD // 1000
  return x, y, num
end

function Utility.IsHasPowerToSkill(entity, skillid, red, blue, battleWorld)
  local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
  local skillConfig = BattleECS.Utility.DataUtility.cSkillCostTable[skillid]
  if skillConfig then
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, skillid, redCost, blueCost)
    if skillConfig.pureCost ~= "" then
      local record = {}
      record.skillComponentB = skillComponent
      record.skillComponentA = skillComponent
      record.world = battleWorld
      record.formulaString = skillConfig.pureCost
      record.skillid = skillid
      record.camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      redCost, blueCost = BattleECS.Utility.BuffUtility.NewAnalysisFormulaPowerCost(record)
    end
    local attr1 = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[1].attr)
    local attr2 = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[2].attr)
    if red >= redCost * attr1 and blue >= blueCost * attr2 then
      return true, red - redCost * attr1, blue - blueCost * attr2
    end
  end
  return false
end

function Utility.IsRoleDead(entity)
  if entity then
    local component = entity:GetComponent(BattleECS.Components.HpComponent)
    if component and component._hpStage == "escape" then
      return true
    end
    component = entity:GetComponent(BattleECS.Components.BuffComponent)
    if component then
      for _, v in ipairs(component._buffList) do
        if v.buffId == 20000 then
          return true
        end
      end
    end
    component = entity:GetComponent(BattleECS.Components.TypeComponent)
    if component and component._summonName == "buff" and component._isNeedDestroy then
      return true
    elseif not component then
      LogInfoFormat("Utility", "IsRoleDead judging has some order problems, but recorder the entity with id %s is dead", entity._entityId)
      return true
    end
  else
    return true
  end
  return false
end

function Utility.RoleDeadClearComponentData(entity)
  if entity:GetComponent(BattleECS.Components.SkillComponent) then
    for _, v in ipairs(entity:GetComponent(BattleECS.Components.SkillComponent)._skillList) do
      v.currentTime = 0
    end
  end
end

function Utility.IsRoleCanUseSkill(entity, skillid, battleWorld)
  if battleWorld:GetCampWinState() ~= "" then
    LogInfo("Utility", "战斗结束")
    return false
  end
  local isHas = false
  local skillInfo
  local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponent then
    for _, v in ipairs(skillComponent._skillList) do
      if v.skillId == skillid then
        skillInfo = v
        isHas = true
      end
    end
    if not isHas then
      LogErrorFormat("Utility", "该角色没有该技能 entityid:%s skillid:%s", entity._entityId, skillid)
    else
      local effectType = {
        AttackSkill = 1,
        UseSkill = 2,
        Both = 3
      }
      local isHasCanNotUseSkillBuff = BattleECS.Utility.BuffUtility.IsRoleHasCanNotUseSkillBuff(entity, effectType.UseSkill, skillid)
      if isHasCanNotUseSkillBuff then
        BattleECS.Utility.ProtocolUtility.SendSkillFail(entity._entityId, skillid, Utility.SkillUseFailedType.CanNotUseSkillBuff, battleWorld)
        LogInfo("Utility", "不能释放技能的负面buff")
        return
      end
      if not Utility.IsToTargetXPoint(entity) then
        BattleECS.Utility.ProtocolUtility.SendSkillFail(entity._entityId, skillid, Utility.SkillUseFailedType.NotInPoint, battleWorld)
        LogInfo("Utility", "未到点位")
        return
      end
      local red = battleWorld._redPower
      local blue = battleWorld._bluePower
      local flag, redcu, bluecu = Utility.IsHasPowerToSkill(entity, skillid, red, blue, battleWorld)
      if flag then
        if (entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkill or skillComponent._skillId ~= 0 and BattleECS.Utility.Utility.IsSkillNeedInitAnimationEventComponentInfo(entity, skillid)) and not Utility.IsSkillCanUseNotNeedRoleInSkill(skillid) then
          BattleECS.Utility.ProtocolUtility.SendSkillFail(entity._entityId, skillid, Utility.SkillUseFailedType.UsingOtherSkill, battleWorld)
          LogInfo("Utility", "角色正在释放其他技能")
        elseif skillInfo.currentTime < skillInfo.cdTime then
          BattleECS.Utility.ProtocolUtility.SendSkillFail(entity._entityId, skillid, Utility.SkillUseFailedType.SkillInCD, battleWorld)
          LogInfo("Utility", "技能cd")
        else
          skillComponent._skillId = skillid
          skillComponent._isClickUseSkill = true
          skillComponent._useActSkillList[skillid] = skillComponent._useActSkillList[skillid] or 0
          skillComponent._useActSkillList[skillid] = skillComponent._useActSkillList[skillid] + 1
          red = redcu
          blue = bluecu
          LogInfoFormat("Utility", "即将使用成功 skillid %s", skillid)
        end
      else
        BattleECS.Utility.ProtocolUtility.SendSkillFail(entity._entityId, skillid, Utility.SkillUseFailedType.PowerNotEnough, battleWorld)
        LogInfo("Utility", "能量不足")
      end
    end
  end
end

function Utility.PlayRoleSkillVoice(entity, skillId, battleWorld)
  local roleId = entity:GetComponent(BattleECS.Components.TypeComponent)._roleID
  if ServerGameTimer then
    if BattleECS.Utility.DataUtility.RoleSkillCVCD[roleId] then
      local delta = ServerGameTimer.GetServerTimeForecast() - BattleECS.Utility.DataUtility.RoleSkillCVCD[roleId]
      if delta < tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[99].attr) * 1000 then
        return
      else
        BattleECS.Utility.DataUtility.RoleSkillCVCD[roleId] = ServerGameTimer.GetServerTimeForecast()
      end
    else
      BattleECS.Utility.DataUtility.RoleSkillCVCD[roleId] = ServerGameTimer.GetServerTimeForecast()
    end
  end
  local index
  if not BattleECS.Utility.DataUtility.cSoundCatalogTable[roleId] then
    LogErrorFormat("Utility", "role id %s dont have config in csoundcatalog", roleId)
    return
  end
  local v = BattleECS.Utility.DataUtility.cSkillItemTable[skillId]
  for i, skillIdInTable in ipairs(BattleECS.Utility.DataUtility.cSoundCatalogTable[roleId].SkillID) do
    if v.itemId == skillIdInTable then
      index = i
      break
    end
  end
  if not index then
    LogErrorFormat("Utility", "role id %s skillid %s dont have the right skillitemid config in csoundcatalog.SkillID", roleId, skillId)
    return
  end
  local skillCV = tonumber(BattleECS.Utility.DataUtility.cSoundCatalogTable[roleId].SkillCV[index])
  local changeRecord = BattleECS.Utility.DataUtility.cBattleSoundChangeTable[skillCV]
  local playOriginalSkillVoice = true
  if changeRecord then
    local component = entity:GetComponent(BattleECS.Components.BuffComponent)
    if component then
      for _, v in ipairs(component._buffList) do
        for i, buffId in ipairs(changeRecord.buffid) do
          if v.buffId == tonumber(buffId) then
            playOriginalSkillVoice = false
            BattleECS.Utility.ProtocolUtility.SendPlayAudio(tonumber(changeRecord.SkillCV[i]), -1, battleWorld)
            LogInfoFormat("Utility", "play skill id %s cv %s voice change to %s", skillId, skillCV, tonumber(changeRecord.SkillCV[i]))
            break
          end
        end
      end
    end
  end
  if playOriginalSkillVoice then
    BattleECS.Utility.ProtocolUtility.SendPlayBattleVoice(roleId, BattleECS.Utility.DataUtility.VoiceType.SkillCV, index, battleWorld)
  end
end

function Utility.ChangeEntityCurrentHp(entity, hpChange)
  entity:GetComponent(BattleECS.Components.HpComponent)._currentHp = fixedpoint.min(entity:GetComponent(BattleECS.Components.HpComponent)._currentHp + hpChange, entity:GetComponent(BattleECS.Components.HpComponent)._maxHp)
  if entity:GetComponent(BattleECS.Components.HpComponent)._currentHp < 0 then
    entity:GetComponent(BattleECS.Components.HpComponent)._currentHp = fixedpoint_zero
  end
end

function Utility.SetEntityHpComponentLastDamege(entity, damagenum, damagefrom)
  entity:GetComponent(BattleECS.Components.HpComponent)._lastDamage = damagenum
  entity:GetComponent(BattleECS.Components.HpComponent)._lastDamageFrom = damagefrom
end

function Utility.SetEntityHpComponentHpStage(entity, stage)
  entity:GetComponent(BattleECS.Components.HpComponent)._hpStage = stage
end

function Utility.IsEntityEscape(entity)
  local component = entity:GetComponent(BattleECS.Components.HpComponent)
  if component and component._hpStage == "escape" then
    return true
  end
  return false
end

function Utility.SetEntityHpComponentTotalDamege(entity, damagenum)
  if entity:GetComponent(BattleECS.Components.HpComponent)._totalDamage >= fixedpoint.maxinteger then
    entity:GetComponent(BattleECS.Components.HpComponent)._totalDamage = fixedpoint.maxinteger
  else
    entity:GetComponent(BattleECS.Components.HpComponent)._totalDamage = entity:GetComponent(BattleECS.Components.HpComponent)._totalDamage + damagenum
  end
end

function Utility.ClearEntityHpComponentTotalDamege(entity)
  entity:GetComponent(BattleECS.Components.HpComponent)._totalDamage = fixedpoint_zero
end

function Utility.RecordEntityHpComponentElementDamage(entity, damagenum, enemyEntity)
  local elementType = enemyEntity:GetComponent(BattleECS.Components.TypeComponent)._roleElementType
  if elementType == BattleECS.Components.TypeComponent.ElementType.None then
    LogInfoFormat("Utility", "elementType == None,EntityID:%s", enemyEntity._entityId)
    return
  end
  local elementDamageList = entity:GetComponent(BattleECS.Components.HpComponent)._elementDamageList
  if not elementDamageList[elementType] then
    elementDamageList[elementType] = fixedpoint_zero
  end
  if elementDamageList[elementType] >= fixedpoint.maxinteger then
    elementDamageList[elementType] = fixedpoint.maxinteger
  else
    elementDamageList[elementType] = elementDamageList[elementType] + damagenum
  end
  entity:GetComponent(BattleECS.Components.HpComponent)._elementDamageList = elementDamageList
end

function Utility.IsEntityHighestElementDamage(entity, elementType)
  local elementDamageList = entity:GetComponent(BattleECS.Components.HpComponent)._elementDamageList
  local currentDam = elementDamageList[elementType]
  if currentDam then
    for k, v in pairs(elementDamageList) do
      if v > currentDam and k ~= elementType then
        return false
      end
    end
  end
  return true
end

function Utility.RecorderPowerCost(battleWorld, skillid, entity)
  local skillConfig = BattleECS.Utility.DataUtility.cSkillCostTable[skillid]
  if skillConfig then
    local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, skillid, redCost, blueCost)
    if skillConfig.pureCost ~= "" then
      local record = {}
      record.skillComponentB = skillComponent
      record.skillComponentA = skillComponent
      record.world = battleWorld
      record.formulaString = skillConfig.pureCost
      record.skillid = skillid
      record.camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
      redCost, blueCost = BattleECS.Utility.BuffUtility.NewAnalysisFormulaPowerCost(record)
      BattleECS.Utility.Utility.SetEntitySkillComponentCostPower(entity, skillid, redCost, blueCost)
    end
    local buffComponent = entity:GetComponent(BattleECS.Components.BuffComponent)
    buffComponent._orderPowerCost = buffComponent._orderPowerCost + redCost
    buffComponent._chaosPowerCost = buffComponent._chaosPowerCost + blueCost
  end
end

function Utility.SetEntitySkillComponentCostPower(entity, skillid, red, blue)
  entity:GetComponent(BattleECS.Components.SkillComponent)._skillCostPowerList[skillid] = {}
  entity:GetComponent(BattleECS.Components.SkillComponent)._skillCostPowerList[skillid].red = red
  entity:GetComponent(BattleECS.Components.SkillComponent)._skillCostPowerList[skillid].blue = blue
end

function Utility.AddEntityHpComponentSkillHitNumber(entity, damagenum, skillid)
  entity:GetComponent(BattleECS.Components.HpComponent)._skillListOnceDamage[skillid] = damagenum
end

function Utility.IsAttackSkill(skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if skillConfig and skillConfig.effecttype == 1 then
    return true
  end
  return false
end

function Utility.IsUseSkill(skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if skillConfig and skillConfig.effecttype == 2 then
    return true
  end
  return false
end

function Utility.IsPassiveSkill(skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if skillConfig and skillConfig.effecttype == 4 then
    return true
  end
  return false
end

function Utility.GetEntityAttackSkillID(entity)
  local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponent then
    for _, v in ipairs(skillComponent._skillList) do
      if Utility.IsAttackSkill(v.skillId) then
        return v.skillId
      end
    end
  end
  return nil
end

function Utility.GetMonsterOrRoleMagicOrAttackEndFraps(entity, skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid]
  if skillConfig then
    local animationRecoder = BattleECS.Utility.DataUtility.cSkillAnimationTable[skillid]
    local animationType = {
      None = 0,
      OneAttackAction = 1,
      ThreeAnimationAction = 2
    }
    if animationRecoder and animationRecoder.actionType == animationType.ThreeAnimationAction then
      local frap = 0
      local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(entity)
      local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
      if animationRecoder.skillStart ~= "" then
        local data = frapData[animationRecoder.skillStart]
        if data then
          frap = frap + data.endEventFrames
        else
          LogErrorFormat("Utility", "actionType 2 npcshapeanimationdata.%s animationstart %s is not exist in cSkillAnimationTable skillid %s", string.lower(shapeRecorder.prefabName), animationRecoder.skillStart, skillid)
        end
      end
      frap = frap + tonumber(animationRecoder.loopTime)
      local endAnimationFrames = 0
      local frapDataSkillEnd = frapData[animationRecoder.skillEnd]
      if frapDataSkillEnd then
        endAnimationFrames = frapDataSkillEnd.endEventFrames
      end
      return frap, frap + endAnimationFrames
    elseif animationRecoder and animationRecoder.actionType == animationType.OneAttackAction then
      local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(entity)
      local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
      local frap = 0
      local data = frapData[animationRecoder.actionAtk]
      if data then
        frap = frapData[animationRecoder.actionAtk].endEventFrames + 2
      else
        LogErrorFormat("Utility", "actionType 1 npcshapeanimationdata.%s actionAtk %s is not exist in cSkillAnimationTable skillid %s", string.lower(shapeRecorder.prefabName), animationRecoder.actionAtk, skillid)
      end
      return frap, frap
    else
      local shapeRecorder = BattleECS.Utility.Utility.GetEntityShapeRecorder(entity)
      local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeRecorder.prefabName))
      local frap = 0
      local data = frapData[skillConfig.actionAtk]
      if data then
        frap = frapData[skillConfig.actionAtk].endEventFrames + 2
      end
      return frap, frap
    end
  else
    LogErrorFormat("Utility", "skillid %s not exist in cSkillBehaviorTable", skillid)
  end
  return 0, 0
end

function Utility.GetSkillActionAtkAnimation(skillid)
  local skillConfig = BattleECS.Utility.DataUtility.cSkillAnimationTable[skillid]
  if skillConfig then
    return skillConfig.actionAtk
  else
    skillConfig = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid]
    if skillConfig then
      return skillConfig.actionAtk
    end
  end
  return ""
end

function Utility.IsDamageReBoundSkill(skillid)
  local config = BattleECS.Utility.DataUtility.cSkillBehaviorTable[skillid]
  if config and #config.invalidEffectAtk > 0 then
    for _, record in pairs(BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable) do
      if tonumber(record.skillid) == tonumber(skillid) then
        local re = string.split(record.conditionid, ";")
        for _, value in ipairs(re) do
          if value == "4" then
            return true
          end
        end
      end
    end
  end
  return false
end

function Utility.IsJoinBattleAndEnoughCondition(battleid)
  for _, v in ipairs(BattleECS.Utility.DataUtility.cJoinBattleInfoTable) do
    local record = v.record
    if battleid == record.battleID then
      return true, {
        num = fixedpoint(record.attr) / 100,
        id = record.id,
        chatId = record.joinBattleMessage
      }
    end
  end
  return false
end

function Utility.IsSkillCanUseNotNeedRoleInSkill(skillid)
  local rec = string.split(BattleECS.Utility.DataUtility.cBattleConstCfgTable[10].attr, ";")
  for _, v in ipairs(rec) do
    if tonumber(v) == skillid then
      return true
    end
  end
  return false
end

function Utility.GetFrogRider201034DestroyFraps()
  local shapeConfig = BattleECS.Utility.DataUtility.cNPCShapeTable[BattleECS.Utility.DataUtility.cMonsterCfgTable[20054].shapeID]
  local frapData = require("data.battledata.npcshapeanimationdata." .. string.lower(shapeConfig.prefabName))
  local frap = frapData.Attack2.endEventFrames
  return frap
end

function Utility.IsNeedPlayPerformSkillAnimation(skillid)
  local record = BattleECS.Utility.DataUtility.cSkillAnimationTable[skillid]
  local animationType = {
    None = 0,
    OneAttackAction = 1,
    ThreeAnimationAction = 2
  }
  if record then
    return record.actionType == animationType.OneAttackAction
  end
  return true
end

function Utility.IsRoleFirstSkill(entity, skillid)
  local roleid = entity:GetComponent(BattleECS.Components.TypeComponent)._roleID
  local record = BattleECS.Utility.DataUtility.roleConfigTable[roleid]
  if record and BattleECS.Utility.DataUtility.cSkillItemTable[skillid].itemId == record.contractskillid then
    return true
  end
  return false
end

function Utility.IsRoleSecondSkill(entity, skillid)
  local roleid = entity:GetComponent(BattleECS.Components.TypeComponent)._roleID
  local record = BattleECS.Utility.DataUtility.roleConfigTable[roleid]
  if record and BattleECS.Utility.DataUtility.cSkillItemTable[skillid].itemId == record.contractskillid2 then
    return true
  end
  return false
end

function Utility.IsTreateSkill(skillid)
  local record = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if record then
    return record.attr == 3
  end
  return false
end

function Utility.IsSkillOnceEquipSkill(skillid)
  for _, record in pairs(BattleECS.Utility.DataUtility.cBuffLinkSkillCfgTable) do
    if tonumber(record.skillid) == tonumber(skillid) then
      local buffid = record.id
    end
  end
  return false
end

function Utility.IsSkillHas10006Buff(skillid)
  local record = BattleECS.Utility.DataUtility.cskillTable[skillid]
  if string.find(record.friendbuffid, "10006") then
    return true
  end
  return false
end

function Utility.GetCampAliveRoleNumber(side, battleworld, entityId)
  local sideType = {Enemy = 1, OwnSide = 2}
  local entityList = {}
  local entity
  for i, e in ipairs(battleworld._entitys) do
    if e._entityId == entityId then
      entity = e
      break
    end
  end
  local camp
  if entity then
    camp = entity:GetComponent(BattleECS.Components.TypeComponent)._camp
  end
  if side == sideType.OwnSide then
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      entityList = battleworld._leftPlayerList
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      entityList = battleworld._rightPlayerList
    end
  elseif side == sideType.Enemy then
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      entityList = battleworld._rightPlayerList
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      entityList = battleworld._leftPlayerList
    end
  end
  local num = 0
  for _, e in ipairs(entityList) do
    if not Utility.IsRoleDead(e) then
      num = num + 1
    end
  end
  return num
end

function Utility.GetSkinSkillChangeEffectId(curPrefabName, skillEffectId)
  local skinChangeRecorder = BattleECS.Utility.DataUtility.cSkinSkillEffectChangeTable[skillEffectId]
  if skinChangeRecorder then
    for index, shapeId in ipairs(skinChangeRecorder.shapeid) do
      local shapeRecorder = BattleECS.Utility.DataUtility.cNPCShapeTable[tonumber(shapeId)]
      if shapeRecorder and shapeRecorder.prefabName == curPrefabName then
        skillEffectId = tonumber(skinChangeRecorder.effectid[index])
        break
      end
    end
  end
  return skillEffectId
end

function Utility.ClearAndDestroyTypeMineEffectAtkList(entity, battleWorld)
  local skillEffectComponent = entity:GetComponent(BattleECS.Components.SkillEffectComponent)
  local typeComponent = entity:GetComponent(BattleECS.Components.TypeComponent)
  if skillEffectComponent and typeComponent then
    for _, v in ipairs(skillEffectComponent._typeMineEffectAtkList) do
      local effectConfig = BattleECS.Utility.DataUtility.cSkillEffectTable[v.effectid]
      BattleECS.Utility.ProtocolUtility.SendDestroyEffectByName(typeComponent._camp, effectConfig.effectName, battleWorld)
    end
  end
end

function Utility.JudgeIfCanUseCoordinatedSkill(useSkillEntity, currentEntitySkillID, battleWorld)
  local useSkillEntitySkillComponent = useSkillEntity:GetComponent(BattleECS.Components.SkillComponent)
  local skillInfo
  for _, v in ipairs(useSkillEntitySkillComponent._skillList) do
    if currentEntitySkillID == v.skillId then
      skillInfo = v
      break
    end
  end
  if skillInfo and skillInfo.activeSkillIndex and useSkillEntitySkillComponent._isCostPower then
    local camp = useSkillEntity:GetComponent(BattleECS.Components.TypeComponent)._camp
    local playerList
    if camp == BattleECS.Components.TypeComponent.CampType.Left then
      playerList = battleWorld._leftPlayerList
    elseif camp == BattleECS.Components.TypeComponent.CampType.Right then
      playerList = battleWorld._rightPlayerList
    end
    if playerList then
      for _, entity in ipairs(playerList) do
        local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
        if entity._entityId ~= useSkillEntity._entityId then
          local skillIndex
          if skillComponent._comborate1 > 0 then
            skillIndex = 1
          elseif 0 < skillComponent._comborate2 then
            skillIndex = 2
          end
          if skillIndex then
            local skillid
            for _, v in ipairs(skillComponent._skillList) do
              if v.activeSkillIndex == skillIndex then
                skillid = v.skillId
                break
              end
            end
            if skillid then
              skillComponent._comborateRemainingNum = skillComponent._comborateRemainingNum - 1
              if 0 > skillComponent._comborateRemainingNum then
                skillComponent._comborateRemainingNum = fixedpoint_zero
              end
              BattleECS.Utility.ProtocolUtility.SendCollaborativeSkillNumChange(skillComponent._comborateRemainingNum, entity._entityId, battleWorld)
              Utility.UseCoordinatedSkill(entity, battleWorld)
            else
              LogInfoFormat("Utility", "entityid %s roleid %s comborate1 %s comborate2 %s but skillList dont have corresponding activeskillindex", entity._entityId, entity:GetComponent(BattleECS.Components.TypeComponent)._roleID, skillComponent._comborate1, skillComponent._comborate2)
            end
          end
        end
      end
    end
  end
end

function Utility.UseCoordinatedSkill(entity, battleWorld)
  local skillComponent = entity:GetComponent(BattleECS.Components.SkillComponent)
  if skillComponent._comborateRemainingNum > 0 then
    return
  end
  local skillIndex
  if 0 < skillComponent._comborate1 then
    skillIndex = 1
  elseif 0 < skillComponent._comborate2 then
    skillIndex = 2
  end
  if skillIndex then
    local skillid
    for _, v in ipairs(skillComponent._skillList) do
      if v.activeSkillIndex == skillIndex then
        skillid = v.skillId
        break
      end
    end
    if skillid and battleWorld:GetCampWinState() == "" then
      local effectType = {
        AttackSkill = 1,
        UseSkill = 2,
        Both = 3
      }
      local isHasCanNotUseSkillBuff = BattleECS.Utility.BuffUtility.IsRoleHasCanNotUseSkillBuff(entity, effectType.UseSkill, skillid)
      if isHasCanNotUseSkillBuff then
        LogInfo("Utility", "协同技能释放失败：不能释放技能的负面buff")
      end
      if not Utility.IsToTargetXPoint(entity) then
        LogInfo("Utility", "协同技能释放失败：未到点位")
      end
      if (entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkill or skillComponent._skillId ~= 0 and BattleECS.Utility.Utility.IsSkillNeedInitAnimationEventComponentInfo(entity, skillid)) and not Utility.IsSkillCanUseNotNeedRoleInSkill(skillid) then
      else
        Utility.SetSkillIsCostPowerState(entity, false)
        skillComponent._skillId = skillid
        skillComponent._comborateRemainingNum = fixedpoint.max(skillComponent._comborate1, skillComponent._comborate2)
        BattleECS.Utility.ProtocolUtility.SendCollaborativeSkillNumChange(skillComponent._comborateRemainingNum, entity._entityId, battleWorld)
        LogInfoFormat("Utility", "协同技能释放成功 skillid %s", skillid)
      end
    end
  end
end

function Utility.CalculateConfigAttrFunc(constant, param)
  local value = 0
  if tonumber(constant) then
    value = tonumber(constant)
  else
    local calculateAttrFunc = assert(load("return " .. constant, "", "t", {
      Math = math,
      lv = param.lv
    }))
    value = calculateAttrFunc()
  end
  local checkForFixedpoint = fixedpoint(value)
  return value
end

function Utility.IsActiveSkill(useSkillEntity, skillId)
  local useSkillEntitySkillComponent = useSkillEntity:GetComponent(BattleECS.Components.SkillComponent)
  local skillInfo
  for _, v in ipairs(useSkillEntitySkillComponent._skillList) do
    if skillId == v.skillId then
      skillInfo = v
      break
    end
  end
  if skillInfo and skillInfo.activeSkillIndex then
    return true
  end
  return false
end

return Utility
