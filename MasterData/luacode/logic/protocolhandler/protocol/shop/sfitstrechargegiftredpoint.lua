local function p1(protocol)
  NekoData.DataManager.DM_Welfare:SFitstRechargeGiftRedPoint(true)
  
  LuaNotificationCenter.PostNotification(Common.n_FitstRechargeGiftRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
