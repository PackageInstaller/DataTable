local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("activity.giftoftime.giftoftimemaindialog")
  if dialog and dialog._frame and dialog._frame:GetCurrentIndex() == 2 then
    local cell = dialog._frame:GetCellAtIndex(2)
    if cell then
      child = cell:GetChild("CharCell1")
    end
  end
  return child
end

return func
