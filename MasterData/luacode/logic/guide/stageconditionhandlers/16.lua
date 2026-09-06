local function func(conditionInfo, luaWindow)
  if luaWindow then
    local dialog = DialogManager.GetDialog("shop.shopmaindialog")
    
    if dialog and dialog._groupBtnFrame and #dialog._shopIDTypeList > 0 then
      local index
      local params = conditionInfo.parm
      local groupBtnID = tonumber(params[1])
      for i, v in ipairs(dialog._shopIDTypeList) do
        if v == groupBtnID then
          index = i
          break
        end
      end
      if index then
        local logicCell = dialog._groupBtnFrame:GetLogicCell(index)
        if logicCell and logicCell._cell then
          return luaWindow == logicCell._cell:GetChild("GroupBtn")
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
