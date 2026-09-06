local TopToBottom = 4
local InstructionsTipDialog = class("InstructionsTipDialog", Dialog)
InstructionsTipDialog.AssetBundleName = "ui/layouts.activityhud"
InstructionsTipDialog.AssetName = "ActivityTips"

function InstructionsTipDialog:Ctor(...)
  InstructionsTipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function InstructionsTipDialog:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._closeBtn = self:GetChild("CloseBtn")
  self._panel = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._width, self._height = self._text:GetRectSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function InstructionsTipDialog:OnDestroy()
end

function InstructionsTipDialog:OnBackBtnClicked()
  self:Destroy()
end

function InstructionsTipDialog:SetData(record)
  self._title:SetText(TextManager.GetText(record.tipsId))
  self._text:SetText(TextManager.GetText(record.tipsTxtId))
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

return InstructionsTipDialog
