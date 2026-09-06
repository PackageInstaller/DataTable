local function p1(protocol)
  local dialog = DialogManager.GetDialog("login.loginqueuedialog")
  
  dialog = dialog or DialogManager.CreateSingletonDialog("login.loginqueuedialog")
  dialog:SetData(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
