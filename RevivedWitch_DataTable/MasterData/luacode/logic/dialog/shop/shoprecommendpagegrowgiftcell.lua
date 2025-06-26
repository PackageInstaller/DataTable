-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprecommendpagegrowgiftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ShopRecommendPageGrowGiftCell = class("ShopRecommendPageGrowGiftCell", Dialog)
ShopRecommendPageGrowGiftCell.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageGrowGiftCell.AssetName = "RecommendShopPage3"
ShopRecommendPageGrowGiftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRecommendPageGrowGiftCell
  ((ShopRecommendPageGrowGiftCell.super).Ctor)(self, ...)
end

ShopRecommendPageGrowGiftCell.OnCreate = function(self)
  -- function num : 0_1
  self._animationPanel = self:GetChild("Cell1")
  self._item = self:GetChild("Cell1/Item")
  self._txt1 = self:GetChild("Cell1/Back2/Txt1")
  self._txt2 = self:GetChild("Cell1/Back2/Txt2")
  self._diamondTxt = self:GetChild("Cell1/Txt1")
  self._goBtn = self:GetChild("Cell1/GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._item):Subscribe_PointerClickEvent(self.OnDiamondClick, self)
end

ShopRecommendPageGrowGiftCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopRecommendPageGrowGiftCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._txt1):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1383))
  ;
  (self._txt2):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1384))
  ;
  (self._diamondTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1385))
end

ShopRecommendPageGrowGiftCell.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
  if dialog then
    dialog:SetData(true)
    dialog:SetSelectedTab(3)
  end
  ;
  (DialogManager.DestroySingletonDialog)("shop.shopmaindialog")
end

ShopRecommendPageGrowGiftCell.OnDiamondClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.DiamodID)})
    local width, height = (self._item):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._item):GetLocalPointInUiRootPanel())
  end
end

ShopRecommendPageGrowGiftCell.PlayShowAnimation = function(self)
  -- function num : 0_6
  (self._animationPanel):PlayAnimation("RecommendShopPage3")
end

return ShopRecommendPageGrowGiftCell

