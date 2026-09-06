local function func(guideFrame)
  local params = guideFrame
  
  local child
  if 0 < #params then
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
          child = logicCell._cell:GetRootWindow()
        end
      end
      if child then
        dialog._frame:SetSlide(false)
      end
    end
  end
  return child
end

return func
