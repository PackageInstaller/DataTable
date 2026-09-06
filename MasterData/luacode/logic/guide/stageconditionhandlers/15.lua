local function func(conditionInfo, luaWindow)
  if luaWindow then
    return true
  else
    local params = conditionInfo.parm
    local dialogName = params[1]
    local dialog = DialogManager.GetDialog(dialogName)
    return dialog and dialog._tag ~= 4
  end
end

return func
