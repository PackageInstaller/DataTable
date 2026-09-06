local SystemInfoTimeCell = class("SystemInfoTimeCell", Dialog)
SystemInfoTimeCell.AssetBundleName = "ui/layouts.chat"
SystemInfoTimeCell.AssetName = "ChatNewSystemMessageTime"

function SystemInfoTimeCell:Ctor(...)
  SystemInfoTimeCell.super.Ctor(self, ...)
  self._info = nil
end

function SystemInfoTimeCell:OnCreate()
  self._time = self:GetChild("Time")
  self._info = self:GetChild("Bubble/Text")
  self._talk = self:GetChild("Bubble")
  self._info:Subscribe_BeginLongPressEvent(self.OnBeginLongPress, self)
  self._imageColor = self._talk:GetColor()
  local _ = 0
  self._info:SetText("")
  _, self._oneline = self._info:GetPreferredSize()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self._talk:GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self._talk:GetPosition()
  self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y = self:GetRootWindow():GetSize()
end

function SystemInfoTimeCell:OnDestroy()
end

function SystemInfoTimeCell:RefreshCell(data)
  self._info:SetText(data.msg)
  self._time:SetText(ServerGameTimer.GetTimeHourMinStr(data.receiveTime))
  local fontsize = self._info:GetFontSize()
  local _, textheight = self._info:GetPreferredSize()
  if textheight > self._oneline then
    local line = (textheight - self._oneline) / self._oneline
    local delta = line * fontsize
    self._talk:SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self._talk:SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
  else
    self._talk:SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self._talk:SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    self:GetRootWindow():SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
  end
end

function SystemInfoTimeCell:OnBeginLongPress(args)
  self._delegate:SetColorInCell(self._talk, self._imageColor)
  local _1, x, _2, y = self:GetRootWindow():GetPosition()
  self._delegate:CopyCellInfo(x, y, true, self._info:GetText())
end

return SystemInfoTimeCell
