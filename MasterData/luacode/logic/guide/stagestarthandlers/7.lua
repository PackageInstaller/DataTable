local function func(guideFrame)
  for i, v in ipairs(guideFrame) do
    local list = string.split(v, "@")
    
    local dialogName = list[1]
    local dialog = DialogManager.GetDialog(dialogName)
    local child
    if dialog then
      if not list[2] then
        child = dialog:GetRootWindow()
      else
        child = dialog:GetChild(list[2])
      end
    end
    if child then
      return child
    end
  end
end

return func
