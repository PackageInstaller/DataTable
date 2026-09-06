local ActiveAwardDialog = class("ActiveAwardDialog", Dialog)
local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
ActiveAwardDialog.AssetBundleName = "ui/layouts.basetasklist"
ActiveAwardDialog.AssetName = "TaskActiveAwardShow"

function ActiveAwardDialog:Ctor(...)
  ActiveAwardDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ActiveAwardDialog:OnCreate()
  self._back = self:GetChild("Back2")
  self._board = self:GetChild("Back2/Frame")
  self._helper = TableFrame.Create(self._board, self, false, false)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function ActiveAwardDialog:OnDestroy()
  self._helper:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ActiveAwardDialog:SetData(data, state)
  if state == "week" then
    self._cfg = BeanManager.GetTableByName("mission.cweekmissionaward"):GetRecorder(data)
  else
    self._cfg = BeanManager.GetTableByName("mission.cdailymissionaward"):GetRecorder(data)
  end
  self._items = {}
  local award = Item.Create(self._cfg.awardid)
  award:SetCount(self._cfg.num)
  table.insert(self._items, award)
  self:Refresh()
end

function ActiveAwardDialog:OnItemClick(item)
  local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  tip:Init({
    item = item,
    num = item:GetCount()
  })
  local key = tip._dialogKey
  self._covered = true
  LuaNotificationCenter.AddObserver(self, function(observer, notification)
    if notification.userInfo._dialogKey == key then
      self._covered = false
      LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
    end
  end, Common.n_DialogWillDestroy, nil)
end

function ActiveAwardDialog:OnGlobalPointerDown(args)
  if not self._covered then
    local pos = args.userInfo.eventData.position
    if not UIManager.RectangleContainsScreenPoint(self._back:GetUIObject(), pos.x, pos.y) then
      self:OnBackBtnClicked()
    end
  end
end

function ActiveAwardDialog:OnBackBtnClicked()
  self:Destroy()
end

function ActiveAwardDialog:Refresh()
  self._helper:ReloadAllCell()
end

function ActiveAwardDialog:NumberOfCell(helper)
  return #self._items
end

function ActiveAwardDialog:CellAtIndex(helper, index)
  return "task.daily.activeawardcell"
end

function ActiveAwardDialog:DataAtIndex(helper, index)
  return self._items[index]
end

return ActiveAwardDialog
