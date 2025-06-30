-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/daily/activeawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ActiveAwardDialog = class("ActiveAwardDialog", Dialog)
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
ActiveAwardDialog.AssetBundleName = "ui/layouts.basetasklist"
ActiveAwardDialog.AssetName = "TaskActiveAwardShow"
ActiveAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActiveAwardDialog
  ((ActiveAwardDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ActiveAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back2")
  self._board = self:GetChild("Back2/Frame")
  self._helper = (TableFrame.Create)(self._board, self, false, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

ActiveAwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._helper):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

ActiveAwardDialog.SetData = function(self, data, state)
  -- function num : 0_3 , upvalues : _ENV, Item
  if state == "week" then
    self._cfg = ((BeanManager.GetTableByName)("mission.cweekmissionaward")):GetRecorder(data)
  else
    self._cfg = ((BeanManager.GetTableByName)("mission.cdailymissionaward")):GetRecorder(data)
  end
  self._items = {}
  local award = (Item.Create)((self._cfg).awardid)
  award:SetCount((self._cfg).num)
  ;
  (table.insert)(self._items, award)
  self:Refresh()
end

ActiveAwardDialog.OnItemClick = function(self, item)
  -- function num : 0_4 , upvalues : _ENV
  local tip = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  tip:Init({item = item, num = item:GetCount()})
  local key = tip._dialogKey
  self._covered = true
  ;
  (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
    -- function num : 0_4_0 , upvalues : key, self, _ENV
    if (notification.userInfo)._dialogKey == key then
      self._covered = false
      ;
      (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
    end
  end
, Common.n_DialogWillDestroy, nil)
end

ActiveAwardDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not self._covered then
    local pos = ((args.userInfo).eventData).position
    if not (UIManager.RectangleContainsScreenPoint)((self._back):GetUIObject(), pos.x, pos.y) then
      self:OnBackBtnClicked()
    end
  end
end

ActiveAwardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

ActiveAwardDialog.Refresh = function(self)
  -- function num : 0_7
  (self._helper):ReloadAllCell()
end

ActiveAwardDialog.NumberOfCell = function(self, helper)
  -- function num : 0_8
  return #self._items
end

ActiveAwardDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_9
  return "task.daily.activeawardcell"
end

ActiveAwardDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_10
  return (self._items)[index]
end

return ActiveAwardDialog

