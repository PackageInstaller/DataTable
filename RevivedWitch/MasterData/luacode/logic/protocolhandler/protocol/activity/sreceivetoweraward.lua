-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sreceivetoweraward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_TowerV2):OnSReceiveTowerAward(protocol)
  do
    if #protocol.items ~= 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
      dialog:LoadData({items = protocol.items})
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_TowerV2Reward, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

