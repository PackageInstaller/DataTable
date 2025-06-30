-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/charactertalentlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrEffectIDName = (BeanManager.GetTableByName)("role.cattreffectidname")
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CharacterTalentLockDialog = class("CharacterTalentLockDialog", Dialog)
CharacterTalentLockDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentLockDialog.AssetName = "BaseCharacterInfoTalentDetail3"
CharacterTalentLockDialog.Type = {property = 1, skill = 2}
CharacterTalentLockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTalentLockDialog
  ((CharacterTalentLockDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

CharacterTalentLockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._closeBtn = self:GetChild("CloseButton")
  self._openBtn = self:GetChild("OpenButton")
  self._text = self:GetChild("Text1")
  self._tips = self:GetChild("Tips")
  self._apNum = self:GetChild("AP/Text")
  self._apIcon = self:GetChild("AP/Icon")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

CharacterTalentLockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

CharacterTalentLockDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CharacterTalentLockDialog, CAttrEffectIDName, _ENV, CStringres, CSkillShow_Soul
  (self._openBtn):SetInteractable(false)
  ;
  (self._apNum):SetText((data.record).costAP)
  local str = ""
  if (data.record).type == (CharacterTalentLockDialog.Type).property then
    local r = CAttrEffectIDName:GetRecorder((data.record).parameter1)
    if r then
      str = (TextManager.GetText)((CStringres:GetRecorder(1079)).msgTextID)
      str = (TextManager.GetText)(r.classnameTextID) .. (string.gsub)(str, "%$parameter1%$", tostring((data.record).parameter2))
    else
      LogErrorFormat("CharacterTalentLockDialog", "wrong id %d for table cattreffectidname", (data.record).parameter1)
    end
  else
    do
      do
        if (data.record).type == (CharacterTalentLockDialog.Type).skill then
          local r = CSkillShow_Soul:GetRecorder((data.record).parameter2)
          if r then
            str = (TextManager.GetText)(r.exDiscribeTextID)
          else
            LogErrorFormat("CharacterTalentLockDialog", "wrong id %d for table cskillshow_soul", (data.record).parameter2)
          end
        end
        ;
        (self._text):SetText(str)
      end
    end
  end
end

CharacterTalentLockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

CharacterTalentLockDialog.OnOpenBtnClicked = function(self)
  -- function num : 0_5
end

return CharacterTalentLockDialog

