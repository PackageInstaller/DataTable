local PB = require("Common/PbHelper")
local buffLogic = require("Logic/BuffLogic")
local FH = require("Logic/HelpLogic")
local CombatDataRecorder = require("Logic/CombatDataRecorder")
local DEFINE = require("Logic/Define")
local SA = {}

local function getProbability(probabilityInfo, cardInfo)
  local probability = 0
  if probabilityInfo.isStaticOrBaseOnCardInfo == true then
    probability = probabilityInfo.staticProbability
  elseif cardInfo.isBigSkill == true then
    probability = probabilityInfo.bigSkillProbability
  elseif cardInfo.isLinkSkill == true then
    probability = probabilityInfo.linkProbability
  else
    local num = cardInfo.num
    if 0 < num and num <= #probabilityInfo.cardNumProbability then
      probability = probabilityInfo.cardNumProbability[num]
    else
      warning("GamePlay", "no probabilityInfo.cardNumProbability for card num: " .. num)
    end
  end
  return probability
end

local function calculateSourceValue(sourceValue, operations, operands)
  local calculatedSourceValue = sourceValue
  for i = 1, #operations do
    local operation = operations[i]
    local operand = operands[i]
    if operand ~= nil then
      if operation == "+" then
        calculatedSourceValue = calculatedSourceValue + operand
      elseif operation == "-" then
        calculatedSourceValue = calculatedSourceValue - operand
      elseif operation == "*" then
        calculatedSourceValue = calculatedSourceValue * operand
      elseif operation == "/" then
        calculatedSourceValue = calculatedSourceValue / operand
      elseif operation == "%" then
        calculatedSourceValue = calculatedSourceValue % operand
      else
        error("GamePlay", "calculateSourceValue has unsupported operation: " .. operation)
      end
    else
      error("GamePlay", "calculateSourceValue condition operands is nil")
    end
  end
  return calculatedSourceValue
end

local function checkValidBuffStack(checkBuffList, checkTypeOrCategory, checkId, childId)
  local num = 0
  for i = 1, #checkBuffList do
    if checkBuffList[i].state ~= PB.enum.BuffFightState.Delete then
      local buffData = FH.getBuffData(checkBuffList[i].buffKey.id, checkBuffList[i].buffKey.owner)
      if buffData then
        local child_match = true
        local child_type = 0
        if buffData.type == PB.enum.BuffFightType.AbHurt or buffData.type == PB.enum.BuffFightType.Attr then
          child_type = buffData.paramInt[1]
        end
        if child_type ~= 0 and childId ~= nil and childId ~= 0 and child_type ~= childId then
          child_match = false
        end
        if child_match then
          if checkTypeOrCategory then
            if checkId == -1 or buffData.type == checkId then
              num = num + checkBuffList[i].stack
            end
          elseif checkId == -1 or table.has(buffData.categoryList, checkId) then
            num = num + checkBuffList[i].stack
          end
        end
      else
        error("GamePlay", "getBuffData failed with id: " .. checkBuffList[i].buffKey.id .. ", and owner id: " .. checkBuffList[i].buffKey.owner)
      end
    end
  end
  return num
end

local function checkValidBuffNum(checkBuffList, checkTypeOrCategory, checkId)
  local num = 0
  for i = 1, #checkBuffList do
    if checkBuffList[i].state ~= PB.enum.BuffFightState.Delete then
      local buffData = FH.getBuffData(checkBuffList[i].buffKey.id, checkBuffList[i].buffKey.owner)
      if buffData then
        if checkTypeOrCategory then
          if checkId == -1 or buffData.type == checkId then
            num = num + 1
          end
        elseif checkId == -1 or table.has(buffData.categoryList, checkId) then
          num = num + 1
        end
      else
        error("GamePlay", "getBuffData failed with id: " .. checkBuffList[i].buffKey.id .. ", and owner id: " .. checkBuffList[i].buffKey.owner)
      end
    end
  end
  return num
end

local function checkCondition(owner, sourceObject, condition, teamList, timing, paramTable)
  local result = false
  local sourceValue
  if condition.type == PB.enum.SpecialAttrCondition.Hp then
    local curHp = sourceObject.dynamicAttrs[PB.enum.AttrType.Hp].value
    local maxHp = sourceObject.actorInfo.attrs[PB.enum.AttrType.Hp].value
    if 0 < maxHp then
      sourceValue = curHp / maxHp * 10000
    end
  elseif condition.type == PB.enum.SpecialAttrCondition.StackCount then
    sourceValue = checkValidBuffStack(sourceObject.buffList, condition.sourceExtraParam[1] == 1, condition.sourceExtraParam[2], condition.sourceExtraParam[3])
  elseif condition.type == PB.enum.SpecialAttrCondition.BuffNum then
    sourceValue = checkValidBuffNum(sourceObject.buffList, condition.sourceExtraParam[1] == 1, condition.sourceExtraParam[2])
  elseif condition.type == PB.enum.SpecialAttrCondition.Round then
    sourceValue = paramTable[1]
  elseif condition.type == PB.enum.SpecialAttrCondition.ActorNum then
    local sourceTeam = FH.getTeamActorsByAssist(teamList, sourceObject.team, false)
    sourceValue = #sourceTeam
  elseif condition.type == PB.enum.SpecialAttrCondition.Faction then
    if owner.team ~= sourceObject.team then
      sourceValue = 1
    end
  elseif condition.type == PB.enum.SpecialAttrCondition.Seat then
    sourceValue = sourceObject.seat
  elseif condition.type == PB.enum.SpecialAttrCondition.TotalHurtData then
    local totalHurtData = CombatDataRecorder.getHurtData(owner.uniqueID, sourceObject.uniqueID).totalHurtValue
    local maxHp = sourceObject.actorInfo.attrs[PB.enum.AttrType.Hp].value
    sourceValue = math.abs(totalHurtData) / maxHp * 10000
  elseif condition.type == PB.enum.SpecialAttrCondition.RoundBeHurtValue then
    if timing == PB.enum.Timing.FirstAttack or timing == PB.enum.Timing.EveryAttack or timing == PB.enum.Timing.FirstAttackAfter or timing == PB.enum.Timing.EveryAttackAfter then
      error("GamePlay", "Condition RoundBeHurtValue doesn't support timing FirstAttack or EveryAttack. Because the data is reset before ActionStart, and set after ActionEnd")
    end
    sourceValue = CombatDataRecorder.getBeHurtData(sourceObject.uniqueID).curRoundHurtValue
  elseif condition.type == PB.enum.SpecialAttrCondition.HitTargetNum then
    local checkEnemtyTeamOrSelfTeam = condition.sourceExtraParam[1] == 1
    if checkEnemtyTeamOrSelfTeam then
      sourceValue = paramTable[3]
    else
      sourceValue = paramTable[4]
    end
  elseif condition.type == PB.enum.SpecialAttrCondition.CastSkillSkipped then
    sourceValue = paramTable[5]
  elseif condition.type == PB.enum.SpecialAttrCondition.Mp then
    sourceValue = paramTable[6]
  elseif condition.type == PB.enum.SpecialAttrCondition.Sp then
    sourceValue = paramTable[7]
  elseif condition.type == PB.enum.SpecialAttrCondition.AddBuff then
    if paramTable and 0 < #paramTable.addBuffs then
      sourceValue = checkValidBuffNum(paramTable.addBuffs, condition.sourceExtraParam[1] == 1, condition.sourceExtraParam[2])
    end
  elseif condition.type == PB.enum.SpecialAttrCondition.RemoveBuff then
    if paramTable and 0 < #paramTable.removeBuffs then
      sourceValue = checkValidBuffNum(paramTable.removeBuffs, condition.sourceExtraParam[1] == 1, condition.sourceExtraParam[2])
    end
  elseif condition.type == PB.enum.SpecialAttrCondition.RefreshBuff then
    sourceValue = checkValidBuffNum(paramTable[9], condition.sourceExtraParam[1] == 1, condition.sourceExtraParam[2])
  elseif condition.type == PB.enum.SpecialAttrCondition.CostMp then
    sourceValue = paramTable[10]
  elseif condition.type == PB.enum.SpecialAttrCondition.CostSp then
    sourceValue = paramTable[11]
  elseif condition.type == PB.enum.SpecialAttrCondition.HurtVal then
    sourceValue = paramTable[12]
  elseif condition.type == PB.enum.SpecialAttrCondition.IsCritical then
    sourceValue = paramTable[13]
  else
    error("GamePlay", "Invalid condition.type: " .. condition.type)
  end
  if sourceValue ~= nil then
    local calculatedSourceValue = calculateSourceValue(sourceValue, condition.sourceOperation, condition.sourceOperand)
    result = FH.compareValue(calculatedSourceValue, condition.targetValue, condition.operation)
  end
  return result
end

local function isConditionSourceIdentityValid(timing, identityCategory)
  local isValid = true
  if timing == PB.enum.Timing.Die then
    if identityCategory == PB.enum.IdentityCategory.Targets then
      isValid = false
    end
  elseif timing == PB.enum.Timing.RoundNumberChange or timing == PB.enum.Timing.RoundNumberChangeFront then
    if identityCategory == PB.enum.IdentityCategory.Targets then
      isValid = false
    end
  elseif timing == PB.enum.Timing.RoundTeamStart and identityCategory == PB.enum.IdentityCategory.Targets then
    isValid = false
  end
  return isValid
end

local function isTargetIdentityValid(timing, identityCategory)
  local isValid = true
  isValid = identityCategory ~= PB.enum.IdentityCategory.Target and isConditionSourceIdentityValid(timing, identityCategory)
  return isValid
end

local function isConditionsVerified(owner, buffTarget, participantList, teamList, timing, specialAttrInfo, paramTable)
  local result = true
  local match_count = 0
  local hasCastSkillSkippedCondition = false
  for i = 1, #specialAttrInfo.conditions do
    local condition = specialAttrInfo.conditions[i]
    if condition.type == PB.enum.SpecialAttrCondition.CastSkillSkipped then
      hasCastSkillSkippedCondition = true
      break
    end
  end
  local needCheckCastSkillSkippedCondition = paramTable[5] ~= nil
  if needCheckCastSkillSkippedCondition and not hasCastSkillSkippedCondition then
    local castSkillSkipped = paramTable[5] == true
    if castSkillSkipped then
      warning("GamePlay", "this Timing requires to check CastSkillSkipped, so condition failed due to CastSkillSkippedCondition is not set and it's counted as False by default")
      return {false, 0}
    end
  end
  for i = 1, #specialAttrInfo.conditions do
    local isConditionVerified = false
    local condition = specialAttrInfo.conditions[i]
    if not isConditionSourceIdentityValid(timing, condition.sourceIdentityCategory) then
      error("GamePlay", "Condition SourceIdentityCategory[" .. condition.sourceIdentityCategory .. "] is INVALID in timing[" .. timing .. "].")
      return {false, 0}
    end
    local sourceObjects
    if condition.sourceIdentityCategory == PB.enum.IdentityCategory.Target then
      sourceObjects = {buffTarget}
    elseif condition.sourceIdentityCategory == PB.enum.IdentityCategory.Targets then
      sourceObjects = participantList
    elseif condition.sourceIdentityCategory == PB.enum.IdentityCategory.WeaponUser then
      sourceObjects = {
        paramTable.weaponUser
      }
    else
      local targetInfo = {
        identityCategory = condition.sourceIdentityCategory,
        kind = condition.sourceAttackType,
        isAll = condition.sourceIsAllOrOne
      }
      sourceObjects = FH.getActorsByIdentityCategory(targetInfo, owner, teamList)
    end
    for i = 1, #sourceObjects do
      if checkCondition(owner, sourceObjects[i], condition, teamList, timing, paramTable) == true then
        isConditionVerified = true
        if condition.sourceAttackType == 4 then
          match_count = match_count + 1
        else
          break
        end
      end
    end
    if isConditionVerified == false then
      result = false
      break
    end
  end
  return {result, match_count}
end

local function isOwnerIdentityCategoryValid(timing, identityCategory)
  local isValid = true
  isValid = identityCategory ~= PB.enum.IdentityCategory.Target
  if isValid then
    if timing == PB.enum.Timing.ActionStart then
      if identityCategory == PB.enum.IdentityCategory.Targets or identityCategory == PB.enum.IdentityCategory.SelfTeam or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif timing == PB.enum.Timing.ActionEnd then
      if identityCategory == PB.enum.IdentityCategory.Targets then
        isValid = false
      end
    elseif timing == PB.enum.Timing.FirstAttack or timing == PB.enum.Timing.FirstAttackAfter then
      if identityCategory == PB.enum.IdentityCategory.SelfTeam or identityCategory == PB.enum.IdentityCategory.TargetTeam or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif timing == PB.enum.Timing.EveryAttack or timing == PB.enum.Timing.EveryAttackAfter then
      if identityCategory == PB.enum.IdentityCategory.Targets or identityCategory == PB.enum.IdentityCategory.SelfTeam or identityCategory == PB.enum.IdentityCategory.TargetTeam or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif timing == PB.enum.Timing.Die then
      if identityCategory == PB.enum.IdentityCategory.Targets or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif timing == PB.enum.Timing.RoundNumberChange or timing == PB.enum.Timing.RoundNumberChangeFront then
      if identityCategory == PB.enum.IdentityCategory.Self or identityCategory == PB.enum.IdentityCategory.Targets or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif timing == PB.enum.Timing.RoundTeamStart then
      if identityCategory == PB.enum.IdentityCategory.Self or identityCategory == PB.enum.IdentityCategory.Targets or identityCategory == PB.enum.IdentityCategory.TargetTeam or identityCategory == PB.enum.IdentityCategory.AllTeam then
        isValid = false
      end
    elseif (timing == PB.enum.Timing.BuffChange or timing == PB.enum.Timing.BuffRefresh) and (identityCategory == PB.enum.IdentityCategory.SelfTeam or identityCategory == PB.enum.IdentityCategory.TargetTeam or identityCategory == PB.enum.IdentityCategory.AllTeam) then
      isValid = false
    end
  end
  return isValid
end

local function isParamValid(specialAttrInfo)
  if specialAttrInfo == nil or specialAttrInfo.timing == PB.enum.Timing.Always then
    return false
  end
  local result = false
  local ownerIdCategory = specialAttrInfo.ownerIdentityCategory
  local targetIdCategory = specialAttrInfo.targetIdentityCategory
  local timing = specialAttrInfo.timing
  result = isOwnerIdentityCategoryValid(timing, ownerIdCategory) and isTargetIdentityValid(timing, targetIdCategory)
  if result == false then
    error("GamePlay", "ownerIdCategory[" .. ownerIdCategory .. "] or [targetIdCategory[" .. targetIdCategory .. "] is INVALID in timing[" .. timing .. "].")
  end
  return result
end

local function isOwnerIdentityMatched(curOwnerId, configOwnerId)
  local isMatched = false
  if curOwnerId == configOwnerId then
    isMatched = true
  elseif configOwnerId == PB.enum.IdentityCategory.AllTeam and (curOwnerId == PB.enum.IdentityCategory.SelfTeam or curOwnerId == PB.enum.IdentityCategory.TargetTeam) then
    isMatched = true
  end
  return isMatched
end

function SA.handlerContinuesTrigger(specialIndex, specialLevel, teamList, attack, params)
  for i = 1, #attack.buffList do
    if attack.buffList[i].isNewHit then
      local buff = attack.buffList[i]
      local buffData = PB.get("BuffData", buff.buffKey.id, buff.buffKey.owner)
      if buffData.type == PB.enum.BuffFightType.HpImmeChangeMulti then
        local identityCategory = {
          identityCategory = buffData.paramInt[5],
          kind = PB.enum.KindForAppendSpecialAttrInfo.Main,
          isAll = true
        }
        local identityTargets = FH.getActorsByIdentityCategory(identityCategory, attack, teamList)
        for i = 1, #identityTargets do
          buffLogic(specialIndex, specialLevel, teamList, attack, identityTargets[i], params)
        end
      end
    end
  end
end

local function parseSpecialAttr(owner, ownerIdentityCategory, participantList, teamList, timing, paramTable, specialIndex, specialLevel, specialFlag, specialIndex2)
  specialFlag = specialFlag or DEFINE.TalentFlagDEF.Common
  specialIndex2 = specialIndex2 or 0
  local result = {}
  local info = PB.get("SpecialAttrInfo", specialIndex)
  local shouldBlendAllActors = false
  if info == nil then
    error("GamePlay", "Cannot get SpecialAttrInfo from specialIndex: " .. specialIndex)
  end
  if not isParamValid(info) then
    return result, shouldBlendAllActors
  end
  if timing == info.timing and isOwnerIdentityMatched(ownerIdentityCategory, info.ownerIdentityCategory) then
    local probabilityInfo = info.probabilityInfo
    if probabilityInfo == nil then
      error("Gameplay", "probabilityInfo is null for specialIndex: " .. specialIndex)
      return result, shouldBlendAllActors
    end
    local probability = getProbability(probabilityInfo, paramTable[2])
    if probabilityInfo.checkOnceOrEach == true and FH.isRandomChanceMet(probability) or probabilityInfo.checkOnceOrEach == false then
      local buffTargets = {}
      local buffLogicParams = {
        paramTable[1],
        specialFlag,
        specialIndex2
      }
      if DEFINE.IsWeapon(owner) then
        buffLogicParams.weaponUser = paramTable.weaponUser
        buffLogicParams.userUniqueId = paramTable.weaponUser.uniqueID
      end
      if info.targetIdentityCategory == PB.enum.IdentityCategory.Targets then
        buffTargets = participantList
      elseif info.targetIdentityCategory == PB.enum.IdentityCategory.WeaponUser then
        buffTargets = {
          paramTable.weaponUser
        }
      else
        local identityCategory = {
          identityCategory = info.targetIdentityCategory,
          kind = info.targetAttackType,
          isAll = info.targetIsAllOrOne
        }
        buffTargets = FH.getActorsByIdentityCategory(identityCategory, owner, teamList)
      end
      for i = 1, #buffTargets do
        local target = buffTargets[i]
        if probabilityInfo.checkOnceOrEach == true or probabilityInfo.checkOnceOrEach == false and FH.isRandomChanceMet(probability) then
          local condition_result = isConditionsVerified(owner, target, participantList, teamList, timing, info, paramTable)
          if condition_result[1] then
            local add_count = 1
            if condition_result[2] ~= nil and 0 < condition_result[2] then
              add_count = condition_result[2]
            end
            for k = 1, add_count do
              buffLogicParams.isContinues = false
              local p1, p2 = buffLogic(specialIndex, specialLevel, teamList, owner, target, buffLogicParams)
              result[target.uniqueID] = p1
              if p2 then
                buffLogicParams.isContinues = true
                SA.handlerContinuesTrigger(specialIndex, specialLevel, teamList, target, buffLogicParams)
                shouldBlendAllActors = true
              end
            end
          end
        end
      end
    end
  end
  for i = 1, #info.childSpecialAttrInfoId do
    local childId = info.childSpecialAttrInfoId[i]
    FH.blendActorBuff(result, parseSpecialAttr(owner, ownerIdentityCategory, participantList, teamList, timing, paramTable, childId, specialLevel, specialFlag, specialIndex2))
  end
  return result, shouldBlendAllActors
end

function SA.SpecialAttrLogic(owner, ownerIdentityCategory, participantList, teamList, timing, paramTable)
  local comboInfo = paramTable[14]
  local compareValue
  local shouldBlendAllActors = false
  if comboInfo and (comboInfo.skillList or comboInfo.link or comboInfo[1]) then
    if comboInfo.skillList then
      compareValue = comboInfo.skillList
    elseif comboInfo.link then
      compareValue = {}
      for l = 1, #comboInfo.link do
        table.insert(compareValue, comboInfo.link[l].skillID)
      end
    else
      compareValue = comboInfo
    end
  end
  local result = {}
  local talent_table = owner.dynamicTalent
  for i = 1, #talent_table do
    local talent = talent_table[i]
    local source = talent.talentSource
    local enable_parse = true
    if source and not table.empty(source) then
      if compareValue ~= nil then
        for j = 1, #compareValue do
          if compareValue[j] ~= source[j] then
            enable_parse = false
          end
        end
      else
        enable_parse = false
      end
    end
    if enable_parse then
      local p1, p2 = parseSpecialAttr(owner, ownerIdentityCategory, participantList, teamList, timing, paramTable, talent.talentId, talent.talentValue, talent.talentFlag, talent.talentIndex)
      FH.blendActorBuff(result, p1)
      shouldBlendAllActors = shouldBlendAllActors or p2
    end
  end
  return result, shouldBlendAllActors
end

function SA.TriggerEachSpecialAttr(triggerInfo, teamList, paramTable)
  for i = 1, #triggerInfo do
    local info = triggerInfo[i]
    local buffData = FH.getBuffData(info.buff.buffKey.id, info.buff.buffKey.owner)
    local talent = {
      talentId = buffData.paramInt[1],
      talentValue = info.buff.val,
      talentFlag = info.buff.talentFlag
    }
    parseSpecialAttr(info.target, PB.enum.IdentityCategory.Self, {
      info.attack
    }, teamList, PB.enum.Timing.TriggerSingleSpecial, paramTable, talent.talentId, talent.talentValue, talent.talentFlag)
  end
end

function SA.SpecialRoundNumberChange(teamList, activeTeam, actionParam, dungeonType)
  local otherTeam = 1
  if activeTeam == 1 then
    otherTeam = 2
  end
  local targetList1 = FH.getTeamActors(teamList, activeTeam)
  local activeTeamInfo1 = FH.getTeamInfo(teamList, activeTeam)
  for i = 1, #targetList1 do
    local energyVal = FH.getCurEnergy(activeTeamInfo1, dungeonType, targetList1[i].uniqueID)
    actionParam[6] = energyVal[1]
    actionParam[7] = energyVal[2]
    SA.SpecialAttrLogic(targetList1[i], PB.enum.IdentityCategory.SelfTeam, {}, teamList, PB.enum.Timing.RoundNumberChange, actionParam)
    SA.SpecialAttrLogic(targetList1[i], PB.enum.IdentityCategory.TargetTeam, {}, teamList, PB.enum.Timing.RoundNumberChange, actionParam)
  end
  local targetList2 = FH.getTeamActors(teamList, otherTeam)
  local otherTeamInfo2 = FH.getTeamInfo(teamList, otherTeam)
  for i = 1, #targetList2 do
    local energyVal = FH.getCurEnergy(otherTeamInfo2, dungeonType, targetList2[i].uniqueID)
    actionParam[6] = energyVal[1]
    actionParam[7] = energyVal[2]
    SA.SpecialAttrLogic(targetList2[i], PB.enum.IdentityCategory.SelfTeam, {}, teamList, PB.enum.Timing.RoundNumberChange, actionParam)
    SA.SpecialAttrLogic(targetList2[i], PB.enum.IdentityCategory.TargetTeam, {}, teamList, PB.enum.Timing.RoundNumberChange, actionParam)
  end
end

return SA
