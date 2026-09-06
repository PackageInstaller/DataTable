local GridFrame = require("framework.ui.frame.grid.gridframe")
local ValuableBagTabCell = class("ValuableBagTabCell", Dialog)
ValuableBagTabCell.AssetBundleName = "ui/layouts.bag"
ValuableBagTabCell.AssetName = "ValuableBagMain"
local ColumnsNum = 8
local MinRowNum = 4
local BottomToTop = 3

function ValuableBagTabCell:Ctor(...)
  ValuableBagTabCell.super.Ctor(self, ...)
  self._taskBagInfo = {}
  self._cellInfo = {}
  self._selectedID = nil
end

function ValuableBagTabCell:OnCreate()
  self._itemFrame = self:GetChild("ItemFrame")
  self._scrollBar = self:GetChild("Scrollbar")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._frame = GridFrame.Create(self._itemFrame, self, true, ColumnsNum)
  self._frame:SetMargin(15, 0)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ItemNumModify, nil)
  self:Init()
end

function ValuableBagTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("bag.itemresolvedialog")
end

function ValuableBagTabCell:Refresh()
  self:LoadValuableBagData()
  self._frame:ReloadAllCell()
end

function ValuableBagTabCell:LoadValuableBagData()
  self._cellInfo = {}
  self._taskBagInfo = NekoData.BehaviorManager.BM_BagInfo:GetValuableBagList()
  table.sort(self._taskBagInfo, function(a, b)
    return a:GetRank() < b:GetRank()
  end)
  for i, v in ipairs(self._taskBagInfo) do
    local celldata = {}
    celldata.item = v
    table.insert(self._cellInfo, celldata)
  end
  self:InsertEmptyCellData()
end

function ValuableBagTabCell:InsertEmptyCellData()
  local num = #self._cellInfo
  if num < MinRowNum * ColumnsNum then
    while num < MinRowNum * ColumnsNum do
      table.insert(self._cellInfo, {})
      num = #self._cellInfo
    end
  elseif num % ColumnsNum ~= 0 then
    while num % ColumnsNum ~= 0 do
      table.insert(self._cellInfo, {})
      num = #self._cellInfo
    end
  end
end

function ValuableBagTabCell:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName == "bag.itemtipsdialog" then
    self._frame:FireEvent("ChangedSelected", nil)
  end
end

function ValuableBagTabCell:NumberOfCell(frame)
  return #self._cellInfo
end

function ValuableBagTabCell:CellAtIndex(frame)
  return "bag.bagcell"
end

function ValuableBagTabCell:DataAtIndex(frame, index)
  return self._cellInfo[index]
end

function ValuableBagTabCell:SetSelectedID(args)
  self._selectedID = args
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function ValuableBagTabCell:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function ValuableBagTabCell:Init()
  self:LoadValuableBagData()
  self._frame:ReloadAllCell()
end

function ValuableBagTabCell:OnBackBtnClicked()
  self:Destroy()
end

function ValuableBagTabCell:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ValuableBagTabCell:OnCurPosChange(frame, proportion)
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

return ValuableBagTabCell
