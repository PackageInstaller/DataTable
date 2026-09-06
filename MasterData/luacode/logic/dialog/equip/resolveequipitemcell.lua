local ResolveEquipItemCell = class("ResolveEquipItemCell", Dialog)
ResolveEquipItemCell.AssetBundleName = "ui/layouts.equip"
ResolveEquipItemCell.AssetName = "EquipResolveItemCell"

function ResolveEquipItemCell:Ctor(...)
  ResolveEquipItemCell.super.Ctor(self, ...)
end

function ResolveEquipItemCell:OnCreate()
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._count = self:GetChild("_Count/Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ResolveEquipItemCell:OnDestroy()
end

function ResolveEquipItemCell:RefreshCell(data)
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetText(NumberManager.GetShowNumber(data:GetCount()))
end

function ResolveEquipItemCell:OnCellClicked()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return ResolveEquipItemCell
