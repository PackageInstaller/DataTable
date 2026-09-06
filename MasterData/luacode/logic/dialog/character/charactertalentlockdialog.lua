local CAttrEffectIDName = BeanManager.GetTableByName("role.cattreffectidname")
local CSkillShow_Soul = BeanManager.GetTableByName("skill.cskillshow_soul")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CharacterTalentLockDialog = class("CharacterTalentLockDialog", Dialog)
CharacterTalentLockDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentLockDialog.AssetName = "BaseCharacterInfoTalentDetail3"
CharacterTalentLockDialog.Type = {property = 1, skill = 2}

function CharacterTalentLockDialog:Ctor(...)
  CharacterTalentLockDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function CharacterTalentLockDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseButton")
  self._openBtn = self:GetChild("OpenButton")
  self._text = self:GetChild("Text1")
  self._tips = self:GetChild("Tips")
  self._apNum = self:GetChild("AP/Text")
  self._apIcon = self:GetChild("AP/Icon")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function CharacterTalentLockDialog:OnDestroy()
end

function CharacterTalentLockDialog:SetData(data)
  self._openBtn:SetInteractable(false)
  self._apNum:SetText(data.record.costAP)
  local str = ""
  if data.record.type == CharacterTalentLockDialog.Type.property then
    local r = CAttrEffectIDName:GetRecorder(data.record.parameter1)
    if r then
      str = TextManager.GetText(CStringres:GetRecorder(1079).msgTextID)
      str = TextManager.GetText(r.classnameTextID) .. string.gsub(str, "%$parameter1%$", tostring(data.record.parameter2))
    else
      LogErrorFormat("CharacterTalentLockDialog", "wrong id %d for table cattreffectidname", data.record.parameter1)
    end
  elseif data.record.type == CharacterTalentLockDialog.Type.skill then
    local r = CSkillShow_Soul:GetRecorder(data.record.parameter2)
    if r then
      str = TextManager.GetText(r.exDiscribeTextID)
    else
      LogErrorFormat("CharacterTalentLockDialog", "wrong id %d for table cskillshow_soul", data.record.parameter2)
    end
  end
  self._text:SetText(str)
end

function CharacterTalentLockDialog:OnBackBtnClicked()
  self:Destroy()
end

function CharacterTalentLockDialog:OnOpenBtnClicked()
end

return CharacterTalentLockDialog
