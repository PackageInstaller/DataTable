local GridFrame = require("framework.ui.frame.grid.gridframe")
local ItemAccountCell = class("ItemAccountCell", Dialog)
ItemAccountCell.AssetBundleName = "ui/layouts.bag"
ItemAccountCell.AssetName = "ItemAccountCell"

function ItemAccountCell:Ctor(...)
  ItemAccountCell.super.Ctor(self, ...)
end

function ItemAccountCell:OnCreate()
  self._frame = GridFrame.Create(self:GetRootWindow(), self, true, 5, false)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

function ItemAccountCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function ItemAccountCell:RefreshCell(dataList)
  self._dataList = dataList
  self._frame:ReloadAllCell()
end

function ItemAccountCell:NumberOfCell(frame)
  return #self._dataList
end

function ItemAccountCell:CellAtIndex(frame)
  return "bag.itemcell"
end

function ItemAccountCell:DataAtIndex(frame, index)
  return self._dataList[index]
end

function ItemAccountCell:SetSelectedID(notification)
  self._selectedID = notification
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

function ItemAccountCell:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._frame:FireEvent("SetItemSelectedState", nil)
  end
end

function ItemAccountCell:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("SetItemSelectedState", self._selectedID)
end

return ItemAccountCell
