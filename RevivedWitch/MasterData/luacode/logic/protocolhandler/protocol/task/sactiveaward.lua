-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/sactiveaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Task):OnSActiveAward(protocol)
  local list = {items = protocol.itemList}
  if protocol.gold ~= 0 then
    (table.insert)(list.items, 1, {id = DataCommon.ManaID, number = protocol.gold, itemtype = 1})
  end
  ;
  ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = list})
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

