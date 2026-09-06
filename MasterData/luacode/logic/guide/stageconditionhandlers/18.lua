local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  local tag
  if luaWindow then
    local dialogName = params[1]
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      local child = dialog:GetChild(params[2])
      if child then
        tag = luaWindow == child
      end
    end
  end
  if not tag then
    local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 7 and dialog._frame and dialog._data then
      local cell = dialog._frame:GetLogicCell(1)
      if cell and cell._cell and cell._cell._frame and cell._cell._data[1] then
        local cell_cell = cell._cell._frame:GetLogicCell(1)
        if cell_cell and cell_cell._cell then
          tag = true
        end
      end
    end
  end
  return tag
end

return func
