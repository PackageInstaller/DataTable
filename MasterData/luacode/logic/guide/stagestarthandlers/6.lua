local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("teamedit.changeteamroledialog")
  if dialog and dialog._curTeam and dialog._curTeam.roles then
    local index
    local count = 0
    for k, v in pairs(dialog._curTeam.roles) do
      if v ~= 0 then
        count = count + 1
      end
    end
    local index
    if count < table.nums(dialog._curTeam.roles) then
      index = count + 1
    end
    if index then
      local logicCell = dialog._upFrame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        child = logicCell._cell:GetRootWindow()
      end
    end
    if child then
      dialog._upFrame:SetSlide(false)
    end
  end
  return child
end

return func
