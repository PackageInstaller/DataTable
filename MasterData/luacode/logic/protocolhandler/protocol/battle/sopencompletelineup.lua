local function p1(protocol)
  local dialog = DialogManager.GetDialog("mainline.resource.completelineupdialog")
  
  if dialog then
    dialog:Init(protocol)
  else
    dialog = DialogManager.GetDialog("mainline.resource.resourcefloordialog")
    dialog = dialog and DialogManager.CreateSingletonChildDialog("mainline.resource.completelineupdialog", dialog._dialogName, dialog:GetRootWindow())
    dialog:Init(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
