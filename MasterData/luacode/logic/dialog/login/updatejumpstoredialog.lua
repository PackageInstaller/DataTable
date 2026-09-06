local UpdateJumpStoreDialog = class("UpdateJumpStoreDialog", Dialog)
UpdateJumpStoreDialog.AssetBundleName = "ui/layouts.secondconfirm"
UpdateJumpStoreDialog.AssetName = "SecondConfirmHighLevel"

function UpdateJumpStoreDialog:Ctor(...)
  UpdateJumpStoreDialog.super.Ctor(self, ...)
  self._groupName = "ClickEffect"
end

function UpdateJumpStoreDialog:OnCreate()
  self:GetChild("Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1637))
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancleBtn = self:GetChild("CancelButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnCancleBtnClicked, self)
end

function UpdateJumpStoreDialog:OnDestroy()
end

function UpdateJumpStoreDialog:OnConfirmBtnClicked()
  NekoData.BehaviorManager.BM_Game:JumpToTheStore(2)
end

function UpdateJumpStoreDialog:OnCancleBtnClicked()
  self:Destroy()
end

return UpdateJumpStoreDialog
