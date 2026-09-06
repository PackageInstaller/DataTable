local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
  
  if dialog then
    dialog:LoadData(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
