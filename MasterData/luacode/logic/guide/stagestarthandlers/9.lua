local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("task.taskmaindialog")
  if dialog and dialog._helper and dialog._helper:GetCurrentIndex() and dialog._helper:GetCurrentIndex() == 1 then
    local tabCell = dialog._helper:GetCellAtIndex(1)
    if tabCell then
      child = tabCell._detail:GetChild("GetBtn/Guide")
    end
  end
  return child
end

return func
