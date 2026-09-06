local AnniversaryUnlockDialog = class("AnniversaryUnlockDialog", Dialog)
AnniversaryUnlockDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
AnniversaryUnlockDialog.AssetName = "Activity1YearAnniversaryUnlock"

function AnniversaryUnlockDialog:Ctor(...)
  AnniversaryUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function AnniversaryUnlockDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GetBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function AnniversaryUnlockDialog:OnDestroy()
end

function AnniversaryUnlockDialog:OnGoBtnClicked()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(125)
  self:Destroy()
end

function AnniversaryUnlockDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.Anniversary)
  self:Destroy()
end

return AnniversaryUnlockDialog
