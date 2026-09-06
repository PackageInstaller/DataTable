local function p1(protocol)
  if protocol.result == 1 then
    NekoData.DataManager.DM_Shop:OnSBuyShopGood(protocol)
    
    LuaNotificationCenter.PostNotification(Common.n_BuyEquipChest, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
