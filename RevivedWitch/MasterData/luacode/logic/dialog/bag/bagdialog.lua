-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/bagdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CBagCurrencyShow = (BeanManager.GetTableByName)("item.cbagcurrencyshow")
local BagDialog = class("BagDialog", Dialog)
BagDialog.AssetBundleName = "ui/layouts.bag"
BagDialog.AssetName = "BagMain"
local ColumnsNum = 8
local MinRowNum = 4
local BottomToTop = 3
BagDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BagDialog
  ((BagDialog.super).Ctor)(self, ...)
  self._bagInfo = {}
  self._cellInfo = {}
  self._selectedID = nil
  self._bResoveMode = false
end

BagDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnsNum, TableFrame, BottomToTop, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._itemFrame = self:GetChild("ItemFrame")
  self._frame = (GridFrame.Create)(self._itemFrame, self, true, ColumnsNum)
  ;
  (self._frame):SetMargin(15, 0)
  self._resolveBtn = self:GetChild("ResolveBtn")
  self._topFrame = self:GetChild("TopGroup")
  self._currencyFrame = (TableFrame.Create)(self._topFrame, self, false, false, false)
  self._groupBtn = {}
  for i = 1, 1 do
    do
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtn)[i] = self:GetChild("Group/GroupBtn" .. i)
      ;
      ((self._groupBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupClick(i)
  end
)
    end
  end
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self:InitCurrencyData()
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._resolveBtn):Subscribe_PointerClickEvent(self.OnResolveBtnClicked, self)
  self:OnGroupClick(1)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemAdd, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemRemove, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemNumModify, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
end

BagDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
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

BagDialog.InitCurrencyData = function(self)
  -- function num : 0_3
  (self._currencyFrame):ReloadAllCell()
end

BagDialog.OnGroupClick = function(self, index)
  -- function num : 0_4
  if self._selectPage and self._selectPage == index then
    return 
  end
  self._selectPage = index
  ;
  ((self._groupBtn)[index]):SetSelected(true)
  self:Refresh()
end

BagDialog.OnItemAdd = function(self, notification)
  -- function num : 0_5
  self:LoadLocalData()
  self:OnAddItem(notification.userInfo)
  ;
  (self._frame):FireEvent("SetResoveModelState", self._bResoveMode)
end

BagDialog.OnItemRemove = function(self, notification)
  -- function num : 0_6
  self:OnRemoveItem(notification.userInfo)
  self:LoadLocalData()
  ;
  (self._frame):FireEvent("SetResoveModelState", self._bResoveMode)
end

BagDialog.OnItemNumModify = function(self, notification)
  -- function num : 0_7
  self:LoadLocalData()
  self:OnModifyItemNum(notification.userInfo)
  ;
  (self._frame):FireEvent("SetResoveModelState", self._bResoveMode)
end

BagDialog.RefreshCell = function(self)
  -- function num : 0_8
  self:Refresh()
end

BagDialog.Refresh = function(self)
  -- function num : 0_9
  self:LoadLocalData()
  self._bResoveMode = false
  ;
  (self._resolveBtn):SetSelected(self._bResoveMode)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):FireEvent("SetResoveModelState", self._bResoveMode)
end

BagDialog.LoadLocalData = function(self)
  -- function num : 0_10 , upvalues : _ENV
  while (self._cellInfo)[#self._cellInfo] do
    (table.remove)(self._cellInfo, #self._cellInfo)
  end
  self._bagInfo = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByPageIndex(self._selectPage)
  ;
  (table.sort)(self._bagInfo, function(a, b)
    -- function num : 0_10_0
    if a:GetRank() == b:GetRank() then
      if a:GetID() >= b:GetID() then
        do return a:GetPinJiID() ~= b:GetPinJiID() end
        do return a:GetRank() < b:GetRank() end
        do return b:GetPinJiID() < a:GetPinJiID() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  for i,v in ipairs(self._bagInfo) do
    local celldata = {}
    celldata.item = v
    ;
    (table.insert)(self._cellInfo, celldata)
  end
  self:InsertEmptyCellData()
end

BagDialog.InsertEmptyCellData = function(self)
  -- function num : 0_11 , upvalues : MinRowNum, ColumnsNum, _ENV
  local curNum = #self._cellInfo
  local onePageNum = MinRowNum * ColumnsNum
  if curNum <= onePageNum then
    for i = curNum + 1, onePageNum do
      local celldata = {}
      celldata.item = nil
      ;
      (table.insert)(self._cellInfo, celldata)
    end
    return 
  end
  local curRow = (math.ceil)(curNum / ColumnsNum)
  for i = curNum + 1, curRow * ColumnsNum do
    local celldata = {}
    celldata.item = nil
    ;
    (table.insert)(self._cellInfo, celldata)
  end
end

BagDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_12
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName == "bag.itemtipsdialog" then
    (self._frame):FireEvent("ChangedSelected", nil)
  end
end

BagDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13 , upvalues : CBagCurrencyShow
  if frame == self._frame then
    return #self._cellInfo
  else
    return #CBagCurrencyShow:GetAllIds()
  end
end

BagDialog.CellAtIndex = function(self, frame)
  -- function num : 0_14
  if frame == self._frame then
    return "bag.bagcell"
  else
    return "bag.bagcurrencycell"
  end
end

BagDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15 , upvalues : CBagCurrencyShow
  if frame == self._frame then
    return (self._cellInfo)[index]
  else
    local ids = CBagCurrencyShow:GetAllIds()
    return CBagCurrencyShow:GetRecorder(ids[index])
  end
end

BagDialog.SetSelectedID = function(self, args)
  -- function num : 0_16
  self._selectedID = args
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

BagDialog.SetNotSelect = function(self)
  -- function num : 0_17
  self._selectedID = nil
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

BagDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:Destroy()
end

BagDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

BagDialog.OnRefreshCurrency = function(self, notification)
  -- function num : 0_20
  (self._currencyFrame):ReloadAllCell()
end

BagDialog.OnRemoveItem = function(self, protocol)
  -- function num : 0_21 , upvalues : _ENV
  for index,info in ipairs(self._cellInfo) do
    if info.item and (info.item):GetKey() == protocol.itemKey then
      (self._frame):RemoveCellsAtIndex({index})
      break
    end
  end
end

BagDialog.OnModifyItemNum = function(self, protocol)
  -- function num : 0_22 , upvalues : _ENV
  for index,info in ipairs(self._cellInfo) do
    if info.item and (info.item):GetKey() == protocol.itemKey then
      (self._frame):FireIndexCellEvent("RefreshCell", index, info)
      break
    end
  end
end

BagDialog.OnAddItem = function(self, protocol)
  -- function num : 0_23 , upvalues : _ENV, Item
  if protocol.bagType ~= ((LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")).BAG then
    return 
  end
  local bAdd = false
  for i,value in ipairs(protocol.data) do
    local item = (Item.Create)(value.id)
    if item:IsPageIndexShow(self._selectPage) then
      local itemInfo = {}
      itemInfo.id = value.id
      itemInfo.itemtype = value.itemtype
      itemInfo.key = value.key
      itemInfo.number = value.number
      item:InitWithFull(itemInfo)
      local emptyIndex = self:GetFirstEmptyCellIndex()
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R11 in 'UnsetPending'

      if emptyIndex then
        ((self._cellInfo)[emptyIndex]).item = item
        local celldata = {}
        celldata.item = item
        ;
        (self._frame):FireIndexCellEvent("RefreshCell", emptyIndex, celldata)
      else
        do
          do
            local celldata = {}
            celldata.item = item
            ;
            (table.insert)(self._cellInfo, item)
            bAdd = true
            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if bAdd then
    self:InsertEmptyCellData()
    ;
    (self._frame):InsertCellsAtIndex({}, false)
  end
end

BagDialog.GetFirstEmptyCellIndex = function(self)
  -- function num : 0_24 , upvalues : _ENV
  for index,info in ipairs(self._cellInfo) do
    if not info.item then
      return index
    end
  end
end

BagDialog.OnResolveBtnClicked = function(self)
  -- function num : 0_25
  self._bResoveMode = not self._bResoveMode
  ;
  (self._frame):FireEvent("SetResoveModelState", self._bResoveMode)
  ;
  (self._resolveBtn):SetSelected(self._bResoveMode)
end

BagDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_26
  if frame == self._frame then
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
end

BagDialog.IfInResolveMode = function(self)
  -- function num : 0_27
  return self._bResoveMode
end

BagDialog.IsBag = function(self)
  -- function num : 0_28
  return true
end

return BagDialog

