local function func(guideFrame)
  local child
  
  local dialog = DialogManager.GetDialog("teamedit.changeteamroledialog")
  if dialog and dialog._curTeam and dialog._curTeam.roles and dialog._listByConditions then
    local index
    for i, role in ipairs(dialog._listByConditions) do
      local tag = table.keyof(dialog._curTeam.roles, role:GetRoleId())
      local isJobLimit = not NekoData.BehaviorManager.BM_Vocation:GetVocationIsSupport(role, dialog._supportVocationTable)
      if isJobLimit and dialog._curRoleKey ~= role:GetRoleId() then
        tag = true
      end
      if not tag then
        index = i
        break
      end
    end
    if index then
      local logicCell = dialog._upFrame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        child = logicCell._cell:GetRootWindow()
      end
    else
      NekoData.BehaviorManager.BM_Guide:FinishGuide(45)
    end
    if child then
      dialog._upFrame:SetSlide(false)
    end
  end
  return child
end

return func
