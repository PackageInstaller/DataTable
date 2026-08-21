local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")

function initTarget(input)
  info("GamePlay", "init target")
  local targetList = {}
  local stageID = input.stageID
  local rewardInfo = PB.get("DungeonReward", stageID)
  if rewardInfo == nil then
    info("GamePlay", "target no reward info " .. stageID)
    return {}
  end
  local script = "Logic/Target/Target"
  for i = 1, #rewardInfo.target do
    local id = rewardInfo.target[i].id
    local kind = rewardInfo.target[i].type
    local paramList = {}
    for p = 1, #rewardInfo.target[i].param do
      table.insert(paramList, rewardInfo.target[i].param[p])
    end
    local className = PB.enum.DungeonTarget.__keys[kind]
    if className == nil then
      info("GamePlay", "no target type " .. kind)
    else
      local target = require(script .. className)
      local new_table = target(paramList)
      new_table.id = id
      new_table.compareVal = paramList[1]
      new_table.operation = paramList[2]
      table.insert(targetList, new_table)
    end
  end
  return targetList
end

function getTarget(targetList, selfTeam, enemyTeam)
  local result = {}
  for i = 1, #targetList do
    local one_target = targetList[i]
    local val_table = {}
    local complete_id = 0
    local self_val = one_target.Update(selfTeam, enemyTeam)
    local compare_val = one_target.compareVal
    local operation = one_target.operation
    local specialResult = one_target.SpecialResult
    if specialResult ~= nil then
      if specialResult() == true then
        complete_id = one_target.id
      end
    elseif FH.compareValue(self_val, compare_val, operation) then
      complete_id = one_target.id
    end
    val_table[1] = complete_id
    val_table[2] = self_val
    val_table[3] = compare_val
    val_table[4] = operation
    local state = 0
    if one_target.CanNotFinishInFight ~= nil then
      state = 1
    end
    val_table[5] = state
    table.insert(result, val_table)
  end
  return result
end

function checkTarget(stageID, selfTeam, enemyTeam)
  local input = {}
  input.stageID = stageID
  local ret = getTarget(initTarget(input), JsonD(selfTeam), JsonD(enemyTeam))
  local result = {}
  for i = 1, #ret do
    local index = ret[i][1]
    if index ~= 0 then
      table.insert(result, index)
    end
  end
  return result
end

return initTarget, getTarget, checkTarget
