-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/storydetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StoryDetailCell = class("StoryDetailCell", Dialog)
StoryDetailCell.AssetBundleName = "ui/layouts.tujian"
StoryDetailCell.AssetName = "CharStoryDetailFrame"
StoryDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : StoryDetailCell
  ((StoryDetailCell.super).Ctor)(self, ...)
end

StoryDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Detail")
  self._width = (self._rootWindow):GetDeltaSize()
end

StoryDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

StoryDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._txt):SetText(data)
  local _, textheight = (self._txt):GetPreferredSize()
  ;
  (self._rootWindow):SetDeltaSize(self._width, textheight)
end

return StoryDetailCell

