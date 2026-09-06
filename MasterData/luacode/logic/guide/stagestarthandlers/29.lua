local function func(guideFrame)
  local params = guideFrame
  
  local child
  if 0 < #params then
    local dialog = DialogManager.GetDialog("signboard.signboardmaindialog")
    if dialog and dialog.roleListFrame and #dialog._listByConditions >= tonumber(params[1]) then
      local index = tonumber(params[1])
      local logicCell = dialog.roleListFrame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        child = logicCell._cell:GetRootWindow()
      end
      if child then
        dialog.roleListFrame:SetSlide(false)
      end
    end
  end
  return child
end

return func
