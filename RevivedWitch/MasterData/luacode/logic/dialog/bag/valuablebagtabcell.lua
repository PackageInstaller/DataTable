-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/valuablebagtabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ValuableBagTabCell = class("ValuableBagTabCell", Dialog)
ValuableBagTabCell.AssetBundleName = "ui/layouts.bag"
ValuableBagTabCell.AssetName = "ValuableBagMain"
local ColumnsNum = 8
local MinRowNum = 4
local BottomToTop = 3
ValuableBagTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ValuableBagTabCell
  ((ValuableBagTabCell.super).Ctor)(self, ...)
  self._taskBagInfo = {}
  self._cellInfo = {}
  self._selectedID = nil
end

ValuableBagTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, ColumnsNum, _ENV
  self._itemFrame = self:GetChild("ItemFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._frame = (GridFrame.Create)(self._itemFrame, self, true, ColumnsNum)
  ;
  (self._frame):SetMargin(15, 0)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_ItemNumModify, nil)
  self:Init()
end

ValuableBagTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemresolvedialog")
end

ValuableBagTabCell.Refresh = function(self)
  -- function num : 0_3
  self:LoadValuableBagData()
  ;
  (self._frame):ReloadAllCell()
end

ValuableBagTabCell.LoadValuableBagData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._cellInfo = {}
  self._taskBagInfo = ((NekoData.BehaviorManager).BM_BagInfo):GetValuableBagList()
  ;
  (table.sort)(self._taskBagInfo, function(a, b)
    -- function num : 0_4_0
    do return a:GetRank() < b:GetRank() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(self._taskBagInfo) do
    local celldata = {}
    celldata.item = v
    ;
    (table.insert)(self._cellInfo, celldata)
  end
  self:InsertEmptyCellData()
end

ValuableBagTabCell.InsertEmptyCellData = function(self)
  -- function num : 0_5 , upvalues : MinRowNum, ColumnsNum, _ENV
  local num = #self._cellInfo
  while 1 do
    -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

    if num < MinRowNum * ColumnsNum and num < MinRowNum * ColumnsNum then
      (table.insert)(self._cellInfo, {})
      num = #self._cellInfo
      -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  while num % ColumnsNum ~= 0 and num % ColumnsNum ~= 0 do
    (table.insert)(self._cellInfo, {})
    num = #self._cellInfo
  end
end

ValuableBagTabCell.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_6
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName == "bag.itemtipsdialog" then
    (self._frame):FireEvent("ChangedSelected", nil)
  end
end

ValuableBagTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._cellInfo
end

ValuableBagTabCell.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "bag.bagcell"
end

ValuableBagTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._cellInfo)[index]
end

ValuableBagTabCell.SetSelectedID = function(self, args)
  -- function num : 0_10
  self._selectedID = args
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

ValuableBagTabCell.SetNotSelect = function(self)
  -- function num : 0_11
  self._selectedID = nil
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

ValuableBagTabCell.Init = function(self)
  -- function num : 0_12
  self:LoadValuableBagData()
  ;
  (self._frame):ReloadAllCell()
end

ValuableBagTabCell.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

ValuableBagTabCell.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ValuableBagTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_15
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

return ValuableBagTabCell

