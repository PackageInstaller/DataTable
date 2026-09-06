local function func(conditionInfo, luaWindow)
  local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
  
  if dialog and dialog._which == 7 and dialog._frame and dialog._data then
    local cell = dialog._frame:GetLogicCell(1)
    if cell and cell._cell and cell._cell._frame and cell._cell._data[1] then
      local cell_cell = cell._cell._frame:GetLogicCell(1)
      if cell_cell and cell_cell._cell then
        local tag = cell_cell._cell._data.unlock
        tag = tag or luaWindow == cell_cell._cell._unLockBtn
        if tag then
          cell._cell._frame:SetSlide(true)
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
