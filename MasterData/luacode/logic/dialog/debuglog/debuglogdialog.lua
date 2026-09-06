local DebugLogDialog = class("DebugLogDialog", Dialog)
DebugLogDialog.AssetBundleName = "ui/layouts"
DebugLogDialog.AssetName = "DebugLog"

function DebugLogDialog:Ctor(...)
  DebugLogDialog.super.Ctor(self, ...)
  self._groupName = "Message"
end

function DebugLogDialog:OnCreate()
  self._logText = self:GetChild("Text")
  self._message = ""
end

function DebugLogDialog:OnDestroy()
end

function DebugLogDialog:SetData(messsageStr)
  self._logText:SetText(messsageStr)
end

function DebugLogDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return DebugLogDialog
