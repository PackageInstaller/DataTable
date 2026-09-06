local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tagId = tonumber(params[1])
  local tagValue = tonumber(params[2])
  local value = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(tagId)
  return value and value == tagValue
end

return func
