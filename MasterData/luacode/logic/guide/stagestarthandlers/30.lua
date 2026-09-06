local function func()
  local dialog = DialogManager.GetDialog("equip.bagdialog")
  
  if dialog and dialog._frame and dialog._frame:GetCurrentIndex() == 4 then
    local cell = dialog._frame:GetCellAtIndex(4)
    if cell and cell._cell and cell._roleClick then
      return cell._roleClick
    end
  end
end

return func
