-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/charactertalentcanunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrEffectIDName = (BeanManager.GetTableByName)("role.cattreffectidname")
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CharacterTalentCanUnLockDialog = class("CharacterTalentCanUnLockDialog", Dialog)
CharacterTalentCanUnLockDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterTalentCanUnLockDialog.AssetName = "BaseCharacterInfoTalentDetail2"
CharacterTalentCanUnLockDialog.Type = {property = 1, skill = 2}
CharacterTalentCanUnLockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterTalentCanUnLockDialog
  ((CharacterTalentCanUnLockDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._receive = true
end

CharacterTalentCanUnLockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._closeBtn = self:GetChild("CloseButton")
  self._openBtn = self:GetChild("OpenButton")
  self._text = self:GetChild("Text1")
  self._apNum = self:GetChild("AP/Text")
  self._apIcon = self:GetChild("AP/Icon")
  self._apNumRed = self:GetChild("AP/TextRed")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._openBtn):Subscribe_PointerClickEvent(self.OnOpenBtnClicked, self)
end

CharacterTalentCanUnLockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

CharacterTalentCanUnLockDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CharacterTalentCanUnLockDialog, CAttrEffectIDName, CSkillShow_Soul
  local apNum = ((NekoData.BehaviorManager).BM_Currency):GetAP()
  self._receive = true
  if (data.record).costAP <= apNum then
    (self._apNumRed):SetActive(false)
    ;
    (self._apNum):SetActive(true)
    ;
    (self._apNum):SetText((data.record).costAP)
    ;
    (self._openBtn):SetInteractable(true)
  else
    ;
    (self._apNumRed):SetActive(true)
    ;
    (self._apNum):SetActive(false)
    ;
    (self._apNumRed):SetText((data.record).costAP)
    ;
    (self._openBtn):SetInteractable(false)
  end
  self._roleKey = data.roleKey
  self._pos = data.pos
  local str = ""
  if (data.record).type == (CharacterTalentCanUnLockDialog.Type).property then
    local r = CAttrEffectIDName:GetRecorder((data.record).parameter1)
    if r then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1079)).msgTextID)
      str = (TextManager.GetText)(r.classnameTextID) .. (string.gsub)(str, "%$parameter1%$", tostring((data.record).parameter2))
    else
      LogErrorFormat("CharacterTalentCanUnLockDialog", "wrong id %d for table cattreffectidname", (data.record).parameter1)
    end
  else
    do
      do
        if (data.record).type == (CharacterTalentCanUnLockDialog.Type).skill then
          local r = CSkillShow_Soul:GetRecorder((data.record).parameter2)
          if r then
            str = (TextManager.GetText)(r.exDiscribeTextID)
          else
            LogErrorFormat("CharacterTalentCanUnLockDialog", "wrong id %d for table cskillshow_soul", (data.record).parameter2)
          end
        end
        ;
        (self._text):SetText(str)
      end
    end
  end
end

CharacterTalentCanUnLockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

CharacterTalentCanUnLockDialog.OnOpenBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._receive then
    self._receive = false
    local csend = (LuaNetManager.CreateProtocol)("protocol.login.cunlocktalent")
    csend.roleId = self._roleKey
    csend.pos = self._pos
    csend:Send()
  end
end

return CharacterTalentCanUnLockDialog

