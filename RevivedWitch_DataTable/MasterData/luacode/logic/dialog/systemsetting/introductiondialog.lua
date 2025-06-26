-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/introductiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfigTable = (BeanManager.GetTableByName)("var.cvarconfig")
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).CharacterIntroduction)
local IntroductionDialog = class("IntroductionDialog", Dialog)
IntroductionDialog.AssetBundleName = "ui/layouts.setting"
IntroductionDialog.AssetName = "SettingIntroduction"
IntroductionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : IntroductionDialog
  ((IntroductionDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._curIntroduction = ""
  self._changeIntroduction = ""
end

IntroductionDialog.OnCreate = function(self)
  -- function num : 0_1
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._introduction = self:GetChild("Back/IntroductionInputField")
  self._text = self:GetChild("Back/Txtnew1")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._introduction):Subscribe_ValueChangedEvent(self.OnIntroductionUpdate, self)
  self:Init()
end

IntroductionDialog.OnDestroy = function(self)
  -- function num : 0_2
end

IntroductionDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, MaxWordCount
  self._curIntroduction = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).introduce
  ;
  (self._introduction):SetText(self._curIntroduction)
  self._changeIntroduction = self._curIntroduction
  local wordCount = (utf8.len)(self._curIntroduction)
  ;
  (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {wordCount, MaxWordCount}))
end

IntroductionDialog.OnIntroductionUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV, MaxWordCount
  self._changeIntroduction = (string.trim)((self._introduction):GetText())
  local wordCount = (utf8.len)(self._changeIntroduction)
  if MaxWordCount < wordCount then
    (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1570, {wordCount, MaxWordCount}))
  else
    ;
    (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {wordCount, MaxWordCount}))
  end
end

IntroductionDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

IntroductionDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, CVarConfigTable, MaxWordCount
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfigTable:GetRecorder(96)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100340)
    return 
  end
  local wordCount = (utf8.len)(self._changeIntroduction)
  if MaxWordCount < wordCount then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100034, {MaxWordCount})
  else
    if self._changeIntroduction ~= self._curIntroduction then
      local cchangeuserintroduce = (LuaNetManager.CreateProtocol)("protocol.user.cchangeuserintroduce")
      if cchangeuserintroduce then
        cchangeuserintroduce.introduce = self._changeIntroduction
        cchangeuserintroduce:Send()
      end
    else
      do
        self:Destroy()
      end
    end
  end
end

return IntroductionDialog

