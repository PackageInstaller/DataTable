local CAttrEffectIDName = BeanManager.GetTableByName("role.cattreffectidname")
local CSkillShow_Soul = BeanManager.GetTableByName("skill.cskillshow_soul")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CharacterTalentUnLockDialog = class("CharacterTalentUnLockDialog", Dialog)
CharacterTalentUnLockDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentUnLockDialog.AssetName = "BaseCharacterInfoTalentDetail1"
CharacterTalentUnLockDialog.Type = {property = 1, skill = 2}

function CharacterTalentUnLockDialog:Ctor(...)
  CharacterTalentUnLockDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function CharacterTalentUnLockDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseButton")
  self._text = self:GetChild("Text1")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function CharacterTalentUnLockDialog:OnDestroy()
end

function CharacterTalentUnLockDialog:SetData(data)
  local str = ""
  if data.record.type == CharacterTalentUnLockDialog.Type.property then
    local r = CAttrEffectIDName:GetRecorder(data.record.parameter1)
    if r then
      str = TextManager.GetText(CStringres:GetRecorder(1079).msgTextID)
      str = TextManager.GetText(r.classnameTextID) .. string.gsub(str, "%$parameter1%$", tostring(data.record.parameter2))
    else
      LogErrorFormat("CharacterTalentUnLockDialog", "wrong id %d for table cattreffectidname", data.record.parameter1)
    end
  elseif data.record.type == CharacterTalentUnLockDialog.Type.skill then
    local r = CSkillShow_Soul:GetRecorder(data.record.parameter2)
    if r then
      str = TextManager.GetText(r.exDiscribeTextID)
    else
      LogErrorFormat("CharacterTalentUnLockDialog", "wrong id %d for table cskillshow_soul", data.record.parameter2)
    end
  end
  self._text:SetText(str)
end

function CharacterTalentUnLockDialog:OnBackBtnClicked()
  self:Destroy()
end

return CharacterTalentUnLockDialog
