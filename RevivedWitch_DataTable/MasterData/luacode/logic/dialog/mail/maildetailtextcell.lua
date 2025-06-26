-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/maildetailtextcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MailDetailTextCell = class("MailDetailTextCell", Dialog)
MailDetailTextCell.AssetBundleName = "ui/layouts.mail"
MailDetailTextCell.AssetName = "MailDetailCellNew"
MailDetailTextCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailDetailTextCell
  ((MailDetailTextCell.super).Ctor)(self, ...)
end

MailDetailTextCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._text = self:GetChild("Txt")
  ;
  (self._text):SetText("")
  self._width = (self._text):GetRectSize()
  self._textDown = self:GetChild("TextDown")
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  ;
  (self._text):Subscribe_ClickLinkEvent(self.OnLinkClick, R4_PC25)
end

MailDetailTextCell.OnLinkClick = function(self, link)
  -- function num : 0_2 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_GotoLink):HandleGoto(link)
end

MailDetailTextCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText(tostring(data.name))
  ;
  (self._text):SetText(data.detail)
  local size = (self._text):GetPreferredValues()
  if self._height < size.y then
    local delta = size.y - self._height
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    ;
    (self._text):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._text):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  else
    do
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
      ;
      (self._textDown):SetText(data.signature)
    end
  end
end

return MailDetailTextCell

