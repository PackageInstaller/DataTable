local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
    
    if dialog and dialog._pageHelper then
      local index = dialog._pageHelper:GetCurrentIndex()
      if index and index == 2 then
        local tabCell = dialog._pageHelper:GetCellAtIndex(2)
        return luaWindow == tabCell:GetChild("Panel/GiftBtn")
      end
    else
      return false
    end
  else
    return false
  end
end

return func
