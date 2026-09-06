local TableFrame = require("framework.ui.frame.table.tableframe")
local DungeonConquestDialog = class("DungeonConquestDialog", Dialog)
DungeonConquestDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonConquestDialog.AssetName = "DungeonTrophies"
local BottomToTop = 2

function DungeonConquestDialog:Ctor(...)
  DungeonConquestDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function DungeonConquestDialog:OnCreate()
  self._itemFrame = self:GetChild("Back/Frame")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._empty = self:GetChild("Back/Empty")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = TableFrame.Create(self._itemFrame, self, true, true, true)
  self._frame:SetMargin(20, 20)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemNumModify, nil)
end

function DungeonConquestDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
end

function DungeonConquestDialog:Refresh()
  self._data = NekoData.BehaviorManager.BM_Dungeon:GetDungeonConquestList()
  self._frame:ReloadAllCell()
  if #self._data == 0 then
    self._empty:SetActive(true)
  else
    self._frame:MoveToBottom()
    self._empty:SetActive(false)
  end
end

function DungeonConquestDialog:NumberOfCell(frame)
  return #self._data
end

function DungeonConquestDialog:CellAtIndex(frame)
  return "dungeon.dungeonconquestcell"
end

function DungeonConquestDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function DungeonConquestDialog:OnBackBtnClicked()
  self:Destroy()
end

function DungeonConquestDialog:OnCurPosChange(frame, proportion)
  local width, height = self._itemFrame:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return DungeonConquestDialog
