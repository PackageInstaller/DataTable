local MailDetailTextCell = class("MailDetailTextCell", Dialog)
MailDetailTextCell.AssetBundleName = "ui/layouts.mail"
MailDetailTextCell.AssetName = "MailDetailCellNew"

function MailDetailTextCell:Ctor(...)
  MailDetailTextCell.super.Ctor(self, ...)
end

function MailDetailTextCell:OnCreate()
  self._title = self:GetChild("Title")
  self._text = self:GetChild("Txt")
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  self._textDown = self:GetChild("TextDown")
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._text:Subscribe_ClickLinkEvent(self.OnLinkClick, self)
end

function MailDetailTextCell:OnLinkClick(link)
  NekoData.BehaviorManager.BM_GotoLink:HandleGoto(link)
end

function MailDetailTextCell:RefreshCell(data)
  self._title:SetText(tostring(data.name))
  self._text:SetText(data.detail)
  local size = self._text:GetPreferredValues()
  if size.y > self._height then
    local delta = size.y - self._height
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  else
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
  end
  self._textDown:SetText(data.signature)
end

return MailDetailTextCell
