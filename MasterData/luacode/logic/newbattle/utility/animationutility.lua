local AnimationUtility = {}

function AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionState(entity, state)
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInPositionChangeAnimationState = state
end

function AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionData(entity, data)
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInPositionChangeAnimationData = data
end

function AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionName(entity, name)
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInPositionChangeAnimationName = name
end

function AnimationUtility.IsNeedResetEntityAnimationEventComponentIsInChangePosition(entity)
  local component = entity:GetComponent(BattleECS.Components.AnimationEventComponent)
  if component and (component._roleIsInPositionChangeAnimationName == "blowup" or component._roleIsInPositionChangeAnimationName == "beatback" or component._roleIsInPositionChangeAnimationName == "blowup3") then
    return false
  end
  return true
end

function AnimationUtility.ChangePositionDataForm(dataFileName)
  local data = require("data.battledata.animation." .. dataFileName)
  local newdata = AnimationUtility.GetChangePositionDataByEachFrame(data)
  return newdata
end

function AnimationUtility.GetChangePositionDataByEachFrame(data)
  local maxFrame = data.x[table.nums(data.x)].timestamp
  local newdata = {}
  local index = 1
  for i = 1, maxFrame do
    newdata[i] = {}
    newdata[i].x = fixedpoint(data.x[index + 1].value) / (data.x[index + 1].timestamp - data.x[index].timestamp)
    newdata[i].y = fixedpoint(data.y[index + 1].value) / (data.y[index + 1].timestamp - data.y[index].timestamp)
    newdata[i].z = fixedpoint(data.z[index + 1].value) / (data.z[index + 1].timestamp - data.z[index].timestamp)
    if i == data.x[index + 1].timestamp then
      index = index + 1
    end
  end
  return newdata
end

function AnimationUtility.IntegrateChangePositionData(entity, dataFileName, targetEntity)
  if BattleECS.Utility.BuffUtility.IsHasCurrentBuff(entity, 20048) and dataFileName ~= "char015magic" then
    return
  end
  local component = entity:GetComponent(BattleECS.Components.AnimationEventComponent)
  if component then
    local currentFrame = component._roleIsInPositionChangeAnimationTimeStamp
    local data = component._roleIsInPositionChangeAnimationData
    local record = {}
    for k, v in ipairs(data) do
      if k > currentFrame then
        table.insert(record, v)
      end
    end
    local insertdata = AnimationUtility.ChangePositionDataForm(dataFileName)
    local newdata = {}
    local maxFrame = math.max(table.nums(data), table.nums(insertdata))
    local frontSpeed = fixedpoint_zero
    local backSpeed = fixedpoint_zero
    local firstJumpFrame = 0
    local firstDownFrame = 0
    local secondJumpFrame = 0
    if dataFileName == "attackmove" then
      firstJumpFrame = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[4].attr)
      firstDownFrame = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[5].attr)
      secondJumpFrame = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[6].attr)
      local deltX = fixedpoint.abs(entity:GetComponent(BattleECS.Components.PositionComponent)._position.x - targetEntity:GetComponent(BattleECS.Components.PositionComponent)._position.x)
      frontSpeed = fixedpoint.floor(deltX / (firstDownFrame - firstJumpFrame))
      backSpeed = fixedpoint.floor(deltX / (maxFrame - secondJumpFrame))
    end
    local firstMoveStart = 0
    local firstMoveEnd = 0
    local secondMoveStart = 0
    local secondMoveEnd = 0
    if dataFileName == "t127attackmove" then
      firstMoveStart = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[32].attr)
      firstMoveEnd = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[33].attr)
      secondMoveStart = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[34].attr)
      secondMoveEnd = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[35].attr)
      local offect = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[36].attr)
      local deltX = fixedpoint.abs(entity:GetComponent(BattleECS.Components.PositionComponent)._position.x - targetEntity:GetComponent(BattleECS.Components.PositionComponent)._position.x + offect)
      frontSpeed = fixedpoint.floor(deltX / (firstMoveEnd - firstMoveStart))
      backSpeed = fixedpoint.floor(deltX / (secondMoveEnd - secondMoveStart))
    end
    for i = 1, maxFrame do
      newdata[i] = {}
      if not record[i] then
        record[i] = {
          x = fixedpoint_zero,
          y = fixedpoint_zero,
          z = fixedpoint_zero
        }
      end
      if not insertdata[i] then
        insertdata[i] = {
          x = fixedpoint_zero,
          y = fixedpoint_zero,
          z = fixedpoint_zero
        }
      end
      if dataFileName == "attackmove" then
        if firstJumpFrame >= i then
          newdata[i].x = fixedpoint_zero
        elseif firstJumpFrame < i and firstDownFrame >= i then
          newdata[i].x = frontSpeed
        elseif firstDownFrame < i and secondJumpFrame >= i then
          newdata[i].x = fixedpoint_zero
        else
          newdata[i].x = -backSpeed
        end
      elseif dataFileName == "t127attackmove" then
        if firstMoveStart >= i then
          newdata[i].x = fixedpoint_zero
        elseif firstMoveStart < i and firstMoveEnd >= i then
          newdata[i].x = frontSpeed
        elseif firstMoveEnd < i and secondMoveStart >= i then
          newdata[i].x = fixedpoint_zero
        elseif secondMoveStart < i and secondMoveEnd >= i then
          newdata[i].x = -backSpeed
        else
          newdata[i].x = fixedpoint_zero
        end
      else
        newdata[i].x = record[i].x + insertdata[i].x
      end
      newdata[i].y = record[i].y + insertdata[i].y
      newdata[i].z = record[i].z + insertdata[i].z
    end
    AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionState(entity, true)
    AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionData(entity, newdata)
    AnimationUtility.SetEntityAnimationEventComponentIsInChangePositionName(entity, dataFileName)
    component._roleIsInPositionChangeAnimationTimeStamp = 0
    if dataFileName == "char015magic" then
      component._chargeBackTime = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[43].attr)
    end
  end
end

function AnimationUtility.InitMonsterOrRoleAnimationEventComponentRoleInSkillInfo(entity, skillid)
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkill = true
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkillTimer = 0
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkillWithEndTime = true
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkillTimerWithEndTime = 0
  local time, containEndTime = BattleECS.Utility.Utility.GetMonsterOrRoleMagicOrAttackEndFraps(entity, skillid)
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkillMaxTime = time
  entity:GetComponent(BattleECS.Components.AnimationEventComponent)._roleIsInSkillMaxTimeWithEndTime = containEndTime
end

return AnimationUtility
