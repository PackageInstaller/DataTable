local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  if luaWindow and 0 < #params then
    for i, v in ipairs(params) do
      local list = string.split(v, "@")
      local dialogName = list[1]
      local dialog = DialogManager.GetDialog(dialogName)
      if dialog then
        local child
        if not list[2] then
          child = dialog:GetRootWindow()
        else
          child = dialog:GetChild(list[2])
        end
        if child then
          return luaWindow == child
        else
          return false
        end
      end
    end
  else
    return false
  end
end

return func
