local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")

local function p1(protocol)
  local data = {
    items = protocol.itemList
  }
  if data.items and #data.items > 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = data
    })
  end
  local str = ""
  for i, v in ipairs(protocol.itemList) do
    if str ~= "" then
      str = str .. ", "
    end
    local itemId = v.id
    local item
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    end
    if item then
      itemId = item:GetID()
    end
    str = str .. "{id=" .. v.id .. ", itemId=" .. itemId .. ", gain=" .. v.gain .. ", itemtype=" .. v.itemtype .. ", bagtype=" .. v.bagtype .. ", number=" .. v.number .. "}"
  end
  LogInfoFormat("sreceiveitems", "%s", str)
end

local function p2(protocol, client)
end

return {p1, p2}
