-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/spopupgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("spopupgift", "--- activityID = %s, leftTime = %s, goodsId = %s, moneyType = %s, price = %s ---", protocol.activityID, protocol.leftTime, protocol.goodsId, protocol.moneyType, protocol.price)
  if protocol.leftTime == -1 then
    (DialogManager.DestroySingletonDialog)("welfare.popupgiftdialog")
  end
  ;
  ((NekoData.DataManager).DM_Activity):OnSPopUpGift(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshPopUpGift, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

