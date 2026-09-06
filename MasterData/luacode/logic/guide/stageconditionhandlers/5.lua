local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("teamedit.changeteamroledialog")
    
    if dialog then
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
