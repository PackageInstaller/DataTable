local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local ReawrdCell = class("ReawrdCell", Dialog)
ReawrdCell.AssetBundleName = "ui/layouts.activityspringouting"
ReawrdCell.AssetName = "ActivitySpringOutingCellItem"

function ReawrdCell:Ctor(...)
  ReawrdCell.super.Ctor(self, ...)
  self._item = nil
end

function ReawrdCell:OnCreate()
  self._haveGetText = self:GetChild("Panel/GetBack/Text")
  self._haveGetBack = self:GetChild("Panel/GetBack")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemNum = self:GetChild("Panel/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:SetStaticRes()
end

function ReawrdCell:SetStaticRes()
  self._haveGetText:SetText(TextManager.GetText(CStringRes:GetRecorder(1820).msgTextID))
end

function ReawrdCell:OnDestroy()
end

function ReawrdCell:RefreshCell(data)
  self._data = data
  self._item = Item.Create(self._data.itemId)
  self._itemNum:SetText(NumberManager.GetShowNumber(self._data.itemNum))
  local imageRecord = self._item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._haveGetBack:SetActive(self._data.isGet)
end

function ReawrdCell:OnCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

return ReawrdCell
