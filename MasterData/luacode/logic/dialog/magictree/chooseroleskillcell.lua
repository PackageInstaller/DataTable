local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ChooseRoleSkillCell = class("ChooseRoleSkillCell", Dialog)
ChooseRoleSkillCell.AssetBundleName = "ui/layouts.yard"
ChooseRoleSkillCell.AssetName = "YardSendSkillCell"

function ChooseRoleSkillCell:Ctor(...)
  ChooseRoleSkillCell.super.Ctor(self, ...)
end

function ChooseRoleSkillCell:OnCreate()
  self._icon = self:GetChild("Back")
  self._name = self:GetChild("Title")
  self._txt = self:GetChild("Txt")
end

function ChooseRoleSkillCell:OnDestroy()
end

function ChooseRoleSkillCell:RefreshCell(data)
  self._name:SetText(data.name)
  self._txt:SetText(data.desc)
  local imgRecord = CImagePathTable:GetRecorder(data.image)
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

return ChooseRoleSkillCell
