local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillItem = BeanManager.GetTableByName("item.cskillitem")
local RoleConfig = BeanManager.GetTableByName("role.roleconfig")
local CIconTypeCfg = BeanManager.GetTableByName("skill.cicontypecfg")
local BattleLockSkillSmallCell = class("BattleLockSkillSmallCell", Dialog)
BattleLockSkillSmallCell.AssetBundleName = "ui/layouts.battlenew"
BattleLockSkillSmallCell.AssetName = "BattleCharSkillCellSmall"

function BattleLockSkillSmallCell:Ctor(...)
  BattleLockSkillSmallCell.super.Ctor(self, ...)
end

function BattleLockSkillSmallCell:OnCreate()
  self._back = self:GetChild("SkillBack1/Back")
  self._frame = self:GetChild("SkillBack1/Frame")
  self._skill = self:GetChild("SkillBack1/Frame/Skill1")
  self._yellow = self:GetChild("SkillBack1/Frame/YellowBack")
  self._yellowNum = self:GetChild("SkillBack1/Frame/YellowBack/Num")
  self._blue = self:GetChild("SkillBack1/Frame/BlueBack")
  self._blueNum = self:GetChild("SkillBack1/Frame/BlueBack/Num")
  self._useEffect = self:GetChild("SkillBack1/Frame/EffectUse")
  self._activeEffect = self:GetChild("SkillBack1/Frame/EffectActive")
  self._effect = self:GetChild("SkillBack1/Frame/Effect")
  self._autoEffect = self:GetChild("SkillBack1/Frame/EffectAuto")
  self._grey = self:GetChild("SkillBack1/Frame/Grey")
  self._guideEffect = self:GetChild("Effect")
  self._countTimeTxt = self:GetChild("SkillBack1/Frame/Time")
  self._skillTypeImg = self:GetChild("SkillBack1/Frame/SkillType")
  self._energySkillTag = self:GetChild("SkillBack1/Frame/EnergySkill")
  self._skillMarkPanel = self:GetChild("SkillBack1/Frame/SkillMarkFrame")
  self._lockTag = self:GetChild("SkillBack1/Frame/Lock")
  self._lockTag:SetActive(true)
  self._yellow:SetActive(false)
  self._yellowNum:SetActive(false)
  self._blue:SetActive(false)
  self._blueNum:SetActive(false)
  self._useEffect:SetActive(false)
  self._activeEffect:SetActive(false)
  self._effect:SetActive(false)
  self._autoEffect:SetActive(false)
  self._guideEffect:SetActive(false)
  self._countTimeTxt:SetActive(false)
  self._skillTypeImg:SetActive(false)
  self._energySkillTag:SetActive(false)
end

function BattleLockSkillSmallCell:OnDestroy()
end

function BattleLockSkillSmallCell:RefreshCell(data)
  if self._delegate._cellData:IsAlive() then
    self._frame:SetActive(true)
  else
    self._frame:SetActive(false)
  end
  local skillRecord = CSkillTable:GetRecorder(data)
  local image = CImagePathTable:GetRecorder(skillRecord.icon) or DataCommon.DefaultImageAsset
  self._skill:SetSprite(image.assetBundle, image.assetName)
end

function BattleLockSkillSmallCell:OnEvent(eventName, arg)
  if eventName == "ShowSkillCardBack" and arg == self._delegate._cellData:GetEntityId() then
    self._frame:SetActive(false)
  elseif eventName == "ShowSkillCardFrame" and arg == self._delegate._cellData:GetEntityId() then
    self._frame:SetActive(true)
  end
end

return BattleLockSkillSmallCell
