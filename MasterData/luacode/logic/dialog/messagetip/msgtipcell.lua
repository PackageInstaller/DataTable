local MsgTipCell = class("MsgTipCell", Dialog)
MsgTipCell.AssetBundleName = "ui/layouts.toast"
MsgTipCell.AssetName = "Toast"

function MsgTipCell:Ctor(...)
  MsgTipCell.super.Ctor(self, ...)
end

function MsgTipCell:OnCreate()
  self._text = self:GetChild("Text")
  self._back = self:GetChild("Back")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self:GetRootWindow():GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self:GetRootWindow():GetPosition()
end

function MsgTipCell:OnDestroy()
end

function MsgTipCell:Refresh(msg)
  self._text:SetText(msg)
  local fontsize = self._text:GetFontSize()
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    self._back:SetSize(self._size_x, self._size_offset_x, self._size_y, self._size_offset_y + delta)
    self._back:SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._size_x, self._size_offset_x, self._size_y, self._size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y - delta)
  end
end

return MsgTipCell
