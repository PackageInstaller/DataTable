local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSModifyItemNum(protocol)
  
  if NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed(protocol) then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  LuaNotificationCenter.PostNotification(Common.n_ItemNumModify, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
