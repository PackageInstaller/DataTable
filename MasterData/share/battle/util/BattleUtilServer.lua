local bc = require("Battle.BattleConst")
local HUNDRED = 100
local BattleUtilServer = {}

function BattleUtilServer.ParseVariableCost(cfgCost)
  if type(cfgCost) ~= "string" then
    return bc.VariableCostMode.None, nil
  end
  if "X" == cfgCost then
    return bc.VariableCostMode.BurnAll, nil
  end
  local limitText = string.match(cfgCost, "^X(%d+)$")
  if limitText then
    return bc.VariableCostMode.Limit, tonumber(limitText)
  end
  return bc.VariableCostMode.None, nil
end

function BattleUtilServer.IsVariableCostCfg(cfgCost)
  local mode = BattleUtilServer.ParseVariableCost(cfgCost)
  return mode ~= bc.VariableCostMode.None
end

function BattleUtilServer.GetSpineAnimDuration(DT, spineFileName, animName)
  local spineData = DT.SpineEventData[spineFileName]
  if not spineData then
    return nil
  end
  local animData = spineData[animName]
  if not animData then
    return nil
  end
  return animData.duration
end

function BattleUtilServer.GetSpineEventList(DT, spineFileName, animName)
  local spineData = DT.SpineEventData[spineFileName]
  if not spineData then
    return nil
  end
  local animData = spineData[animName]
  if not animData then
    return nil
  end
  return animData.eventList
end

function BattleUtilServer.GetTimelineTime(DT, animFile, animName)
  local actorTimelineData = DT.TimelineEventData[animFile]
  if not actorTimelineData then
    return nil
  end
  local timelineData = actorTimelineData[animName]
  return timelineData.duration, timelineData.castTime
end

function BattleUtilServer.IsExclusiveCard(DT, cardConfigId)
  local cardConfig = DT.Item[cardConfigId]
  return cardConfig.ActorID ~= nil
end

function BattleUtilServer.GetActorIdOfExclusiveCard(DT, cardConfigId)
  local cardConfig = DT.Item[cardConfigId]
  return cardConfig.ActorID
end

function BattleUtilServer.GetRandomNNum(battleEngine, m, n)
  local list = {}
  for i = 1, m do
    table.insert(list, i)
  end
  if m <= n then
    n = m
  end
  local rand = battleEngine.rand
  for i = 1, n do
    local ri = rand:random(i, #list)
    local tmp = list[i]
    list[i] = list[ri]
    list[ri] = tmp
  end
  if m > n then
    for i = m, n + 1, -1 do
      table.remove(list, i)
    end
  end
  return list
end

function BattleUtilServer.GetTQList(tqList, breakSkillLevel, potencyLevel)
  if not tqList then
    return
  end
  local k, v = table.next(tqList)
  if not v or "table" ~= type(v) then
    do return table.clone end
    return table.clone, tqList, nil, nil
  end
  local matchKey = BattleUtilServer.GetMatchTQ(tqList, breakSkillLevel, potencyLevel)
  return tqList[matchKey] and table.clone(tqList[matchKey])
end

function BattleUtilServer.GetTQText(tqText, breakSkillLevel, potencyLevel)
  if not tqText then
    return
  end
  if type(tqText) ~= "table" then
    return tqText
  end
  local matchKey = BattleUtilServer.GetMatchTQ(tqText, breakSkillLevel, potencyLevel)
  return tqText[matchKey]
end

function BattleUtilServer.GetMatchTQ(tqConfig, breakSkillLevel, potencyLevel)
  local matchBT, matchPT = 0, 0
  for k, _ in pairs(tqConfig) do
    local needBT = k // bc.BREAKTHROUGH_AND_POTENCY_CONST
    local needPT = k % bc.BREAKTHROUGH_AND_POTENCY_CONST
    if breakSkillLevel >= needBT and matchBT < needBT then
      matchBT = needBT
    end
    if potencyLevel >= needPT and matchPT < needPT then
      matchPT = needPT
    end
  end
  return matchBT * bc.BREAKTHROUGH_AND_POTENCY_CONST + matchPT
end

BattleUtilServer.MonsterDataFormula = {
  [bc.BattleProperty.hp] = "MonsterHpFormula",
  [bc.BattleProperty.atk] = "MonsterAtkFormula",
  [bc.BattleProperty.def] = "MonsterDefFormula",
  level = "MonsterLvFormula"
}

function BattleUtilServer.__GetFormulaVariables(key)
  if "StandardHp" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.stageConfig.StandardHp, nil, nil
  end
  if "StandardAtk" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.stageConfig.StandardAtk, nil, nil
  end
  if "StandardTurn" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.stageConfig.StandardTurn, nil, nil
  end
  if "StandardDef" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.stageConfig.StandardDef, nil, nil
  end
  if "StandardLevel" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.stageConfig.StandardLv, nil, nil
  end
  if "MonsterProportion" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.monsterConfig.MonsterProportion, nil, nil
  end
  if "MonsterHpPercent" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.monsterConfig.MonsterHpPercent, nil, nil
  end
  if "MonsterDefPercent" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.monsterConfig.MonsterDefPercent, nil, nil
  end
  if "MonsterAtkPercent" == key then
    do return tonumber end
    return tonumber, BattleUtilServer.monsterConfig.MonsterAtkPercent, nil, nil
  end
  assert(false, key .. "找不到")
end

function BattleUtilServer.GetMonsterDataValue(battleEngine, dataName, monsterConfig, stageConfig)
  local DT = battleEngine.battleDT
  local name = BattleUtilServer.MonsterDataFormula[dataName]
  local formula = DT.GetConstant(name)
  BattleUtilServer.monsterConfig = monsterConfig
  BattleUtilServer.stageConfig = stageConfig
  if not formula then
    return 0
  end
  local mt = {
    __index = function(_, key)
      if _G[key] then
        return _G[key]
      end
      do return BattleUtilServer.__GetFormulaVariables end
      return BattleUtilServer.__GetFormulaVariables, key
    end
  }
  local env = {}
  setmetatable(env, mt)
  local func = battleEngine:GetCmdFunc(formula, env)
  local ret, v = xpcall(func, debug.traceback)
  if not ret then
    return 0
  end
  do return math.max, 1, math.ceil(v) end
  return math.max, 1, math.ceil(v)
end

function BattleUtilServer.GetStageColByDifficulty(DT, stageId, difficultyId, colName)
  local cfg
  if difficultyId and difficultyId > 0 then
    cfg = DT.StageDifficulty[difficultyId]
  else
    cfg = DT.Stage[stageId]
  end
  return cfg[colName]
end

function BattleUtilServer.GetStageMonsterData(DT, stageId, difficultyId, battleTag, mapNodeGroupId)
  local stageMonsterDataId = BattleUtilServer.GetStageColByDifficulty(DT, stageId, difficultyId, "StageMonsterData")
  local standardConfig
  if stageMonsterDataId then
    standardConfig = DT.StageMonsterData[stageMonsterDataId]
  else
    if difficultyId and difficultyId > 0 then
      standardConfig = DT.StageMonsterData[difficultyId]
    end
    standardConfig = standardConfig or DT.StageMonsterData[stageId]
  end
  if standardConfig and standardConfig.data_list then
    for _, cfg in ipairs(standardConfig.data_list) do
      if cfg.BattleTag == battleTag then
        return cfg
      end
    end
  end
  if mapNodeGroupId and mapNodeGroupId > 0 then
    local groupCfg = DT.MapNodeGroup[mapNodeGroupId]
    if groupCfg and groupCfg.CustomMonsterData and groupCfg.CustomMonsterData > 0 then
      local customMonsterDataId = groupCfg.CustomMonsterData
      local customConfig = DT.StageMonsterData[customMonsterDataId]
      if customConfig and customConfig.data_list then
        for _, cfg in ipairs(customConfig.data_list) do
          if cfg.BattleTag == battleTag then
            return cfg
          end
        end
      end
    end
  end
end

function BattleUtilServer.KeepXDecimal(num, keepNum)
  local t = math.modf(1 ^ (keepNum or 2) * 100)
  return math.ceil(num * t) / t
end

function BattleUtilServer.Shuffle(battleEngine, list)
  local rand = battleEngine.rand
  for index = 1, #list do
    local targetIndex = rand:random(1, #list)
    local temp = list[index]
    list[index] = list[targetIndex]
    list[targetIndex] = temp
  end
end

function BattleUtilServer.MoveEnchantToEnd(cardList)
  local len = #cardList
  local findCount = 0
  for index = 1, len do
    local newIndex = index - findCount
    local card = cardList[newIndex]
    if card.data.runes and card.data.runes[1] then
      local endIndex = len - findCount
      findCount = findCount + 1
      cardList[newIndex], cardList[endIndex] = cardList[endIndex], cardList[newIndex]
    end
  end
end

function BattleUtilServer.MoveNoEnchantToEnd(cardList)
  local len = #cardList
  local findCount = 0
  for index = 1, len do
    local newIndex = index - findCount
    local card = cardList[newIndex]
    if not card.data.runes or not next(card.data.runes) then
      local endIndex = len - findCount
      findCount = findCount + 1
      cardList[newIndex], cardList[endIndex] = cardList[endIndex], cardList[newIndex]
    end
  end
end

function BattleUtilServer.MoveCost0ToEnd(cardList)
  local len = #cardList
  local findCount = 0
  for index = 1, len do
    local newIndex = index - findCount
    local card = cardList[newIndex]
    if 0 == card:GetCurCost() or card:IsXCost() then
      local endIndex = len - findCount
      cardList[newIndex], cardList[endIndex] = cardList[endIndex], cardList[newIndex]
      findCount = findCount + 1
    end
  end
end

function BattleUtilServer.IsFightBackState(battleEngine, stateId)
  if not stateId then
    return false
  end
  local DT = battleEngine.battleDT
  local states = DT.GetOriginalConstant("StrikeBackStateType")
  if states and next(states) then
    for _, state in ipairs(states) do
      if state == stateId then
        return true
      end
    end
  end
  return false
end

BattleUtilServer.FLOAT_ERROR = 1.0E-5

function BattleUtilServer.GetBattleApiMarkerData(battleApiTable, markerKey, defaultValue)
  local apiCfg = battleApiTable and battleApiTable[markerKey]
  if not apiCfg or apiCfg.Data == nil then
    return defaultValue
  end
  local markerData = apiCfg.Data
  if type(markerData) == "number" then
    return markerData
  end
  if type(markerData) == "string" then
    local evalFunc = load("return " .. markerData)
    if evalFunc then
      local isOk, evalResult = pcall(evalFunc)
      if isOk and type(evalResult) == "number" then
        return evalResult
      end
    end
  end
  return defaultValue
end

function BattleUtilServer.CalKeeperskillAtkPer(occupationMasterFinal, battleApiTable)
  local inspect = BattleUtilServer.GetBattleApiMarkerData(battleApiTable, "keeperskill_atk_per_inspect", 20)
  local slope = BattleUtilServer.GetBattleApiMarkerData(battleApiTable, "keeperskill_atk_per_slope", 0.1)
  return occupationMasterFinal * slope + inspect
end

function BattleUtilServer.CalKeeperskillDefPer(occupationMasterFinal, battleApiTable)
  local inspect = BattleUtilServer.GetBattleApiMarkerData(battleApiTable, "keeperskill_def_per_inspect", 20)
  local slope = BattleUtilServer.GetBattleApiMarkerData(battleApiTable, "keeperskill_def_per_slope", 0.05)
  return occupationMasterFinal * slope + inspect
end

function BattleUtilServer.GetNewChaosAtkMultiplier(keeperskillAtkPer, is_chaos_type2)
  if not is_chaos_type2 or 0 == is_chaos_type2 then
    return 1
  end
  local atkPer = keeperskillAtkPer or 0
  if 0 == atkPer then
    return 1
  end
  return 1 + atkPer / HUNDRED * is_chaos_type2
end

function BattleUtilServer.GetNewChaosDefMultiplier(keeperskillDefPer, is_chaos_type2)
  if not is_chaos_type2 or 0 == is_chaos_type2 then
    return 1
  end
  local defPer = keeperskillDefPer or 0
  if 0 == defPer then
    return 1
  end
  return 1 + defPer / HUNDRED * is_chaos_type2
end

function BattleUtilServer.ShowDamageFormula(data)
  local env = setmetatable({}, {
    __index = function(_, key)
      return data[key] or 0
    end
  })
  local damagePlus = env.cardDamagePlus + env.strength + env.ultiDamgePlus + env.strikecard_damage_plus + env.skillArgsPlus + env.awakerDamagePlus
  local curDamage = math.max(math.ceil((env.value * (100 + env.awakerOutsideDamagePer) * (100 + env.awakerInsideBasicDamagePer) * (100 + env.playerOutsideDamagePer) * (100 + env.cardOutsideDmgPer) * (100 + env.curCardDamagePer) * (100 + env.basicDamagePer) * env.skillTypeOutsideDmgPer * env.skillTypeDmgPer / 1000000000000 + damagePlus) * (100 + env.roleEnhancePer) / 100 * (1 - env.roleWeakPer / 100) * 10000 * (1 + env.awakerInsideDamagePer / 100) * (1 + env.awakerInsideDamagePer1 / 100) * (1 + env.awakerInsideDamagePer2 / 100) * (1 + env.awakerInsideDamagePer3 / 100) * (1 + env.awakerInsideDamagePer4 / 100) * (1 + env.awakerInsideDamagePer5 / 100) * (1 + env.awakerInsideDamagePer6 / 100) * (1 + env.awakerInsideDamagePer7 / 100) * (1 + env.awakerInsideDamagePer8 / 100) * (1 + env.playerInsideDamagePer / 100) * (1 + env.dimension_fix_per / 100) * (1 + env.cardInsideDmgPer / 100) * (1 + env.cardDamagePer2 / 100) * (1 + env.cardDamagePer3 / 100 + (env.card_damage_per3_n2 or 0) / 100) * (1 + env.awaker_CmdCard_dmg_per / 100) * (1 + env.awaker_ulti_dmg_per / 100) * env.skillTypeInsideDmgPer / 10000 - BattleUtilServer.FLOAT_ERROR), 1)
  local spellboundDmgPer = 1 * (1 - env.spellboundDmgPer / HUNDRED) * (1 - env.spellboundDmgPer2 / HUNDRED) * (1 - env.spellboundDmgPer3 / HUNDRED) * (1 - env.spellboundDmgPer4 / HUNDRED) * (1 - env.spellboundDmgPer5 / HUNDRED)
  curDamage = math.max(math.floor(curDamage * 10000 * spellboundDmgPer / 10000 + BattleUtilServer.FLOAT_ERROR), 1)
  local baseDamage = math.max(math.ceil(env.value * 10000 * (1 + env.awakerOutsideDamagePer / 100) * (1 + env.awakerInsideBasicDamagePer / 100) * (1 + env.playerOutsideDamagePer / 100) * env.skillTypeOutsideDmgPer * (1 + env.cardOutsideDmgPer / 100) * (1 + env.curCardDamagePer / 100) * (1 + env.basicDamagePer / 100) * env.skillTypeDmgPer / 10000 - BattleUtilServer.FLOAT_ERROR), 1)
  return curDamage, baseDamage
end

function BattleUtilServer.ShowHealFormula(data)
  local env = setmetatable({}, {
    __index = function(_, key)
      return data[key] or 0
    end
  })
  local curHeal = math.max(math.ceil((env.value * (100 + env.awakerOutsideHealPer) * (100 + env.playerOutsideHealPer) * (100 + env.curCardHealPer) * (100 + env.cardOutsideHealPer) * env.skillTypeHealPer / 100000000 + (env.awakerHealPlus + env.cardHealPlus + env.skillArgsPlus)) * (100 - env.dying_per) * (100 - env.dying_per2) * (100 + env.awakerInsideHealPer) * (100 + env.dimension_fix_per) * (100 + env.playerInsideHealPer) * (100 + env.cardInsideHealPer) * (100 + env.allDealHealPer) * (1 + env.cardHealPer2 / 100 + (env.card_heal_per2_n2 or 0) / 100) * (1 + env.awaker_CmdCard_heal_per / 100) * (1 + env.awaker_ulti_heal_per / 100) * env.skillTypeInsideHealPer / 100000000000000 - BattleUtilServer.FLOAT_ERROR), 1)
  local spellboundHealPer = 1 * (1 - env.spellboundHealPer / HUNDRED) * (1 - env.spellboundHealPer2 / HUNDRED) * (1 - env.spellboundHealPer3 / HUNDRED) * (1 - env.spellboundHealPer4 / HUNDRED) * (1 - env.spellboundHealPer5 / HUNDRED)
  local newChaosDefMultiplier = BattleUtilServer.GetNewChaosDefMultiplier(env.keeperskill_def_per, env.is_chaos_type2)
  curHeal = math.max(math.floor(curHeal * 10000 * spellboundHealPer * newChaosDefMultiplier / 10000 + BattleUtilServer.FLOAT_ERROR), 1)
  return curHeal, env.value
end

function BattleUtilServer.ShowBlockFormula(data)
  local env = setmetatable({}, {
    __index = function(_, key)
      return data[key] or 0
    end
  })
  local curBlock = math.max(math.ceil((env.value * (100 + env.awakerOutsideBlockPer) * (100 + env.playerOutsideBlockPer) * (100 + env.curCardBlockPer) * (100 + env.cardBlockPer) * (100 + env.ultiBlockPer) * env.skillTypeBlockPer / 10000000000 + (env.awakerBlockPlus + env.cardBlockPlus + env.skillArgsPlus)) * (1 - env.awakerFrailPer / 100) * (100 + env.awakerInsideBlockPer) * (100 + env.playerInsideBlockPer) * (100 + env.instructcardFinalBlockPer) * (100 + env.dimension_fix_per) * env.skillTypeInsideBlockPer * (1 + env.cardBlockPer2 / 100 + (env.card_block_per2_n2 or 0) / 100) * (1 + env.awaker_CmdCard_block_per / 100) * (1 + env.awaker_ulti_block_per / 100) / 100000000 - BattleUtilServer.FLOAT_ERROR), 1)
  local spellboundBlockPer = 1 * (1 - env.spellboundBlockPer / HUNDRED) * (1 - env.spellboundBlockPer2 / HUNDRED) * (1 - env.spellboundBlockPer3 / HUNDRED) * (1 - env.spellboundBlockPer4 / HUNDRED) * (1 - env.spellboundBlockPer5 / HUNDRED)
  local newChaosDefMultiplier = BattleUtilServer.GetNewChaosDefMultiplier(env.keeperskill_def_per, env.is_chaos_type2)
  curBlock = math.max(math.floor(curBlock * 10000 * spellboundBlockPer * newChaosDefMultiplier / 10000 + BattleUtilServer.FLOAT_ERROR), 1)
  local baseBlock = math.max(math.ceil(env.value * (100 + env.awakerOutsideBlockPer) * (100 + env.playerOutsideBlockPer) * (100 + env.curCardBlockPer) * (100 + env.cardBlockPer) * (100 + env.ultiBlockPer) * env.skillTypeBlockPer / 10000000000 - BattleUtilServer.FLOAT_ERROR), 1)
  return curBlock, baseBlock
end

function BattleUtilServer.AttackTimesFormula(data)
  local env = setmetatable({}, {
    __index = function(_, key)
      return data[key] or 0
    end
  })
  local curTimes = math.max(math.ceil(env.value * 10000 * (1 + env.damagetimes_per / 100) / 10000 - BattleUtilServer.FLOAT_ERROR + env.damagetimes_plus), 1)
  return curTimes, env.value
end

function BattleUtilServer.PoisonFormula(env)
  local newChaosAtkMultiplier = 1
  if env.skipNewChaosKeeperskill ~= true then
    newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  end
  local curValue = math.ceil(env.value * 10000 * (1 + env.state_layer_per_posion / 100) * (1 + env.i_state_layer_per_posion / 100) * (1 + env.fix_state_layer_per_posion / 100) * (1 + (env.card_fixed_state_layer_per_poison or 0) / 100 + (env.card_fixed_state_layer_per_poison_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_fixed_state_layer_per_poison or 0) / 100) * (1 + (env.awaker_ulti_fixed_state_layer_per_poison or 0) / 100) * (1 + (env.card_state_layer_per_poison or 0) / 100) * (1 + (env.awaker_CmdCard_state_layer_per_poison or 0) / 100) * (1 + (env.awaker_ulti_state_layer_per_poison or 0) / 100) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.CorrosionFormula(env)
  local newChaosAtkMultiplier = 1
  if env.skipNewChaosKeeperskill ~= true then
    newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  end
  local curValue = math.ceil(env.value * 10000 * (1 + (env.basic_state_layer_per_corrosion or 0) / HUNDRED) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.CounterattackFormula(env)
  local newChaosAtkMultiplier = 1
  if env.skipNewChaosKeeperskill ~= true then
    newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  end
  local curValue = math.ceil(env.value * 10000 * (1 + env.state_layer_per_counterattack / 100) * (1 + env.i_state_layer_per_counterattack / 100) * (1 + (env.card_fixed_state_layer_per_counterattack or 0) / 100 + (env.card_fixed_state_layer_per_counterattack_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_fixed_state_layer_per_counterattack or 0) / 100) * (1 + (env.awaker_ulti_fixed_state_layer_per_counterattack or 0) / 100) * (1 + (env.card_state_layer_per_counterattack or 0) / 100) * (1 + (env.awaker_CmdCard_state_layer_per_counterattack or 0) / 100) * (1 + (env.awaker_ulti_state_layer_per_counterattack or 0) / 100) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.BleedFormula(env)
  local newChaosAtkMultiplier = 1
  if env.skipNewChaosKeeperskill ~= true then
    newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  end
  local curValue = math.ceil(env.value * 10000 * (1 + env.state_layer_per_bleeding / 100) * (1 + env.i_state_layer_per_bleeding / 100) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.CutFormula(env)
  local newChaosAtkMultiplier = 1
  if env.skipNewChaosKeeperskill ~= true then
    newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  end
  local curValue = math.ceil(env.value * 10000 * (1 + (env.card_fixed_state_layer_per_fatecut or 0) / 100 + (env.card_fixed_state_layer_per_fatecut_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_fixed_state_layer_per_fatecut or 0) / 100) * (1 + (env.awaker_ulti_fixed_state_layer_per_fatecut or 0) / 100) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.ExhaustionFormula(env)
  local newChaosDefMultiplier = BattleUtilServer.GetNewChaosDefMultiplier(env.keeperskill_def_per, env.is_chaos_type2)
  local curValue = math.ceil(env.value * 10000 * (1 + env.i_state_layer_per_exhaustion / 100) * (1 + (env.card_state_layer_per_exhaustion or 0) / 100 + (env.card_state_layer_per_exhaustion_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_state_layer_per_exhaustion or 0) / 100) * (1 + (env.awaker_ulti_state_layer_per_exhaustion or 0) / 100) * newChaosDefMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.PowerFormula(env)
  local newChaosAtkMultiplier = BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)
  local curValue = math.ceil(env.value * 10000 * (1 + env.i_state_layer_per_power / 100) * (1 + env.o_state_layer_per_power / 100) * (1 + env.o_state_layer_per_power_bycmd / 100) * (1 + env.card_state_layer_per_power / 100 + (env.card_state_layer_per_power_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_state_layer_per_power or 0) / 100) * (1 + (env.awaker_ulti_state_layer_per_power or 0) / 100) * newChaosAtkMultiplier / 10000 - BattleUtilServer.FLOAT_ERROR)
  return curValue, env.value
end

function BattleUtilServer.TentacleShowFormula(env)
  local curValue = math.max(math.ceil(math.max(math.ceil(env.value * (1 + env.o_state_layer_per_tentacle_dmg / 100 + env.instructcard_basic_state_layer_per_tentacle_dmg / 100 + env.ulti_basic_state_layer_per_tentacle_dmg / 100) * (1 + env.card_basic_state_layer_per_tentacle_dmg / 100)), 1) * (1 + env.i_state_layer_per_tentacle_dmg / 100 + env.instructcard_final_state_layer_per_tentacle_dmg / 100 + env.ulti_final_state_layer_per_tentacle_dmg / 100) * (1 + env.card_state_layer_per_tentacle_dmg / 100) * (1 + (env.card_state_layer_per_TentaclePower or 0) / 100 + (env.card_state_layer_per_TentaclePower_n2 or 0) / 100) * (1 + (env.awaker_CmdCard_state_layer_per_TentaclePower or 0) / 100) * (1 + (env.awaker_ulti_state_layer_per_TentaclePower or 0) / 100) * BattleUtilServer.GetNewChaosAtkMultiplier(env.keeperskill_atk_per, env.is_chaos_type2)), 1)
  return curValue, env.value
end

function BattleUtilServer.ShowUltiEnergyFormula(data)
  local env = setmetatable({}, {
    __index = function(_, key)
      return data[key] or 0
    end
  })
  local curValue = math.max(math.ceil((env.value + env.awakerUltiEnergyPlus + env.cardUltiEnergyPlus + env.awakerUltiEnergyPlus2) * 10000 * (1 + env.awakerUltiEnergyPer / 100) * (1 + env.i_awakerUltiEnergyPer / 100) * (1 + env.outUltiEnergyPer / 100) * (1 + env.awakerUltiEnergyEff / 100) * (1 + env.curCardUltiEnergyPer / 100) * (1 + env.dimension_fix_per / 100) * env.skillTypeEnergyPer / 10000 - BattleUtilServer.FLOAT_ERROR), 1)
  local baseValue = math.max(math.ceil(env.value * 10000 * (1 + env.awakerUltiEnergyEff / 100) / 10000 - BattleUtilServer.FLOAT_ERROR), 1)
  return curValue, baseValue
end

function BattleUtilServer.GetCollectionIdByPVPSkillId(battleEngine, skillId)
  local DT = require("System.DataTable")
  if not battleEngine.PVPSkill2Collection then
    battleEngine.PVPSkill2Collection = {}
  end
  local PVPSkill2Collection = battleEngine.PVPSkill2Collection
  for k, v in pairs(DT.PVPCollect) do
    local itemCfg = DT.Item[v.Item]
    if itemCfg.PVPSkill and #itemCfg.PVPSkill > 0 then
      PVPSkill2Collection[itemCfg.PVPSkill[1]] = k
    end
  end
  return PVPSkill2Collection[skillId]
end

function BattleUtilServer.IsPVPSkillOpen(battleEngine, skillId, now)
  local DT = require("System.DataTable")
  local collectionId = BattleUtilServer.GetCollectionIdByPVPSkillId(battleEngine, skillId)
  if not collectionId then
    return false
  end
  if 121139 == collectionId then
    local battleInitData = battleEngine and battleEngine.initData
    if battleInitData and battleInitData.isTwoAnniversaryKeeperSkillOpen ~= nil then
      return battleInitData.isTwoAnniversaryKeeperSkillOpen
    end
  end
  local cfg = DT.PVPCollect[collectionId]
  if not cfg then
    return false
  end
  if not cfg.DisplayDate then
    return true
  end
  return now >= cfg.DisplayDate
end

function BattleUtilServer.IsAwakerOpen(DT, awakerTid, now)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  if not awakerCfg then
    return false
  end
  if not awakerCfg.OpenDate then
    return true
  end
  return now >= awakerCfg.OpenDate
end

function BattleUtilServer.Comparison(a, operator, b)
  if not a or not b then
    return false
  end
  if operator == bc.ComparisonOperator.LT then
    return a < b
  end
  if operator == bc.ComparisonOperator.GT then
    return b < a
  end
  if operator == bc.ComparisonOperator.LTE then
    return a <= b
  end
  if operator == bc.ComparisonOperator.GTE then
    return b <= a
  end
  if operator == bc.ComparisonOperator.EQ then
    return a == b
  end
  if operator == bc.ComparisonOperator.NE then
    return a ~= b
  end
  return false
end

function BattleUtilServer.GetTrueConditionByCmd(cmdServer, condList)
  if type(condList) ~= "table" then
    return condList
  end
  local index = BattleUtilServer.GetTrueConditionIndexByCmd(cmdServer, condList)
  if not index then
    return nil
  end
  return condList[index][2]
end

function BattleUtilServer.GetTrueConditionIndexByCmd(cmdServer, condList)
  if type(condList) ~= "table" then
    return nil
  end
  for i = #condList, 1, -1 do
    local condCfg = condList[i]
    if condCfg and BattleUtilServer.IsCondMatch(cmdServer, condCfg[1]) then
      return i
    end
  end
  return nil
end

function BattleUtilServer.IsCondMatch(cmdServer, cond)
  if type(cond) == "boolean" then
    return cond
  elseif "true" == cond then
    return true
  else
    local val = cmdServer:GetValueByCmd(cond)
    if type(val) == "boolean" then
      return val
    elseif type(val) == "number" then
      return val and val > 0
    end
    return val
  end
end

function BattleUtilServer.IsForceExistState(stateCfg)
  if not stateCfg then
    return false
  end
  local forceExist = stateCfg.ForceExist
  return forceExist and "TRUE" == forceExist
end

function BattleUtilServer.BuildExistStateSource(ownerTid, layer)
  return {
    {
      tid = ownerTid,
      sourceType = "ExistState",
      layer = layer
    }
  }
end

function BattleUtilServer.GetCurTime(battleEngine)
  local now
  if battleEngine:IsServerBattle() then
    local TimeUtil = require("TimeUtil")
    now = TimeUtil.GetTime()
  else
    now = TimeUtils.GetServerTime()
  end
  return now
end

return BattleUtilServer
