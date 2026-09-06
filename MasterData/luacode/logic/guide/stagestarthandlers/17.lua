local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("friend.friendsmaindialog")
  if dialog and dialog._pageHelper and dialog._pageHelper:GetCurrentIndex() == 4 then
    local tabCell = dialog._pageHelper:GetCellAtIndex(4)
    if tabCell then
      child = tabCell:GetChild("UI/Left/ChangeBtn")
    end
  end
  return child
end

return func
