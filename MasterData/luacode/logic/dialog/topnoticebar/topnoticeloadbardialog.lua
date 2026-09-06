local LoadingTime = 1
local TopNoticeLoadBardialog = class("TopNoticeLoadBardialog", Dialog)
TopNoticeLoadBardialog.AssetBundleName = "ui/layouts.toast"
TopNoticeLoadBardialog.AssetName = "TopInformLoading"

function TopNoticeLoadBardialog:Ctor(...)
  TopNoticeLoadBardialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._msgNumStr = nil
  self._params = nil
  self._task = nil
end

function TopNoticeLoadBardialog:OnCreate()
  self._text = self:GetChild("Back/Text")
  self._text2 = self:GetChild("Back/Text2")
  self._loadingBar = self:GetChild("Back/Loading/Loading/BackGround/Progress")
  self._num = self:GetChild("Back/Loading/Num/Num")
  self._clear = self:GetChild("Back/Clear")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function TopNoticeLoadBardialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TopNoticeLoadBardialog:SetData(msgTitle, msgMain, msgNumStr, params, showClear)
  self._msgNumStr = msgNumStr
  self._params = params
  self._text:SetText(msgTitle)
  self._text2:SetText(msgMain)
  self._clear:SetActive(showClear)
  local str = self._msgNumStr
  str = string.gsub(str, "%$parameter1%$", self._params[1])
  str = string.gsub(str, "%$parameter2%$", self._params[3])
  self._num:SetText(str)
  self._task = Tween.new(LoadingTime, {
    num = tonumber(params[1])
  }, {
    num = tonumber(params[2])
  }, "linear")
end

function TopNoticeLoadBardialog:OnUpdate(notification)
  if self._task then
    if self._task:update(notification.userInfo.deltaTime) then
      local str = self._msgNumStr
      str = string.gsub(str, "%$parameter1%$", self._params[2])
      str = string.gsub(str, "%$parameter2%$", self._params[3])
      self._num:SetText(str)
      self._loadingBar:SetFillAmount(tonumber(self._params[2]) / tonumber(self._params[3]))
      self._task = nil
    else
      self._loadingBar:SetFillAmount(self._task.subject.num / tonumber(self._params[3]))
    end
  end
end

function TopNoticeLoadBardialog:OnAnimationEnd()
  self:Destroy()
end

function TopNoticeLoadBardialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return TopNoticeLoadBardialog
