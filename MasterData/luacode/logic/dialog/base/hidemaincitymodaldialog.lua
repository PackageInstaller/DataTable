local HideMainCityModalDialog = class("HideMainCityModalDialog", Dialog)
HideMainCityModalDialog.AssetBundleName = "ui/layouts.basemainhud"
HideMainCityModalDialog.AssetName = "HideMainCityModel"

function HideMainCityModalDialog:Ctor(...)
  HideMainCityModalDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function HideMainCityModalDialog:OnCreate()
end

function HideMainCityModalDialog:OnDestroy()
end

function HideMainCityModalDialog:OnBackBtnClicked()
  if not DialogManager.GetDialog("newbattle.battlenewmaindialog") then
    return DataCommon.BackPressed_NotResponse
  else
    return DataCommon.BackPressed_SkipResponse
  end
end

return HideMainCityModalDialog
