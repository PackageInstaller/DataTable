local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSLockEquip(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_EquipLockStateChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
