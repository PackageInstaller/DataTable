local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  local dialogName = params[1]
  if dialogName then
    local value = tonumber(params[2])
    if value == 0 then
      return not DialogManager.GetDialog(dialogName)
    elseif value == 1 then
      return DialogManager.GetDialog(dialogName) ~= nil
    end
  end
end

return func
