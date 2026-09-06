local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TopToBottom = 4
local SeasonPvpTipsDialog = class("SeasonPvpTipsDialog", Dialog)
SeasonPvpTipsDialog.AssetBundleName = "ui/widgets.activeprefab"
SeasonPvpTipsDialog.AssetName = "Tips"

function SeasonPvpTipsDialog:Ctor(...)
  SeasonPvpTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SeasonPvpTipsDialog:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._closeBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function SeasonPvpTipsDialog:OnDestroy()
end

function SeasonPvpTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function SeasonPvpTipsDialog:SetData(contentTextID)
  self._title:SetText("幻域纷争")
  self._text:SetText(TextManager.GetText(CStringRes:GetRecorder(contentTextID).msgTextID))
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

function SeasonPvpTipsDialog:OnCurPosChange(frame, proportion)
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

return SeasonPvpTipsDialog
