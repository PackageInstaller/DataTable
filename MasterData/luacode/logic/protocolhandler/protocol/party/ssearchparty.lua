local function p1(protocol)
  local dialog = DialogManager.GetDialog("guild.guildsearchdialog")
  
  if dialog then
    dialog:Refrash(protocol)
  else
    dialog = DialogManager.CreateSingletonDialog("guild.guildsearchdialog")
    dialog:Refrash(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
