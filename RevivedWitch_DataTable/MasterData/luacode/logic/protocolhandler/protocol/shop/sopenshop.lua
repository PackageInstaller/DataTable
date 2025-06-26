-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/shop/sopenshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):OnSOpenShop(protocol)
  local list = ((NekoData.BehaviorManager).BM_Shop):GetShopIDList()
  local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
  if dialog then
    dialog:SetData(list)
  else
    dialog = (DialogManager.CreateSingletonDialog)("shop.shopmaindialog")
    dialog:SetData(list)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SOpenShop, nil, dialog)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

