local function func(guideFrame)
  if guideFrame[1] then
    local child
    
    local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 4 and dialog._frame and dialog._data then
      local cell = dialog._frame:GetLogicCell(1)
      if cell and cell._cell and cell._cell._frame and #cell._cell._data > 0 then
        local id = tonumber(guideFrame[1])
        local index
        for i, v in ipairs(cell._cell._data) do
          for j, k in ipairs(v.data) do
            if k.id == id then
              index = i
              break
            end
          end
          if index ~= nil then
            break
          end
        end
        if index then
          local cell_cell = cell._cell._frame:GetLogicCell(index)
          if cell_cell and cell_cell._cell then
            child = cell_cell._cell._img
          end
        end
      end
    end
    return child
  end
end

return func
