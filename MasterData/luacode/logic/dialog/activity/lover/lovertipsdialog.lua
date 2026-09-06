local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local TopToBottom = 4
local LoverTipsDialog = class("LoverTipsDialog", Dialog)
LoverTipsDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverTipsDialog.AssetName = "ActivityValentinesTips"

function LoverTipsDialog:Ctor(...)
  LoverTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function LoverTipsDialog:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._closeBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self:SetStaticRes()
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function LoverTipsDialog:SetStaticRes()
  self._title:SetText(TextManager.GetText(CStringRes:GetRecorder(1698).msgTextID))
end

function LoverTipsDialog:OnDestroy()
end

function LoverTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverTipsDialog:SetData(textID)
  self._text:SetText(TextManager.GetText(textID))
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function LoverTipsDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._text:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return LoverTipsDialog
