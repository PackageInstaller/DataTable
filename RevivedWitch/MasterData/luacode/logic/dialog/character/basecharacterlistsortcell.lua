-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistsortcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local BaseCharacterListSortCell = class("BaseCharacterListSortCell", Dialog)
BaseCharacterListSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSortCell.AssetName = "BaseCharacterListSortCell"
BaseCharacterListSortCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListSortCell
  ((BaseCharacterListSortCell.super).Ctor)(self, ...)
  self._filter = true
end

BaseCharacterListSortCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

BaseCharacterListSortCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharacterListSortCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  if (self._delegate):GetOperateType() == "sort" or (self._delegate):GetOperateType() == "filter" then
    (self._text):SetText((TextManager.GetText)(self._cellData))
  else
    if (self._delegate):GetOperateType() == "skillsort" or (self._delegate):GetOperateType() == "skillfilter" then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(self._cellData)).msgTextID)
      ;
      (self._text):SetText(str)
    end
  end
  do
    if (self._delegate):GetSelect() ~= self._cellData then
      (self._btn):SetSelected((self._delegate):GetOperateType() ~= "sort" and (self._delegate):GetOperateType() ~= "skillsort")
      if (self._delegate):GetOperateType() == "filter" or (self._delegate):GetOperateType() == "skillfilter" then
        self._filter = false
        for _,v in pairs((self._delegate)._nameIdListRank) do
          if v == self._cellData then
            self._filter = true
            break
          end
        end
        for _,v in pairs((self._delegate)._nameIdListVocation) do
          if v == self._cellData then
            self._filter = true
            break
          end
        end
        ;
        (self._btn):SetSelected(self._filter)
      end
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

BaseCharacterListSortCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LogError("BaseCharacterListSortCell:OnCellClick()")
  -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

  if ((self._delegate):GetOperateType() == "sort" or (self._delegate):GetOperateType() == "skillsort") and (self._delegate):GetSelect() ~= self._cellData then
    (self._btn):SetSelected(true)
    ;
    (self._delegate):SetSelect(self._cellData)
    ;
    (self._delegate):OnSortCellClick(self._cellData)
    ;
    (self._delegate):SetScreenedListTypeTxt((self._text):GetText())
  end
  if (self._delegate):GetOperateType() == "filter" or (self._delegate):GetOperateType() == "skillfilter" then
    if self._cellData ~= 37 and self._cellData ~= 38 then
      if self._filter == false then
        self._filter = true
        ;
        (self._btn):SetSelected(self._filter)
      else
        self._filter = false
        ;
        (self._btn):SetSelected(self._filter)
      end
      ;
      (self._delegate):OnFilterCellClick(self._cellData)
    else
      if not self._filter then
        (self._delegate):OnFilterCellClick(self._cellData)
      end
    end
  end
end

BaseCharacterListSortCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ChangedSelected" then
    if self._cellData == arg then
      (self._btn):SetSelected(true)
    else
      ;
      (self._btn):SetSelected(false)
    end
  else
    -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

    if eventName == "Remove" and self._cellData == arg then
      self._filter = false
      ;
      (self._btn):SetSelected(false)
    end
  end
  if eventName == "Insert" and self._cellData == arg then
    self._filter = true
    ;
    (self._btn):SetSelected(true)
  end
end

return BaseCharacterListSortCell

