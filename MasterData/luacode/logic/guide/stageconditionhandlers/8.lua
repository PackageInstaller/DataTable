local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("teamedit.changeteamroledialog")
    
    if dialog then
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
          local tag = luaWindow == logicCell._cell:GetRootWindow()
          if tag then
            dialog._upFrame:SetSlide(true)
            return true
          else
            return false
          end
        else
          return false
        end
      else
        return false
      end
    else
      return false
    end
  else
    return false
  end
end

return func
