local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  if luaWindow and 0 < #params then
    local dialogName = params[1]
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      local child
      if not params[2] then
        child = dialog:GetRootWindow()
      else
        child = dialog:GetChild(params[2])
      end
      if child then
        return luaWindow == child
      else
        return false
      end
    else
      return false
    end
  else
    return false
  end
end

return func
