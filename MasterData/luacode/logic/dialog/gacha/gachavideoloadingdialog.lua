local GachaVideoLoadingDialog = class("GachaVideoLoadingDialog", Dialog)
GachaVideoLoadingDialog.AssetBundleName = "ui/layouts.loading"
GachaVideoLoadingDialog.AssetName = "gacharesultskip"

function GachaVideoLoadingDialog:Ctor(...)
  GachaVideoLoadingDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
end

function GachaVideoLoadingDialog:OnCreate()
  self._skipBtn = self:GetChild("SkipBtn")
  self._skipBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local dialog = DialogManager.GetDialog("gacha.gachamoviedialog")
  if not dialog then
    self._skipBtn:SetActive(false)
  end
  LogInfoFormat("GachaVideoLoadingDialog", "=====OnCreate")
end

function GachaVideoLoadingDialog:OnDestroy()
  LogInfoFormat("GachaVideoLoadingDialog", "=====OnDestroy")
end

function GachaVideoLoadingDialog:OnBackBtnClicked()
  LogInfoFormat("GachaVideoLoadingDialog", "=====OnBackBtnClicked")
  local dialog = DialogManager.GetDialog("gacha.gachamoviedialog")
  if dialog then
    dialog:OnSkipButtonClick()
  end
  self:Destroy()
end

return GachaVideoLoadingDialog
