-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/shopgoodscell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShopGoodsCellHelper = require("logic.dialog.activity.swimsuitechoes.shopgoodscellhelper")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activitysummer2"
ShopGoodsCell.AssetName = "ActivitySummer2OtherShopCell"
ShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGoodsCell
  ((ShopGoodsCell.super).Ctor)(self, ...)
end

ShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ShopGoodsCellHelper
  self._rootElement = self:GetRootWindow()
  self._goodsCellHelper = (ShopGoodsCellHelper.Create)(self._rootElement)
end

ShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._goodsCellHelper then
    (self._goodsCellHelper):OnDestroy()
  end
end

ShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if self._goodsCellHelper then
    (self._goodsCellHelper):RefreshCell(data.data, (self._delegate)._shopID, data.index)
  end
end

return ShopGoodsCell

