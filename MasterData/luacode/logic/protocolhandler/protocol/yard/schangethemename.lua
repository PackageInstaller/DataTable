local function p1(protocol)
  NekoData.DataManager.DM_Cabin:OnSChangeThemeName(protocol)
  
  DialogManager.DestroySingletonDialog("courtcabin.changediythemenamedialog")
  NekoData.BehaviorManager.BM_Message:SendMessageById(100160)
  local dialog = DialogManager.GetDialog("courtcabin.diythemedialog")
  if dialog then
    dialog:RefreshName(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_DIYThemeNameChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
