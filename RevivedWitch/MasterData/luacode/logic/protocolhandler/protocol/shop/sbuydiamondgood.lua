-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/shop/sbuydiamondgood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("shop.itemgiftbuydialog")
  if dialog then
    dialog:Destroy()
  end
  dialog = (DialogManager.GetDialog)("activity.halloween.shopbuydialogskin")
  if dialog then
    dialog:Destroy()
  end
  dialog = (DialogManager.GetDialog)("activity.halloween.shopbuydialog6")
  if dialog then
    dialog:Destroy()
  end
  if protocol.result == 1 then
    ((NekoData.DataManager).DM_Shop):OnSBuyDiamondGood(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshShopInfo, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

