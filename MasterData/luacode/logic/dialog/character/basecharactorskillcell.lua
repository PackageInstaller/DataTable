local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BaseCharactorSkillCell = class("BaseCharactorSkillCell", Dialog)
BaseCharactorSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharactorSkillCell.AssetName = "BaseCharactorSkillCell"

function BaseCharactorSkillCell:Ctor(...)
  BaseCharactorSkillCell.super.Ctor(self, ...)
end

function BaseCharactorSkillCell:OnCreate()
  self._icon = self:GetChild("SkillCell/_BackGround/Icon")
  self._frame = self:GetChild("SkillCell/_BackGround/Frame")
  self._select = self:GetChild("SkillCell/_BackGround/Select")
  self._frame:Subscribe_PointerClickEvent(self.OnCellPointerClick, self)
  self:GetRootWindow():SetUserData(self)
  self._select:SetActive(false)
end

function BaseCharactorSkillCell:OnDestroy()
end

function BaseCharactorSkillCell:RefreshCell(data)
  local skillRecord = CSkillTable:GetRecorder(data)
  local iconImageRecord = CImagePathTable:GetRecorder(skillRecord.icon) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(iconImageRecord.assetBundle, iconImageRecord.assetName)
end

function BaseCharactorSkillCell:OnCellPointerClick()
  self._select:SetActive(true)
  self._delegate:SetSelectedID(self:GetRootWindow():GetUserData())
end

function BaseCharactorSkillCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == arg)
  end
end

return BaseCharactorSkillCell
