-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticesigncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeSignCell = class("NoticeDialog", Dialog)
NoticeSignCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeSignCell.AssetName = "FootCell"
NoticeSignCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeSignCell
  ((NoticeSignCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeSignCell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("Text")
end

NoticeSignCell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeSignCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._content):SetText((self._cellData).content)
  _ = (self._content):GetPreferredSize()
  ;
  (self._content):SetHeight(0, self._total)
end

return NoticeSignCell

