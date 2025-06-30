-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/topnoticebar/topnoticeloadbardialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoadingTime = 1
local TopNoticeLoadBardialog = class("TopNoticeLoadBardialog", Dialog)
TopNoticeLoadBardialog.AssetBundleName = "ui/layouts.toast"
TopNoticeLoadBardialog.AssetName = "TopInformLoading"
TopNoticeLoadBardialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TopNoticeLoadBardialog
  ((TopNoticeLoadBardialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._msgNumStr = nil
  self._params = nil
  self._task = nil
end

TopNoticeLoadBardialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._text = self:GetChild("Back/Text")
  self._text2 = self:GetChild("Back/Text2")
  self._loadingBar = self:GetChild("Back/Loading/Loading/BackGround/Progress")
  self._num = self:GetChild("Back/Loading/Num/Num")
  self._clear = self:GetChild("Back/Clear")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

TopNoticeLoadBardialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TopNoticeLoadBardialog.SetData = function(self, msgTitle, msgMain, msgNumStr, params, showClear)
  -- function num : 0_3 , upvalues : _ENV, LoadingTime
  self._msgNumStr = msgNumStr
  self._params = params
  ;
  (self._text):SetText(msgTitle)
  ;
  (self._text2):SetText(msgMain)
  ;
  (self._clear):SetActive(showClear)
  local str = self._msgNumStr
  str = (string.gsub)(str, "%$parameter1%$", (self._params)[1])
  str = (string.gsub)(str, "%$parameter2%$", (self._params)[3])
  ;
  (self._num):SetText(str)
  self._task = (Tween.new)(LoadingTime, {num = tonumber(params[1])}, {num = tonumber(params[2])}, "linear")
end

TopNoticeLoadBardialog.OnUpdate = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  if self._task then
    if (self._task):update((notification.userInfo).deltaTime) then
      local str = self._msgNumStr
      str = (string.gsub)(str, "%$parameter1%$", (self._params)[2])
      str = (string.gsub)(str, "%$parameter2%$", (self._params)[3])
      ;
      (self._num):SetText(str)
      ;
      (self._loadingBar):SetFillAmount(tonumber((self._params)[2]) / tonumber((self._params)[3]))
      self._task = nil
    else
      do
        ;
        (self._loadingBar):SetFillAmount(((self._task).subject).num / tonumber((self._params)[3]))
      end
    end
  end
end

TopNoticeLoadBardialog.OnAnimationEnd = function(self)
  -- function num : 0_5
  self:Destroy()
end

TopNoticeLoadBardialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return TopNoticeLoadBardialog

