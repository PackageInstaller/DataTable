local MailRoleOptionalCell = class("MailRoleOptionalCell", Dialog)
MailRoleOptionalCell.AssetBundleName = "ui/layouts.mail"
MailRoleOptionalCell.AssetName = "MailRoleOptionalCell"

function MailRoleOptionalCell:Ctor(...)
  MailRoleOptionalCell.super.Ctor(self, ...)
end

function MailRoleOptionalCell:OnCreate()
  self._frame = self:GetChild("Cell/Frame")
  self._photo = self:GetChild("Cell/Photo")
  self._element = self:GetChild("Cell/Element")
  self._job = self:GetChild("Cell/Job")
  self._name = self:GetChild("Name")
  self._checkBorder = self:GetChild("Cell/Check")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnClick, self)
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnLongPress, self)
end

function MailRoleOptionalCell:OnDestroy()
end

function MailRoleOptionalCell:RefreshCell(data)
  self._role = data.role
  self._index = data.index
  local image = self._role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  image = self._role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(self._role:GetRoleName())
  self._checkBorder:SetActive(self._delegate._selectIndex == self._index)
end

function MailRoleOptionalCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelected" then
    self._checkBorder:SetActive(arg == self._index)
  end
end

function MailRoleOptionalCell:OnClick()
  self._delegate:OnCellClick(self._index)
end

function MailRoleOptionalCell:OnLongPress()
  self._delegate:OnCellLongPress(self._index)
end

return MailRoleOptionalCell
