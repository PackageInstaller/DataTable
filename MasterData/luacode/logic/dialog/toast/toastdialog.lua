local ToastDialog = class("ToastDialog", Dialog)
ToastDialog.AssetBundleName = "ui/layouts.toast"
ToastDialog.AssetName = "Toast"

function ToastDialog:Ctor(...)
  ToastDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ToastDialog:OnCreate()
  self._text = self:GetChild("Text")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function ToastDialog:OnDestroy()
end

function ToastDialog:Show(text)
  text = string.trim(text)
  self._text:SetText(text)
  local width, _ = self:GetRootWindow():GetDeltaSize()
  local w, h = self._text:GetPreferredSize()
  if width < w then
    w = width
    self:GetRootWindow():SetDeltaSize(w + 20, h + 10)
  else
    self:GetRootWindow():SetDeltaSize(w + 20, h + 10)
    local w, h = self._text:GetPreferredSize()
    self:GetRootWindow():SetDeltaSize(w + 20, h + 10)
  end
end

function ToastDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "ToastShow" then
    DialogManager.DestroySingletonDialog("toast.toastdialog")
  end
end

return ToastDialog
