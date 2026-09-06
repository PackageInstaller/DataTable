local function p1(protocol)
  DialogManager.DestroySingletonDialog("character.quicklevelup.quicklevelupconfirmdialog")
  
  DialogManager.DestroySingletonDialog("character.quicklevelup.quicklevelupmaindialog")
  DialogManager.CreateSingletonDialog("character.quicklevelup.quicklevelupsuccessdialog"):SetData(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
