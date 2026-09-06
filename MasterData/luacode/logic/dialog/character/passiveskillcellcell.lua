local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSKIllTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local PassiveSkillCellCell = class("PassiveSkillCellCell", Dialog)
PassiveSkillCellCell.AssetBundleName = "ui/layouts.basecharacterinfo"
PassiveSkillCellCell.AssetName = "BaseCharacterInfoSkillNewCell1"

function PassiveSkillCellCell:Ctor(...)
  PassiveSkillCellCell.super.Ctor(self, ...)
end

function PassiveSkillCellCell:OnCreate()
  self._grey = self:GetChild("Grey")
  self._grey:SetActive(false)
  self._skill = self:GetChild("SkillBack/Skill")
  self._skillName = self:GetChild("SkillName")
  self._skillDescribe = self:GetChild("SkillDescribe")
  self._lock = self:GetChild("Lock")
  self._unlockCondition = self:GetChild("Lock/Txt")
end

function PassiveSkillCellCell:OnDestroy()
end

local function SetCondition(self, total, index)
  if total == 1 and index == 1 or total == 2 and index == 2 or total == 3 and index == 3 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1075).msgTextID)
    self._unlockCondition:SetText(str)
  elseif total == 2 and index == 1 or total == 3 and index == 2 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1073).msgTextID)
    self._unlockCondition:SetText(str)
  elseif total == 3 and index == 1 then
    local str = TextManager.GetText(CStringRes:GetRecorder(1072).msgTextID)
    self._unlockCondition:SetText(str)
  end
end

function PassiveSkillCellCell:RefreshCell(data)
  if data.unlock then
    self._lock:SetActive(false)
  else
    self._lock:SetActive(true)
    SetCondition(self, data.count, data.index)
  end
  local cSkillTable = CSKIllTable:GetRecorder(data.id)
  local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
  self._skill:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
  self._skillName:SetText(tostring(TextManager.GetText(show.nameTextID)))
  self._skillDescribe:SetText(NekoData.BehaviorManager.BM_Message:GetRoleSkillDescribe(cSkillTable.id))
end

function PassiveSkillCellCell:OnCellClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("character.characterskilltipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData.id)
    self._Anchoredx, self._Anchoredy = self._delegate:GetRootWindow():GetAnchoredPosition()
    tipsDialog:GetRootWindow():SetAnchoredPosition(self._Anchoredx, self._Anchoredy)
  end
end

return PassiveSkillCellCell
