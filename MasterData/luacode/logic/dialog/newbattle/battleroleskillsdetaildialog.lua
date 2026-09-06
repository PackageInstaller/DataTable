local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Role = require("logic.manager.experimental.types.role")
local BattleRoleSkillsDetailDialog = class("BattleRoleSkillsDetailDialog", Dialog)
BattleRoleSkillsDetailDialog.AssetBundleName = "ui/layouts.battlenew"
BattleRoleSkillsDetailDialog.AssetName = "BattleSkillExplain"

function BattleRoleSkillsDetailDialog:Ctor(...)
  BattleRoleSkillsDetailDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
end

function BattleRoleSkillsDetailDialog:OnCreate()
  self._charIcon = self:GetChild("CharBack/Char")
  self._skills = {}
  for i = 1, 2 do
    self._skills[i] = {}
    self._skills[i].icon = self:GetChild("Frame/Skill" .. i .. "/SkillBack/Skill")
    self._skills[i].name = self:GetChild("Frame/Skill" .. i .. "/TitleBack/Num")
    self._skills[i].describe = self:GetChild("Frame/Skill" .. i .. "/Detail")
  end
  local dialog = DialogManager.GetDialog("newbattle.battlepausedialog")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
end

function BattleRoleSkillsDetailDialog:OnDestroy()
  local dialog = DialogManager.GetDialog("newbattle.battlepausedialog")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
end

function BattleRoleSkillsDetailDialog:SetData(data)
  local role = Role.Create(data:GetConfigId())
  local record = role:GetSkillHeadImageRecord()
  if record then
    self._charIcon:SetSprite(record.assetBundle, record.assetName)
  end
  for i, v in ipairs(data:GetSkillList()) do
    local skillRecord = CSkillTable:GetRecorder(v)
    local image = CImagePathTable:GetRecorder(skillRecord.icon) or DataCommon.DefaultImageAsset
    self._skills[i].icon:SetSprite(image.assetBundle, image.assetName)
    local skillShowRecord = CSkillShow_Role:GetRecorder(v)
    self._skills[i].name:SetText(TextManager.GetText(skillShowRecord.nameTextID))
    self._skills[i].describe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(v))
  end
end

function BattleRoleSkillsDetailDialog:OnBackClicked()
  self:Destroy()
end

return BattleRoleSkillsDetailDialog
