local function func(guideFrame)
  if #guideFrame == 3 then
    local dialog = DialogManager.GetDialog(guideFrame[1])
    
    if dialog and dialog._rootWindow and dialog:GetCurMessageId() == tonumber(guideFrame[3]) then
      return dialog:GetChild(guideFrame[2])
    end
  end
end

return func
