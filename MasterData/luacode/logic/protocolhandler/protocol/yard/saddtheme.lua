local function p1(protocol)
  NekoData.DataManager.DM_Cabin:OnSAddTheme(protocol)
  
  local dialog = DialogManager.GetDialog("courtcabin.adddiythemedialog")
  if dialog then
    dialog:Destroy()
  end
  LuaNotificationCenter.PostNotification(Common.n_AddDIYTheme, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
