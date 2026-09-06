local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("equipforge.equipforgedialog")
    
    if dialog and dialog._tab and dialog._tab == 1 and #dialog._forgeIetmData > 0 then
      local index = 1
      local data = dialog._forgeIetmData[index]
      if data then
        local logicCell = dialog._item_frame:GetLogicCell(index)
        if logicCell and logicCell._cell then
          local tag = luaWindow == logicCell._cell:GetRootWindow()
          if tag then
            dialog._item_frame:SetSlide(true)
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
