-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticetextcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeTextCell = class("NoticeDialog", Dialog)
NoticeTextCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTextCell.AssetName = "TextMainCell"
NoticeTextCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeTextCell
  ((NoticeTextCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeTextCell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("TextMainCell")
  ;
  (self._content):Subscribe_ClickLinkEvent(self.OnLinkClick, self)
  self._initialHeightAnchor = (self:GetRootWindow()):GetHeight()
end

NoticeTextCell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeTextCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._content):SetText((self._cellData).content)
  self._total = ((self._content):GetPreferredValues()).y
  ;
  (self._content):SetHeight(0, self._total)
  ;
  (self:GetRootWindow()):SetHeight(self._initialHeightAnchor, self._initialHeightOffset + self._total)
end

NoticeTextCell.OnLinkClick = function(self, link)
  -- function num : 0_4
  (self._delegate):OnLinkClick(link)
end

return NoticeTextCell

