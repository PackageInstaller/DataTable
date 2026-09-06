local function p1(protocol)
  local dialog = DialogManager.GetDialog("guild.guildrankleveldialog")
  
  if dialog then
    dialog:SetData(protocol)
  else
    dialog = DialogManager.CreateSingletonDialog("guild.guildrankleveldialog")
    dialog:SetData(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
