local Item = require("logic.manager.experimental.types.item")
local ShopCurrencyCell = class("ShopCurrencyCell", Dialog)
ShopCurrencyCell.AssetBundleName = "ui/layouts.baseshop"
ShopCurrencyCell.AssetName = "ShopTopGroupCell"

function ShopCurrencyCell:Ctor(...)
  ShopCurrencyCell.super.Ctor(self, ...)
end

function ShopCurrencyCell:OnCreate()
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._addBtn1 = self:GetChild("Num0/Add (1)")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  self._cell:Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  self._addBtn1:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
end

function ShopCurrencyCell:OnDestroy()
end

function ShopCurrencyCell:RefreshCell(data)
  local haveAddWays = NekoData.BehaviorManager.BM_Currency:HaveAddWays(data)
  self._addBtn:SetActive(haveAddWays)
  self._addBtn1:SetActive(haveAddWays)
  self._item = Item.Create(data)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data)
  if data == DataCommon.SpiritID then
    local limitNum = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
    self._text:SetText(NumberManager.GetShowNumber(currencyNum) .. "/" .. NumberManager.GetShowNumber(limitNum))
  else
    self._text:SetText(NumberManager.GetShowNumber(currencyNum))
  end
end

function ShopCurrencyCell:OnCellClick()
  local width, height = self._cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._cell:GetLocalPointInUiRootPanel())
  end
end

function ShopCurrencyCell:OnAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:AddCurrencyById(self._cellData)
end

return ShopCurrencyCell
