-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/introductioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local IntroductionCell = class("IntroductionCell", Dialog)
IntroductionCell.AssetBundleName = "ui/layouts.tujian"
IntroductionCell.AssetName = "CharStoryCell1"
IntroductionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : IntroductionCell
  ((IntroductionCell.super).Ctor)(self, ...)
end

IntroductionCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Text")
  self._detail = self:GetChild("Detail")
  self._back = self:GetChild("Back")
  self._title_width = (self._title):GetDeltaSize()
  self._detail_width = (self._detail):GetDeltaSize()
  self._back_width = (self._back):GetDeltaSize()
  self._rootWindow_width = (self._rootWindow):GetDeltaSize()
end

IntroductionCell.OnDestroy = function(self)
  -- function num : 0_2
end

IntroductionCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._title):SetText(data.title)
  ;
  (self._detail):SetText(data.content)
  local _, textheight = (self._detail):GetPreferredSize()
  if self._detail_height < textheight then
    local delta = textheight - self._detail_height
    ;
    (self._title):SetDeltaSize(self._title_width, self._title_height + delta)
    ;
    (self._detail):SetDeltaSize(self._detail_width, self._detail_height + delta)
    ;
    (self._back):SetDeltaSize(self._back_width, self._back_height + delta)
    ;
    (self._rootWindow):SetDeltaSize(self._rootWindow_width, self._rootWindow_height + delta)
  else
    do
      ;
      (self._title):SetDeltaSize(self._title_width, self._title_height)
      ;
      (self._detail):SetDeltaSize(self._detail_width, self._detail_height)
      ;
      (self._back):SetDeltaSize(self._back_width, self._back_height)
      ;
      (self._rootWindow):SetDeltaSize(self._rootWindow_width, self._rootWindow_height)
    end
  end
end

return IntroductionCell

