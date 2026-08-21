-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/logincodedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local OfflineType = (LuaNetManager.GetBeanDef)("protocol.common.offlinetype")
local LoginCodeDialog = class("LoginCodeDialog", Dialog)
LoginCodeDialog.AssetBundleName = "ui/layouts.login"
LoginCodeDialog.AssetName = "LoginCode"
LoginCodeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginCodeDialog
  ((LoginCodeDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
end

LoginCodeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._code = self:GetChild("InputField")
  self._confirmBtn = self:GetChild("SubmitButton")
  self._changeBtn = self:GetChild("ChangeIdBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._changeBtn):Subscribe_PointerClickEvent(self.OnChangeBtnClicked, self)
end

LoginCodeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

LoginCodeDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local code = (self._code):GetText()
  local cactive = (LuaNetManager.CreateProtocol)("protocol.common.cactive")
  if cactive then
    cactive.code = code
    cactive:Send()
  end
end

LoginCodeDialog.OnChangeBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Login):ClientLogout()
end

return LoginCodeDialog

