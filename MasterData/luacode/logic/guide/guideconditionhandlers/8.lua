local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local groupName = DataCommon.Group[tonumber(params[1])]
  local group = DialogManager.GetGroup(groupName)
  local active = tonumber(params[2]) == 1
  local tag
  local dialogName = DataCommon.Dialog[tonumber(params[3])]
  if dialogName then
    local value = tonumber(params[4])
    if value == 0 then
      tag = not DialogManager.GetDialog(dialogName)
    elseif value == 1 then
      tag = DialogManager.GetDialog(dialogName) ~= nil
    end
  end
  return group and group:GetObjectActive() == active or tag
end

return func
