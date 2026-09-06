local function func(conditionInfo, luaWindow)
  local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
  
  if dialog and dialog._which == 6 and dialog._frame and dialog._data then
    local cell = dialog._frame:GetLogicCell(1)
    if cell and cell._cell and cell._cell._frame and cell._cell._data[1] then
      return true
    else
      return false
    end
  else
    return false
  end
end

return func
