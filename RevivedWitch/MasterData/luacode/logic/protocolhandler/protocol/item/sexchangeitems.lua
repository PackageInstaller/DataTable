-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sexchangeitems.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local data = {items = protocol.itemList}
  if data.items and #data.items > 0 then
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = data})
  end
  LogInfoFormat("sexchangeitems", "activityId = %s", protocol.activityId)
  if protocol.activityId == ((NekoData.BehaviorManager).BM_Activity):GetActivityIdByType(DataCommon.GeneralCollectionActFuncType) then
    local dialog = (DialogManager.GetDialog)("activity.midautumn.midautumndialog")
    if dialog then
      (dialog._animator):Play("like")
    end
    ;
    (DialogManager.DestroySingletonDialog)("activity.midautumn.exchangedialog")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

