-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/recommendshoppageitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local RecommendShopPageItemCell = class("RecommendShopPageItemCell", Dialog)
RecommendShopPageItemCell.AssetBundleName = "ui/layouts.baseshop"
RecommendShopPageItemCell.AssetName = "RecommendShopPage1Item"
RecommendShopPageItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendShopPageItemCell
  ((RecommendShopPageItemCell.super).Ctor)(self, ...)
  self._item = {}
end

RecommendShopPageItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemBack = self:GetChild("Item/Back")
  self._itemIcon = self:GetChild("Item/Item")
  self._count = self:GetChild("Item/Num")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RecommendShopPageItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

RecommendShopPageItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._item = (Item.Create)(data.id)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetText(data.count)
end

RecommendShopPageItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return RecommendShopPageItemCell

