local Item = require("logic.manager.experimental.types.item")
local MoneyCell = class("MoneyCell", Dialog)
MoneyCell.AssetBundleName = "ui/layouts.gacha"
MoneyCell.AssetName = "GachaMainMoneyCell"

function MoneyCell:Ctor(...)
  MoneyCell.super.Ctor(self, ...)
  self._item = nil
end

function MoneyCell:OnCreate()
  self._moneyBoard = self:GetChild("Money")
  self._addBtn = self:GetChild("Money/Add")
  self._moneyIcon = self:GetChild("Money/Icon")
  self._moneyText = self:GetChild("Money/Text")
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  self._moneyBoard:Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
  LuaNotificationCenter.AddObserver(self, self.OpenShop, Common.n_SOpenShop, nil)
end

function MoneyCell:OnDestroy()
end

function MoneyCell:RefreshCell(data)
  self._item = Item.Create(data)
  local image = self._item:GetIcon()
  self._moneyIcon:SetSprite(image.assetBundle, image.assetName)
  if NekoData.BehaviorManager.BM_Currency:IsCurrency(data) then
    self._moneyText:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data))
  else
    self._moneyText:SetNumber(NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(data))
  end
  self._addBtn:SetActive(data ~= 30077 and data ~= 30076)
end

function MoneyCell:OnAddBtnClick()
  local dialog = DialogManager.GetDialog("base.basemainui")
  if dialog then
    dialog:OnShopClick()
    self._isClicked = true
  else
    LogError("MoneyCell", "Cannot find basemainui.")
  end
end

function MoneyCell:OpenShop(notification)
  if self._isClicked then
    local dialog = notification.userInfo
    if dialog then
      if self._item:GetID() == DataCommon.DiamodID then
        dialog:OnGroupBtnClicked(4)
      elseif self._item:GetID() == DataCommon.SoulDropID then
        dialog:OnGroupBtnClicked(19)
      elseif self._item:GetID() == DataCommon.WhiteCoin then
        dialog:OnGroupBtnClicked(7)
      elseif self._item:GetID() == DataCommon.GoldCoin then
        dialog:OnGroupBtnClicked(8)
      end
    else
      LogError("MoneyCell", "Cannot find shopmaindialog.")
    end
  end
  self._isClicked = false
end

function MoneyCell:OnMoneyBoardClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self._moneyBoard:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._moneyBoard:GetLocalPointInUiRootPanel())
  end
end

return MoneyCell
