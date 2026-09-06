local WorldInfoTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local Item = require("logic.manager.experimental.types.item")
local OfflinePvpAccountCell = class("OfflinePvpAccountCell", Dialog)
OfflinePvpAccountCell.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpAccountCell.AssetName = "OffLinePVPAccountCell"

function OfflinePvpAccountCell:Ctor(...)
  OfflinePvpAccountCell.super.Ctor(self, ...)
end

function OfflinePvpAccountCell:OnCreate()
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemSelect = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._itemSelect:SetActive(false)
end

function OfflinePvpAccountCell:OnDestroy()
end

function OfflinePvpAccountCell:RefreshCell(data)
  local item = Item.Create(data.itemId)
  local imageRecord = item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCount:SetText(NumberManager.GetShowNumber(data.count))
end

function OfflinePvpAccountCell:OnCellClicked()
end

return OfflinePvpAccountCell
