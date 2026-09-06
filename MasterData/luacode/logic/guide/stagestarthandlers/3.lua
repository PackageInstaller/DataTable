local function func(guideFrame)
  local dialog = DialogManager.GetDialog(guideFrame[1])
  
  local child
  if dialog and dialog._clipName and dialog._clipName == "CharLevelUp" then
    child = dialog:GetChild(guideFrame[2])
  end
  return child
end

return func
