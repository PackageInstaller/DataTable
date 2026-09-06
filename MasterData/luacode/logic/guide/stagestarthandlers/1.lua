local function func(guideFrame)
  if guideFrame[1] then
    if guideFrame[1] ~= "0" then
      local child
      
      local dialog = DialogManager.GetDialog(guideFrame[1])
      if dialog and dialog._rootWindow then
        if guideFrame[2] then
          child = dialog:GetChild(guideFrame[2])
        else
          return dialog._rootWindow
        end
      end
      return child
    else
      return guideFrame[1]
    end
  end
end

return func
