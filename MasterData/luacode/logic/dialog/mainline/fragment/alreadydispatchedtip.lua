local AlreadyDispatchedTip = class("AlreadyDispatchedTip", Dialog)
AlreadyDispatchedTip.AssetBundleName = "ui/layouts.secondconfirm"
AlreadyDispatchedTip.AssetName = "SingleConfirmLarge"

function AlreadyDispatchedTip:Ctor(...)
  AlreadyDispatchedTip.super.Ctor(self, ...)
  self._groupName = "Message"
  self._strList = {}
end

function AlreadyDispatchedTip:OnCreate()
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function AlreadyDispatchedTip:OnDestroy()
end

function AlreadyDispatchedTip:SetText(str)
  self._text:SetText(str)
end

function AlreadyDispatchedTip:OnClickConfirmBtn()
  self:Destroy()
end

return AlreadyDispatchedTip
