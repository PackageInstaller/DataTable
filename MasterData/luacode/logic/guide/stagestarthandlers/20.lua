local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("handbook.favour.givegiftdialog")
  if dialog and dialog._itemFrame and dialog._selectItem then
    local index = 1
    local logicCell = dialog._itemFrame:GetLogicCell(index)
    if logicCell and logicCell._cell then
      child = logicCell._cell:GetRootWindow()
    end
    if child then
      dialog._itemFrame:SetSlide(false)
    end
  end
  return child
end

return func
