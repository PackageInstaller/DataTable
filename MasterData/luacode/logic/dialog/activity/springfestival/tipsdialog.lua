local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local TopToBottom = 4
local TipsDialog = class("TipsDialog", Dialog)
TipsDialog.AssetBundleName = "ui/layouts.activitynewyear"
TipsDialog.AssetName = "ActivityNewYearTips"

function TipsDialog:Ctor(...)
  TipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function TipsDialog:OnCreate()
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

function TipsDialog:SetStaticRes()
  self._title:SetText(TextManager.GetText(CStringRes:GetRecorder(1636).msgTextID))
end

function TipsDialog:OnDestroy()
end

function TipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function TipsDialog:SetData(textID, parameter)
  self._text:SetText(TextManager.GetText(textID, parameter))
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function TipsDialog:OnCurPosChange(frame, proportion)
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

return TipsDialog
