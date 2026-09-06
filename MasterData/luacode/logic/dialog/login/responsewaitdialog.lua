local ResponseWaitDialog = class("ResponseWaitDialog", Dialog)
ResponseWaitDialog.AssetBundleName = "ui/layouts.loading"
ResponseWaitDialog.AssetName = "WaitResponse"

function ResponseWaitDialog:Ctor(...)
  ResponseWaitDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
end

function ResponseWaitDialog:OnCreate()
end

function ResponseWaitDialog:OnDestroy()
end

return ResponseWaitDialog
