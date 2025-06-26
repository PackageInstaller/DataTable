-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/sortchoosecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SortChooseCell = class("SortChooseCell", Dialog)
SortChooseCell.AssetBundleName = "ui/layouts.yard"
SortChooseCell.AssetName = "FurnitureSortListCell"
SortChooseCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SortChooseCell
  ((SortChooseCell.super).Ctor)(self, ...)
end

SortChooseCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Btn/Txt")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

SortChooseCell.OnDestroy = function(self)
  -- function num : 0_2
end

SortChooseCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._text):SetText((TextManager.GetText)(data.nameid))
end

SortChooseCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSortId((self._cellData).id)
end

return SortChooseCell

