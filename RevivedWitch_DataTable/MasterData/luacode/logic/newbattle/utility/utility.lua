-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/utility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Utility = {}
Utility.SkillEffectCampType = {OwnSide = 1, Enemy = 2, Both = 3}
Utility.SkillUseFailedType = {PowerNotEnough = 1, UsingOtherSkill = 2, SkillInCD = 3, CanNotUseSkillBuff = 4, NotInPoint = 5}
local calculationcdtime = function(cdtime, entity)
  -- function num : 0_0 , upvalues : _ENV
  local attackspeed = (fixedpoint.min)(5, (fixedpoint.max)((entity:GetComponent((BattleECS.Components).AttackComponent))._attackSpeed, fixedpoint("-0.8")))
  return (fixedpoint.floor)(cdtime / (1 + attackspeed))
end

Utility.IsInCD = function(entity, skillid)
  -- function num : 0_1 , upvalues : _ENV, calculationcdtime
  if #(entity:GetComponent((BattleECS.Components).SkillComponent))._skillList > 0 then
    local flag = true
    local skill = nil
    local skillList = {}
    for _,v in ipairs(skillid) do
      local skillInfo = nil
      for _,skillTable in ipairs((entity:GetComponent((BattleECS.Components).SkillComponent))._skillList) do
        if v == skillTable.skillId then
          skillInfo = skillTable
          break
        end
      end
      do
        do
          -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

          if skillInfo and calculationcdtime(skillInfo.cdTime, entity) <= skillInfo.currentTime then
            flag = false
            skill = v
          end
          LogErrorFormat("Utility", "entity not has this skillid:%s", v)
          -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    return flag, skill
  end
end

Utility.IsHasRateSkill = function(battleWorld, skillid, data)
  -- function num : 0_2 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cSkillRateCfgTable)[skillid]
  if record then
    local skillRateList = {}
    for index,rateSkill in ipairs(record.skillid) do
      local formula = (record.skillrate)[index]
      local findAttrInFormula = false
      local paramterAddTable = {"passiveskill", "evolution", "exclusivelv"}
      for _,v in ipairs(paramterAddTable) do
        local i = 0
        while 1 do
          -- DECOMPILER ERROR at PC33: Confused about usage of register: R19 in 'UnsetPending'

          if v == "evolution" then
            (((BattleECS.Utility).DataUtility).SkillRateFormulaVariables).evolution = (data.typeComponentA)._evolutionLevel
            break
          else
            -- DECOMPILER ERROR at PC44: Confused about usage of register: R19 in 'UnsetPending'

            if v == "exclusivelv" then
              (((BattleECS.Utility).DataUtility).SkillRateFormulaVariables).exclusivelv = (data.typeComponentA)._exclusiveLevel
              break
            end
          end
          i = (string.find)(formula, v .. "a", i + 1)
          if i ~= nil then
            findAttrInFormula = true
            -- DECOMPILER ERROR at PC66: Confused about usage of register: R19 in 'UnsetPending'

            if v == "passiveskill" then
              (((BattleECS.Utility).DataUtility).SkillRateFormulaVariables).passiveskilla = (data.skillComponentA)._isHasPassiveSkillParamter
            end
            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      local result = fixedpoint_zero
      local func = nil
      if (((BattleECS.Utility).DataUtility).CSkillRateCfgFunc)[skillid] and ((((BattleECS.Utility).DataUtility).CSkillRateCfgFunc)[skillid])[rateSkill] then
        func = ((((BattleECS.Utility).DataUtility).CSkillRateCfgFunc)[skillid])[rateSkill]
      end
      if func then
        result = func()
      else
        if not findAttrInFormula then
          result = fixedpoint(formula)
        else
          LogErrorFormat("Utility", "function loading failed skillid %s rateSkill %s formula %s, table is cskillratecfg", skillid, rateSkill, formula)
        end
      end
      if not (fixedpoint.judgetype)(result) then
        result = fixedpoint(result)
      end
      skillRateList[index] = result
    end
    local upRate, downRate = 0, 0
    local totalRate = 0
    for _,r in ipairs(skillRateList) do
      totalRate = totalRate + r
    end
    local tagRate = (battleWorld._randomPcg)(1, 100)
    for i,skillid in ipairs(record.skillid) do
      upRate = downRate
      downRate = upRate + skillRateList[i] / (totalRate)
      if upRate * 100 < tagRate and tagRate <= (downRate) * 100 then
        return true, tonumber(skillid)
      end
    end
  end
  do
    return false
  end
end

Utility.IsYeRenBiaoJi = function(skillid)
  -- function num : 0_3
  do return skillid == 6014301 or skillid == 6014302 or skillid == 6014303 or skillid == 6014304 or skillid == 6014305 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsYuZiZhaoHuan = function(skillid)
  -- function num : 0_4
  do return skillid == 6060101 or skillid == 6060102 or skillid == 6060103 or skillid == 6060104 or skillid == 6060105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsLiuGuangZhan = function(skillid)
  -- function num : 0_5
  do return skillid == 6013101 or skillid == 6013102 or skillid == 6013103 or skillid == 6013104 or skillid == 6013105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsMoLiZhenDang = function(skillid)
  -- function num : 0_6
  do return skillid == 6000301 or skillid == 6000302 or skillid == 6000303 or skillid == 6000304 or skillid == 6000305 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsShiKongZhiMen = function(skillid)
  -- function num : 0_7
  do return skillid == 6000501 or skillid == 6000502 or skillid == 6000503 or skillid == 6000504 or skillid == 6000505 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsShiBuKeDang = function(skillid)
  -- function num : 0_8
  do return skillid == 6011101 or skillid == 6011102 or skillid == 6011103 or skillid == 6011104 or skillid == 6011105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsRouGuang = function(skillid)
  -- function num : 0_9
  do return skillid == 6002101 or skillid == 6002102 or skillid == 6002103 or skillid == 6002104 or skillid == 6002105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsYingXiSkill = function(skillid)
  -- function num : 0_10
  do return skillid == 6014101 or skillid == 6014102 or skillid == 6014103 or skillid == 6014104 or skillid == 6014105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsLiuXingZhan = function(skillid)
  -- function num : 0_11
  do return skillid == 6013201 or skillid == 6013202 or skillid == 6013203 or skillid == 6013204 or skillid == 6013205 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsSkillTypeEffectNeedDiffTarget = function(skillid)
  -- function num : 0_12
  do return skillid == 6069101 or skillid == 6069102 or skillid == 6069103 or skillid == 6069104 or skillid == 6069105 or skillid == 6098101 or skillid == 6098102 or skillid == 6098103 or skillid == 6098104 or skillid == 6098105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsShiKongZhiMenEffect = function(effectId)
  -- function num : 0_13
  do return effectId == 600050106 or effectId == 600050106 or effectId == 600050106 or effectId == 600050106 or effectId == 600050106 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsShiXiangGuiSiWangGuangXian = function(skillid)
  -- function num : 0_14
  do return skillid == 201008 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsLingShouChongJi = function(skillid)
  -- function num : 0_15
  do return skillid == 6070201 or skillid == 6070202 or skillid == 6070203 or skillid == 6070204 or skillid == 6070205 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsAiSheLei1Skill = function(skillid)
  -- function num : 0_16
  do return skillid == 6084101 or skillid == 6084102 or skillid == 6084103 or skillid == 6084104 or skillid == 6084105 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.IsAiSheLei2Skill = function(skillid)
  -- function num : 0_17
  do return skillid == 6084201 or skillid == 6084202 or skillid == 6084203 or skillid == 6084204 or skillid == 6084205 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.GetSkillAttackNumber = function(skillid)
  -- function num : 0_18 , upvalues : _ENV
  return ((((BattleECS.Utility).DataUtility).cskillTable)[skillid]).collideTime
end

Utility.IsSkillHasCollider = function(skillid)
  -- function num : 0_19 , upvalues : _ENV
  do return ((((BattleECS.Utility).DataUtility).cskillTable)[skillid]).colliderOrNot == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Utility.ClearSkillCurrentTime = function(entity, skillid)
  -- function num : 0_20 , upvalues : _ENV
  local skillComponnet = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponnet then
    for _,v in ipairs(skillComponnet._skillList) do
      if skillid == v.skillId then
        v.currentTime = 0
        break
      end
    end
  end
end

Utility.ClearEntityAllSkillCurrentTime = function(entity)
  -- function num : 0_21 , upvalues : _ENV
  local skillComponnet = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponnet then
    for _,v in ipairs(skillComponnet._skillList) do
      v.currentTime = 0
    end
  end
end

Utility.IsMonsterSkillInCD = function(entity, skillid)
  -- function num : 0_22 , upvalues : _ENV, Utility, calculationcdtime
  local skillComponnet = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponnet then
    for _,v in ipairs(skillComponnet._skillList) do
      -- DECOMPILER ERROR at PC27: Unhandled construct in 'MakeBoolean' P1

      if skillid == v.skillId and (Utility.IsAttackSkill)(skillid) and calculationcdtime(v.cdTime, entity) <= v.currentTime then
        return false
      end
      if v.cdTime <= v.currentTime then
        return false
      end
    end
  end
  do
    return true
  end
end

Utility.SetSkillID = function(entity, id)
  -- function num : 0_23 , upvalues : _ENV, Utility
  local originalSkillId = (entity:GetComponent((BattleECS.Components).SkillComponent))._skillId
  if (Utility.IsUseSkill)(originalSkillId) and (Utility.IsAttackSkill)(id) then
    return 
  end
  ;
  (entity:GetComponent((BattleECS.Components).SkillComponent))._skillId = id
end

Utility.SetSkillIsCostPowerState = function(entity, state)
  -- function num : 0_24 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).SkillComponent))._isCostPower = state
end

Utility.SetSkillComponnetPassiveSkillList = function(entity, skillStruct, targetEntity, isRoleDeadAlsoCanUsePassiveSkill)
  -- function num : 0_25 , upvalues : _ENV
  local id = nil
  if skillStruct.skillid then
    id = skillStruct.skillid
  else
    if skillStruct.skillgroupid then
      local record = (((BattleECS.Utility).DataUtility).cBuffLinkSkillGroupCfgTable)[skillStruct.skillgroupid]
      if record then
        local lv = nil
        local skillList = (entity:GetComponent((BattleECS.Components).SkillComponent))._skillList
        for _,v in ipairs(skillList) do
          local r = (((BattleECS.Utility).DataUtility).cSkillItemTable)[v.skillId]
          if r and r.itemId == tonumber(record.skillitemid) then
            lv = r.lv
            break
          end
        end
        do
          do
            do
              if lv then
                id = tonumber((record.skilllv)[lv])
              else
                LogErrorFormat("Utility", "cbufflinkskillgroupcfg skillgroupid %s 的 skillitemid %s 不在 cskillitem 中", skillStruct.skillgroupid, record.skillitemid)
              end
              LogErrorFormat("Utility", "cbufflinkskillcfg 中存在一项 skillid 为空，同时skillgroupid %s 也不在 cbufflinkskillgroupcfg 中", skillStruct.skillgroupid)
              if id then
                (table.insert)((entity:GetComponent((BattleECS.Components).SkillComponent))._passiveSkillList, {id = id, target = targetEntity, isRoleDeadAlsoCanUsePassiveSkill = isRoleDeadAlsoCanUsePassiveSkill})
              end
            end
          end
        end
      end
    end
  end
end

Utility.IfSkillTargetIsPassiveSkillTarget = function(skillId, camp)
  -- function num : 0_26 , upvalues : _ENV
  local campType = {AttackOrderToEmery = 1, AttackOrderToOur = 2}
  local config = (((BattleECS.Utility).DataUtility).cskillTable)[skillId]
  if camp == campType.AttackOrderToOur then
    if config.attackOrderToOur ~= 17 then
      do return not config end
      if config.attackOrderToEmery ~= 17 then
        do return camp ~= campType.AttackOrderToEmery end
        do return false end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

Utility.GetSkillEffectEntity = function(skillid, useSkillEntityId, battleWorld)
  -- function num : 0_27 , upvalues : _ENV, Utility
  local entity = nil
  for i,e in ipairs(battleWorld._entitys) do
    if e._entityId == useSkillEntityId then
      entity = e
      break
    end
  end
  do
    if entity then
      local list = {}
      local config = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
      local useSkillEntitycamp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
      if (Utility.GetSkillEffectCamp)(skillid) == (Utility.SkillEffectCampType).OwnSide then
        if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Left then
          local efffectEntityNum = (math.min)(config.targetNumberToOur, (table.nums)(battleWorld._leftPlayerList) + (table.nums)(battleWorld._leftPlayerSummonList))
          local record = {}
          for _,v in ipairs(battleWorld._leftPlayerList) do
            if not (Utility.IsRoleDead)(v) then
              (table.insert)(record, v)
            end
          end
          for _,v in ipairs(battleWorld._leftPlayerSummonList) do
            if not (Utility.IsRoleDead)(v) then
              (table.insert)(record, v)
            end
          end
          local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToOur, entity)
          for _,v in ipairs(rankList) do
            if (config.attackOrderToOur ~= 18 or v._entityId ~= useSkillEntityId) and (table.nums)(list) < efffectEntityNum then
              (table.insert)(list, v)
            end
          end
        else
          do
            if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Right then
              local efffectEntityNum = (math.min)(config.targetNumberToOur, (table.nums)(battleWorld._rightPlayerList) + (table.nums)(battleWorld._rightPlayerSummonList))
              local record = {}
              for _,v in ipairs(battleWorld._rightPlayerList) do
                if not (Utility.IsRoleDead)(v) and not (Utility.IsEntityEscape)(v) then
                  (table.insert)(record, v)
                end
              end
              for _,v in ipairs(battleWorld._rightPlayerSummonList) do
                if not (Utility.IsRoleDead)(v) and not (Utility.IsEntityEscape)(v) then
                  (table.insert)(record, v)
                end
              end
              local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToOur, entity)
              for _,v in ipairs(rankList) do
                if (config.attackOrderToOur ~= 18 or v._entityId ~= useSkillEntityId) and (table.nums)(list) < efffectEntityNum then
                  (table.insert)(list, v)
                end
              end
            end
            do
              if (Utility.GetSkillEffectCamp)(skillid) == (Utility.SkillEffectCampType).Enemy then
                if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Left then
                  local efffectEntityNum = (math.min)(config.targetNumberToEmery, (table.nums)(battleWorld._rightPlayerList) + (table.nums)(battleWorld._rightPlayerSummonList))
                  local record = {}
                  for _,v in ipairs(battleWorld._rightPlayerList) do
                    if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) and not (Utility.IsEntityEscape)(v) then
                      (table.insert)(record, v)
                    end
                  end
                  for _,v in ipairs(battleWorld._rightPlayerSummonList) do
                    if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) and not (Utility.IsEntityEscape)(v) then
                      (table.insert)(record, v)
                    end
                  end
                  local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToEmery, entity)
                  -- DECOMPILER ERROR at PC310: Unhandled construct in 'MakeBoolean' P1

                  if config.attackOrderToEmery == 5 and (table.nums)(rankList) > 0 then
                    if (table.nums)(rankList) == 1 then
                      (table.insert)(list, rankList[1])
                    else
                      local random = (battleWorld._randomPcg)(1, (table.nums)(rankList))
                      local entity = rankList[random]
                      ;
                      (table.insert)(list, entity)
                    end
                  end
                  do
                    for _,v in ipairs(rankList) do
                      if (table.nums)(list) < efffectEntityNum then
                        (table.insert)(list, v)
                      end
                    end
                    do
                      if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Right then
                        local efffectEntityNum = (math.min)(config.targetNumberToEmery, (table.nums)(battleWorld._leftPlayerList) + (table.nums)(battleWorld._leftPlayerSummonList))
                        local record = {}
                        for _,v in ipairs(battleWorld._leftPlayerList) do
                          if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) then
                            (table.insert)(record, v)
                          end
                        end
                        for _,v in ipairs(battleWorld._leftPlayerSummonList) do
                          if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) then
                            (table.insert)(record, v)
                          end
                        end
                        local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToEmery, entity)
                        -- DECOMPILER ERROR at PC428: Unhandled construct in 'MakeBoolean' P1

                        if config.attackOrderToEmery == 5 and (table.nums)(rankList) > 0 then
                          if (table.nums)(rankList) == 1 then
                            (table.insert)(list, rankList[1])
                          else
                            local random = (battleWorld._randomPcg)(1, (table.nums)(rankList))
                            local entity = rankList[random]
                            ;
                            (table.insert)(list, entity)
                          end
                        end
                      end
                      do
                        for _,v in ipairs(rankList) do
                          if (table.nums)(list) < efffectEntityNum then
                            (table.insert)(list, v)
                          end
                        end
                        do
                          if (Utility.GetSkillEffectCamp)(skillid) == (Utility.SkillEffectCampType).Both then
                            if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Left then
                              local efffectEntityNum = (math.min)(config.targetNumberToEmery, (table.nums)(battleWorld._rightPlayerList) + (table.nums)(battleWorld._rightPlayerSummonList))
                              local record = {}
                              for _,v in ipairs(battleWorld._rightPlayerList) do
                                if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) and not (Utility.IsEntityEscape)(v) then
                                  (table.insert)(record, v)
                                end
                              end
                              for _,v in ipairs(battleWorld._rightPlayerSummonList) do
                                if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) and not (Utility.IsEntityEscape)(v) then
                                  (table.insert)(record, v)
                                end
                              end
                              local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToEmery, entity)
                              for _,v in ipairs(rankList) do
                                if (table.nums)(list) < efffectEntityNum then
                                  (table.insert)(list, v)
                                end
                              end
                            else
                              do
                                local efffectEntityNum = (math.min)(config.targetNumberToEmery, (table.nums)(battleWorld._leftPlayerList) + (table.nums)(battleWorld._leftPlayerSummonList))
                                local record = {}
                                for _,v in ipairs(battleWorld._leftPlayerList) do
                                  if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) then
                                    (table.insert)(record, v)
                                  end
                                end
                                for _,v in ipairs(battleWorld._leftPlayerSummonList) do
                                  if (((BattleECS.Utility).BuffUtility).IsCanBeChosenInDifferentCampSkill)(v) then
                                    (table.insert)(record, v)
                                  end
                                end
                                local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToEmery, entity)
                                -- DECOMPILER ERROR at PC639: Unhandled construct in 'MakeBoolean' P1

                                if config.attackOrderToEmery == 5 and (table.nums)(rankList) > 0 then
                                  if (table.nums)(rankList) == 1 then
                                    (table.insert)(list, rankList[1])
                                  else
                                    local random = (battleWorld._randomPcg)(1, (table.nums)(rankList))
                                    local entity = rankList[random]
                                    ;
                                    (table.insert)(list, entity)
                                  end
                                end
                                do
                                  for _,v in ipairs(rankList) do
                                    if (table.nums)(list) < efffectEntityNum then
                                      (table.insert)(list, v)
                                    end
                                  end
                                  do
                                    do return list end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

Utility.GetSkillOurCampEntityList = function(skillid, useSkillEntityId, battleWorld)
  -- function num : 0_28 , upvalues : _ENV, Utility
  local entity = nil
  for i,e in ipairs(battleWorld._entitys) do
    if e._entityId == useSkillEntityId then
      entity = e
      break
    end
  end
  do
    if entity then
      local list = {}
      local config = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
      if not config then
        LogErrorFormat("Utility", "skillid %s is not in cskill", skillid)
      end
      if config.targetNumberToOur > 0 then
        local useSkillEntitycamp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
        if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Left then
          local efffectEntityNum = (math.min)(config.targetNumberToOur, (table.nums)(battleWorld._leftPlayerList) + (table.nums)(battleWorld._leftPlayerSummonList))
          local record = {}
          for _,v in ipairs(battleWorld._leftPlayerList) do
            if config.attackOrderToOur == 7 and (Utility.IsRoleDead)(v) and (v:GetComponent((BattleECS.Components).TypeComponent))._roleID ~= 20054 then
              (table.insert)(record, v)
            end
            if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and (((BattleECS.Utility).BuffUtility).IsCanBeChosenInSameCampSkill)(v) then
              (table.insert)(record, v)
            end
          end
          if config.attackOrderToOur ~= 7 then
            for _,v in ipairs(battleWorld._leftPlayerSummonList) do
              if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and (((BattleECS.Utility).BuffUtility).IsCanBeChosenInSameCampSkill)(v) then
                (table.insert)(record, v)
              end
            end
            local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToOur, entity)
            for _,v in ipairs(rankList) do
              if (table.nums)(list) < efffectEntityNum then
                (table.insert)(list, v)
              end
            end
          else
            do
              for _,v in ipairs(record) do
                if (table.nums)(list) < efffectEntityNum then
                  (table.insert)(list, v)
                end
              end
              do
                if useSkillEntitycamp == (((BattleECS.Components).TypeComponent).CampType).Right then
                  local efffectEntityNum = (math.min)(config.targetNumberToOur, (table.nums)(battleWorld._rightPlayerList) + (table.nums)(battleWorld._rightPlayerSummonList))
                  local record = {}
                  for _,v in ipairs(battleWorld._rightPlayerList) do
                    if config.attackOrderToOur == 7 and (Utility.IsRoleDead)(v) then
                      (table.insert)(record, v)
                    end
                    if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and (((BattleECS.Utility).BuffUtility).IsCanBeChosenInSameCampSkill)(v) and not (Utility.IsEntityEscape)(v) then
                      (table.insert)(record, v)
                    end
                  end
                  if config.attackOrderToOur ~= 7 then
                    for _,v in ipairs(battleWorld._rightPlayerSummonList) do
                      if (config.attackOrderToOur ~= 18 or useSkillEntityId ~= v._entityId) and (((BattleECS.Utility).BuffUtility).IsCanBeChosenInSameCampSkill)(v) then
                        (table.insert)(record, v)
                      end
                    end
                    local rankList = (Utility.GetSkillEffectRankEntityList)(skillid, record, config.attackOrderToOur, entity)
                    for _,v in ipairs(rankList) do
                      if (table.nums)(list) < efffectEntityNum then
                        (table.insert)(list, v)
                      end
                    end
                  else
                    do
                      for _,v in ipairs(record) do
                        if (table.nums)(list) < efffectEntityNum then
                          (table.insert)(list, v)
                        end
                      end
                      do
                        do return list end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

Utility.GetSkillEffectRankEntityList = function(skillid, entitylist, rankType, useSkillEntity)
  -- function num : 0_29 , upvalues : _ENV
  local list = entitylist
  if rankType == 1 and (table.nums)(list) > 1 then
    (table.sort)(list, function(a, b)
    -- function num : 0_29_0 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).HpComponent))._currentHp < (b:GetComponent((BattleECS.Components).HpComponent))._currentHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  else
    if rankType == 2 and (table.nums)(list) > 1 then
      (table.sort)(list, function(a, b)
    -- function num : 0_29_1 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).HpComponent))._currentHp < (a:GetComponent((BattleECS.Components).HpComponent))._currentHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    else
      if rankType == 3 and (table.nums)(list) > 1 then
        if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
          (table.sort)(list, function(a, b)
    -- function num : 0_29_2 , upvalues : _ENV
    if ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
        else
          ;
          (table.sort)(list, function(a, b)
    -- function num : 0_29_3 , upvalues : _ENV
    if ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
        end
      else
        if rankType == 4 and (table.nums)(list) > 1 then
          if (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._isImaged then
            (table.sort)(list, function(a, b)
    -- function num : 0_29_4 , upvalues : _ENV
    if ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
          else
            ;
            (table.sort)(list, function(a, b)
    -- function num : 0_29_5 , upvalues : _ENV
    if ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x >= ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x then
      do return (a:GetComponent((BattleECS.Components).TypeComponent))._camp ~= (((BattleECS.Components).TypeComponent).CampType).Left end
      do return ((b:GetComponent((BattleECS.Components).PositionComponent))._position).x < ((a:GetComponent((BattleECS.Components).PositionComponent))._position).x end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
          end
        else
          if rankType == 6 then
            list = {}
            ;
            (table.insert)(list, useSkillEntity)
          else
            if rankType == 8 and (table.nums)(list) > 1 then
              (table.sort)(list, function(a, b)
    -- function num : 0_29_6 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).HpComponent))._currentHp / (a:GetComponent((BattleECS.Components).HpComponent))._maxHp < (b:GetComponent((BattleECS.Components).HpComponent))._currentHp / (b:GetComponent((BattleECS.Components).HpComponent))._maxHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            else
              if rankType == 9 and (table.nums)(list) > 1 then
                (table.sort)(list, function(a, b)
    -- function num : 0_29_7 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).HpComponent))._currentHp / (b:GetComponent((BattleECS.Components).HpComponent))._maxHp < (a:GetComponent((BattleECS.Components).HpComponent))._currentHp / (a:GetComponent((BattleECS.Components).HpComponent))._maxHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
              else
                if rankType == 11 and (table.nums)(list) > 1 then
                  (table.sort)(list, function(a, b)
    -- function num : 0_29_8 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).AttackComponent))._attack < (a:GetComponent((BattleECS.Components).AttackComponent))._attack end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                else
                  if rankType == 12 and (table.nums)(list) > 1 then
                    (table.sort)(list, function(a, b)
    -- function num : 0_29_9 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).AttackComponent))._attack < (b:GetComponent((BattleECS.Components).AttackComponent))._attack end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                  else
                    if rankType == 13 and (table.nums)(list) > 1 then
                      (table.sort)(list, function(a, b)
    -- function num : 0_29_10 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).DefenseComponent))._attackDefense < (a:GetComponent((BattleECS.Components).DefenseComponent))._attackDefense end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                    else
                      if rankType == 14 and (table.nums)(list) > 1 then
                        (table.sort)(list, function(a, b)
    -- function num : 0_29_11 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).DefenseComponent))._attackDefense < (b:GetComponent((BattleECS.Components).DefenseComponent))._attackDefense end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                      else
                        if rankType == 15 and (table.nums)(list) > 1 then
                          (table.sort)(list, function(a, b)
    -- function num : 0_29_12 , upvalues : _ENV
    do return (b:GetComponent((BattleECS.Components).DefenseComponent))._magicDefense < (a:GetComponent((BattleECS.Components).DefenseComponent))._magicDefense end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                        else
                          if rankType == 16 and (table.nums)(list) > 1 then
                            (table.sort)(list, function(a, b)
    -- function num : 0_29_13 , upvalues : _ENV
    do return (a:GetComponent((BattleECS.Components).DefenseComponent))._magicDefense < (b:GetComponent((BattleECS.Components).DefenseComponent))._magicDefense end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                          else
                            if rankType == 17 then
                              list = {}
                            else
                              if rankType == 19 and (table.nums)(list) > 1 then
                                (table.sort)(list, function(a, b)
    -- function num : 0_29_14 , upvalues : useSkillEntity, _ENV
    if a._entityId == useSkillEntity._entityId then
      return true
    end
    if b._entityId == useSkillEntity._entityId then
      return false
    end
    do return (a:GetComponent((BattleECS.Components).HpComponent))._currentHp / (a:GetComponent((BattleECS.Components).HpComponent))._maxHp < (b:GetComponent((BattleECS.Components).HpComponent))._currentHp / (b:GetComponent((BattleECS.Components).HpComponent))._maxHp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return list
end

Utility.GetSkillEffectCamp = function(skillid)
  -- function num : 0_30 , upvalues : _ENV, Utility
  local config = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if config then
    if config.targetNumberToEmery > 0 then
      if config.targetNumberToOur > 0 then
        return (Utility.SkillEffectCampType).Both
      else
        return (Utility.SkillEffectCampType).Enemy
      end
    else
      if config.targetNumberToOur > 0 then
        return (Utility.SkillEffectCampType).OwnSide
      end
    end
  end
end

Utility.IsSkillHasNoColliderEffect = function(skillid)
  -- function num : 0_31 , upvalues : _ENV
  local config = (((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]
  if #config.noColliderEffectAtk <= 0 then
    do return not config end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Utility.SkillIsHasPowerExpended = function(skillid)
  -- function num : 0_32 , upvalues : _ENV
  local config = (((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]
  if config.OrderCost == 0 and config.ChaosCost == 0 and config.pureCost == "" then
    do return not config end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Utility.IsSkillNeedInitAnimationEventComponentInfo = function(entity, skillid)
  -- function num : 0_33 , upvalues : _ENV, Utility
  if (entity:GetComponent((BattleECS.Components).TypeComponent))._summonName == "partner" then
    return false
  end
  local roleid = (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID
  if (((BattleECS.Utility).DataUtility).cMonsterCfgTable)[roleid] then
    return true
  end
  if (((BattleECS.Utility).DataUtility).roleConfigTable)[roleid] then
    if not (Utility.IsAttackSkill)(skillid) then
      return true
    else
      return false
    end
  end
end

Utility.IsToTargetXPoint = function(entity)
  -- function num : 0_34 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).TypeComponent)
  if component and component._isImaged then
    return true
  end
  local component = entity:GetComponent((BattleECS.Components).PositionComponent)
  if component then
    local targetpoint = component._targetPos
    local camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
    local pos = component._position
    if (component._targetPos).x then
      if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
        if pos.x <= targetpoint.x + 1 and targetpoint.x - 1 <= pos.x then
          return true
        else
          return false
        end
      else
        if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          if pos.x <= targetpoint.x + 1 and targetpoint.x - 1 <= pos.x then
            return true
          else
            return false
          end
        end
      end
    else
      return true
    end
  else
    do
      do return true end
    end
  end
end

Utility.ShiXiangGuiBattleEndMoveFun = function(entity)
  -- function num : 0_35 , upvalues : _ENV
  if (entity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Left then
    local component = entity:GetComponent((BattleECS.Components).PositionComponent)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    if component and (component._targetPos).x and (component._position).x < (component._targetPos).x then
      (component._position).x = (component._targetPos).x
    end
  end
end

Utility.GetSkillEffectSocketPoint = function(prefabName, socket)
  -- function num : 0_36 , upvalues : _ENV
  local data = {x = 0, y = 0, z = 0}
  local str = (string.lower)(prefabName)
  local prefabData = require("data.battledata.npcshapedata." .. str)
  if not prefabData[socket] then
    LogInfoFormat("utility", "no npcshapedata with prefabname \'%s\' socket %s", str, socket)
  else
    data.x = (prefabData[socket]).x
    data.y = (prefabData[socket]).y
    data.z = (prefabData[socket]).z
  end
  return data
end

Utility.GetEntityShapeRecorder = function(entity)
  -- function num : 0_37 , upvalues : _ENV
  local entityTypeCom = entity:GetComponent((BattleECS.Components).TypeComponent)
  if entityTypeCom._changeShapeID ~= 0 then
    local shapeID = entityTypeCom._changeShapeID
    local shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[shapeID]
    return {assetBundleName = shapeRecorder.assetBundleName, prefabName = shapeRecorder.prefabName}
  else
    do
      do return {assetBundleName = entityTypeCom._oriShapeAssetBundleName, prefabName = entityTypeCom._oriShapePrefabName} end
    end
  end
end

Utility.ReturnEffectRad = function(entity, targetEntity, point, targetpoint)
  -- function num : 0_38 , upvalues : _ENV, Utility
  if entity._entityId == targetEntity._entityId then
    return 0, 0
  end
  local position = (entity:GetComponent((BattleECS.Components).PositionComponent))._position
  local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(entity)
  local qDPath = (Utility.GetSkillEffectSocketPoint)(shapeRecorder.prefabName, point)
  local tDPath = {}
  shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(targetEntity)
  if targetpoint then
    tDPath = (Utility.GetSkillEffectSocketPoint)(shapeRecorder.prefabName, targetpoint)
  else
    tDPath = (Utility.GetSkillEffectSocketPoint)(shapeRecorder.prefabName, "HitPoint")
  end
  local x = 0
  local y = 0
  if (entity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
    x = position.x - qDPath.x
    y = position.y + qDPath.y
  else
    x = position.x + qDPath.x
    y = position.y + qDPath.y
  end
  local tarPosition = (targetEntity:GetComponent((BattleECS.Components).PositionComponent))._position
  if (targetEntity:GetComponent((BattleECS.Components).TypeComponent))._camp == (((BattleECS.Components).TypeComponent).CampType).Right then
    local tarX = tarPosition.x - tDPath.x
    local tarY = tarPosition.y + tDPath.y
    local distance = (fixedpoint.sqrt)((fixedpoint.square)((tarY - (y)) / 1000) + (fixedpoint.square)((tarX - (x)) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - (y)) / distance
    local changeValueForCalculate = sin / (1 + (fixedpoint.sqrt)(1 - (fixedpoint.square)(sin)))
    local rad = 2 * (fixedpoint.atan2f)(changeValueForCalculate, 1)
    local degree = (fixedpoint.deg)(rad)
    return rad, sin, degree
  else
    do
      local tarX = tarPosition.x + tDPath.x
      local tarY = tarPosition.y + tDPath.y
      local distance = (fixedpoint.sqrt)((fixedpoint.square)((tarY - (y)) / 1000) + (fixedpoint.square)((tarX - (x)) / 1000)) * 1000
      if distance == fixedpoint_zero then
        distance = 1
      end
      local sin = (tarY - (y)) / distance
      local changeValueForCalculate = sin / (1 + (fixedpoint.sqrt)(1 - (fixedpoint.square)(sin)))
      local rad = 2 * (fixedpoint.atan2f)(changeValueForCalculate, 1)
      local degree = (fixedpoint.deg)(rad)
      do return rad, -sin, degree end
    end
  end
end

Utility.ReturnEffectRadByTargetXY = function(qX, qY, tX, tY, tarCamp)
  -- function num : 0_39 , upvalues : _ENV
  local x = qX
  local y = qY
  local tarX = tX
  local tarY = tY
  if tarCamp == (((BattleECS.Components).TypeComponent).CampType).Right then
    local distance = (fixedpoint.sqrt)((fixedpoint.square)((tarY - y) / 1000) + (fixedpoint.square)((tarX - x) / 1000)) * 1000
    if distance == fixedpoint_zero then
      distance = 1
    end
    local sin = (tarY - y) / distance
    local rad = (fixedpoint.deg)((fixedpoint.atan2f)(sin, 1))
    return rad, sin
  else
    do
      local distance = (fixedpoint.sqrt)((fixedpoint.square)((tarY - y) / 1000) + (fixedpoint.square)((tarX - x) / 1000)) * 1000
      if distance == fixedpoint_zero then
        distance = 1
      end
      local sin = (tarY - y) / distance
      local rad = (fixedpoint.deg)((fixedpoint.atan2f)(sin, 1))
      do return rad, -sin end
    end
  end
end

Utility.GetRandomPosition = function(random, randomFun)
  -- function num : 0_40 , upvalues : _ENV
  local num = randomFun(1, 3)
  while num == random do
    num = randomFun(1, 3)
  end
  local pos = {}
  for i = 1, 3 do
    pos[i] = {}
    pos[i] = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[18 + i]).attr, ";")
  end
  local xD = (fixedpoint((pos[num])[2]) - fixedpoint((pos[num])[1])) * 1000
  local yD = (fixedpoint((pos[num])[4]) - fixedpoint((pos[num])[3])) * 1000
  local x = fixedpoint((pos[num])[1]) * 1000 + randomFun(1, 1000) * xD // 1000
  local y = fixedpoint((pos[num])[3]) * 1000 + randomFun(1, 1000) * yD // 1000
  return x, y, num
end

Utility.IsHasPowerToSkill = function(entity, skillid, red, blue, battleWorld)
  -- function num : 0_41 , upvalues : _ENV
  local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
  local skillConfig = (((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]
  if skillConfig then
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    ;
    (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, skillid, redCost, blueCost)
    do
      if skillConfig.pureCost ~= "" then
        local record = {}
        record.skillComponentB = skillComponent
        record.skillComponentA = skillComponent
        record.world = battleWorld
        record.formulaString = skillConfig.pureCost
        record.skillid = skillid
        record.camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
        redCost = (((BattleECS.Utility).BuffUtility).NewAnalysisFormulaPowerCost)(record)
      end
      local attr1 = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[1]).attr)
      do
        local attr2 = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[2]).attr)
        if redCost * attr1 <= red and blueCost * attr2 <= blue then
          return true, red - redCost * attr1, blue - blueCost * attr2
        end
        return false
      end
    end
  end
end

Utility.IsRoleDead = function(entity)
  -- function num : 0_42 , upvalues : _ENV
  if entity then
    local component = entity:GetComponent((BattleECS.Components).HpComponent)
    if component and component._hpStage == "escape" then
      return true
    end
    component = entity:GetComponent((BattleECS.Components).BuffComponent)
    if component then
      for _,v in ipairs(component._buffList) do
        if v.buffId == 20000 then
          return true
        end
      end
    end
    do
      do
        component = entity:GetComponent((BattleECS.Components).TypeComponent)
        if component and component._summonName == "buff" and component._isNeedDestroy then
          return true
        else
          if not component then
            LogInfoFormat("Utility", "IsRoleDead judging has some order problems, but recorder the entity with id %s is dead", entity._entityId)
            return true
          end
        end
        do return true end
        return false
      end
    end
  end
end

Utility.RoleDeadClearComponentData = function(entity)
  -- function num : 0_43 , upvalues : _ENV
  if entity:GetComponent((BattleECS.Components).SkillComponent) then
    for _,v in ipairs((entity:GetComponent((BattleECS.Components).SkillComponent))._skillList) do
      v.currentTime = 0
    end
  end
end

Utility.IsRoleCanUseSkill = function(entity, skillid, battleWorld)
  -- function num : 0_44 , upvalues : _ENV, Utility
  if battleWorld:GetCampWinState() ~= "" then
    LogInfo("Utility", "战斗结束")
    return false
  end
  local isHas = false
  local skillInfo = nil
  local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponent then
    for _,v in ipairs(skillComponent._skillList) do
      if v.skillId == skillid then
        skillInfo = v
        isHas = true
      end
    end
    if not isHas then
      LogErrorFormat("Utility", "该角色没有该技能 entityid:%s skillid:%s", entity._entityId, skillid)
    else
      local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
      local isHasCanNotUseSkillBuff = (((BattleECS.Utility).BuffUtility).IsRoleHasCanNotUseSkillBuff)(entity, effectType.UseSkill, skillid)
      if isHasCanNotUseSkillBuff then
        (((BattleECS.Utility).ProtocolUtility).SendSkillFail)(entity._entityId, skillid, (Utility.SkillUseFailedType).CanNotUseSkillBuff, battleWorld)
        LogInfo("Utility", "不能释放技能的负面buff")
        return 
      end
      if not (Utility.IsToTargetXPoint)(entity) then
        (((BattleECS.Utility).ProtocolUtility).SendSkillFail)(entity._entityId, skillid, (Utility.SkillUseFailedType).NotInPoint, battleWorld)
        LogInfo("Utility", "未到点位")
        return 
      end
      local red = battleWorld._redPower
      local blue = battleWorld._bluePower
      local flag, redcu, bluecu = (Utility.IsHasPowerToSkill)(entity, skillid, red, blue, battleWorld)
      if flag then
        if ((entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkill or skillComponent._skillId == 0 or (((BattleECS.Utility).Utility).IsSkillNeedInitAnimationEventComponentInfo)(entity, skillid)) and not (Utility.IsSkillCanUseNotNeedRoleInSkill)(skillid) then
          (((BattleECS.Utility).ProtocolUtility).SendSkillFail)(entity._entityId, skillid, (Utility.SkillUseFailedType).UsingOtherSkill, battleWorld)
          LogInfo("Utility", "角色正在释放其他技能")
        else
          if skillInfo.currentTime < skillInfo.cdTime then
            (((BattleECS.Utility).ProtocolUtility).SendSkillFail)(entity._entityId, skillid, (Utility.SkillUseFailedType).SkillInCD, battleWorld)
            LogInfo("Utility", "技能cd")
          else
            skillComponent._skillId = skillid
            skillComponent._isClickUseSkill = true
            -- DECOMPILER ERROR at PC166: Confused about usage of register: R13 in 'UnsetPending'

            ;
            (skillComponent._useActSkillList)[skillid] = (skillComponent._useActSkillList)[skillid] or 0
            -- DECOMPILER ERROR at PC171: Confused about usage of register: R13 in 'UnsetPending'

            ;
            (skillComponent._useActSkillList)[skillid] = (skillComponent._useActSkillList)[skillid] + 1
            red = redcu
            blue = bluecu
            LogInfoFormat("Utility", "即将使用成功 skillid %s", skillid)
          end
        end
      else
        ;
        (((BattleECS.Utility).ProtocolUtility).SendSkillFail)(entity._entityId, skillid, (Utility.SkillUseFailedType).PowerNotEnough, battleWorld)
        LogInfo("Utility", "能量不足")
      end
    end
  end
end

Utility.PlayRoleSkillVoice = function(entity, skillId, battleWorld)
  -- function num : 0_45 , upvalues : _ENV
  local roleId = (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID
  if ServerGameTimer then
    if (((BattleECS.Utility).DataUtility).RoleSkillCVCD)[roleId] then
      local delta = (ServerGameTimer.GetServerTimeForecast)() - (((BattleECS.Utility).DataUtility).RoleSkillCVCD)[roleId]
      if delta < tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[99]).attr) * 1000 then
        return 
      else
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (((BattleECS.Utility).DataUtility).RoleSkillCVCD)[roleId] = (ServerGameTimer.GetServerTimeForecast)()
      end
    else
      do
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((BattleECS.Utility).DataUtility).RoleSkillCVCD)[roleId] = (ServerGameTimer.GetServerTimeForecast)()
        local index = nil
        if not (((BattleECS.Utility).DataUtility).cSoundCatalogTable)[roleId] then
          LogErrorFormat("Utility", "role id %s dont have config in csoundcatalog", roleId)
          return 
        end
        local v = (((BattleECS.Utility).DataUtility).cSkillItemTable)[skillId]
        for i,skillIdInTable in ipairs(((((BattleECS.Utility).DataUtility).cSoundCatalogTable)[roleId]).SkillID) do
          if v.itemId == skillIdInTable then
            index = i
            break
          end
        end
        do
          if not index then
            LogErrorFormat("Utility", "role id %s skillid %s dont have the right skillitemid config in csoundcatalog.SkillID", roleId, skillId)
            return 
          end
          local skillCV = tonumber((((((BattleECS.Utility).DataUtility).cSoundCatalogTable)[roleId]).SkillCV)[index])
          local changeRecord = (((BattleECS.Utility).DataUtility).cBattleSoundChangeTable)[skillCV]
          local playOriginalSkillVoice = true
          if changeRecord then
            local component = entity:GetComponent((BattleECS.Components).BuffComponent)
            if component then
              for _,v in ipairs(component._buffList) do
                for i,buffId in ipairs(changeRecord.buffid) do
                  if v.buffId == tonumber(buffId) then
                    playOriginalSkillVoice = false
                    ;
                    (((BattleECS.Utility).ProtocolUtility).SendPlayAudio)(tonumber((changeRecord.SkillCV)[i]), -1, battleWorld)
                    LogInfoFormat("Utility", "play skill id %s cv %s voice change to %s", skillId, skillCV, tonumber((changeRecord.SkillCV)[i]))
                    break
                  end
                end
              end
            end
          end
          do
            if playOriginalSkillVoice then
              (((BattleECS.Utility).ProtocolUtility).SendPlayBattleVoice)(roleId, (((BattleECS.Utility).DataUtility).VoiceType).SkillCV, index, battleWorld)
            end
          end
        end
      end
    end
  end
end

Utility.ChangeEntityCurrentHp = function(entity, hpChange)
  -- function num : 0_46 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).HpComponent))._currentHp = (fixedpoint.min)((entity:GetComponent((BattleECS.Components).HpComponent))._currentHp + hpChange, (entity:GetComponent((BattleECS.Components).HpComponent))._maxHp)
  if (entity:GetComponent((BattleECS.Components).HpComponent))._currentHp < 0 then
    (entity:GetComponent((BattleECS.Components).HpComponent))._currentHp = fixedpoint_zero
  end
end

Utility.SetEntityHpComponentLastDamege = function(entity, damagenum, damagefrom)
  -- function num : 0_47 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).HpComponent))._lastDamage = damagenum
  ;
  (entity:GetComponent((BattleECS.Components).HpComponent))._lastDamageFrom = damagefrom
end

Utility.SetEntityHpComponentHpStage = function(entity, stage)
  -- function num : 0_48 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).HpComponent))._hpStage = stage
end

Utility.IsEntityEscape = function(entity)
  -- function num : 0_49 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).HpComponent)
  if component and component._hpStage == "escape" then
    return true
  end
  return false
end

Utility.SetEntityHpComponentTotalDamege = function(entity, damagenum)
  -- function num : 0_50 , upvalues : _ENV
  if fixedpoint.maxinteger <= (entity:GetComponent((BattleECS.Components).HpComponent))._totalDamage then
    (entity:GetComponent((BattleECS.Components).HpComponent))._totalDamage = fixedpoint.maxinteger
  else
    ;
    (entity:GetComponent((BattleECS.Components).HpComponent))._totalDamage = (entity:GetComponent((BattleECS.Components).HpComponent))._totalDamage + damagenum
  end
end

Utility.ClearEntityHpComponentTotalDamege = function(entity)
  -- function num : 0_51 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).HpComponent))._totalDamage = fixedpoint_zero
end

Utility.RecordEntityHpComponentElementDamage = function(entity, damagenum, enemyEntity)
  -- function num : 0_52 , upvalues : _ENV
  local elementType = (enemyEntity:GetComponent((BattleECS.Components).TypeComponent))._roleElementType
  if elementType == (((BattleECS.Components).TypeComponent).ElementType).None then
    LogInfoFormat("Utility", "elementType == None,EntityID:%s", enemyEntity._entityId)
    return 
  end
  local elementDamageList = (entity:GetComponent((BattleECS.Components).HpComponent))._elementDamageList
  if not elementDamageList[elementType] then
    elementDamageList[elementType] = fixedpoint_zero
  end
  if fixedpoint.maxinteger <= elementDamageList[elementType] then
    elementDamageList[elementType] = fixedpoint.maxinteger
  else
    elementDamageList[elementType] = elementDamageList[elementType] + damagenum
  end
  ;
  (entity:GetComponent((BattleECS.Components).HpComponent))._elementDamageList = elementDamageList
end

Utility.IsEntityHighestElementDamage = function(entity, elementType)
  -- function num : 0_53 , upvalues : _ENV
  local elementDamageList = (entity:GetComponent((BattleECS.Components).HpComponent))._elementDamageList
  local currentDam = elementDamageList[elementType]
  if currentDam then
    for k,v in pairs(elementDamageList) do
      if currentDam < v and k ~= elementType then
        return false
      end
    end
  end
  do
    return true
  end
end

Utility.RecorderPowerCost = function(battleWorld, skillid, entity)
  -- function num : 0_54 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cSkillCostTable)[skillid]
  if skillConfig then
    local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
    local redCost = skillConfig.OrderCost
    local blueCost = skillConfig.ChaosCost
    ;
    (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, skillid, redCost, blueCost)
    do
      if skillConfig.pureCost ~= "" then
        local record = {}
        record.skillComponentB = skillComponent
        record.skillComponentA = skillComponent
        record.world = battleWorld
        record.formulaString = skillConfig.pureCost
        record.skillid = skillid
        record.camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
        redCost = (((BattleECS.Utility).BuffUtility).NewAnalysisFormulaPowerCost)(record)
        ;
        (((BattleECS.Utility).Utility).SetEntitySkillComponentCostPower)(entity, skillid, redCost, blueCost)
      end
      local buffComponent = entity:GetComponent((BattleECS.Components).BuffComponent)
      buffComponent._orderPowerCost = buffComponent._orderPowerCost + redCost
      buffComponent._chaosPowerCost = buffComponent._chaosPowerCost + blueCost
    end
  end
end

Utility.SetEntitySkillComponentCostPower = function(entity, skillid, red, blue)
  -- function num : 0_55 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ((entity:GetComponent((BattleECS.Components).SkillComponent))._skillCostPowerList)[skillid] = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((entity:GetComponent((BattleECS.Components).SkillComponent))._skillCostPowerList)[skillid]).red = red
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((entity:GetComponent((BattleECS.Components).SkillComponent))._skillCostPowerList)[skillid]).blue = blue
end

Utility.AddEntityHpComponentSkillHitNumber = function(entity, damagenum, skillid)
  -- function num : 0_56 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((entity:GetComponent((BattleECS.Components).HpComponent))._skillListOnceDamage)[skillid] = damagenum
end

Utility.IsAttackSkill = function(skillid)
  -- function num : 0_57 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if skillConfig and skillConfig.effecttype == 1 then
    return true
  end
  return false
end

Utility.IsUseSkill = function(skillid)
  -- function num : 0_58 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if skillConfig and skillConfig.effecttype == 2 then
    return true
  end
  return false
end

Utility.IsPassiveSkill = function(skillid)
  -- function num : 0_59 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if skillConfig and skillConfig.effecttype == 4 then
    return true
  end
  return false
end

Utility.GetEntityAttackSkillID = function(entity)
  -- function num : 0_60 , upvalues : _ENV, Utility
  local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponent then
    for _,v in ipairs(skillComponent._skillList) do
      if (Utility.IsAttackSkill)(v.skillId) then
        return v.skillId
      end
    end
  end
  do
    return nil
  end
end

Utility.GetMonsterOrRoleMagicOrAttackEndFraps = function(entity, skillid)
  -- function num : 0_61 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]
  if skillConfig then
    local animationRecoder = (((BattleECS.Utility).DataUtility).cSkillAnimationTable)[skillid]
    local animationType = {None = 0, OneAttackAction = 1, ThreeAnimationAction = 2}
    if animationRecoder and animationRecoder.actionType == animationType.ThreeAnimationAction then
      local frap = 0
      local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(entity)
      local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
      do
        if animationRecoder.skillStart ~= "" then
          local data = frapData[animationRecoder.skillStart]
          if data then
            frap = frap + data.endEventFrames
          else
            LogErrorFormat("Utility", "actionType 2 npcshapeanimationdata.%s animationstart %s is not exist in cSkillAnimationTable skillid %s", (string.lower)(shapeRecorder.prefabName), animationRecoder.skillStart, skillid)
          end
        end
        frap = frap + tonumber(animationRecoder.loopTime)
        local endAnimationFrames = 0
        do
          local frapDataSkillEnd = frapData[animationRecoder.skillEnd]
          if frapDataSkillEnd then
            endAnimationFrames = frapDataSkillEnd.endEventFrames
          end
          do return frap, frap + endAnimationFrames end
          if animationRecoder and animationRecoder.actionType == animationType.OneAttackAction then
            local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(entity)
            local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
            local frap = 0
            local data = frapData[animationRecoder.actionAtk]
            if data then
              frap = (frapData[animationRecoder.actionAtk]).endEventFrames + 2
            else
              LogErrorFormat("Utility", "actionType 1 npcshapeanimationdata.%s actionAtk %s is not exist in cSkillAnimationTable skillid %s", (string.lower)(shapeRecorder.prefabName), animationRecoder.actionAtk, skillid)
            end
            return frap, frap
          else
            do
              local shapeRecorder = (((BattleECS.Utility).Utility).GetEntityShapeRecorder)(entity)
              local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeRecorder.prefabName))
              local frap = 0
              do
                local data = frapData[skillConfig.actionAtk]
                if data then
                  frap = (frapData[skillConfig.actionAtk]).endEventFrames + 2
                end
                do return frap, frap end
                LogErrorFormat("Utility", "skillid %s not exist in cSkillBehaviorTable", skillid)
                return 0, 0
              end
            end
          end
        end
      end
    end
  end
end

Utility.GetSkillActionAtkAnimation = function(skillid)
  -- function num : 0_62 , upvalues : _ENV
  local skillConfig = (((BattleECS.Utility).DataUtility).cSkillAnimationTable)[skillid]
  if skillConfig then
    return skillConfig.actionAtk
  else
    skillConfig = (((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]
    if skillConfig then
      return skillConfig.actionAtk
    end
  end
  return ""
end

Utility.IsDamageReBoundSkill = function(skillid)
  -- function num : 0_63 , upvalues : _ENV
  local config = (((BattleECS.Utility).DataUtility).cSkillBehaviorTable)[skillid]
  if config and #config.invalidEffectAtk > 0 then
    for _,record in pairs(((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable) do
      if tonumber(record.skillid) == tonumber(skillid) then
        local re = (string.split)(record.conditionid, ";")
        for _,value in ipairs(re) do
          if value == "4" then
            return true
          end
        end
      end
    end
  end
  do
    return false
  end
end

Utility.IsJoinBattleAndEnoughCondition = function(battleid)
  -- function num : 0_64 , upvalues : _ENV
  for _,v in ipairs(((BattleECS.Utility).DataUtility).cJoinBattleInfoTable) do
    local record = v.record
    if battleid == record.battleID then
      return true, {num = fixedpoint(record.attr) / 100, id = record.id, chatId = record.joinBattleMessage}
    end
  end
  return false
end

Utility.IsSkillCanUseNotNeedRoleInSkill = function(skillid)
  -- function num : 0_65 , upvalues : _ENV
  local rec = (string.split)(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[10]).attr, ";")
  for _,v in ipairs(rec) do
    if tonumber(v) == skillid then
      return true
    end
  end
  return false
end

Utility.GetFrogRider201034DestroyFraps = function()
  -- function num : 0_66 , upvalues : _ENV
  local shapeConfig = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[((((BattleECS.Utility).DataUtility).cMonsterCfgTable)[20054]).shapeID]
  local frapData = require("data.battledata.npcshapeanimationdata." .. (string.lower)(shapeConfig.prefabName))
  local frap = (frapData.Attack2).endEventFrames
  return frap
end

Utility.IsNeedPlayPerformSkillAnimation = function(skillid)
  -- function num : 0_67 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cSkillAnimationTable)[skillid]
  local animationType = {None = 0, OneAttackAction = 1, ThreeAnimationAction = 2}
  if record.actionType ~= animationType.OneAttackAction then
    do return not record end
    do return true end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Utility.IsRoleFirstSkill = function(entity, skillid)
  -- function num : 0_68 , upvalues : _ENV
  local roleid = (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID
  local record = (((BattleECS.Utility).DataUtility).roleConfigTable)[roleid]
  if record and ((((BattleECS.Utility).DataUtility).cSkillItemTable)[skillid]).itemId == record.contractskillid then
    return true
  end
  return false
end

Utility.IsRoleSecondSkill = function(entity, skillid)
  -- function num : 0_69 , upvalues : _ENV
  local roleid = (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID
  local record = (((BattleECS.Utility).DataUtility).roleConfigTable)[roleid]
  if record and ((((BattleECS.Utility).DataUtility).cSkillItemTable)[skillid]).itemId == record.contractskillid2 then
    return true
  end
  return false
end

Utility.IsTreateSkill = function(skillid)
  -- function num : 0_70 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if record.attr ~= 3 then
    do return not record end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

Utility.IsSkillOnceEquipSkill = function(skillid)
  -- function num : 0_71 , upvalues : _ENV
  for _,record in pairs(((BattleECS.Utility).DataUtility).cBuffLinkSkillCfgTable) do
    if tonumber(record.skillid) == tonumber(skillid) then
      local buffid = record.id
    end
  end
  return false
end

Utility.IsSkillHas10006Buff = function(skillid)
  -- function num : 0_72 , upvalues : _ENV
  local record = (((BattleECS.Utility).DataUtility).cskillTable)[skillid]
  if (string.find)(record.friendbuffid, "10006") then
    return true
  end
  return false
end

Utility.GetCampAliveRoleNumber = function(side, battleworld, entityId)
  -- function num : 0_73 , upvalues : _ENV, Utility
  local sideType = {Enemy = 1, OwnSide = 2}
  local entityList = {}
  local entity = nil
  for i,e in ipairs(battleworld._entitys) do
    if e._entityId == entityId then
      entity = e
      break
    end
  end
  do
    local camp = nil
    if entity then
      camp = (entity:GetComponent((BattleECS.Components).TypeComponent))._camp
    end
    if side == sideType.OwnSide then
      if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
        entityList = battleworld._leftPlayerList
      else
        if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          entityList = battleworld._rightPlayerList
        end
      end
    else
      if side == sideType.Enemy then
        if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
          entityList = battleworld._rightPlayerList
        else
          if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            entityList = battleworld._leftPlayerList
          end
        end
      end
    end
    local num = 0
    for _,e in ipairs(entityList) do
      if not (Utility.IsRoleDead)(e) then
        num = num + 1
      end
    end
    return num
  end
end

Utility.GetSkinSkillChangeEffectId = function(curPrefabName, skillEffectId)
  -- function num : 0_74 , upvalues : _ENV
  local skinChangeRecorder = (((BattleECS.Utility).DataUtility).cSkinSkillEffectChangeTable)[skillEffectId]
  if skinChangeRecorder then
    for index,shapeId in ipairs(skinChangeRecorder.shapeid) do
      local shapeRecorder = (((BattleECS.Utility).DataUtility).cNPCShapeTable)[tonumber(shapeId)]
      if shapeRecorder and shapeRecorder.prefabName == curPrefabName then
        skillEffectId = tonumber((skinChangeRecorder.effectid)[index])
        break
      end
    end
  end
  do
    return skillEffectId
  end
end

Utility.ClearAndDestroyTypeMineEffectAtkList = function(entity, battleWorld)
  -- function num : 0_75 , upvalues : _ENV
  local skillEffectComponent = entity:GetComponent((BattleECS.Components).SkillEffectComponent)
  local typeComponent = entity:GetComponent((BattleECS.Components).TypeComponent)
  if skillEffectComponent and typeComponent then
    for _,v in ipairs(skillEffectComponent._typeMineEffectAtkList) do
      local effectConfig = (((BattleECS.Utility).DataUtility).cSkillEffectTable)[v.effectid]
      ;
      (((BattleECS.Utility).ProtocolUtility).SendDestroyEffectByName)(typeComponent._camp, effectConfig.effectName, battleWorld)
    end
  end
end

Utility.JudgeIfCanUseCoordinatedSkill = function(useSkillEntity, currentEntitySkillID, battleWorld)
  -- function num : 0_76 , upvalues : _ENV, Utility
  local useSkillEntitySkillComponent = (useSkillEntity:GetComponent((BattleECS.Components).SkillComponent))
  local skillInfo = nil
  for _,v in ipairs(useSkillEntitySkillComponent._skillList) do
    if currentEntitySkillID == v.skillId then
      skillInfo = v
      break
    end
  end
  do
    if skillInfo and skillInfo.activeSkillIndex and useSkillEntitySkillComponent._isCostPower then
      local camp = (useSkillEntity:GetComponent((BattleECS.Components).TypeComponent))._camp
      local playerList = nil
      if camp == (((BattleECS.Components).TypeComponent).CampType).Left then
        playerList = battleWorld._leftPlayerList
      else
        if camp == (((BattleECS.Components).TypeComponent).CampType).Right then
          playerList = battleWorld._rightPlayerList
        end
      end
      if playerList then
        for _,entity in ipairs(playerList) do
          local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
          if entity._entityId ~= useSkillEntity._entityId then
            local skillIndex = nil
            if skillComponent._comborate1 > 0 then
              skillIndex = 1
            else
              if skillComponent._comborate2 > 0 then
                skillIndex = 2
              end
            end
            if skillIndex then
              local skillid = nil
              for _,v in ipairs(skillComponent._skillList) do
                if v.activeSkillIndex == skillIndex then
                  skillid = v.skillId
                  break
                end
              end
              do
                do
                  if skillid then
                    skillComponent._comborateRemainingNum = skillComponent._comborateRemainingNum - 1
                    if skillComponent._comborateRemainingNum < 0 then
                      skillComponent._comborateRemainingNum = fixedpoint_zero
                    end
                    ;
                    (((BattleECS.Utility).ProtocolUtility).SendCollaborativeSkillNumChange)(skillComponent._comborateRemainingNum, entity._entityId, battleWorld)
                    ;
                    (Utility.UseCoordinatedSkill)(entity, battleWorld)
                  else
                    LogInfoFormat("Utility", "entityid %s roleid %s comborate1 %s comborate2 %s but skillList dont have corresponding activeskillindex", entity._entityId, (entity:GetComponent((BattleECS.Components).TypeComponent))._roleID, skillComponent._comborate1, skillComponent._comborate2)
                  end
                  -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
end

Utility.UseCoordinatedSkill = function(entity, battleWorld)
  -- function num : 0_77 , upvalues : _ENV, Utility
  local skillComponent = entity:GetComponent((BattleECS.Components).SkillComponent)
  if skillComponent._comborateRemainingNum > 0 then
    return 
  end
  local skillIndex = nil
  if skillComponent._comborate1 > 0 then
    skillIndex = 1
  else
    if skillComponent._comborate2 > 0 then
      skillIndex = 2
    end
  end
  if skillIndex then
    local skillid = nil
    for _,v in ipairs(skillComponent._skillList) do
      if v.activeSkillIndex == skillIndex then
        skillid = v.skillId
        break
      end
    end
    do
      if skillid and battleWorld:GetCampWinState() == "" then
        local effectType = {AttackSkill = 1, UseSkill = 2, Both = 3}
        local isHasCanNotUseSkillBuff = (((BattleECS.Utility).BuffUtility).IsRoleHasCanNotUseSkillBuff)(entity, effectType.UseSkill, skillid)
        if isHasCanNotUseSkillBuff then
          LogInfo("Utility", "协同技能释放失败：不能释放技能的负面buff")
        end
        if not (Utility.IsToTargetXPoint)(entity) then
          LogInfo("Utility", "协同技能释放失败：未到点位")
        end
      end
      if ((entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkill or skillComponent._skillId == 0 or (((BattleECS.Utility).Utility).IsSkillNeedInitAnimationEventComponentInfo)(entity, skillid)) and not (Utility.IsSkillCanUseNotNeedRoleInSkill)(skillid) then
        (Utility.SetSkillIsCostPowerState)(entity, false)
        skillComponent._skillId = skillid
        skillComponent._comborateRemainingNum = (fixedpoint.max)(skillComponent._comborate1, skillComponent._comborate2)
        ;
        (((BattleECS.Utility).ProtocolUtility).SendCollaborativeSkillNumChange)(skillComponent._comborateRemainingNum, entity._entityId, battleWorld)
        LogInfoFormat("Utility", "协同技能释放成功 skillid %s", skillid)
      end
    end
  end
end

Utility.CalculateConfigAttrFunc = function(constant, param)
  -- function num : 0_78 , upvalues : _ENV
  local value = 0
  if tonumber(constant) then
    value = tonumber(constant)
  else
    local calculateAttrFunc = assert(load("return " .. constant, "", "t", {lv = param.lv}))
    value = calculateAttrFunc()
  end
  do
    local checkForFixedpoint = fixedpoint(value)
    return value
  end
end

Utility.IsActiveSkill = function(useSkillEntity, skillId)
  -- function num : 0_79 , upvalues : _ENV
  local useSkillEntitySkillComponent = (useSkillEntity:GetComponent((BattleECS.Components).SkillComponent))
  -- DECOMPILER ERROR at PC5: Overwrote pending register: R3 in 'AssignReg'

  local skillInfo = .end
  for _,v in ipairs(useSkillEntitySkillComponent._skillList) do
    if skillId == v.skillId then
      skillInfo = v
      break
    end
  end
  do
    if skillInfo and skillInfo.activeSkillIndex then
      return true
    end
    return false
  end
end

return Utility

