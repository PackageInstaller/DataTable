-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/changediythemenamedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).DIYThemeName)
local ChangeDiyThemeNameDialog = class("ChangeDiyThemeNameDialog", Dialog)
ChangeDiyThemeNameDialog.AssetBundleName = "ui/layouts.yard"
ChangeDiyThemeNameDialog.AssetName = "HouseAddTheme"
ChangeDiyThemeNameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChangeDiyThemeNameDialog
  ((ChangeDiyThemeNameDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ChangeDiyThemeNameDialog.OnCreate = function(self)
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
  ;
  (self._addThemeTxt):SetActive(false)
  ;
  (self._changeThemeTxt):SetActive(true)
  self:OnNameUpdate()
end

ChangeDiyThemeNameDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ChangeDiyThemeNameDialog.Init = function(self, themeInfo)
  -- function num : 0_3
  self._themeKey = themeInfo.key
  ;
  (self._name):SetText(themeInfo.name)
end

ChangeDiyThemeNameDialog.OnNameUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV, MaxWordCount
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

ChangeDiyThemeNameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

ChangeDiyThemeNameDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local cchangeThemeName = (LuaNetManager.CreateProtocol)("protocol.yard.cchangethemename")
  cchangeThemeName.key = self._themeKey
  cchangeThemeName.name = self._changeName
  cchangeThemeName:Send()
end

return ChangeDiyThemeNameDialog

