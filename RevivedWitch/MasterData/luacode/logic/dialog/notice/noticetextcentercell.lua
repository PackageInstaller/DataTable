-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticetextcentercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeTextCenterCell = class("NoticeDialog", Dialog)
NoticeTextCenterCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTextCenterCell.AssetName = "TextMainCenterCell"
NoticeTextCenterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeTextCenterCell
  ((NoticeTextCenterCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeTextCenterCell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("TextMainCell")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnLinkClick, self)
end

NoticeTextCenterCell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeTextCenterCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._content):SetText((self._cellData).content)
  _ = (self._content):GetPreferredSize()
  ;
  (self._content):SetYPosition(0, 0)
  ;
  (self._content):SetHeight(0, self._total)
  ;
  (self:GetRootWindow()):SetHeight(0, self._total)
end

NoticeTextCenterCell.OnLinkClick = function(self)
  -- function num : 0_4
  if (self._cellData).attr == "link" then
    (self._delegate):OnLinkClick((self._cellData).value)
  end
end

return NoticeTextCenterCell

