local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSBookActivity(protocol)
  
  local baseMainUI = DialogManager.GetDialog("base.basemainui")
  if baseMainUI ~= nil then
    baseMainUI:RefreshOrderBtn()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
