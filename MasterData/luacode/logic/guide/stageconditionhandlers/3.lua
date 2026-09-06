local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  if luaWindow and 0 < #params then
    local dialog = DialogManager.GetDialog("signboard.signboardmaindialog")
    if dialog then
      local index = tonumber(params[1])
      local logicCell = dialog.roleListFrame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        local window = logicCell._cell:GetChild("Cell/Frame")
        local tag = luaWindow == window
        if tag then
          dialog.roleListFrame:SetSlide(true)
          return true
        else
          return false
        end
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
