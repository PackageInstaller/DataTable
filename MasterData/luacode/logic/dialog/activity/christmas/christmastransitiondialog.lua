local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local ChristmasTransitionDialog = class("ChristmasTransitionDialog", Dialog)
ChristmasTransitionDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasTransitionDialog.AssetName = "ActivityChristmasTransition"

function ChristmasTransitionDialog:Ctor(...)
  ChristmasTransitionDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ChristmasTransitionDialog:OnCreate()
  self:GetRootWindow():Subscribe_AnimationEvent("ActivityChristmasRurn", self.OnAnimationEvent, self)
end

function ChristmasTransitionDialog:OnAnimationEvent(floatValue, intValue, stringValue, obj, clipName)
  if stringValue == "turn" then
    local dialog
    if self._state == 1 then
      dialog = DialogManager.GetDialog("activity.christmas.christmasmain2dialog")
      if dialog then
        dialog:Destroy()
      end
      DialogManager.CreateSingletonDialog("activity.christmas.christmasmaindialog"):Init()
    elseif self._state == 2 then
      dialog = DialogManager.GetDialog("activity.christmas.christmasmaindialog")
      if dialog then
        dialog:Destroy()
      end
      DialogManager.CreateSingletonDialog("activity.christmas.christmasmain2dialog")
    end
  elseif stringValue == "End" then
    self:Destroy()
  end
end

function ChristmasTransitionDialog:SetState(state)
  self._state = state
end

function ChristmasTransitionDialog:OnDestroy()
end

return ChristmasTransitionDialog
