local function func(conditionInfo, luaWindow)
  local params = conditionInfo.parm
  
  if luaWindow and 0 < #params then
    local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
    if dialog then
      local index
      for i, v in ipairs(dialog._listByConditions) do
        if v:GetId() == tonumber(params[1]) then
          index = i
          break
        end
      end
      if index then
        local logicCell = dialog._frame:GetLogicCell(index)
        if logicCell and logicCell._cell then
          local window = logicCell._cell:GetChild("CharacterCell")
          local tag = luaWindow == logicCell._cell:GetRootWindow()
          if tag then
            dialog._frame:SetSlide(true)
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
