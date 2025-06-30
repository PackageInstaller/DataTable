-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticeimagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeImageCell = class("NoticeDialog", Dialog)
NoticeImageCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeImageCell.AssetName = "HeadImageCell"
NoticeImageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticeImageCell
  ((NoticeImageCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticeImageCell.OnCreate = function(self)
  -- function num : 0_1
  self._content = self:GetChild("Image")
  ;
  (self._content):Subscribe_PointerClickEvent(self.OnPointerClick, self)
  self._initialHeightAnchor = (self:GetRootWindow()):GetHeight()
end

NoticeImageCell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticeImageCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (((((CS.PixelNeko).P1).Platform).ImageHttpHelperStaticFunctions).LoadImage)((self._content):GetUIObject(), (self._cellData).content)
  local height = ((self._cellData).attrs).height
  ;
  (self._content):SetHeight(0, height)
  LogInfo("notice", height, self._initialHeightAnchor, self._initialHeightOffset)
  ;
  (self:GetRootWindow()):SetHeight(self._initialHeightAnchor, self._initialHeightOffset + height)
end

NoticeImageCell.OnPointerClick = function(self)
  -- function num : 0_4
  local link = ((self._cellData).attrs).link
  if link ~= nil then
    (self._delegate):OnLinkClick(link)
  end
end

return NoticeImageCell

