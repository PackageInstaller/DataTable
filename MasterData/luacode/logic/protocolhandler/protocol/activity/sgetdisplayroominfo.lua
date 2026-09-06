local function p1(protocol)
  local dialogName = "activity.swimsuit.maskdialog"
  
  local dialog = DialogManager.GetDialog(dialogName)
  dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
  dialog:SetData(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
