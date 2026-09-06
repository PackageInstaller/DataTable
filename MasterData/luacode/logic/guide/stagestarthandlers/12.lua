local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("equipforge.equipforgedialog")
  if dialog and dialog._tab_frame and dialog._tab_frame:GetCurrentIndex() and dialog._tab_frame:GetCurrentIndex() == 1 then
    local index = 1
    local tabCell = dialog._tab_frame:GetCellAtIndex(1)
    if tabCell then
      child = tabCell:GetChild("Frame/StartBtn")
    end
  end
  return child
end

return func
