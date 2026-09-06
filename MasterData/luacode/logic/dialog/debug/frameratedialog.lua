local FrameRateDialog = class("FrameRateDialog", Dialog)
FrameRateDialog.AssetBundleName = "ui/layouts"
FrameRateDialog.AssetName = "FrameRate"

function FrameRateDialog:Ctor(...)
  FrameRateDialog.super.Ctor(self, ...)
  self._groupName = "ClickEffect"
end

function FrameRateDialog:OnCreate()
end

function FrameRateDialog:OnDestroy()
end

function FrameRateDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return FrameRateDialog
