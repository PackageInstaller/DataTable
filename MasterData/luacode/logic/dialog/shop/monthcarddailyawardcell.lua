local Item = require("logic.manager.experimental.types.item")
local MonthCardDailyAwardCell = class("MonthCardDailyAwardCell", Dialog)
MonthCardDailyAwardCell.AssetBundleName = "ui/layouts.baseshop"
MonthCardDailyAwardCell.AssetName = "MonthCardItemAccountCell"

function MonthCardDailyAwardCell:Ctor(...)
  MonthCardDailyAwardCell.super.Ctor(self, ...)
end

function MonthCardDailyAwardCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._name = self:GetChild("Text")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MonthCardDailyAwardCell:OnDestroy()
end

function MonthCardDailyAwardCell:RefreshCell(data)
  self._itemid = data.itemid
  local item = Item.Create(data.itemid)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.itemnum > 1 then
    self._count:SetActive(true)
    self._count:SetNumber(data.itemnum)
  else
    self._count:SetActive(false)
  end
  self._name:SetActive(true)
  self._name:SetText(item:GetName())
end

function MonthCardDailyAwardCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._itemid)
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return MonthCardDailyAwardCell
