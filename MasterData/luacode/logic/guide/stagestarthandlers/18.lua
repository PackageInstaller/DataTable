local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("assistbattle.choosesupportroledialog")
  if dialog and dialog._frame and #dialog._listByConditions > 0 then
    local index = 1
    local logicCell = dialog._frame:GetLogicCell(index)
    if logicCell and logicCell._cell then
      child = logicCell._cell:GetRootWindow()
    end
    if child then
      dialog._frame:SetSlide(false)
    end
  end
  return child
end

return func
