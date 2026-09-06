local function p1(protocol)
  NekoData.DataManager.DM_Tower:OnSOpenTowerList(protocol)
  
  local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:ToTowerDialog(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
