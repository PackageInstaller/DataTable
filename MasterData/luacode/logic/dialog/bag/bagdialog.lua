local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local CBagCurrencyShow = BeanManager.GetTableByName("item.cbagcurrencyshow")
local BagDialog = class("BagDialog", Dialog)
BagDialog.AssetBundleName = "ui/layouts.bag"
BagDialog.AssetName = "BagMain"
local ColumnsNum = 8
local MinRowNum = 4
local BottomToTop = 3

function BagDialog:Ctor(...)
  BagDialog.super.Ctor(self, ...)
  self._bagInfo = {}
  self._cellInfo = {}
  self._selectedID = nil
  self._bResoveMode = false
end

function BagDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._itemFrame = self:GetChild("ItemFrame")
  self._frame = GridFrame.Create(self._itemFrame, self, true, ColumnsNum)
  self._frame:SetMargin(15, 0)
  self._resolveBtn = self:GetChild("ResolveBtn")
  self._topFrame = self:GetChild("TopGroup")
  self._currencyFrame = TableFrame.Create(self._topFrame, self, false, false, false)
  self._groupBtn = {}
  for i = 1, 1 do
    self._groupBtn[i] = self:GetChild("Group/GroupBtn" .. i)
    self._groupBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnGroupClick(i)
    end)
  end
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self:InitCurrencyData()
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._resolveBtn:Subscribe_PointerClickEvent(self.OnResolveBtnClicked, self)
  self:OnGroupClick(1)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemAdd, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemRemove, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemNumModify, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
end

function BagDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._frame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("bag.itemresolvedialog")
end

function BagDialog:InitCurrencyData()
  self._currencyFrame:ReloadAllCell()
end

function BagDialog:OnGroupClick(index)
  if self._selectPage and self._selectPage == index then
    return
  end
  self._selectPage = index
  self._groupBtn[index]:SetSelected(true)
  self:Refresh()
end

function BagDialog:OnItemAdd(notification)
  self:LoadLocalData()
  self:OnAddItem(notification.userInfo)
  self._frame:FireEvent("SetResoveModelState", self._bResoveMode)
end

function BagDialog:OnItemRemove(notification)
  self:OnRemoveItem(notification.userInfo)
  self:LoadLocalData()
  self._frame:FireEvent("SetResoveModelState", self._bResoveMode)
end

function BagDialog:OnItemNumModify(notification)
  self:LoadLocalData()
  self:OnModifyItemNum(notification.userInfo)
  self._frame:FireEvent("SetResoveModelState", self._bResoveMode)
end

function BagDialog:RefreshCell()
  self:Refresh()
end

function BagDialog:Refresh()
  self:LoadLocalData()
  self._bResoveMode = false
  self._resolveBtn:SetSelected(self._bResoveMode)
  self._frame:ReloadAllCell()
  self._frame:FireEvent("SetResoveModelState", self._bResoveMode)
end

function BagDialog:LoadLocalData()
  while self._cellInfo[#self._cellInfo] do
    table.remove(self._cellInfo, #self._cellInfo)
  end
  self._bagInfo = NekoData.BehaviorManager.BM_BagInfo:GetItemListByPageIndex(self._selectPage)
  table.sort(self._bagInfo, function(a, b)
    if a:GetPinJiID() == b:GetPinJiID() then
      if a:GetRank() == b:GetRank() then
        return a:GetID() < b:GetID()
      else
        return a:GetRank() < b:GetRank()
      end
    else
      return a:GetPinJiID() > b:GetPinJiID()
    end
  end)
  for i, v in ipairs(self._bagInfo) do
    local celldata = {}
    celldata.item = v
    table.insert(self._cellInfo, celldata)
  end
  self:InsertEmptyCellData()
end

function BagDialog:InsertEmptyCellData()
  local curNum = #self._cellInfo
  local onePageNum = MinRowNum * ColumnsNum
  if curNum <= onePageNum then
    for i = curNum + 1, onePageNum do
      local celldata = {}
      celldata.item = nil
      table.insert(self._cellInfo, celldata)
    end
    return
  end
  local curRow = math.ceil(curNum / ColumnsNum)
  for i = curNum + 1, curRow * ColumnsNum do
    local celldata = {}
    celldata.item = nil
    table.insert(self._cellInfo, celldata)
  end
end

function BagDialog:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName == "bag.itemtipsdialog" then
    self._frame:FireEvent("ChangedSelected", nil)
  end
end

function BagDialog:NumberOfCell(frame)
  if frame == self._frame then
    return #self._cellInfo
  else
    return #CBagCurrencyShow:GetAllIds()
  end
end

function BagDialog:CellAtIndex(frame)
  if frame == self._frame then
    return "bag.bagcell"
  else
    return "bag.bagcurrencycell"
  end
end

function BagDialog:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._cellInfo[index]
  else
    local ids = CBagCurrencyShow:GetAllIds()
    return CBagCurrencyShow:GetRecorder(ids[index])
  end
end

function BagDialog:SetSelectedID(args)
  self._selectedID = args
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function BagDialog:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function BagDialog:OnBackBtnClicked()
  self:Destroy()
end

function BagDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function BagDialog:OnRefreshCurrency(notification)
  self._currencyFrame:ReloadAllCell()
end

function BagDialog:OnRemoveItem(protocol)
  for index, info in ipairs(self._cellInfo) do
    if info.item and info.item:GetKey() == protocol.itemKey then
      self._frame:RemoveCellsAtIndex({index})
      break
    end
  end
end

function BagDialog:OnModifyItemNum(protocol)
  for index, info in ipairs(self._cellInfo) do
    if info.item and info.item:GetKey() == protocol.itemKey then
      self._frame:FireIndexCellEvent("RefreshCell", index, info)
      break
    end
  end
end

function BagDialog:OnAddItem(protocol)
  if protocol.bagType ~= LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes").BAG then
    return
  end
  local bAdd = false
  for i, value in ipairs(protocol.data) do
    local item = Item.Create(value.id)
    if item:IsPageIndexShow(self._selectPage) then
      local itemInfo = {}
      itemInfo.id = value.id
      itemInfo.itemtype = value.itemtype
      itemInfo.key = value.key
      itemInfo.number = value.number
      item:InitWithFull(itemInfo)
      local emptyIndex = self:GetFirstEmptyCellIndex()
      if emptyIndex then
        self._cellInfo[emptyIndex].item = item
        local celldata = {}
        celldata.item = item
        self._frame:FireIndexCellEvent("RefreshCell", emptyIndex, celldata)
      else
        local celldata = {}
        celldata.item = item
        table.insert(self._cellInfo, item)
        bAdd = true
      end
    end
  end
  if bAdd then
    self:InsertEmptyCellData()
    self._frame:InsertCellsAtIndex({}, false)
  end
end

function BagDialog:GetFirstEmptyCellIndex()
  for index, info in ipairs(self._cellInfo) do
    if not info.item then
      return index
    end
  end
end

function BagDialog:OnResolveBtnClicked()
  self._bResoveMode = not self._bResoveMode
  self._frame:FireEvent("SetResoveModelState", self._bResoveMode)
  self._resolveBtn:SetSelected(self._bResoveMode)
end

function BagDialog:OnCurPosChange(frame, proportion)
  if frame == self._frame then
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
end

function BagDialog:IfInResolveMode()
  return self._bResoveMode
end

function BagDialog:IsBag()
  return true
end

return BagDialog
