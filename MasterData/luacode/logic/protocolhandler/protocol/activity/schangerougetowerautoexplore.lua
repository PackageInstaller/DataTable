local function p1(protocol)
  NekoData.DataManager.DM_TowerV2:OnSChangeRougeTowerAutoExplore(protocol)
  
  local mode
  if protocol.switchState == 1 then
    mode = "auto"
  end
  NekoData.DataManager.DM_Dungeon:SetMode(mode)
  LuaNotificationCenter.PostNotification(Common.n_TowerV2AutoExplore, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
