local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ChildrenTipsDialog = class("ChildrenTipsDialog", Dialog)
ChildrenTipsDialog.AssetBundleName = "ui/layouts.activitychildrensday"
ChildrenTipsDialog.AssetName = "ActivityChildrensDayTips"
local TopToBottom = 4

function ChildrenTipsDialog:Ctor(...)
  ChildrenTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ChildrenTipsDialog:OnCreate()
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

function ChildrenTipsDialog:SetStaticRes()
  self._title:SetText(TextManager.GetText(CStringRes:GetRecorder(1793).msgTextID))
end

function ChildrenTipsDialog:OnDestroy()
end

function ChildrenTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChildrenTipsDialog:SetData(textID)
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

function ChildrenTipsDialog:OnCurPosChange(frame, proportion)
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

return ChildrenTipsDialog
