-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/charactertalentunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrEffectIDName = (BeanManager.GetTableByName)("role.cattreffectidname")
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CharacterTalentUnLockDialog = class("CharacterTalentUnLockDialog", Dialog)
CharacterTalentUnLockDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentUnLockDialog.AssetName = "BaseCharacterInfoTalentDetail1"
CharacterTalentUnLockDialog.Type = {property = 1, skill = 2}
CharacterTalentUnLockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTalentUnLockDialog
  ((CharacterTalentUnLockDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

CharacterTalentUnLockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._closeBtn = self:GetChild("CloseButton")
  self._text = self:GetChild("Text1")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

CharacterTalentUnLockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

CharacterTalentUnLockDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CharacterTalentUnLockDialog, CAttrEffectIDName, _ENV, CStringres, CSkillShow_Soul
  local str = ""
  if (data.record).type == (CharacterTalentUnLockDialog.Type).property then
    local r = CAttrEffectIDName:GetRecorder((data.record).parameter1)
    if r then
      str = (TextManager.GetText)((CStringres:GetRecorder(1079)).msgTextID)
      str = (TextManager.GetText)(r.classnameTextID) .. (string.gsub)(str, "%$parameter1%$", tostring((data.record).parameter2))
    else
      LogErrorFormat("CharacterTalentUnLockDialog", "wrong id %d for table cattreffectidname", (data.record).parameter1)
    end
  else
    do
      do
        if (data.record).type == (CharacterTalentUnLockDialog.Type).skill then
          local r = CSkillShow_Soul:GetRecorder((data.record).parameter2)
          if r then
            str = (TextManager.GetText)(r.exDiscribeTextID)
          else
            LogErrorFormat("CharacterTalentUnLockDialog", "wrong id %d for table cskillshow_soul", (data.record).parameter2)
          end
        end
        ;
        (self._text):SetText(str)
      end
    end
  end
end

CharacterTalentUnLockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return CharacterTalentUnLockDialog

