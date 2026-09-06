local function p1(protocol)
  LogInfoFormat("spopupgift", "--- activityID = %s, leftTime = %s, goodsId = %s, moneyType = %s, price = %s ---", protocol.activityID, protocol.leftTime, protocol.goodsId, protocol.moneyType, protocol.price)
  
  if protocol.leftTime == -1 then
    DialogManager.DestroySingletonDialog("welfare.popupgiftdialog")
  end
  NekoData.DataManager.DM_Activity:OnSPopUpGift(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshPopUpGift, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
