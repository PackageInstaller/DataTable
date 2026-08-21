-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildtips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuildTips = class("GuildTips", Dialog)
GuildTips.AssetBundleName = "ui/layouts.guild"
GuildTips.AssetName = "GuildTips"
GuildTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildTips
  ((GuildTips.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

GuildTips.OnCreate = function(self)
  -- function num : 0_1
  self._textRuler = self:GetChild("Back/Frame/Text")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width = (self._textRuler):GetRectSize()
  local _ = 0
  _ = (self._textRuler):GetPreferredSize()
  self._text_size_x = (self._textRuler):GetSize()
  self._text_pos_x = (self._textRuler):GetPosition()
  self:Init()
end

GuildTips.OnDestroy = function(self)
  -- function num : 0_2
end

GuildTips.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._textRuler):SetText((TextManager.GetText)(2000021))
  local fontsize = (self._textRuler):GetFontSize()
  local _, textheight = (self._textRuler):GetPreferredSize()
  if self._height < textheight then
    local line = (textheight - self._height) / fontsize
    local delta = line * fontsize
    ;
    (self._textRuler):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._textRuler):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
  end
end

GuildTips.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return GuildTips

