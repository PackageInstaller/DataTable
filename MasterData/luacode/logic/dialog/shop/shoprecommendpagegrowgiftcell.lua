local Item = require("logic.manager.experimental.types.item")
local ShopRecommendPageGrowGiftCell = class("ShopRecommendPageGrowGiftCell", Dialog)
ShopRecommendPageGrowGiftCell.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageGrowGiftCell.AssetName = "RecommendShopPage3"

function ShopRecommendPageGrowGiftCell:Ctor(...)
  ShopRecommendPageGrowGiftCell.super.Ctor(self, ...)
end

function ShopRecommendPageGrowGiftCell:OnCreate()
  self._animationPanel = self:GetChild("Cell1")
  self._item = self:GetChild("Cell1/Item")
  self._txt1 = self:GetChild("Cell1/Back2/Txt1")
  self._txt2 = self:GetChild("Cell1/Back2/Txt2")
  self._diamondTxt = self:GetChild("Cell1/Txt1")
  self._goBtn = self:GetChild("Cell1/GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._item:Subscribe_PointerClickEvent(self.OnDiamondClick, self)
end

function ShopRecommendPageGrowGiftCell:OnDestroy()
end

function ShopRecommendPageGrowGiftCell:RefreshCell()
  self._txt1:SetText(NekoData.BehaviorManager.BM_Message:GetString(1383))
  self._txt2:SetText(NekoData.BehaviorManager.BM_Message:GetString(1384))
  self._diamondTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1385))
end

function ShopRecommendPageGrowGiftCell:OnGoBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
  if dialog then
    dialog:SetData(true)
    dialog:SetSelectedTab(3)
  end
  DialogManager.DestroySingletonDialog("shop.shopmaindialog")
end

function ShopRecommendPageGrowGiftCell:OnDiamondClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._item:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._item:GetLocalPointInUiRootPanel())
  end
end

function ShopRecommendPageGrowGiftCell:PlayShowAnimation()
  self._animationPanel:PlayAnimation("RecommendShopPage3")
end

return ShopRecommendPageGrowGiftCell
