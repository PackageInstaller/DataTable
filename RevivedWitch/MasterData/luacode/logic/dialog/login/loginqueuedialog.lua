-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/loginqueuedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginQueueDialog = class("LoginQueueDialog", Dialog)
LoginQueueDialog.AssetBundleName = "ui/layouts.login"
LoginQueueDialog.AssetName = "LoginLineUp"
LoginQueueDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginQueueDialog
  ((LoginQueueDialog.super).Ctor)(self, ...)
  self._groupName = "BrokenLine"
end

LoginQueueDialog.OnCreate = function(self)
  -- function num : 0_1
  self._ranking = self:GetChild("Num1")
  self._totalLength = self:GetChild("Num2")
  self._restTime = self:GetChild("Num3")
  self._cancleBtn = self:GetChild("CancelBtn")
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnCancleBtnClick, self)
end

LoginQueueDialog.OnDestroy = function(self)
  -- function num : 0_2
end

LoginQueueDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  if protocol.order ~= -1 then
    (self._ranking):SetText(protocol.order)
  else
    local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1220)).msgTextID)
    ;
    (self._ranking):SetText(str)
  end
  do
    ;
    (self._totalLength):SetText(protocol.queuelength)
    local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1221)).msgTextID)
    ;
    (self._restTime):SetText(protocol.minutes .. str)
  end
end

LoginQueueDialog.OnCancleBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Login):CancleLoginQueue()
  self:Destroy()
end

return LoginQueueDialog

