local Skill = require("logic.manager.experimental.types.skill")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CharacterSkillChangeCell = class("CharacterSkillChangeCell", Dialog)
CharacterSkillChangeCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillChangeCell.AssetName = "BaseCharacterInfoSkillChangeCell"
CharacterSkillChangeCell.SkillType = {ContractSkill = 1, OrderSkill = 2}

function CharacterSkillChangeCell:Ctor(...)
  CharacterSkillChangeCell.super.Ctor(self, ...)
end

function CharacterSkillChangeCell:OnCreate()
  self._select = self:GetChild("Back/Select")
  self._skill = self:GetChild("Back/BackGround/Skill")
  self._current = self:GetChild("Back/Current")
  self._equipTxt = self:GetChild("Back/EquipTxt")
  self._lv = self:GetChild("Back/Level/Num")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function CharacterSkillChangeCell:OnDestroy()
end

function CharacterSkillChangeCell:RefreshCell(data)
  local skillId = data.skillLevel
  local cSkillTable = CSkillTable:GetRecorder(skillId)
  local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
  self._skill:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._delegate._selectSkill.onlyMark and self._delegate._selectSkill.onlyMark == data.onlyMark then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
  local equipRoleKey = 0
  local record = {}
  local skillItem
  if data.type == self.SkillType.ContractSkill then
    skillItem = Skill.Create(data.onlyMark)
    record = CSkillItemTable:GetRecorder(data.onlyMark)
    for _, r in ipairs(NekoData.BehaviorManager.BM_AllRoles:GetRoleList()) do
      if r:GetContractSkillItemId() == data.onlyMark then
        equipRoleKey = r:GetRoleId()
        break
      end
    end
  end
  for i, si in ipairs(record.skillID) do
    if si == data.skillLevel then
      self._lv:SetText(i)
    end
  end
  if equipRoleKey ~= 0 then
    if self._delegate._ownSkillMark and self._delegate._ownSkillMark == data.onlyMark then
      self._current:SetActive(true)
      self._equipTxt:SetActive(false)
    else
      self._current:SetActive(false)
      self._equipTxt:SetActive(true)
    end
  else
    self._current:SetActive(false)
    self._equipTxt:SetActive(false)
  end
  if self._delegate._selectSkill.onlyMark == data.onlyMark then
    self._select:SetActive(true)
  else
    self._select:SetActive(false)
  end
end

function CharacterSkillChangeCell:OnCellClicked()
  if self._delegate._selectSkill.onlyMark ~= self._cellData.onlyMark then
    self._delegate:SetSelect(self._cellData)
  end
end

function CharacterSkillChangeCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelected" then
    if arg.onlyMark == self._cellData.onlyMark then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  elseif eventName == "InfoChange" and arg.onlyMark == self._cellData.onlyMark then
    self:RefreshCell(arg)
  end
end

return CharacterSkillChangeCell
