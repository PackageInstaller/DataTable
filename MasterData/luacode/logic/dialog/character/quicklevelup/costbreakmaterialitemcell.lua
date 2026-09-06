local CostBreakMaterialItemCell = class("CostBreakMaterialItemCell", Dialog)
CostBreakMaterialItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CostBreakMaterialItemCell.AssetName = "CharFastlUpListCell"

function CostBreakMaterialItemCell:Ctor(...)
  CostBreakMaterialItemCell.super.Ctor(self, ...)
end

function CostBreakMaterialItemCell:OnCreate()
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._num = self:GetChild("_Count/Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function CostBreakMaterialItemCell:OnDestroy()
end

function CostBreakMaterialItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(NumberManager.GetShowNumber(data.num))
end

function CostBreakMaterialItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  local width, height = self:GetRootWindow():GetRectSize()
  if tipsDialog then
    tipsDialog:Init(self._cellData)
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return CostBreakMaterialItemCell
