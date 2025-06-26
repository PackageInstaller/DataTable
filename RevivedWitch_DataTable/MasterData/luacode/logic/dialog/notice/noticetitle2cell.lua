-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticetitle2cell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeTitle2Cell = class("NoticeDialog", Dialog)
NoticeTitle2Cell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTitle2Cell.AssetName = "SubTitleCell"
NoticeTitle2Cell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeTitle2Cell
  ((NoticeTitle2Cell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeTitle2Cell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("Text")
end

NoticeTitle2Cell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeTitle2Cell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._content):SetText((self._cellData).content)
end

return NoticeTitle2Cell

