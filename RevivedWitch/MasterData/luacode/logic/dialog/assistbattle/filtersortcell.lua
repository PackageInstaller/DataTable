-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/filtersortcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local FilterSortCell = class("FilterSortCell", Dialog)
FilterSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterSortCell.AssetName = "BaseCharacterListSortCell"
FilterSortCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FilterSortCell
  ((FilterSortCell.super).Ctor)(self, ...)
end

FilterSortCell.OnCreate = function(self)
  -- function num : 0_1
  self._selectBtn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

FilterSortCell.OnDestroy = function(self)
  -- function num : 0_2
end

FilterSortCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  local str = (TextManager.GetText)((CStringRes:GetRecorder((self._cellData).nameid)).msgTextID)
  ;
  (self._text):SetText(str)
  if (self._delegate):IsInSelectedList(data) then
    (self._selectBtn):SetSelected(true)
  else
    ;
    (self._selectBtn):SetSelected(false)
  end
end

FilterSortCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectedList(self._cellData)
end

FilterSortCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ChangeSelectNameId" then
    if (self._delegate):IsInSelectedList(self._cellData) then
      (self._selectBtn):SetSelected(true)
    else
      ;
      (self._selectBtn):SetSelected(false)
    end
  end
end

return FilterSortCell

