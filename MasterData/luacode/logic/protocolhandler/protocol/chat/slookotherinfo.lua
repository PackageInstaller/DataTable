local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("friend.charactershowdialog")
  
  dialog:SetData(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
