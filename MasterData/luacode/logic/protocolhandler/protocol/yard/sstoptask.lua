local function p1(protocol)
  if protocol.statue == 1 then
    NekoData.DataManager.DM_MagicTree:OnSStopTask(protocol)
    
    LuaNotificationCenter.PostNotification(Common.n_StopMagicTreeSlotTask, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
