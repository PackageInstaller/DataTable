local GuildTips = class("GuildTips", Dialog)
GuildTips.AssetBundleName = "ui/layouts.guild"
GuildTips.AssetName = "GuildTips"

function GuildTips:Ctor(...)
  GuildTips.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function GuildTips:OnCreate()
  self._textRuler = self:GetChild("Back/Frame/Text")
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width, self._height = self._textRuler:GetRectSize()
  local _ = 0
  _, self._oneline = self._textRuler:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._textRuler:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._textRuler:GetPosition()
  self:Init()
end

function GuildTips:OnDestroy()
end

function GuildTips:Init()
  self._textRuler:SetText(TextManager.GetText(2000021))
  local fontsize = self._textRuler:GetFontSize()
  local _, textheight = self._textRuler:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._textRuler:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._textRuler:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function GuildTips:OnBackBtnClicked()
  self:Destroy()
end

return GuildTips
