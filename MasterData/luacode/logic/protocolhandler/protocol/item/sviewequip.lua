local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSViewEquip(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_EquipChecked, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
