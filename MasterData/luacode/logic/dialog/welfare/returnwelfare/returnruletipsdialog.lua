local ReturnRuleTipsDialog = class("ReturnRuleTipsDialog", Dialog)
ReturnRuleTipsDialog.AssetBundleName = "ui/layouts.welfare"
ReturnRuleTipsDialog.AssetName = "ReturnTips"
ReturnRuleTipsDialog.TipsType = {InvitePlayer = 1, GiftPack = 2}

function ReturnRuleTipsDialog:Ctor(...)
  ReturnRuleTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ReturnRuleTipsDialog:OnCreate()
  self._Text = self:GetChild("Back/Frame/Text")
  self._Title = self:GetChild("Back/Title")
  self._CloseBtn = self:GetChild("CloseBtn")
  self._CloseBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

function ReturnRuleTipsDialog:Init(type)
  if type == self.TipsType.InvitePlayer then
    self._Text:SetText(TextManager.GetText(701611))
  elseif type == self.TipsType.GiftPack then
    self._Text:SetText(TextManager.GetText(701610))
  end
  self._Title:SetText(TextManager.GetText(701612))
end

function ReturnRuleTipsDialog:OnDestroy()
end

function ReturnRuleTipsDialog:OnCloseBtnClicked()
  self:Destroy()
end

return ReturnRuleTipsDialog
