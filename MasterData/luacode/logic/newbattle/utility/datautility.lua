local DataUtility = {}
local CSkill = BeanManager.GetTableByName("skill.cskill")
local CSkillFormulaCfg = BeanManager.GetTableByName("skill.cskillformulacfg")
local CSkillRateCfg = BeanManager.GetTableByName("skill.cskillratecfg")
local CCostSkill = BeanManager.GetTableByName("skill.ccostskill")
local CIBuffConfig = BeanManager.GetTableByName("buff.cibuffconfig")
local CCostSkill = BeanManager.GetTableByName("skill.ccostskill")
local CSkillChange = BeanManager.GetTableByName("buff.cskillchange")
local CCBuffConfig = BeanManager.GetTableByName("buff.ccbuffconfig")
local CBuffConflicts = BeanManager.GetTableByName("buff.cbuffconflicts")
local CBuffLinkSkillCfg = BeanManager.GetTableByName("buff.cbufflinkskillcfg")
local CLinkSkillConditionCfg = BeanManager.GetTableByName("buff.clinkskillconditioncfg")
local CBuffSummon = BeanManager.GetTableByName("buff.cbuffsummon")
local CBossBreakCfg = BeanManager.GetTableByName("battle.cbossbreakcfg")
local CBattleConstCfg = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CAttrEffectIdName = BeanManager.GetTableByName("role.cattreffectidname")
local CBuffEffect = BeanManager.GetTableByName("buff.cbuffeffect")
local CBuffTriggerAnimationCfg = BeanManager.GetTableByName("buff.cbufftriggeranimationcfg")
local RoleConfig = BeanManager.GetTableByName("role.roleconfig")
local CMonsterConfig = BeanManager.GetTableByName("npc.cmonsterconfig")
local CSkillBehavior = BeanManager.GetTableByName("skill.cskillbehavior")
local CSkillAnimation = BeanManager.GetTableByName("skill.cskillanimation")
local CSkillEffect = BeanManager.GetTableByName("skill.cskilleffect")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CBuffLinkSkillGroupCfg = BeanManager.GetTableByName("buff.cbufflinkskillgroupcfg")
local CSkillItem = BeanManager.GetTableByName("item.cskillitem")
local CJoinBattleInfo = BeanManager.GetTableByName("battle.cjoinbattleinfo")
local CEquipmentSkillIcon = BeanManager.GetTableByName("skill.cequipmentskillicon")
local CSoundCatalog = BeanManager.GetTableByName("sound.csoundcatalog")
local CBattleSoundChange = BeanManager.GetTableByName("sound.cbattlesoundchange")
local CSkinSkillEffectChange = BeanManager.GetTableByName("skill.cskinskilleffectchange")
local CRoleSkinChangeshapeCfg = BeanManager.GetTableByName("role.croleskinchangeshapecfg")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CCardRoleSkillCD = BeanManager.GetTableByName("dungeonselect.ccardroleskillcd")
local CCellBattleInfo = BeanManager.GetTableByName("dungeonselect.ccellbattleinfo")
local CDreamMain = BeanManager.GetTableByName("dungeonselect.cdreammain")
local CDreamTopic = BeanManager.GetTableByName("dungeonselect.cdreamtopic")
local CGloballBuffConfig = BeanManager.GetTableByName("buff.cgloballbuffconfig")
local CSkillCameraMove = BeanManager.GetTableByName("skill.cskillcameramove")
local CSkinBuffEffectChange = BeanManager.GetTableByName("skill.cskinbuffeffectchange")
local CBuffNumConfig = BeanManager.GetTableByName("role.cbuffnumconfig")
DataUtility.VoiceType = {
  LevelUp = "LevelUp",
  LimitUp = "LimitUp",
  RareUp = "RareUp",
  Impression = "Impression",
  NormalGift = "NormalGift",
  FavoriteGift = "FavoriteGift",
  BodyTouch = "BodyTouch",
  Standby = "Standby",
  Formation = "Formation",
  Adventure = "Adventure",
  OpenBox = "OpenBox",
  ManaTree = "ManaTree",
  LifeHealing = "LifeHealing",
  BattleStart = "BattleStart",
  SkillID = "SkillID",
  SkillCV = "SkillCV",
  Attacked = "Attacked",
  Revive = "Revive",
  Victory = "Victory",
  Defeat = "Defeat",
  BattleKill = "BattleKill",
  YardTouch = "YardTouch",
  Dispatch = "Dispatch",
  Withdraw = "Withdraw",
  Summory = "Summory",
  Conversation = "Conversation",
  Emotion = "Emotion",
  Introduction = "Introduction",
  Login = "Login"
}
DataUtility.PowerType = {Red = 1, Blue = 2}
DataUtility.CSkillEnemyBuffValuesFunc = {}
DataUtility.CSkillFriendBuffValuesFunc = {}
DataUtility.BattleFormulaVariables = {
  math = fixedpoint,
  f = {},
  fixedpoint = fixedpoint
}

function DataUtility.InitCSkillFormulaCfgBattleFormula()
  local allIds = CSkillFormulaCfg:GetAllIds()
  for _, id in ipairs(allIds) do
    local recorder = CSkillFormulaCfg:GetRecorder(id)
    if DataUtility.BattleFormulaVariables.f[recorder.FormulaName] then
      LogErrorFormat("DataUtility", "the same FormulaName %s in cskillformulacfg", recorder.FormulaName)
    else
      local funstr = "f." .. recorder.FormulaName .. "=function("
      local attrCount = #recorder.attr
      for i, attrName in ipairs(recorder.attr) do
        funstr = funstr .. attrName
        if i < attrCount then
          funstr = funstr .. ","
        end
      end
      funstr = funstr .. ") return " .. recorder.Formula .. "," .. recorder.BaseDamageFormula .. " end"
      assert(load(funstr, "f." .. recorder.FormulaName, "t", DataUtility.BattleFormulaVariables))()
    end
  end
end

function DataUtility.InitCSkillBattleFormula()
  local cskillAllIds = CSkill:GetAllIds()
  for _, skillid in ipairs(cskillAllIds) do
    local ourlist, enemylist = BattleECS.Utility.BuffUtility.GetSKillBuffList(skillid)
    DataUtility.CSkillFriendBuffValuesFunc[skillid] = {}
    for _, v in ipairs(ourlist) do
      local record = string.split(v.buffvalues, ";")
      if v.buffid then
        DataUtility.CSkillFriendBuffValuesFunc[skillid][v.buffid] = {}
        for index, param in ipairs(record) do
          local r = string.split(param, "=")
          if string.find(r[1], "_value") then
            local splitIndex = string.find(param, "=")
            local formula = string.sub(param, splitIndex + 1, string.len(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables))()
            DataUtility.CSkillFriendBuffValuesFunc[skillid][v.buffid][r[1]] = func
          elseif #r == 2 then
            local splitIndex = string.find(param, "=")
            local formula = string.sub(param, splitIndex + 1, string.len(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables))()
            DataUtility.CSkillFriendBuffValuesFunc[skillid][v.buffid][r[1]] = func
          end
        end
      else
        LogErrorFormat("DataUtility", "skillid %s friendbuffid is wrong", skillid)
      end
    end
    DataUtility.CSkillEnemyBuffValuesFunc[skillid] = {}
    for _, v in ipairs(enemylist) do
      local record = string.split(v.buffvalues, ";")
      if v.buffid then
        DataUtility.CSkillEnemyBuffValuesFunc[skillid][v.buffid] = {}
        for index, param in ipairs(record) do
          local r = string.split(param, "=")
          if string.find(r[1], "_value") then
            local splitIndex = string.find(param, "=")
            local formula = string.sub(param, splitIndex + 1, string.len(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables))()
            DataUtility.CSkillEnemyBuffValuesFunc[skillid][v.buffid][r[1]] = func
          elseif #r == 2 then
            local splitIndex = string.find(param, "=")
            local formula = string.sub(param, splitIndex + 1, string.len(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables))()
            DataUtility.CSkillEnemyBuffValuesFunc[skillid][v.buffid][r[1]] = func
          end
        end
      else
        LogErrorFormat("DataUtility", "skillid %s enemybuffid is wrong", skillid)
      end
    end
  end
end

function DataUtility.InitCGlobalBuffBattleFormula()
  local skillid = 0
  local CGloballBuffConfigAllIds = CGloballBuffConfig:GetAllIds()
  for _, id in ipairs(CGloballBuffConfigAllIds) do
    local record = CGloballBuffConfig:GetRecorder(id)
    DataUtility.CSkillFriendBuffValuesFunc[skillid] = DataUtility.CSkillFriendBuffValuesFunc[skillid] or {}
    local inRecord = string.split(record.buffattr, ";")
    DataUtility.CSkillFriendBuffValuesFunc[skillid][id] = {}
    for index, param in ipairs(inRecord) do
      local r = string.split(param, "=")
      if string.find(r[1], "_value") then
        local splitIndex = string.find(param, "=")
        local formula = string.sub(param, splitIndex + 1, string.len(param))
        local funstr = "return function() return " .. formula .. " end"
        local func = assert(load(funstr, "cgloballbuffconfig buffid " .. id, "t", DataUtility.BattleFormulaVariables))()
        DataUtility.CSkillFriendBuffValuesFunc[skillid][id][r[1]] = func
      elseif #r == 2 then
        local splitIndex = string.find(param, "=")
        local formula = string.sub(param, splitIndex + 1, string.len(param))
        local funstr = "return function() return " .. formula .. " end"
        local func = assert(load(funstr, "cgloballbuffconfig buffid " .. id, "t", DataUtility.BattleFormulaVariables))()
        DataUtility.CSkillFriendBuffValuesFunc[skillid][id][r[1]] = func
      end
    end
  end
end

function DataUtility.ClearBattleFormulaVariables()
  local functionList = DataUtility.BattleFormulaVariables.f
  for key, value in pairs(DataUtility.BattleFormulaVariables) do
    DataUtility.BattleFormulaVariables[key] = 0
  end
  DataUtility.BattleFormulaVariables.math = fixedpoint
  DataUtility.BattleFormulaVariables.fixedpoint = fixedpoint
  DataUtility.BattleFormulaVariables.f = functionList
end

DataUtility.CSkillRateCfgFunc = {}
DataUtility.SkillRateFormulaVariables = {
  math = fixedpoint,
  fixedpoint = fixedpoint
}

function DataUtility.InitCSkillRateCfgFormula()
  local cskillRateAllIds = CSkillRateCfg:GetAllIds()
  for _, skillid in ipairs(cskillRateAllIds) do
    local record = CSkillRateCfg:GetRecorder(skillid)
    DataUtility.CSkillRateCfgFunc[skillid] = {}
    for index, rateSkill in ipairs(record.skillid) do
      local formula = record.skillrate[index]
      local funstr = "return function() return " .. formula .. " end"
      local func = assert(load(funstr, skillid .. ".. rateSkill" .. rateSkill .. "..", "t", DataUtility.SkillRateFormulaVariables))()
      DataUtility.CSkillRateCfgFunc[skillid][rateSkill] = func
    end
  end
end

function DataUtility.ClearSkillRateFormulaVariables()
  for key, value in pairs(DataUtility.SkillRateFormulaVariables) do
    DataUtility.SkillRateFormulaVariables[key] = 0
  end
  DataUtility.SkillRateFormulaVariables.math = fixedpoint
  DataUtility.SkillRateFormulaVariables.fixedpoint = fixedpoint
end

DataUtility.CSkillCostCfgFunc = {}
DataUtility.SkillCostFormulaVariables = {
  math = fixedpoint,
  fixedpoint = fixedpoint
}

function DataUtility.InitCSkillCostCfgFormula()
  local cskillCostAllIds = CCostSkill:GetAllIds()
  for _, skillid in ipairs(cskillCostAllIds) do
    local record = CCostSkill:GetRecorder(skillid)
    if record and record.pureCost ~= "" then
      DataUtility.CSkillCostCfgFunc[skillid] = {}
      local rec = string.split(record.pureCost, ";")
      local funstr = "return function() return " .. rec[DataUtility.PowerType.Red] .. " end"
      local func = assert(load(funstr, skillid .. ".. ccostskill" .. skillid .. "..", "t", DataUtility.SkillCostFormulaVariables))()
      DataUtility.CSkillCostCfgFunc[skillid][DataUtility.PowerType.Red] = func
      funstr = "return function() return " .. rec[DataUtility.PowerType.Blue] .. " end"
      func = assert(load(funstr, skillid .. ".. ccostskill" .. skillid .. "..", "t", DataUtility.SkillCostFormulaVariables))()
      DataUtility.CSkillCostCfgFunc[skillid][DataUtility.PowerType.Blue] = func
    end
  end
end

function DataUtility.ClearSkillCostFormulaVariables()
  for key, value in pairs(DataUtility.SkillCostFormulaVariables) do
    DataUtility.SkillCostFormulaVariables[key] = 0
  end
  DataUtility.SkillCostFormulaVariables.math = fixedpoint
  DataUtility.SkillCostFormulaVariables.fixedpoint = fixedpoint
end

function DataUtility.InitCSkillbehavior()
  local CSkillBehaviorAllIds = CSkillBehavior:GetAllIds()
  DataUtility.cSkillBehaviorTable = {}
  for _, id in ipairs(CSkillBehaviorAllIds) do
    local record = CSkillBehavior:GetRecorder(id)
    DataUtility.cSkillBehaviorTable[id] = {}
    if record.actionAtk then
      DataUtility.cSkillBehaviorTable[id].actionAtk = record.actionAtk
    end
    local effect = string.split(record.typeMineEffectAtk, ";")
    DataUtility.cSkillBehaviorTable[id].typeMineEffectAtk = {}
    for k, v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        table.insert(DataUtility.cSkillBehaviorTable[id].typeMineEffectAtk, skillEffectId)
      elseif string.len(v) > 0 then
        local vTable = string.split(v, "||")
        if vTable then
          DataUtility.cSkillBehaviorTable[id].typeMineEffectAtk[k] = {}
          for _, v1 in ipairs(vTable) do
            table.insert(DataUtility.cSkillBehaviorTable[id].typeMineEffectAtk[k], tonumber(v1))
          end
        end
      end
    end
    DataUtility.cSkillBehaviorTable[id].flightPropEffectAtk = {}
    local effect = string.split(record.flightPropEffectAtk, ";")
    for k, v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        table.insert(DataUtility.cSkillBehaviorTable[id].flightPropEffectAtk, skillEffectId)
      elseif string.len(v) > 0 then
        local vTable = string.split(v, "||")
        if vTable then
          DataUtility.cSkillBehaviorTable[id].flightPropEffectAtk[k] = {}
          for _, v1 in ipairs(vTable) do
            table.insert(DataUtility.cSkillBehaviorTable[id].flightPropEffectAtk[k], tonumber(v1))
          end
        end
      end
    end
    DataUtility.cSkillBehaviorTable[id].invalidEffectAtk = {}
    effect = string.split(record.invalidEffectAtk, ";")
    for k, v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        table.insert(DataUtility.cSkillBehaviorTable[id].invalidEffectAtk, skillEffectId)
      elseif string.len(v) > 0 then
        local vTable = string.split(v, "||")
        if vTable then
          DataUtility.cSkillBehaviorTable[id].invalidEffectAtk[k] = {}
          for _, v1 in ipairs(vTable) do
            table.insert(DataUtility.cSkillBehaviorTable[id].invalidEffectAtk[k], tonumber(v1))
          end
        end
      end
    end
    DataUtility.cSkillBehaviorTable[id].noColliderEffectAtk = {}
    effect = string.split(record.noColliderEffectAtk, ";")
    for k, v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        table.insert(DataUtility.cSkillBehaviorTable[id].noColliderEffectAtk, skillEffectId)
      elseif string.len(v) > 0 then
        local vTable = string.split(v, "||")
        if vTable then
          DataUtility.cSkillBehaviorTable[id].noColliderEffectAtk[k] = {}
          for _, v1 in ipairs(vTable) do
            table.insert(DataUtility.cSkillBehaviorTable[id].noColliderEffectAtk[k], tonumber(v1))
          end
        end
      end
    end
    DataUtility.cSkillBehaviorTable[id].WarningEffect = {}
    effect = string.split(record.WarningEffect, ";")
    for k, v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        table.insert(DataUtility.cSkillBehaviorTable[id].WarningEffect, skillEffectId)
      elseif string.len(v) > 0 then
        local vTable = string.split(v, "||")
        if vTable then
          DataUtility.cSkillBehaviorTable[id].WarningEffect[k] = {}
          for _, v1 in ipairs(vTable) do
            table.insert(DataUtility.cSkillBehaviorTable[id].WarningEffect[k], tonumber(v1))
          end
        end
      end
    end
  end
end

DataUtility.CSkillFriendBuffValueTable = {}
DataUtility.CSkillEnemyBuffValueTable = {}

function DataUtility.InitSplitCSkillBuffValue()
  local cskillAllIds = CSkill:GetAllIds()
  for _, skillid in ipairs(cskillAllIds) do
    local recorder = CSkill:GetRecorder(skillid)
    if recorder.friendbuffid ~= "" then
      DataUtility.CSkillFriendBuffValueTable[skillid] = DataUtility.CSkillFriendBuffValueTable[skillid] or {}
      local friendValue = string.split(string.sub(recorder.friendbuffValues, 2, string.len(recorder.friendbuffValues) - 1), "}{")
      for k, v in ipairs(string.split(recorder.friendbuffid, ";")) do
        table.insert(DataUtility.CSkillFriendBuffValueTable[skillid], {
          buffid = tonumber(v),
          buffvalues = friendValue[k]
        })
      end
    end
    if recorder.enemybuffid ~= "" then
      DataUtility.CSkillEnemyBuffValueTable[skillid] = DataUtility.CSkillEnemyBuffValueTable[skillid] or {}
      local enermyValue = string.split(string.sub(recorder.enemybuffValues, 2, string.len(recorder.enemybuffValues) - 1), "}{")
      for k, v in ipairs(string.split(recorder.enemybuffid, ";")) do
        table.insert(DataUtility.CSkillEnemyBuffValueTable[skillid], {
          buffid = tonumber(v),
          buffvalues = enermyValue[k]
        })
      end
    end
  end
end

DataUtility.RoleSkillCVCD = {}

function DataUtility.InitPowerNumType()
  DataUtility.PowerNumType = {}
  DataUtility.PowerNumType[DataUtility.PowerType.Red] = {}
  DataUtility.PowerNumType[DataUtility.PowerType.Blue] = {}
  DataUtility.PowerLimit = {}
  DataUtility.PowerLimit[DataUtility.PowerType.Red] = {
    Down = 1,
    Up = tonumber(DataUtility.cBattleConstCfgTable[8].attr)
  }
  for i = DataUtility.PowerLimit[DataUtility.PowerType.Red].Down, DataUtility.PowerLimit[DataUtility.PowerType.Red].Up do
    DataUtility.PowerNumType[DataUtility.PowerType.Red][i] = fixedpoint(DataUtility.cBattleConstCfgTable[1].attr) * i
  end
  DataUtility.PowerLimit[DataUtility.PowerType.Blue] = {
    Down = 1,
    Up = tonumber(DataUtility.cBattleConstCfgTable[9].attr)
  }
  for i = DataUtility.PowerLimit[DataUtility.PowerType.Blue].Down, DataUtility.PowerLimit[DataUtility.PowerType.Blue].Up do
    DataUtility.PowerNumType[DataUtility.PowerType.Blue][i] = fixedpoint(DataUtility.cBattleConstCfgTable[2].attr) * i
  end
end

function DataUtility.GetPowerGridFunc(powerValue, cellValue)
  if not DataUtility.PowerLimit[cellValue] then
    LogErrorFormat("DataUtility", "DataUtility.PowerLimit[cellValue %s] is nil", cellValue)
    return 0
  end
  if not DataUtility.PowerNumType[cellValue] then
    LogErrorFormat("DataUtility", "DataUtility.PowerNumType[cellValue %s] is nil", cellValue)
    return 0
  end
  for i = DataUtility.PowerLimit[cellValue].Up, DataUtility.PowerLimit[cellValue].Down, -1 do
    if powerValue >= DataUtility.PowerNumType[cellValue][i] then
      return i
    end
  end
  return 0
end

function DataUtility.InitConfigTable()
  local allIds = CIBuffConfig:GetAllIds()
  DataUtility.cIBuffCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cIBuffCfgTable[id] = CIBuffConfig:GetRecorder(id)
  end
  allIds = CCostSkill:GetAllIds()
  DataUtility.cSkillCostTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkillCostTable[id] = CCostSkill:GetRecorder(id)
  end
  allIds = CSkillChange:GetAllIds()
  DataUtility.cSkillChangeTable = {}
  for _, id in ipairs(allIds) do
    local record = CSkillChange:GetRecorder(id)
    for _, buffId in ipairs(string.split(record.buffId, ";")) do
      DataUtility.cSkillChangeTable[tonumber(record.aSkillId)] = DataUtility.cSkillChangeTable[tonumber(record.aSkillId)] or {}
      if not DataUtility.cSkillChangeTable[tonumber(record.aSkillId)][tonumber(buffId)] then
        DataUtility.cSkillChangeTable[tonumber(record.aSkillId)][tonumber(buffId)] = tonumber(record.bSkillId)
      else
        LogErrorFormat("DataUtility", "duplication : cskillchange always has aSkillId %s buffId %s", tonumber(record.aSkillId), tonumber(buffId))
      end
    end
  end
  allIds = CCBuffConfig:GetAllIds()
  DataUtility.cBuffCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffCfgTable[id] = CCBuffConfig:GetRecorder(id)
  end
  allIds = CBuffConflicts:GetAllIds()
  DataUtility.cBuffConficsTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffConficsTable[id] = CBuffConflicts:GetRecorder(id)
  end
  allIds = CLinkSkillConditionCfg:GetAllIds()
  DataUtility.cLinkSkillConditionCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cLinkSkillConditionCfgTable[id] = CLinkSkillConditionCfg:GetRecorder(id)
  end
  allIds = CBuffLinkSkillCfg:GetAllIds()
  DataUtility.cBuffLinkSkillCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffLinkSkillCfgTable[id] = CBuffLinkSkillCfg:GetRecorder(id)
  end
  allIds = CBuffSummon:GetAllIds()
  DataUtility.cBuffSummonTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffSummonTable[id] = CBuffSummon:GetRecorder(id)
  end
  allIds = CBossBreakCfg:GetAllIds()
  DataUtility.cBossBreakCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBossBreakCfgTable[id] = CBossBreakCfg:GetRecorder(id)
  end
  allIds = CBattleConstCfg:GetAllIds()
  DataUtility.cBattleConstCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBattleConstCfgTable[id] = CBattleConstCfg:GetRecorder(id)
  end
  allIds = CSkill:GetAllIds()
  DataUtility.cskillTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cskillTable[id] = CSkill:GetRecorder(id)
  end
  local attrIdList = {
    {
      10,
      20,
      30,
      40,
      50,
      60,
      70,
      80,
      90,
      100,
      110,
      120,
      130
    },
    {
      140,
      150,
      160,
      170,
      180,
      190,
      200,
      210,
      220,
      230,
      240,
      250,
      260,
      270,
      280,
      290
    },
    {
      300,
      310,
      320,
      350,
      360,
      370,
      400,
      410,
      420,
      430,
      440,
      450,
      460
    },
    {
      490,
      500,
      510,
      750,
      530,
      540,
      590,
      830,
      610,
      620,
      630,
      640,
      650,
      1060,
      670,
      680,
      690,
      700,
      710,
      720,
      730,
      740,
      1070
    },
    {
      330,
      340,
      380,
      390,
      470,
      480
    }
  }
  DataUtility.soreCattr = {
    {},
    {},
    {},
    {},
    {}
  }
  allIds = CAttrEffectIdName:GetAllIds()
  for _, id in ipairs(allIds) do
    for i, v in ipairs(attrIdList[1]) do
      if id == v then
        table.insert(DataUtility.soreCattr[1], {
          id = id,
          record = CAttrEffectIdName:GetRecorder(id)
        })
      end
    end
    for i, v in ipairs(attrIdList[2]) do
      if id == v then
        table.insert(DataUtility.soreCattr[2], {
          id = id,
          record = CAttrEffectIdName:GetRecorder(id)
        })
      end
    end
    for i, v in ipairs(attrIdList[3]) do
      if id == v then
        table.insert(DataUtility.soreCattr[3], {
          id = id,
          record = CAttrEffectIdName:GetRecorder(id)
        })
      end
    end
    for i, v in ipairs(attrIdList[4]) do
      if id == v then
        table.insert(DataUtility.soreCattr[4], {
          id = id,
          record = CAttrEffectIdName:GetRecorder(id)
        })
      end
    end
    for i, v in ipairs(attrIdList[5]) do
      if id == v then
        table.insert(DataUtility.soreCattr[5], {
          id = id,
          record = CAttrEffectIdName:GetRecorder(id)
        })
      end
    end
  end
  table.insert(DataUtility.soreCattr, {})
  for _, id in ipairs(CBuffNumConfig:GetAllIds()) do
    table.insert(DataUtility.soreCattr[#DataUtility.soreCattr], {
      id = id,
      record = CBuffNumConfig:GetRecorder(id)
    })
  end
  allIds = CBuffEffect:GetAllIds()
  DataUtility.cBuffEffectCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffEffectCfgTable[id] = CBuffEffect:GetRecorder(id)
  end
  allIds = CBuffTriggerAnimationCfg:GetAllIds()
  DataUtility.cBuffAnimationCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffAnimationCfgTable[id] = CBuffTriggerAnimationCfg:GetRecorder(id)
  end
  allIds = RoleConfig:GetAllIds()
  DataUtility.roleConfigTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.roleConfigTable[id] = RoleConfig:GetRecorder(id)
  end
  allIds = CMonsterConfig:GetAllIds()
  DataUtility.cMonsterCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cMonsterCfgTable[id] = CMonsterConfig:GetRecorder(id)
  end
  allIds = CSkillAnimation:GetAllIds()
  DataUtility.cSkillAnimationTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkillAnimationTable[id] = CSkillAnimation:GetRecorder(id)
  end
  allIds = CSkillEffect:GetAllIds()
  DataUtility.cSkillEffectTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkillEffectTable[id] = CSkillEffect:GetRecorder(id)
  end
  allIds = CNPCShape:GetAllIds()
  DataUtility.cNPCShapeTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cNPCShapeTable[id] = CNPCShape:GetRecorder(id)
  end
  allIds = CBuffLinkSkillGroupCfg:GetAllIds()
  DataUtility.cBuffLinkSkillGroupCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBuffLinkSkillGroupCfgTable[id] = CBuffLinkSkillGroupCfg:GetRecorder(id)
  end
  allIds = CSkillItem:GetAllIds()
  DataUtility.cSkillItemTable = {}
  for _, id in ipairs(allIds) do
    local record = CSkillItem:GetRecorder(id)
    for i, skillId in ipairs(record.skillID) do
      DataUtility.cSkillItemTable[skillId] = {itemId = id, lv = i}
    end
  end
  allIds = CJoinBattleInfo:GetAllIds()
  DataUtility.cJoinBattleInfoTable = {}
  for _, id in ipairs(allIds) do
    table.insert(DataUtility.cJoinBattleInfoTable, {
      id = id,
      record = CJoinBattleInfo:GetRecorder(id)
    })
  end
  allIds = CSkillRateCfg:GetAllIds()
  DataUtility.cSkillRateCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkillRateCfgTable[id] = CSkillRateCfg:GetRecorder(id)
  end
  allIds = CEquipmentSkillIcon:GetAllIds()
  DataUtility.cEquipmentSkillIconTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cEquipmentSkillIconTable[id] = CEquipmentSkillIcon:GetRecorder(id)
  end
  allIds = CSoundCatalog:GetAllIds()
  DataUtility.cSoundCatalogTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSoundCatalogTable[id] = CSoundCatalog:GetRecorder(id)
  end
  allIds = CBattleSoundChange:GetAllIds()
  DataUtility.cBattleSoundChangeTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cBattleSoundChangeTable[id] = CBattleSoundChange:GetRecorder(id)
  end
  allIds = CSkinSkillEffectChange:GetAllIds()
  DataUtility.cSkinSkillEffectChangeTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkinSkillEffectChangeTable[id] = CSkinSkillEffectChange:GetRecorder(id)
  end
  allIds = CRoleSkinChangeshapeCfg:GetAllIds()
  DataUtility.cRoleSkinChangeshapeCfgTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cRoleSkinChangeshapeCfgTable[id] = CRoleSkinChangeshapeCfg:GetRecorder(id)
  end
  allIds = CSkin:GetAllIds()
  DataUtility.cSkinTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkinTable[id] = CSkin:GetRecorder(id)
  end
  allIds = CCardRoleSkillCD:GetAllIds()
  DataUtility.cCardRoleSkillCDTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cCardRoleSkillCDTable[id] = CCardRoleSkillCD:GetRecorder(id)
  end
  allIds = CCellBattleInfo:GetAllIds()
  DataUtility.cCellBattleInfoTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cCellBattleInfoTable[id] = CCellBattleInfo:GetRecorder(id)
  end
  allIds = CDreamMain:GetAllIds()
  DataUtility.cDreamMainTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cDreamMainTable[id] = CDreamMain:GetRecorder(id)
  end
  allIds = CDreamTopic:GetAllIds()
  DataUtility.cDreamTopicTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cDreamTopicTable[id] = CDreamTopic:GetRecorder(id)
  end
  allIds = CSkillFormulaCfg:GetAllIds()
  DataUtility.cSkillFormulaCfgTable = {}
  for _, id in ipairs(allIds) do
    table.insert(DataUtility.cSkillFormulaCfgTable, {
      id = id,
      record = CSkillFormulaCfg:GetRecorder(id)
    })
  end
  allIds = CGloballBuffConfig:GetAllIds()
  DataUtility.cGlobalBuffConfigTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cGlobalBuffConfigTable[id] = CGloballBuffConfig:GetRecorder(id)
  end
  allIds = CSkillCameraMove:GetAllIds()
  DataUtility.cSkillCameraMoveTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkillCameraMoveTable[id] = CSkillCameraMove:GetRecorder(id)
  end
  allIds = CSkinBuffEffectChange:GetAllIds()
  DataUtility.cSkinBuffEffectChangeTable = {}
  for _, id in ipairs(allIds) do
    DataUtility.cSkinBuffEffectChangeTable[id] = CSkinBuffEffectChange:GetRecorder(id)
  end
end

return DataUtility
