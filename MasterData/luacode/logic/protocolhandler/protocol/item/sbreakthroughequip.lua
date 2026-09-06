local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSEquipBreak(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_EquipBreak, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
