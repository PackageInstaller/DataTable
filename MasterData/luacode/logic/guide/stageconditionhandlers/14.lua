local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  local dialogName = params[1]
  local dialog = DialogManager.GetDialog(dialogName)
  local tag = false
  if dialog then
    if luaWindow then
      local child = dialog:GetChild(params[2])
      if child then
        tag = luaWindow == child
      end
    end
    tag = tag or dialog._tag ~= tonumber(params[3])
  end
  return tag
end

return func
