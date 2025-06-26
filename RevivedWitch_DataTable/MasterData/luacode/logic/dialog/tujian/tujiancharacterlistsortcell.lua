-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterlistsortcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TuJianCharacterListSortCell = class("TuJianCharacterListSortCell", Dialog)
TuJianCharacterListSortCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterListSortCell.AssetName = "TuJianCharListSortCell"
TuJianCharacterListSortCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterListSortCell
  ((TuJianCharacterListSortCell.super).Ctor)(self, ...)
  self._filter = true
end

TuJianCharacterListSortCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

TuJianCharacterListSortCell.OnDestroy = function(self)
  -- function num : 0_2
end

TuJianCharacterListSortCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._text):SetText(tostring((TextManager.GetText)(self._cellData)))
  self._filter = false
  for _,v in pairs((self._delegate)._filterList1) do
    if v == self._cellData then
      self._filter = true
      break
    end
  end
  do
    for _,v in pairs((self._delegate)._filterList2) do
      if v == self._cellData then
        self._filter = true
        break
      end
    end
    do
      ;
      (self._btn):SetSelected(self._filter)
    end
  end
end

TuJianCharacterListSortCell.OnCellClick = function(self)
  -- function num : 0_4
  self._filter = not self._filter
  ;
  (self._btn):SetSelected(self._filter)
  ;
  (self._delegate):OnFilterCellClick(self._cellData)
end

return TuJianCharacterListSortCell

