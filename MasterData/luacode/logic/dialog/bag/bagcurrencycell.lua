local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local BagCurrencyCell = class("BagCurrencyCell", Dialog)
BagCurrencyCell.AssetBundleName = "ui/layouts.bag"
BagCurrencyCell.AssetName = "TopCurrencyCell"

function BagCurrencyCell:Ctor(...)
  BagCurrencyCell.super.Ctor(self, ...)
end

function BagCurrencyCell:OnCreate(root)
  self._btn = self:GetChild("Button")
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Text")
  self._addBtn = self:GetChild("Add")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClick, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddClicked, self)
end

function BagCurrencyCell:OnDestroy()
end

function BagCurrencyCell:RefreshCell(data)
  self._currencyId = data.CurrencyID
  local imageRecord = CImagePathTable:GetRecorder(data.CurrencyShowID) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._currencyId))
end

function BagCurrencyCell:OnAddClicked()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(self._currencyId)
end

function BagCurrencyCell:OnBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._currencyId)
    })
    local width, height = self._btn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._btn:GetLocalPointInUiRootPanel())
  end
end

return BagCurrencyCell
