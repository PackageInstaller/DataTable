local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnSUpdateRolesStatus(protocol.roleStatus)
end

local function p2(protocol, client)
end

return {p1, p2}
