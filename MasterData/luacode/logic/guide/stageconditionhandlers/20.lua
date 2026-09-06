local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("bag.rolereset.changeselectroledialog")
    
    if dialog then
      local index = 1
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
