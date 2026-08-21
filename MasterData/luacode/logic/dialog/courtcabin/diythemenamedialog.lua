-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/diythemenamedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).DIYThemeName)
local DiyThemeNameDialog = class("DiyThemeNameDialog", Dialog)
DiyThemeNameDialog.AssetBundleName = "ui/layouts.yard"
DiyThemeNameDialog.AssetName = "HouseAddTheme"
DiyThemeNameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DiyThemeNameDialog
  ((DiyThemeNameDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

DiyThemeNameDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MinWordCount, MaxWordCount
  self._addThemeTxt = self:GetChild("Back/Title")
  self._changeThemeTxt = self:GetChild("Back/Title2")
  self._name = self:GetChild("Back/InputField")
  self._inputTextNum = self:GetChild("Back/Textnew1")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self:GetChild("Back/Txt1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1573, {MinWordCount, MaxWordCount}))
  ;
  (self._name):Subscribe_ValueChangedEvent(self.OnNameUpdate, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self:Init()
end

DiyThemeNameDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DiyThemeNameDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._name):SetText(((NekoData.BehaviorManager).BM_Cabin):GetName())
  self:OnNameUpdate()
end

DiyThemeNameDialog.SetFunctionTag = function(self, tag)
  -- function num : 0_4
  self._tag = tag
  if self._tag == "Change" then
    (self._addThemeTxt):SetActive(false)
    ;
    (self._changeThemeTxt):SetActive(true)
  else
    if self._tag == "Add" then
      (self._addThemeTxt):SetActive(true)
      ;
      (self._changeThemeTxt):SetActive(false)
    end
  end
end

DiyThemeNameDialog.OnNameUpdate = function(self)
  -- function num : 0_5 , upvalues : _ENV, MaxWordCount
  local name = (self._name):GetText()
  name = (string.trim)(name)
  self._changeName = name
  local count = (utf8.len)(name)
  if MaxWordCount < count then
    (self._inputTextNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1570, {count, MaxWordCount}))
  else
    ;
    (self._inputTextNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {count, MaxWordCount}))
  end
end

DiyThemeNameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

DiyThemeNameDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_7
  if (self._tag ~= "Change" or self._tag == "Add") then
  end
end

return DiyThemeNameDialog

