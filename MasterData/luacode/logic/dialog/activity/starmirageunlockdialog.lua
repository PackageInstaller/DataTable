local StarMirageUnlockDialog = class("StarMirageUnlockDialog", Dialog)
StarMirageUnlockDialog.AssetBundleName = "ui/layouts.activitystar"
StarMirageUnlockDialog.AssetName = "ActivityStarUnlock"

function StarMirageUnlockDialog:Ctor(...)
  StarMirageUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function StarMirageUnlockDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function StarMirageUnlockDialog:OnDestroy()
end

function StarMirageUnlockDialog:OnGoBtnClicked()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(1)
  self:Destroy()
end

function StarMirageUnlockDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.StarMirageUnlock)
  self:Destroy()
end

return StarMirageUnlockDialog
