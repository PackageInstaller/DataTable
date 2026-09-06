local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local LoverTransitionDialog = class("LoverTransitionDialog", Dialog)
LoverTransitionDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverTransitionDialog.AssetName = "ActivityValentinesTransition"

function LoverTransitionDialog:Ctor(...)
  LoverTransitionDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function LoverTransitionDialog:OnCreate()
  self:GetRootWindow():Subscribe_AnimationEvent("ActivityChristmasRurn", self.OnAnimationEvent, self)
  self._dialog = DialogManager.CreateSingletonDialog("activity.lover.lovermaindialog")
  self._dialog:GetRootWindow():SetActive(false)
end

function LoverTransitionDialog:OnAnimationEvent(floatValue, intValue, stringValue, obj, clipName)
  if stringValue == "turn" then
    DialogManager.DestroySingletonDialog("activity.loverunlockdialog")
    self._dialog:GetRootWindow():SetActive(true)
  elseif stringValue == "End" then
    self:Destroy()
  end
end

function LoverTransitionDialog:OnDestroy()
end

return LoverTransitionDialog
