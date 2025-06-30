-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ItemAccountCell = class("ItemAccountCell", Dialog)
ItemAccountCell.AssetBundleName = "ui/layouts.bag"
ItemAccountCell.AssetName = "ItemAccountCell"
ItemAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemAccountCell
  ((ItemAccountCell.super).Ctor)(self, ...)
end

ItemAccountCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._frame = (GridFrame.Create)(self:GetRootWindow(), self, true, 5, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

ItemAccountCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

ItemAccountCell.RefreshCell = function(self, dataList)
  -- function num : 0_3
  self._dataList = dataList
  ;
  (self._frame):ReloadAllCell()
end

ItemAccountCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._dataList
end

ItemAccountCell.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "bag.itemcell"
end

ItemAccountCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._dataList)[index]
end

ItemAccountCell.SetSelectedID = function(self, notification)
  -- function num : 0_7
  self._selectedID = notification
  ;
  (self._frame):FireEvent("SetItemSelectedState", self._selectedID)
end

ItemAccountCell.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_8
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._frame):FireEvent("SetItemSelectedState", nil)
  end
end

ItemAccountCell.SetNotSelect = function(self)
  -- function num : 0_9
  self._selectedID = nil
  ;
  (self._frame):FireEvent("SetItemSelectedState", self._selectedID)
end

return ItemAccountCell

