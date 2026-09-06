local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSTaskAward(protocol)
  
  local list = {
    items = protocol.itemList
  }
  if protocol.gold ~= 0 then
    table.insert(list.items, 1, {
      id = DataCommon.ManaID,
      number = protocol.gold,
      itemtype = 1
    })
  end
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
    tag = DataCommon.ShowDialogType.ItemAccount,
    data = list
  })
end

local function p2(protocol, client)
end

return {p1, p2}
