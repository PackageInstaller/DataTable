local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("bag.rolereset.changeselectroledialog")
  if dialog and dialog._upFrame and dialog._listByConditions then
    if #dialog._listByConditions > 0 then
      local logicCell = dialog._upFrame:GetLogicCell(1)
      if logicCell and logicCell._cell then
        child = logicCell._cell:GetRootWindow()
      end
      if child then
        dialog._upFrame:SetSlide(false)
      end
    else
      NekoData.BehaviorManager.BM_Guide:FinishGuide(65)
    end
  end
  return child
end

return func
