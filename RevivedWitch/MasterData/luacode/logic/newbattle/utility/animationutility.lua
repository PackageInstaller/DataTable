-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/utility/animationutility.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimationUtility = {}
AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionState = function(entity, state)
  -- function num : 0_0 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInPositionChangeAnimationState = state
end

AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionData = function(entity, data)
  -- function num : 0_1 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInPositionChangeAnimationData = data
end

AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionName = function(entity, name)
  -- function num : 0_2 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInPositionChangeAnimationName = name
end

AnimationUtility.IsNeedResetEntityAnimationEventComponentIsInChangePosition = function(entity)
  -- function num : 0_3 , upvalues : _ENV
  local component = entity:GetComponent((BattleECS.Components).AnimationEventComponent)
  if component and (component._roleIsInPositionChangeAnimationName == "blowup" or component._roleIsInPositionChangeAnimationName == "beatback" or component._roleIsInPositionChangeAnimationName == "blowup3") then
    return false
  end
  return true
end

AnimationUtility.ChangePositionDataForm = function(dataFileName)
  -- function num : 0_4 , upvalues : _ENV, AnimationUtility
  local data = require("data.battledata.animation." .. dataFileName)
  local newdata = (AnimationUtility.GetChangePositionDataByEachFrame)(data)
  return newdata
end

AnimationUtility.GetChangePositionDataByEachFrame = function(data)
  -- function num : 0_5 , upvalues : _ENV
  local maxFrame = ((data.x)[(table.nums)(data.x)]).timestamp
  local newdata = {}
  local index = 1
  for i = 1, maxFrame do
    newdata[i] = {}
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (newdata[i]).x = fixedpoint(((data.x)[index + 1]).value) / (((data.x)[index + 1]).timestamp - ((data.x)[index]).timestamp)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (newdata[i]).y = fixedpoint(((data.y)[index + 1]).value) / (((data.y)[index + 1]).timestamp - ((data.y)[index]).timestamp)
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (newdata[i]).z = fixedpoint(((data.z)[index + 1]).value) / (((data.z)[index + 1]).timestamp - ((data.z)[index]).timestamp)
    if i == ((data.x)[index + 1]).timestamp then
      index = index + 1
    end
  end
  return newdata
end

AnimationUtility.IntegrateChangePositionData = function(entity, dataFileName, targetEntity)
  -- function num : 0_6 , upvalues : _ENV, AnimationUtility
  if (((BattleECS.Utility).BuffUtility).IsHasCurrentBuff)(entity, 20048) and dataFileName ~= "char015magic" then
    return 
  end
  local component = entity:GetComponent((BattleECS.Components).AnimationEventComponent)
  if component then
    local currentFrame = component._roleIsInPositionChangeAnimationTimeStamp
    local data = component._roleIsInPositionChangeAnimationData
    local record = {}
    for k,v in ipairs(data) do
      if currentFrame < k then
        (table.insert)(record, v)
      end
    end
    local insertdata = (AnimationUtility.ChangePositionDataForm)(dataFileName)
    local newdata = {}
    local maxFrame = (math.max)((table.nums)(data), (table.nums)(insertdata))
    local frontSpeed = fixedpoint_zero
    local backSpeed = fixedpoint_zero
    local firstJumpFrame = 0
    local firstDownFrame = 0
    local secondJumpFrame = 0
    if dataFileName == "attackmove" then
      firstJumpFrame = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[4]).attr)
      firstDownFrame = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[5]).attr)
      secondJumpFrame = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[6]).attr)
      local deltX = (fixedpoint.abs)(((entity:GetComponent((BattleECS.Components).PositionComponent))._position).x - ((targetEntity:GetComponent((BattleECS.Components).PositionComponent))._position).x)
      frontSpeed = (fixedpoint.floor)(deltX / (firstDownFrame - firstJumpFrame))
      backSpeed = (fixedpoint.floor)(deltX / (maxFrame - secondJumpFrame))
    end
    do
      local firstMoveStart = 0
      local firstMoveEnd = 0
      local secondMoveStart = 0
      local secondMoveEnd = 0
      if dataFileName == "t127attackmove" then
        firstMoveStart = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[32]).attr)
        firstMoveEnd = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[33]).attr)
        secondMoveStart = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[34]).attr)
        secondMoveEnd = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[35]).attr)
        local offect = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[36]).attr)
        local deltX = (fixedpoint.abs)(((entity:GetComponent((BattleECS.Components).PositionComponent))._position).x - ((targetEntity:GetComponent((BattleECS.Components).PositionComponent))._position).x + offect)
        frontSpeed = (fixedpoint.floor)(deltX / (firstMoveEnd - firstMoveStart))
        backSpeed = (fixedpoint.floor)(deltX / (secondMoveEnd - secondMoveStart))
      end
      do
        for i = 1, maxFrame do
          newdata[i] = {}
          if not record[i] then
            record[i] = {x = fixedpoint_zero, y = fixedpoint_zero, z = fixedpoint_zero}
          end
          if not insertdata[i] then
            insertdata[i] = {x = fixedpoint_zero, y = fixedpoint_zero, z = fixedpoint_zero}
          end
          -- DECOMPILER ERROR at PC229: Confused about usage of register: R23 in 'UnsetPending'

          if dataFileName == "attackmove" then
            if i <= firstJumpFrame then
              (newdata[i]).x = fixedpoint_zero
            else
              -- DECOMPILER ERROR at PC236: Confused about usage of register: R23 in 'UnsetPending'

              if firstJumpFrame < i and i <= firstDownFrame then
                (newdata[i]).x = frontSpeed
              else
                -- DECOMPILER ERROR at PC244: Confused about usage of register: R23 in 'UnsetPending'

                if firstDownFrame < i and i <= secondJumpFrame then
                  (newdata[i]).x = fixedpoint_zero
                else
                  -- DECOMPILER ERROR at PC248: Confused about usage of register: R23 in 'UnsetPending'

                  ;
                  (newdata[i]).x = -backSpeed
                end
              end
            end
          else
            -- DECOMPILER ERROR at PC256: Confused about usage of register: R23 in 'UnsetPending'

            if dataFileName == "t127attackmove" then
              if i <= firstMoveStart then
                (newdata[i]).x = fixedpoint_zero
              else
                -- DECOMPILER ERROR at PC263: Confused about usage of register: R23 in 'UnsetPending'

                if firstMoveStart < i and i <= firstMoveEnd then
                  (newdata[i]).x = frontSpeed
                else
                  -- DECOMPILER ERROR at PC271: Confused about usage of register: R23 in 'UnsetPending'

                  if firstMoveEnd < i and i <= secondMoveStart then
                    (newdata[i]).x = fixedpoint_zero
                  else
                    -- DECOMPILER ERROR at PC279: Confused about usage of register: R23 in 'UnsetPending'

                    if secondMoveStart < i and i <= secondMoveEnd then
                      (newdata[i]).x = -backSpeed
                    else
                      -- DECOMPILER ERROR at PC283: Confused about usage of register: R23 in 'UnsetPending'

                      ;
                      (newdata[i]).x = fixedpoint_zero
                    end
                  end
                end
              end
            else
              -- DECOMPILER ERROR at PC291: Confused about usage of register: R23 in 'UnsetPending'

              ;
              (newdata[i]).x = (record[i]).x + (insertdata[i]).x
            end
          end
          -- DECOMPILER ERROR at PC298: Confused about usage of register: R23 in 'UnsetPending'

          ;
          (newdata[i]).y = (record[i]).y + (insertdata[i]).y
          -- DECOMPILER ERROR at PC305: Confused about usage of register: R23 in 'UnsetPending'

          ;
          (newdata[i]).z = (record[i]).z + (insertdata[i]).z
        end
        ;
        (AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionState)(entity, true)
        ;
        (AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionData)(entity, newdata)
        ;
        (AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionName)(entity, dataFileName)
        component._roleIsInPositionChangeAnimationTimeStamp = 0
        if dataFileName == "char015magic" then
          component._chargeBackTime = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[43]).attr)
        end
      end
    end
  end
end

AnimationUtility.InitMonsterOrRoleAnimationEventComponentRoleInSkillInfo = function(entity, skillid)
  -- function num : 0_7 , upvalues : _ENV
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkill = true
  ;
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillTimer = 0
  ;
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillWithEndTime = true
  ;
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillTimerWithEndTime = 0
  local time, containEndTime = (((BattleECS.Utility).Utility).GetMonsterOrRoleMagicOrAttackEndFraps)(entity, skillid)
  ;
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillMaxTime = time
  ;
  (entity:GetComponent((BattleECS.Components).AnimationEventComponent))._roleIsInSkillMaxTimeWithEndTime = containEndTime
end

return AnimationUtility

