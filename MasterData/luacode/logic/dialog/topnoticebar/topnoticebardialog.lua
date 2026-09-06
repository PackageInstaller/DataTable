local TopNoticeBarDialog = class("TopNoticeBarDialog", Dialog)
TopNoticeBarDialog.AssetBundleName = "ui/layouts.toast"
TopNoticeBarDialog.AssetName = "TopInform"

function TopNoticeBarDialog:Ctor(...)
  TopNoticeBarDialog.super.Ctor(self, ...)
  self._groupName = "Message"
end

function TopNoticeBarDialog:OnCreate()
  self._text = self:GetChild("Back/Text")
  self._text2 = self:GetChild("Back/Text2")
  self._clear = self:GetChild("Clear")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
end

function TopNoticeBarDialog:OnDestroy()
end

function TopNoticeBarDialog:SetData(msgTitle, msgMain, showClear)
  self._text:SetText(msgTitle)
  self._text2:SetText(msgMain)
  self._clear:SetActive(showClear)
end

function TopNoticeBarDialog:OnAnimationEnd()
  self:Destroy()
end

function TopNoticeBarDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return TopNoticeBarDialog
