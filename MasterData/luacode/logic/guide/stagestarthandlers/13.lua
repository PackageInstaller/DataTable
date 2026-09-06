local function func(guideFrame)
  local dialog = DialogManager.GetDialog(guideFrame[1])
  
  local child
  if dialog and dialog._rootWindow then
    child = dialog:GetChild(guideFrame[2])
    if child then
      return {
        parent = child._uiObject,
        effectPos = {posX = 0, posY = 0}
      }
    end
  end
end

return func
