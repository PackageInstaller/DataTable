-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/ranking/sreceivewatermelonreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  do
    if protocol.items and #protocol.items > 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
      if dialog then
        dialog:LoadData(protocol)
      end
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnSreceiveWatermelonReward, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

