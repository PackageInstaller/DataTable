-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/changenamedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).CharacterName)
local ChangeNameDialog = class("ChangeNameDialog", Dialog)
ChangeNameDialog.AssetBundleName = "ui/layouts.setting"
ChangeNameDialog.AssetName = "SettingChangeName"
ChangeNameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChangeNameDialog
  ((ChangeNameDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ChangeNameDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MinWordCount, MaxWordCount
  self._username = self:GetChild("InputField")
  ;
  (self:GetChild("Back2/Textnew1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1566, {MinWordCount, MaxWordCount}))
  self._cancle = self:GetChild("Cancel")
  self._confirm = self:GetChild("Confirm")
  ;
  (self._cancle):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirm):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (self._username):SetText(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username))
end

ChangeNameDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ChangeNameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

ChangeNameDialog.OnConfirmClick = function(self, args)
  -- function num : 0_4 , upvalues : _ENV, CVarConfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfig:GetRecorder(91)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100335)
    return 
  end
  local ccreateUser = (LuaNetManager.CreateProtocol)("protocol.user.cchangeusername")
  if ccreateUser then
    ccreateUser.name = (self._username):GetText()
    ccreateUser:Send()
  end
end

return ChangeNameDialog

