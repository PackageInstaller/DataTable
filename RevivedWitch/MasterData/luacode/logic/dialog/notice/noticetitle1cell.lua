-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticetitle1cell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeTitle1Cell = class("NoticeDialog", Dialog)
NoticeTitle1Cell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTitle1Cell.AssetName = "HeadTitleCell"
NoticeTitle1Cell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeTitle1Cell
  ((NoticeTitle1Cell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeTitle1Cell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("Text")
end

NoticeTitle1Cell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeTitle1Cell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._content):SetText((self._cellData).content)
end

return NoticeTitle1Cell

