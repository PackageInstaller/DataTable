local ChristmasUnlockDialog = class("ChristmasUnlockDialog", Dialog)
ChristmasUnlockDialog.AssetBundleName = "ui/layouts.activityhud"
ChristmasUnlockDialog.AssetName = "ActivityStart"

function ChristmasUnlockDialog:Ctor(...)
  ChristmasUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ChristmasUnlockDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GoBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ChristmasUnlockDialog:OnDestroy()
end

function ChristmasUnlockDialog:OnGoBtnClicked()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(48)
  self:Destroy()
end

function ChristmasUnlockDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChristmasUnlockDialog
