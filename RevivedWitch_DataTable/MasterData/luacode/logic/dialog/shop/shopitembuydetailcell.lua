-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopitembuydetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ShopItemBuyDetailCell = class("ShopItemBuyDetailCell", Dialog)
ShopItemBuyDetailCell.AssetBundleName = "ui/layouts.baseshop"
ShopItemBuyDetailCell.AssetName = "ItemBuyDetailCell"
ShopItemBuyDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopItemBuyDetailCell
  ((ShopItemBuyDetailCell.super).Ctor)(self, ...)
end

ShopItemBuyDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._buyDetail = self:GetChild("Detail")
end

ShopItemBuyDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopItemBuyDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  local buyDetail = ""
  do
    if data.id > 10000 then
      local item = (Item.Create)(data.id)
      buyDetail = buyDetail .. item:GetName() .. "X" .. data.num
    end
    ;
    (self._buyDetail):SetText(buyDetail)
  end
end

return ShopItemBuyDetailCell

