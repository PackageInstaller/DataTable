local RestartDialog = class("RestartDialog", Dialog)
RestartDialog.AssetBundleName = "ui/layouts"
RestartDialog.AssetName = "RestartTips"

function RestartDialog:Ctor(...)
  RestartDialog.super.Ctor(self, ...)
  self._groupName = "ClickEffect"
end

function RestartDialog:OnCreate()
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function RestartDialog:OnDestroy()
end

function RestartDialog:OnConfirmBtnClicked()
  LogInfo("RestartDialog", "ApplicationQuit")
  CS.UnityEngine.Application.Quit()
end

function RestartDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_NotResponse
end

return RestartDialog
