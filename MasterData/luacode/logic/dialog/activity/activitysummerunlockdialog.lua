local ActivitySummerUnlockDialog = class("ActivitySummerUnlockDialog", Dialog)
ActivitySummerUnlockDialog.AssetBundleName = "ui/layouts.activitysummer"
ActivitySummerUnlockDialog.AssetName = "ActivitySummerUnlock"

function ActivitySummerUnlockDialog:Ctor(...)
  ActivitySummerUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ActivitySummerUnlockDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ActivitySummerUnlockDialog:OnDestroy()
end

function ActivitySummerUnlockDialog:OnGoBtnClicked()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(21)
  self:Destroy()
end

function ActivitySummerUnlockDialog:OnBackBtnClicked()
  self:Destroy()
end

return ActivitySummerUnlockDialog
