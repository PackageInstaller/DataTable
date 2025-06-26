-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/datautility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DataUtility = {}
local CSkill = (BeanManager.GetTableByName)("skill.cskill")
local CSkillFormulaCfg = (BeanManager.GetTableByName)("skill.cskillformulacfg")
local CSkillRateCfg = (BeanManager.GetTableByName)("skill.cskillratecfg")
local CCostSkill = (BeanManager.GetTableByName)("skill.ccostskill")
local CIBuffConfig = (BeanManager.GetTableByName)("buff.cibuffconfig")
local CCostSkill = (BeanManager.GetTableByName)("skill.ccostskill")
local CSkillChange = (BeanManager.GetTableByName)("buff.cskillchange")
local CCBuffConfig = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CBuffConflicts = (BeanManager.GetTableByName)("buff.cbuffconflicts")
local CBuffLinkSkillCfg = (BeanManager.GetTableByName)("buff.cbufflinkskillcfg")
local CLinkSkillConditionCfg = (BeanManager.GetTableByName)("buff.clinkskillconditioncfg")
local CBuffSummon = (BeanManager.GetTableByName)("buff.cbuffsummon")
local CBossBreakCfg = (BeanManager.GetTableByName)("battle.cbossbreakcfg")
local CBattleConstCfg = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CAttrEffectIdName = (BeanManager.GetTableByName)("role.cattreffectidname")
local CBuffEffect = (BeanManager.GetTableByName)("buff.cbuffeffect")
local CBuffTriggerAnimationCfg = (BeanManager.GetTableByName)("buff.cbufftriggeranimationcfg")
local RoleConfig = (BeanManager.GetTableByName)("role.roleconfig")
local CMonsterConfig = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CSkillBehavior = (BeanManager.GetTableByName)("skill.cskillbehavior")
local CSkillAnimation = (BeanManager.GetTableByName)("skill.cskillanimation")
local CSkillEffect = (BeanManager.GetTableByName)("skill.cskilleffect")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CBuffLinkSkillGroupCfg = (BeanManager.GetTableByName)("buff.cbufflinkskillgroupcfg")
local CSkillItem = (BeanManager.GetTableByName)("item.cskillitem")
local CJoinBattleInfo = (BeanManager.GetTableByName)("battle.cjoinbattleinfo")
local CEquipmentSkillIcon = (BeanManager.GetTableByName)("skill.cequipmentskillicon")
local CSoundCatalog = (BeanManager.GetTableByName)("sound.csoundcatalog")
local CBattleSoundChange = (BeanManager.GetTableByName)("sound.cbattlesoundchange")
local CSkinSkillEffectChange = (BeanManager.GetTableByName)("skill.cskinskilleffectchange")
local CRoleSkinChangeshapeCfg = (BeanManager.GetTableByName)("role.croleskinchangeshapecfg")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CCardRoleSkillCD = (BeanManager.GetTableByName)("dungeonselect.ccardroleskillcd")
local CCellBattleInfo = (BeanManager.GetTableByName)("dungeonselect.ccellbattleinfo")
local CGloballBuffConfig = (BeanManager.GetTableByName)("buff.cgloballbuffconfig")
local CSkillCameraMove = (BeanManager.GetTableByName)("skill.cskillcameramove")
local CSkinBuffEffectChange = (BeanManager.GetTableByName)("skill.cskinbuffeffectchange")
local CBuffNumConfig = (BeanManager.GetTableByName)("role.cbuffnumconfig")
DataUtility.VoiceType = {LevelUp = "LevelUp", LimitUp = "LimitUp", RareUp = "RareUp", Impression = "Impression", NormalGift = "NormalGift", FavoriteGift = "FavoriteGift", BodyTouch = "BodyTouch", Standby = "Standby", Formation = "Formation", Adventure = "Adventure", OpenBox = "OpenBox", ManaTree = "ManaTree", LifeHealing = "LifeHealing", BattleStart = "BattleStart", SkillID = "SkillID", SkillCV = "SkillCV", Attacked = "Attacked", Revive = "Revive", Victory = "Victory", Defeat = "Defeat", BattleKill = "BattleKill", YardTouch = "YardTouch", Dispatch = "Dispatch", Withdraw = "Withdraw", Summory = "Summory", Conversation = "Conversation", Emotion = "Emotion", Introduction = "Introduction", Login = "Login"}
DataUtility.PowerType = {Red = 1, Blue = 2}
DataUtility.CSkillEnemyBuffValuesFunc = {}
DataUtility.CSkillFriendBuffValuesFunc = {}
DataUtility.BattleFormulaVariables = {math = fixedpoint, 
f = {}
, fixedpoint = fixedpoint}
DataUtility.InitCSkillFormulaCfgBattleFormula = function()
  -- function num : 0_0 , upvalues : CSkillFormulaCfg, _ENV, DataUtility
  local allIds = CSkillFormulaCfg:GetAllIds()
  for _,id in ipairs(allIds) do
    local recorder = CSkillFormulaCfg:GetRecorder(id)
    if ((DataUtility.BattleFormulaVariables).f)[recorder.FormulaName] then
      LogErrorFormat("DataUtility", "the same FormulaName %s in cskillformulacfg", recorder.FormulaName)
    else
      local funstr = "f." .. recorder.FormulaName .. "=function("
      local attrCount = #recorder.attr
      for i,attrName in ipairs(recorder.attr) do
        funstr = funstr .. attrName
        if i < attrCount then
          funstr = funstr .. ","
        end
      end
      funstr = funstr .. ") return " .. recorder.Formula .. "," .. recorder.BaseDamageFormula .. " end"
      ;
      (assert(load(funstr, "f." .. recorder.FormulaName, "t", DataUtility.BattleFormulaVariables)))()
    end
  end
end

DataUtility.InitCSkillBattleFormula = function()
  -- function num : 0_1 , upvalues : CSkill, _ENV, DataUtility
  local cskillAllIds = CSkill:GetAllIds()
  for _,skillid in ipairs(cskillAllIds) do
    local ourlist, enemylist = (((BattleECS.Utility).BuffUtility).GetSKillBuffList)(skillid)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (DataUtility.CSkillFriendBuffValuesFunc)[skillid] = {}
    for _,v in ipairs(ourlist) do
      local record = (string.split)(v.buffvalues, ";")
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R14 in 'UnsetPending'

      if v.buffid then
        ((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[v.buffid] = {}
        for index,param in ipairs(record) do
          local r = (string.split)(param, "=")
          if (string.find)(r[1], "_value") then
            local splitIndex = (string.find)(param, "=")
            local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = (assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables)))()
            -- DECOMPILER ERROR at PC84: Confused about usage of register: R24 in 'UnsetPending'

            ;
            (((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[v.buffid])[r[1]] = func
          else
            do
              if #r == 2 then
                local splitIndex = (string.find)(param, "=")
                local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
                local funstr = "return function() return " .. formula .. " end"
                local func = (assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables)))()
                -- DECOMPILER ERROR at PC124: Confused about usage of register: R24 in 'UnsetPending'

                ;
                (((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[v.buffid])[r[1]] = func
              end
              do
                -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      else
        LogErrorFormat("DataUtility", "skillid %s friendbuffid is wrong", skillid)
      end
    end
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (DataUtility.CSkillEnemyBuffValuesFunc)[skillid] = {}
    for _,v in ipairs(enemylist) do
      local record = (string.split)(v.buffvalues, ";")
      -- DECOMPILER ERROR at PC154: Confused about usage of register: R14 in 'UnsetPending'

      if v.buffid then
        ((DataUtility.CSkillEnemyBuffValuesFunc)[skillid])[v.buffid] = {}
        for index,param in ipairs(record) do
          local r = (string.split)(param, "=")
          if (string.find)(r[1], "_value") then
            local splitIndex = (string.find)(param, "=")
            local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = (assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables)))()
            -- DECOMPILER ERROR at PC206: Confused about usage of register: R24 in 'UnsetPending'

            ;
            (((DataUtility.CSkillEnemyBuffValuesFunc)[skillid])[v.buffid])[r[1]] = func
          else
            do
              if #r == 2 then
                local splitIndex = (string.find)(param, "=")
                local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
                local funstr = "return function() return " .. formula .. " end"
                local func = (assert(load(funstr, "skillid " .. skillid .. "..", "t", DataUtility.BattleFormulaVariables)))()
                -- DECOMPILER ERROR at PC246: Confused about usage of register: R24 in 'UnsetPending'

                ;
                (((DataUtility.CSkillEnemyBuffValuesFunc)[skillid])[v.buffid])[r[1]] = func
              end
              do
                -- DECOMPILER ERROR at PC247: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC247: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC247: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      else
        LogErrorFormat("DataUtility", "skillid %s enemybuffid is wrong", skillid)
      end
    end
  end
end

DataUtility.InitCGlobalBuffBattleFormula = function()
  -- function num : 0_2 , upvalues : CGloballBuffConfig, _ENV, DataUtility
  local skillid = 0
  local CGloballBuffConfigAllIds = CGloballBuffConfig:GetAllIds()
  for _,id in ipairs(CGloballBuffConfigAllIds) do
    local record = CGloballBuffConfig:GetRecorder(id)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    if not (DataUtility.CSkillFriendBuffValuesFunc)[skillid] then
      (DataUtility.CSkillFriendBuffValuesFunc)[skillid] = {}
      do
        local inRecord = (string.split)(record.buffattr, ";")
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[id] = {}
        for index,param in ipairs(inRecord) do
          local r = (string.split)(param, "=")
          if (string.find)(r[1], "_value") then
            local splitIndex = (string.find)(param, "=")
            local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
            local funstr = "return function() return " .. formula .. " end"
            local func = (assert(load(funstr, "cgloballbuffconfig buffid " .. id, "t", DataUtility.BattleFormulaVariables)))()
            -- DECOMPILER ERROR at PC77: Confused about usage of register: R19 in 'UnsetPending'

            ;
            (((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[id])[r[1]] = func
          else
            do
              if #r == 2 then
                local splitIndex = (string.find)(param, "=")
                local formula = (string.sub)(param, splitIndex + 1, (string.len)(param))
                local funstr = "return function() return " .. formula .. " end"
                local func = (assert(load(funstr, "cgloballbuffconfig buffid " .. id, "t", DataUtility.BattleFormulaVariables)))()
                -- DECOMPILER ERROR at PC115: Confused about usage of register: R19 in 'UnsetPending'

                ;
                (((DataUtility.CSkillFriendBuffValuesFunc)[skillid])[id])[r[1]] = func
              end
              do
                -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

DataUtility.ClearBattleFormulaVariables = function()
  -- function num : 0_3 , upvalues : DataUtility, _ENV
  local functionList = (DataUtility.BattleFormulaVariables).f
  for key,value in pairs(DataUtility.BattleFormulaVariables) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.BattleFormulaVariables)[key] = 0
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (DataUtility.BattleFormulaVariables).math = fixedpoint
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (DataUtility.BattleFormulaVariables).fixedpoint = fixedpoint
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (DataUtility.BattleFormulaVariables).f = functionList
end

DataUtility.CSkillRateCfgFunc = {}
DataUtility.SkillRateFormulaVariables = {math = fixedpoint, fixedpoint = fixedpoint}
DataUtility.InitCSkillRateCfgFormula = function()
  -- function num : 0_4 , upvalues : CSkillRateCfg, _ENV, DataUtility
  local cskillRateAllIds = CSkillRateCfg:GetAllIds()
  for _,skillid in ipairs(cskillRateAllIds) do
    local record = CSkillRateCfg:GetRecorder(skillid)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (DataUtility.CSkillRateCfgFunc)[skillid] = {}
    for index,rateSkill in ipairs(record.skillid) do
      local formula = (record.skillrate)[index]
      local funstr = "return function() return " .. formula .. " end"
      local func = (assert(load(funstr, skillid .. ".. rateSkill" .. rateSkill .. "..", "t", DataUtility.SkillRateFormulaVariables)))()
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((DataUtility.CSkillRateCfgFunc)[skillid])[rateSkill] = func
    end
  end
end

DataUtility.ClearSkillRateFormulaVariables = function()
  -- function num : 0_5 , upvalues : _ENV, DataUtility
  for key,value in pairs(DataUtility.SkillRateFormulaVariables) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

    (DataUtility.SkillRateFormulaVariables)[key] = 0
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.SkillRateFormulaVariables).math = fixedpoint
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.SkillRateFormulaVariables).fixedpoint = fixedpoint
end

DataUtility.CSkillCostCfgFunc = {}
DataUtility.SkillCostFormulaVariables = {math = fixedpoint, fixedpoint = fixedpoint}
DataUtility.InitCSkillCostCfgFormula = function()
  -- function num : 0_6 , upvalues : CCostSkill, _ENV, DataUtility
  local cskillCostAllIds = CCostSkill:GetAllIds()
  for _,skillid in ipairs(cskillCostAllIds) do
    local record = CCostSkill:GetRecorder(skillid)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    if record and record.pureCost ~= "" then
      (DataUtility.CSkillCostCfgFunc)[skillid] = {}
      local rec = (string.split)(record.pureCost, ";")
      local funstr = "return function() return " .. rec[(DataUtility.PowerType).Red] .. " end"
      local func = (assert(load(funstr, skillid .. ".. ccostskill" .. skillid .. "..", "t", DataUtility.SkillCostFormulaVariables)))()
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((DataUtility.CSkillCostCfgFunc)[skillid])[(DataUtility.PowerType).Red] = func
      funstr = "return function() return " .. rec[(DataUtility.PowerType).Blue] .. " end"
      func = (assert(load(funstr, skillid .. ".. ccostskill" .. skillid .. "..", "t", DataUtility.SkillCostFormulaVariables)))()
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((DataUtility.CSkillCostCfgFunc)[skillid])[(DataUtility.PowerType).Blue] = func
    end
  end
end

DataUtility.ClearSkillCostFormulaVariables = function()
  -- function num : 0_7 , upvalues : _ENV, DataUtility
  for key,value in pairs(DataUtility.SkillCostFormulaVariables) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

    (DataUtility.SkillCostFormulaVariables)[key] = 0
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.SkillCostFormulaVariables).math = fixedpoint
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.SkillCostFormulaVariables).fixedpoint = fixedpoint
end

DataUtility.InitCSkillbehavior = function()
  -- function num : 0_8 , upvalues : CSkillBehavior, DataUtility, _ENV
  local CSkillBehaviorAllIds = CSkillBehavior:GetAllIds()
  DataUtility.cSkillBehaviorTable = {}
  for _,id in ipairs(CSkillBehaviorAllIds) do
    local record = CSkillBehavior:GetRecorder(id)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (DataUtility.cSkillBehaviorTable)[id] = {}
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

    if record.actionAtk then
      ((DataUtility.cSkillBehaviorTable)[id]).actionAtk = record.actionAtk
    end
    local effect = (string.split)(record.typeMineEffectAtk, ";")
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((DataUtility.cSkillBehaviorTable)[id]).typeMineEffectAtk = {}
    for k,v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        (table.insert)(((DataUtility.cSkillBehaviorTable)[id]).typeMineEffectAtk, skillEffectId)
      else
        if (string.len)(v) > 0 then
          local vTable = (string.split)(v, "||")
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R15 in 'UnsetPending'

          if vTable then
            (((DataUtility.cSkillBehaviorTable)[id]).typeMineEffectAtk)[k] = {}
            for _,v1 in ipairs(vTable) do
              (table.insert)((((DataUtility.cSkillBehaviorTable)[id]).typeMineEffectAtk)[k], tonumber(v1))
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((DataUtility.cSkillBehaviorTable)[id]).flightPropEffectAtk = {}
    local effect = (string.split)(record.flightPropEffectAtk, ";")
    for k,v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        (table.insert)(((DataUtility.cSkillBehaviorTable)[id]).flightPropEffectAtk, skillEffectId)
      else
        if (string.len)(v) > 0 then
          local vTable = (string.split)(v, "||")
          -- DECOMPILER ERROR at PC128: Confused about usage of register: R16 in 'UnsetPending'

          if vTable then
            (((DataUtility.cSkillBehaviorTable)[id]).flightPropEffectAtk)[k] = {}
            for _,v1 in ipairs(vTable) do
              (table.insert)((((DataUtility.cSkillBehaviorTable)[id]).flightPropEffectAtk)[k], tonumber(v1))
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC150: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((DataUtility.cSkillBehaviorTable)[id]).invalidEffectAtk = {}
    effect = (string.split)(record.invalidEffectAtk, ";")
    for k,v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        (table.insert)(((DataUtility.cSkillBehaviorTable)[id]).invalidEffectAtk, skillEffectId)
      else
        if (string.len)(v) > 0 then
          local vTable = (string.split)(v, "||")
          -- DECOMPILER ERROR at PC191: Confused about usage of register: R16 in 'UnsetPending'

          if vTable then
            (((DataUtility.cSkillBehaviorTable)[id]).invalidEffectAtk)[k] = {}
            for _,v1 in ipairs(vTable) do
              (table.insert)((((DataUtility.cSkillBehaviorTable)[id]).invalidEffectAtk)[k], tonumber(v1))
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC213: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((DataUtility.cSkillBehaviorTable)[id]).noColliderEffectAtk = {}
    effect = (string.split)(record.noColliderEffectAtk, ";")
    for k,v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        (table.insert)(((DataUtility.cSkillBehaviorTable)[id]).noColliderEffectAtk, skillEffectId)
      else
        if (string.len)(v) > 0 then
          local vTable = (string.split)(v, "||")
          -- DECOMPILER ERROR at PC254: Confused about usage of register: R16 in 'UnsetPending'

          if vTable then
            (((DataUtility.cSkillBehaviorTable)[id]).noColliderEffectAtk)[k] = {}
            for _,v1 in ipairs(vTable) do
              (table.insert)((((DataUtility.cSkillBehaviorTable)[id]).noColliderEffectAtk)[k], tonumber(v1))
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC276: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((DataUtility.cSkillBehaviorTable)[id]).WarningEffect = {}
    effect = (string.split)(record.WarningEffect, ";")
    for k,v in ipairs(effect) do
      local skillEffectId = tonumber(v)
      if skillEffectId then
        (table.insert)(((DataUtility.cSkillBehaviorTable)[id]).WarningEffect, skillEffectId)
      else
        if (string.len)(v) > 0 then
          local vTable = (string.split)(v, "||")
          -- DECOMPILER ERROR at PC317: Confused about usage of register: R16 in 'UnsetPending'

          if vTable then
            (((DataUtility.cSkillBehaviorTable)[id]).WarningEffect)[k] = {}
            for _,v1 in ipairs(vTable) do
              (table.insert)((((DataUtility.cSkillBehaviorTable)[id]).WarningEffect)[k], tonumber(v1))
            end
          end
        end
      end
    end
  end
end

DataUtility.CSkillFriendBuffValueTable = {}
DataUtility.CSkillEnemyBuffValueTable = {}
DataUtility.InitSplitCSkillBuffValue = function()
  -- function num : 0_9 , upvalues : CSkill, _ENV, DataUtility
  local cskillAllIds = CSkill:GetAllIds()
  for _,skillid in ipairs(cskillAllIds) do
    local recorder = CSkill:GetRecorder(skillid)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    if recorder.friendbuffid ~= "" then
      if not (DataUtility.CSkillFriendBuffValueTable)[skillid] then
        (DataUtility.CSkillFriendBuffValueTable)[skillid] = {}
        local friendValue = (string.split)((string.sub)(recorder.friendbuffValues, 2, (string.len)(recorder.friendbuffValues) - 1), "}{")
        for k,v in ipairs((string.split)(recorder.friendbuffid, ";")) do
          (table.insert)((DataUtility.CSkillFriendBuffValueTable)[skillid], {buffid = tonumber(v), buffvalues = friendValue[k]})
        end
        do
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R7 in 'UnsetPending'

          if recorder.enemybuffid ~= "" then
            if not (DataUtility.CSkillEnemyBuffValueTable)[skillid] then
              (DataUtility.CSkillEnemyBuffValueTable)[skillid] = {}
              local enermyValue = (string.split)((string.sub)(recorder.enemybuffValues, 2, (string.len)(recorder.enemybuffValues) - 1), "}{")
              for k,v in ipairs((string.split)(recorder.enemybuffid, ";")) do
                (table.insert)((DataUtility.CSkillEnemyBuffValueTable)[skillid], {buffid = tonumber(v), buffvalues = enermyValue[k]})
              end
              do
                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

DataUtility.RoleSkillCVCD = {}
DataUtility.InitPowerNumType = function()
  -- function num : 0_10 , upvalues : DataUtility, _ENV
  DataUtility.PowerNumType = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.PowerNumType)[(DataUtility.PowerType).Red] = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.PowerNumType)[(DataUtility.PowerType).Blue] = {}
  DataUtility.PowerLimit = {}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.PowerLimit)[(DataUtility.PowerType).Red] = {Down = 1, Up = tonumber(((DataUtility.cBattleConstCfgTable)[8]).attr)}
  for i = ((DataUtility.PowerLimit)[(DataUtility.PowerType).Red]).Down, ((DataUtility.PowerLimit)[(DataUtility.PowerType).Red]).Up do
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

    ((DataUtility.PowerNumType)[(DataUtility.PowerType).Red])[i] = fixedpoint(((DataUtility.cBattleConstCfgTable)[1]).attr) * i
  end
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (DataUtility.PowerLimit)[(DataUtility.PowerType).Blue] = {Down = 1, Up = tonumber(((DataUtility.cBattleConstCfgTable)[9]).attr)}
  for i = ((DataUtility.PowerLimit)[(DataUtility.PowerType).Blue]).Down, ((DataUtility.PowerLimit)[(DataUtility.PowerType).Blue]).Up do
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

    ((DataUtility.PowerNumType)[(DataUtility.PowerType).Blue])[i] = fixedpoint(((DataUtility.cBattleConstCfgTable)[2]).attr) * i
  end
end

DataUtility.GetPowerGridFunc = function(powerValue, cellValue)
  -- function num : 0_11 , upvalues : DataUtility, _ENV
  if not (DataUtility.PowerLimit)[cellValue] then
    LogErrorFormat("DataUtility", "DataUtility.PowerLimit[cellValue %s] is nil", cellValue)
    return 0
  end
  if not (DataUtility.PowerNumType)[cellValue] then
    LogErrorFormat("DataUtility", "DataUtility.PowerNumType[cellValue %s] is nil", cellValue)
    return 0
  end
  for i = ((DataUtility.PowerLimit)[cellValue]).Up, ((DataUtility.PowerLimit)[cellValue]).Down, -1 do
    if ((DataUtility.PowerNumType)[cellValue])[i] <= powerValue then
      return i
    end
  end
  return 0
end

DataUtility.InitConfigTable = function()
  -- function num : 0_12 , upvalues : CIBuffConfig, DataUtility, _ENV, CCostSkill, CSkillChange, CCBuffConfig, CBuffConflicts, CLinkSkillConditionCfg, CBuffLinkSkillCfg, CBuffSummon, CBossBreakCfg, CBattleConstCfg, CSkill, CAttrEffectIdName, CBuffNumConfig, CBuffEffect, CBuffTriggerAnimationCfg, RoleConfig, CMonsterConfig, CSkillAnimation, CSkillEffect, CNPCShape, CBuffLinkSkillGroupCfg, CSkillItem, CJoinBattleInfo, CSkillRateCfg, CEquipmentSkillIcon, CSoundCatalog, CBattleSoundChange, CSkinSkillEffectChange, CRoleSkinChangeshapeCfg, CSkin, CCardRoleSkillCD, CCellBattleInfo, CSkillFormulaCfg, CGloballBuffConfig, CSkillCameraMove, CSkinBuffEffectChange
  local allIds = CIBuffConfig:GetAllIds()
  DataUtility.cIBuffCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cIBuffCfgTable)[id] = CIBuffConfig:GetRecorder(id)
  end
  allIds = CCostSkill:GetAllIds()
  DataUtility.cSkillCostTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cSkillCostTable)[id] = CCostSkill:GetRecorder(id)
  end
  allIds = CSkillChange:GetAllIds()
  DataUtility.cSkillChangeTable = {}
  for _,id in ipairs(allIds) do
    local record = CSkillChange:GetRecorder(id)
    for _,buffId in ipairs((string.split)(record.buffId, ";")) do
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R12 in 'UnsetPending'

      if not (DataUtility.cSkillChangeTable)[tonumber(record.aSkillId)] then
        do
          (DataUtility.cSkillChangeTable)[tonumber(record.aSkillId)] = {}
          -- DECOMPILER ERROR at PC92: Confused about usage of register: R12 in 'UnsetPending'

          if not ((DataUtility.cSkillChangeTable)[tonumber(record.aSkillId)])[tonumber(buffId)] then
            ((DataUtility.cSkillChangeTable)[tonumber(record.aSkillId)])[tonumber(buffId)] = tonumber(record.bSkillId)
          else
            LogErrorFormat("DataUtility", "duplication : cskillchange always has aSkillId %s buffId %s", tonumber(record.aSkillId), tonumber(buffId))
          end
          -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  allIds = CCBuffConfig:GetAllIds()
  DataUtility.cBuffCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC123: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBuffCfgTable)[id] = CCBuffConfig:GetRecorder(id)
  end
  allIds = CBuffConflicts:GetAllIds()
  DataUtility.cBuffConficsTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC141: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBuffConficsTable)[id] = CBuffConflicts:GetRecorder(id)
  end
  allIds = CLinkSkillConditionCfg:GetAllIds()
  DataUtility.cLinkSkillConditionCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC159: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cLinkSkillConditionCfgTable)[id] = CLinkSkillConditionCfg:GetRecorder(id)
  end
  allIds = CBuffLinkSkillCfg:GetAllIds()
  DataUtility.cBuffLinkSkillCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC177: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBuffLinkSkillCfgTable)[id] = CBuffLinkSkillCfg:GetRecorder(id)
  end
  allIds = CBuffSummon:GetAllIds()
  DataUtility.cBuffSummonTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC195: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBuffSummonTable)[id] = CBuffSummon:GetRecorder(id)
  end
  allIds = CBossBreakCfg:GetAllIds()
  DataUtility.cBossBreakCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC213: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBossBreakCfgTable)[id] = CBossBreakCfg:GetRecorder(id)
  end
  allIds = CBattleConstCfg:GetAllIds()
  DataUtility.cBattleConstCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC231: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cBattleConstCfgTable)[id] = CBattleConstCfg:GetRecorder(id)
  end
  allIds = CSkill:GetAllIds()
  DataUtility.cskillTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC249: Confused about usage of register: R6 in 'UnsetPending'

    (DataUtility.cskillTable)[id] = CSkill:GetRecorder(id)
  end
  local attrIdList = {
{10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130}
, 
{140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290}
, 
{300, 310, 320, 350, 360, 370, 400, 410, 420, 430, 440, 450, 460}
, 
{490, 500, 510, 750, 530, 540, 590, 830, 610, 620, 630, 640, 650, 1060, 670, 680, 690, 700, 710, 720, 730, 740, 1070}
, 
{330, 340, 380, 390, 470, 480}
}
  DataUtility.soreCattr = {
{}
, 
{}
, 
{}
, 
{}
, 
{}
}
  allIds = CAttrEffectIdName:GetAllIds()
  for _,id in ipairs(allIds) do
    for i,v in ipairs(attrIdList[1]) do
      if id == v then
        (table.insert)((DataUtility.soreCattr)[1], {id = id, record = CAttrEffectIdName:GetRecorder(id)})
      end
    end
    for i,v in ipairs(attrIdList[2]) do
      if id == v then
        (table.insert)((DataUtility.soreCattr)[2], {id = id, record = CAttrEffectIdName:GetRecorder(id)})
      end
    end
    for i,v in ipairs(attrIdList[3]) do
      if id == v then
        (table.insert)((DataUtility.soreCattr)[3], {id = id, record = CAttrEffectIdName:GetRecorder(id)})
      end
    end
    for i,v in ipairs(attrIdList[4]) do
      if id == v then
        (table.insert)((DataUtility.soreCattr)[4], {id = id, record = CAttrEffectIdName:GetRecorder(id)})
      end
    end
    for i,v in ipairs(attrIdList[5]) do
      if id == v then
        (table.insert)((DataUtility.soreCattr)[5], {id = id, record = CAttrEffectIdName:GetRecorder(id)})
      end
    end
  end
  ;
  (table.insert)(DataUtility.soreCattr, {})
  for _,id in ipairs(CBuffNumConfig:GetAllIds()) do
    (table.insert)((DataUtility.soreCattr)[#DataUtility.soreCattr], {id = id, record = CBuffNumConfig:GetRecorder(id)})
  end
  allIds = CBuffEffect:GetAllIds()
  DataUtility.cBuffEffectCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC495: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cBuffEffectCfgTable)[id] = CBuffEffect:GetRecorder(id)
  end
  allIds = CBuffTriggerAnimationCfg:GetAllIds()
  DataUtility.cBuffAnimationCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC513: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cBuffAnimationCfgTable)[id] = CBuffTriggerAnimationCfg:GetRecorder(id)
  end
  allIds = RoleConfig:GetAllIds()
  DataUtility.roleConfigTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC531: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.roleConfigTable)[id] = RoleConfig:GetRecorder(id)
  end
  allIds = CMonsterConfig:GetAllIds()
  DataUtility.cMonsterCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC549: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cMonsterCfgTable)[id] = CMonsterConfig:GetRecorder(id)
  end
  allIds = CSkillAnimation:GetAllIds()
  DataUtility.cSkillAnimationTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC567: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkillAnimationTable)[id] = CSkillAnimation:GetRecorder(id)
  end
  allIds = CSkillEffect:GetAllIds()
  DataUtility.cSkillEffectTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC585: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkillEffectTable)[id] = CSkillEffect:GetRecorder(id)
  end
  allIds = CNPCShape:GetAllIds()
  DataUtility.cNPCShapeTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC603: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cNPCShapeTable)[id] = CNPCShape:GetRecorder(id)
  end
  allIds = CBuffLinkSkillGroupCfg:GetAllIds()
  DataUtility.cBuffLinkSkillGroupCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC621: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cBuffLinkSkillGroupCfgTable)[id] = CBuffLinkSkillGroupCfg:GetRecorder(id)
  end
  allIds = CSkillItem:GetAllIds()
  DataUtility.cSkillItemTable = {}
  for _,id in ipairs(allIds) do
    local record = CSkillItem:GetRecorder(id)
    for i,skillId in ipairs(record.skillID) do
      -- DECOMPILER ERROR at PC646: Confused about usage of register: R13 in 'UnsetPending'

      (DataUtility.cSkillItemTable)[skillId] = {itemId = id, lv = i}
    end
  end
  allIds = CJoinBattleInfo:GetAllIds()
  DataUtility.cJoinBattleInfoTable = {}
  for _,id in ipairs(allIds) do
    (table.insert)(DataUtility.cJoinBattleInfoTable, {id = id, record = CJoinBattleInfo:GetRecorder(id)})
  end
  allIds = CSkillRateCfg:GetAllIds()
  DataUtility.cSkillRateCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC689: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkillRateCfgTable)[id] = CSkillRateCfg:GetRecorder(id)
  end
  allIds = CEquipmentSkillIcon:GetAllIds()
  DataUtility.cEquipmentSkillIconTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC707: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cEquipmentSkillIconTable)[id] = CEquipmentSkillIcon:GetRecorder(id)
  end
  allIds = CSoundCatalog:GetAllIds()
  DataUtility.cSoundCatalogTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC725: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSoundCatalogTable)[id] = CSoundCatalog:GetRecorder(id)
  end
  allIds = CBattleSoundChange:GetAllIds()
  DataUtility.cBattleSoundChangeTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC743: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cBattleSoundChangeTable)[id] = CBattleSoundChange:GetRecorder(id)
  end
  allIds = CSkinSkillEffectChange:GetAllIds()
  DataUtility.cSkinSkillEffectChangeTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC761: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkinSkillEffectChangeTable)[id] = CSkinSkillEffectChange:GetRecorder(id)
  end
  allIds = CRoleSkinChangeshapeCfg:GetAllIds()
  DataUtility.cRoleSkinChangeshapeCfgTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC779: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cRoleSkinChangeshapeCfgTable)[id] = CRoleSkinChangeshapeCfg:GetRecorder(id)
  end
  allIds = CSkin:GetAllIds()
  DataUtility.cSkinTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC797: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkinTable)[id] = CSkin:GetRecorder(id)
  end
  allIds = CCardRoleSkillCD:GetAllIds()
  DataUtility.cCardRoleSkillCDTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC815: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cCardRoleSkillCDTable)[id] = CCardRoleSkillCD:GetRecorder(id)
  end
  allIds = CCellBattleInfo:GetAllIds()
  DataUtility.cCellBattleInfoTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC833: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cCellBattleInfoTable)[id] = CCellBattleInfo:GetRecorder(id)
  end
  allIds = CSkillFormulaCfg:GetAllIds()
  DataUtility.cSkillFormulaCfgTable = {}
  for _,id in ipairs(allIds) do
    (table.insert)(DataUtility.cSkillFormulaCfgTable, {id = id, record = CSkillFormulaCfg:GetRecorder(id)})
  end
  allIds = CGloballBuffConfig:GetAllIds()
  DataUtility.cGlobalBuffConfigTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC874: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cGlobalBuffConfigTable)[id] = CGloballBuffConfig:GetRecorder(id)
  end
  allIds = CSkillCameraMove:GetAllIds()
  DataUtility.cSkillCameraMoveTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC892: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkillCameraMoveTable)[id] = CSkillCameraMove:GetRecorder(id)
  end
  allIds = CSkinBuffEffectChange:GetAllIds()
  DataUtility.cSkinBuffEffectChangeTable = {}
  for _,id in ipairs(allIds) do
    -- DECOMPILER ERROR at PC910: Confused about usage of register: R7 in 'UnsetPending'

    (DataUtility.cSkinBuffEffectChangeTable)[id] = CSkinBuffEffectChange:GetRecorder(id)
  end
end

return DataUtility

