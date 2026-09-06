local GuideTipDialog = class("GuideTipDialog", Dialog)

function GuideTipDialog:Ctor()
end

function GuideTipDialog:OnCreate()
  self._text = self:GetChild("")
end

function GuideTipDialog:SetTip(id)
  local word = TextManager.GetText(id)
end

return GuideTipDialog
