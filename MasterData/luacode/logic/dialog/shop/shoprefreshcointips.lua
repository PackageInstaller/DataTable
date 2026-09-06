local Item = require("logic.manager.experimental.types.item")
local UIManager = CS.PixelNeko.UI.UIManager
local ShopRefreshCoinTips = class("ShopRefreshCoinTips", Dialog)
ShopRefreshCoinTips.AssetBundleName = "ui/layouts.baseshop"
ShopRefreshCoinTips.AssetName = "ShopRefreshSecondConfirm"

function ShopRefreshCoinTips:Ctor(...)
  ShopRefreshCoinTips.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShopRefreshCoinTips:OnCreate()
  self._leftNum = self:GetChild("BackImage/Text3")
  self._image = self:GetChild("BackImage/Num/Icon")
  self._cost = self:GetChild("BackImage/Num/Num2")
  self._have = self:GetChild("BackImage/Num/Num1")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancelBtn = self:GetChild("BackImage/CancelButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ShopRefreshCoinTips:OnDestroy()
end

function ShopRefreshCoinTips:SetData()
  local moneyType = NekoData.BehaviorManager.BM_Shop:GetShopRefreshCointCurrencyType()
  local item = Item.Create(moneyType)
  local imageRecord = item:GetIcon()
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local left = NekoData.BehaviorManager.BM_Shop:GetShopRefreshCointLeftChange()
  self._leftNum:SetText(left)
  self._totalMoney = 0
  if moneyType == 35001 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetDiamond()
  elseif moneyType == 35002 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetMoney()
  elseif moneyType == 35003 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  elseif moneyType == 35017 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetAgCoin()
  elseif moneyType == 35009 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetFriendShip()
  elseif moneyType == 35010 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetEther()
  elseif moneyType == 35011 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetWhiteCoin()
  elseif moneyType == 35012 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetGoldCoin()
  elseif moneyType == 35018 then
    self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetFurnitureCion()
  end
  self._have:SetText(self._totalMoney)
  local cost = NekoData.BehaviorManager.BM_Shop:GetShopRefreshCointNextTimeCost()
  self._cost:SetText("-" .. cost)
  if cost > self._totalMoney or left <= 0 then
    self._confirmBtn:SetInteractable(false)
  else
    self._confirmBtn:SetInteractable(true)
  end
end

function ShopRefreshCoinTips:OnConfirmBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.crefreshfriendshop")
  if protocol then
    protocol.shopType = 9
    protocol:Send()
  end
  self:Destroy()
end

function ShopRefreshCoinTips:OnBackBtnClicked()
  self:Destroy()
end

function ShopRefreshCoinTips:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:Destroy()
  end
end

return ShopRefreshCoinTips
