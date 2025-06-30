-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/stotalsignaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = {result = protocol.success, day = protocol.day}
  ;
  ((NekoData.DataManager).DM_Welfare):OnSTotalSign(userInfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_AccumulatedSignResult, nil, userInfo)
  local pro = {items = protocol.awards}
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
  if dialog then
    dialog:LoadData(pro)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

