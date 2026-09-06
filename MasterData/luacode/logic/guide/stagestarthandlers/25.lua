local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
  if dialog and dialog._which == 7 and dialog._frame and dialog._data then
    local cell = dialog._frame:GetLogicCell(1)
    if cell and cell._cell and cell._cell._frame and cell._cell._data[1] then
      local cell_cell = cell._cell._frame:GetLogicCell(1)
      if cell_cell and cell_cell._cell then
        child = cell_cell._cell._rootWindow
      end
      if child then
        cell._cell._frame:SetSlide(false)
      end
    end
  end
  return child
end

return func
