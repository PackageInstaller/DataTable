-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonconquestdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local DungeonConquestDialog = class("DungeonConquestDialog", Dialog)
DungeonConquestDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonConquestDialog.AssetName = "DungeonTrophies"
local BottomToTop = 2
DungeonConquestDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonConquestDialog
  ((DungeonConquestDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

DungeonConquestDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._itemFrame = self:GetChild("Back/Frame")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._empty = self:GetChild("Back/Empty")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (TableFrame.Create)(self._itemFrame, self, true, true, true)
  ;
  (self._frame):SetMargin(20, 20)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemNumModify, nil)
end

DungeonConquestDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
end

DungeonConquestDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = ((NekoData.BehaviorManager).BM_Dungeon):GetDungeonConquestList()
  ;
  (self._frame):ReloadAllCell()
  if #self._data == 0 then
    (self._empty):SetActive(true)
  else
    ;
    (self._frame):MoveToBottom()
    ;
    (self._empty):SetActive(false)
  end
end

DungeonConquestDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

DungeonConquestDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "dungeon.dungeonconquestcell"
end

DungeonConquestDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

DungeonConquestDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

DungeonConquestDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._itemFrame):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return DungeonConquestDialog

