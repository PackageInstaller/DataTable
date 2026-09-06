local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("assistbattle.choosesupportroledialog")
    
    if dialog then
      local index = 1
      local logicCell = dialog._frame:GetLogicCell(index)
      if logicCell and logicCell._cell then
        local tag = luaWindow == logicCell._cell:GetRootWindow()
        if tag then
          dialog._frame:SetSlide(true)
          return true
        else
          return false
        end
      end
    else
      return false
    end
  else
    return false
  end
end

return func
