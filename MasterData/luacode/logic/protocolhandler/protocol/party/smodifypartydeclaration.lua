local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnSModifyPartyDeclaration(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSModifyPartyDeclaration, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
