local function func(guideFrame)
  if guideFrame[1] then
    local child
    
    local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 6 and dialog._frame and dialog._data then
      local cell = dialog._frame:GetLogicCell(1)
      if cell and cell._cell and cell._cell._helper and #cell._cell._data > 0 then
        local cell_cell = cell._cell._helper:GetLogicCell(1)
        if cell_cell and cell_cell._cell then
          child = cell_cell._cell:GetChild(guideFrame[1])
        end
      end
    end
    return child
  end
end

return func
