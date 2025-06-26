-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/systeminfotimecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SystemInfoTimeCell = class("SystemInfoTimeCell", Dialog)
SystemInfoTimeCell.AssetBundleName = "ui/layouts.chat"
SystemInfoTimeCell.AssetName = "ChatNewSystemMessageTime"
SystemInfoTimeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SystemInfoTimeCell
  ((SystemInfoTimeCell.super).Ctor)(self, ...)
  self._info = nil
end

SystemInfoTimeCell.OnCreate = function(self)
  -- function num : 0_1
  self._time = self:GetChild("Time")
  self._info = self:GetChild("Bubble/Text")
  self._talk = self:GetChild("Bubble")
  ;
  (self._info):Subscribe_BeginLongPressEvent(self.OnBeginLongPress, self)
  self._imageColor = (self._talk):GetColor()
  local _ = 0
  ;
  (self._info):SetText("")
  _ = (self._info):GetPreferredSize()
  self._talk_size_x = (self._talk):GetSize()
  self._talk_pos_x = (self._talk):GetPosition()
  self._cell_size_x = (self:GetRootWindow()):GetSize()
end

SystemInfoTimeCell.OnDestroy = function(self)
  -- function num : 0_2
end

SystemInfoTimeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._info):SetText(data.msg)
  ;
  (self._time):SetText((ServerGameTimer.GetTimeHourMinStr)(data.receiveTime))
  local fontsize = (self._info):GetFontSize()
  local _, textheight = (self._info):GetPreferredSize()
  if self._oneline < textheight then
    local line = (textheight - self._oneline) / self._oneline
    local delta = line * fontsize
    ;
    (self._talk):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self._talk):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
  else
    do
      ;
      (self._talk):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self._talk):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
    end
  end
end

SystemInfoTimeCell.OnBeginLongPress = function(self, args)
  -- function num : 0_4
  (self._delegate):SetColorInCell(self._talk, self._imageColor)
  local _1, x, _2, y = (self:GetRootWindow()):GetPosition()
  ;
  (self._delegate):CopyCellInfo(x, y, true, (self._info):GetText())
end

return SystemInfoTimeCell

