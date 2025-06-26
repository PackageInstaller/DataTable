-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildchatnoticecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GuildChatNoticeCell = class("GuildChatNoticeCell", Dialog)
GuildChatNoticeCell.AssetBundleName = "ui/layouts.guild"
GuildChatNoticeCell.AssetName = "GuildChatMessage"
local SecToDay = 86400
local GetTimeStr = function(ms)
  -- function num : 0_0 , upvalues : _ENV, SecToDay
  local interval = ((ServerGameTimer.GetServerTime)() - ms) // 1000
  local sec = ms // 1000
  if interval < SecToDay then
    local lt = (os.date)("*t", sec)
    return (string.format)("%02d:%02d", lt.hour, lt.min)
  else
    do
      if interval < SecToDay * 30 then
        local lt = (os.date)("*t", sec)
        return (string.format)("%02d-%02d %02d:%02d", lt.month, lt.day, lt.hour, lt.min)
      else
        do
          if interval < SecToDay * 30 * 12 then
            local lt = (os.date)("*t", sec)
            return (string.format)("%04d-%02d-%02d %02d:%02d", lt.year, lt.month, lt.day, lt.hour, lt.min)
          end
        end
      end
    end
  end
end

GuildChatNoticeCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildChatNoticeCell
  ((GuildChatNoticeCell.super).Ctor)(self, ...)
end

GuildChatNoticeCell.OnCreate = function(self)
  -- function num : 0_2
  self._text = self:GetChild("Bubble/Text")
  self._time = self:GetChild("Time")
  self._bubble = self:GetChild("Bubble")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._bubble):GetSize()
  self._text_pos_x = (self._bubble):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
end

GuildChatNoticeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : GetTimeStr, _ENV, CStringRes
  (self._time):SetText(GetTimeStr((data.data).sendTime))
  local list = (string.split)((data.data).msg, ";")
  local msgID = tonumber(list[1])
  local str = (TextManager.GetText)((CStringRes:GetRecorder(msgID)).msgTextID)
  for i = 2, #list do
    str = (string.gsub)(str, "%$parameter" .. i - 1 .. "%$", list[i])
  end
  ;
  (self._text):SetText(str)
  local textWidth, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    ;
    (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    ;
    (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    do
      ;
      (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
      ;
      (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
      ;
      (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
      ;
      (self:GetRootWindow()):SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
    end
  end
end

return GuildChatNoticeCell

