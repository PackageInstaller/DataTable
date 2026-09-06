local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local tag = true
  for i, v in ipairs(params) do
    local list = string.split(v, "@")
    local dialogName = DataCommon.Dialog[tonumber(list[1])]
    if dialogName then
      local value = tonumber(list[2])
      if value == 0 then
        tag = not DialogManager.GetDialog(dialogName)
      elseif value == 1 then
        tag = DialogManager.GetDialog(dialogName) ~= nil
      end
      if tag then
        return true
      end
    else
      return false
    end
  end
  return tag
end

return func
