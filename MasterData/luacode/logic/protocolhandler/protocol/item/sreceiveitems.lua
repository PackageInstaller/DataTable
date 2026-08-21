-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sreceiveitems.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, ItemTypeEnum
  local data = {items = protocol.itemList}
  if data.items and #data.items > 0 then
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = data})
  end
  local str = ""
  for i,v in ipairs(protocol.itemList) do
    if str ~= "" then
      str = str .. ", "
    end
    local itemId = v.id
    local item = nil
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
        end
      end
    end
    if item then
      itemId = item:GetID()
    end
    str = str .. "{id=" .. v.id .. ", itemId=" .. itemId .. ", gain=" .. v.gain .. ", itemtype=" .. v.itemtype .. ", bagtype=" .. v.bagtype .. ", number=" .. v.number .. "}"
  end
  LogInfoFormat("sreceiveitems", "%s", str)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

