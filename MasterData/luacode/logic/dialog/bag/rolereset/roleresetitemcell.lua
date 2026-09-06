local RoleResetItemCell = class("RoleResetItemCell", Dialog)
RoleResetItemCell.AssetBundleName = "ui/layouts.bag"
RoleResetItemCell.AssetName = "RoleRestartItemCell"

function RoleResetItemCell:Ctor(...)
  RoleResetItemCell.super.Ctor(self, ...)
end

function RoleResetItemCell:OnCreate()
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._select = self:GetChild("_BackGround/Select")
  self._count = self:GetChild("_Count")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RoleResetItemCell:OnDestroy()
end

function RoleResetItemCell:RefreshCell(data)
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data:GetCount())
end

function RoleResetItemCell:OnCellClicked()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RoleResetItemCell
