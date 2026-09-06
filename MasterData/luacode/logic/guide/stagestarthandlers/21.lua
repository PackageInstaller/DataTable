local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("shop.shopmaindialog")
  if dialog and dialog._groupBtnFrame and #dialog._shopIDTypeList > 0 then
    local index
    local groupBtnID = tonumber(guideFrame[1])
    for i, v in ipairs(dialog._shopIDTypeList) do
      if v == groupBtnID then
        index = i
        break
      end
    end
    if index then
      local logicCell = dialog._groupBtnFrame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        child = logicCell._cell:GetChild("GroupBtn/Guide")
      end
    end
  end
  return child
end

return func
