local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("equipforge.equipforgedialog")
  if dialog and dialog._tab and dialog._tab == 1 then
    if #dialog._forgeIetmData > 0 then
      local index = 1
      local data = dialog._forgeIetmData[index]
      if data then
        local logicCell = dialog._item_frame:GetLogicCell(index)
        if logicCell and logicCell._cell then
          child = logicCell._cell:GetRootWindow()
        end
      end
      if child then
        dialog._item_frame:SetSlide(false)
      end
    else
      NekoData.BehaviorManager.BM_Guide:FinishGuide(53)
    end
  end
  return child
end

return func
