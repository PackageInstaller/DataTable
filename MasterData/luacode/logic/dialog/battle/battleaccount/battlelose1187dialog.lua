local BattleLose1187Dialog = class("BattleLose1187Dialog", Dialog)
BattleLose1187Dialog.AssetBundleName = "ui/layouts.guide"
BattleLose1187Dialog.AssetName = "YuanNianGuide"

function BattleLose1187Dialog:Ctor(...)
  BattleLose1187Dialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function BattleLose1187Dialog:OnCreate()
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function BattleLose1187Dialog:OnDestroy()
end

function BattleLose1187Dialog:OnClickConfirmBtn()
  self:Destroy()
end

return BattleLose1187Dialog
