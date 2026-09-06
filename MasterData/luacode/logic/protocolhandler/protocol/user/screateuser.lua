local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSCreateUser(protocol)
  
  local dialog = DialogManager.GetDialog("login.createroledialog")
  if dialog then
    DialogManager.DestroySingletonDialog("login.createroledialog")
  end
  local jsonStr = JSON.encode({eventName = "4"})
  ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
end

local function p2(protocol, client)
end

return {p1, p2}
