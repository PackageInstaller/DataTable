local function p1(protocol)
  local str = ""
  
  for i, v in ipairs(protocol.roles) do
    if i ~= 1 then
      str = str .. ", "
    end
    str = str .. v
  end
  LogInfoFormat("SShowSpecialWeapon", "roles = %s", str)
  NekoData.DataManager.DM_AllRoles:OnSShowSpecialWeapon(protocol)
  LuaNotificationCenter.PostNotification(Common.n_UniqueEquipAvailable, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
