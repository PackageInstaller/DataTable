local Skill = require("logic.manager.experimental.types.skill")
local SkillCell = class("SkillCell", Dialog)
SkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillCell.AssetName = "SkillCell"

function SkillCell:Ctor(...)
  SkillCell.super.Ctor(self, ...)
end

function SkillCell:OnCreate()
  self._normalFrame = self:GetChild("BackNormal")
  self._lvMaxFrame = self:GetChild("BackFull")
  self._icon = self:GetChild("Skill")
  self._lvPanel = self:GetChild("NumBack")
  self._lvPanel_txt = self:GetChild("NumBack/Num")
  self._lock = self:GetChild("Lock")
  self._chargingPanel = self:GetChild("Energy")
  self._select = self:GetChild("Select")
  self._grey = self:GetChild("Grey")
  self._skillElement = self:GetChild("Skill/Element")
  self._skillElement:SetActive(false)
end

function SkillCell:OnDestroy()
end

function SkillCell:Init(skill, unlock, delegate)
  local lv = skill:GetSkillLevel()
  local maxLv = skill:GetSkillMaxLevel()
  if lv < maxLv or skill:GetType() == Skill.Type.Attribute then
    self._normalFrame:SetActive(true)
    self._lvMaxFrame:SetActive(false)
  else
    self._normalFrame:SetActive(false)
    self._lvMaxFrame:SetActive(true)
  end
  local imgRecord = skill:GetSkillIcon()
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if skill:GetType() == Skill.Type.Attribute then
    self._lvPanel:SetActive(false)
  elseif not self._hideLv then
    self._lvPanel:SetActive(true)
    self._lvPanel_txt:SetText(lv)
  end
  if not self._hideLock then
    self._lock:SetActive(not unlock)
  end
  self._chargingPanel:SetActive(skill:GetType() == Skill.Type.Charging)
  if self._fromCharacterSkillRowCell then
    self._grey:SetActive(not unlock)
  end
end

function SkillCell:HideFromCharacterSkillDialog()
  self._hideLv = true
  self._hideLock = true
  self._lvPanel:SetActive(false)
  self._lock:SetActive(false)
end

function SkillCell:HideFromCharacterSkillRowCell()
  self._hideLock = true
  self._lock:SetActive(false)
  self._fromCharacterSkillRowCell = true
end

return SkillCell
