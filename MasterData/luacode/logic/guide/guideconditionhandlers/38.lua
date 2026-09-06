local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local groupName = DataCommon.Group[tonumber(params[1])]
  local group = DialogManager.GetGroup(groupName)
  local active = tonumber(params[2]) == 1
  return group and group:GetObjectActive() == active
end

return func
