local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("activity.giftoftime.giftoftimemaindialog")
    
    if dialog then
      local index = 2
      if index then
        local cell = dialog._frame:GetCellAtIndex(index)
        if cell and cell then
          local window = cell:GetChild("CharCell1")
          local tag = luaWindow == window
          if tag then
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
