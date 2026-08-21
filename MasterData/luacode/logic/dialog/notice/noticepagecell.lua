-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/notice/noticepagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticePageCell = class("NoticeDialog", Dialog)
NoticePageCell.AssetBundleName = "ui/layouts.activeannouce"
NoticePageCell.AssetName = "PageGroupButton"
NoticePageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NoticePageCell
  ((NoticePageCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

NoticePageCell.OnCreate = function(self)
  -- function num : 0_1
  self._button = self:GetChild("GroupBtn")
  self._title = self:GetChild("GroupBtn/Txt")
  self._day = self:GetChild("GroupBtn/dateDay")
  self._month = self:GetChild("GroupBtn/dateMonth")
  ;
  (self._button):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

NoticePageCell.OnDestroy = function(self)
  -- function num : 0_2
end

NoticePageCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._title):SetText(((self._cellData).data).title)
  ;
  (self._day):SetText((string.format)("%02d", (((self._cellData).data).time).day))
  ;
  (self._month):SetText((string.format)("%02d", (((self._cellData).data).time).month))
end

NoticePageCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnPageClick((self._cellData).index)
end

NoticePageCell.OnEvent = function(self, name, args)
  -- function num : 0_5
  if args ~= (self._cellData).index then
    (self._button):SetSelected(name ~= "selected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return NoticePageCell

