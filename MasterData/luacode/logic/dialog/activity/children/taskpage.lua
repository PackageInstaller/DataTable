local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local CactivityTasks = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
local TaskPage = class("TaskPage", Dialog)
TaskPage.AssetBundleName = "ui/layouts.activitychildrensday"
TaskPage.AssetName = "ActivityChildrensDayTask"

function TaskPage:Ctor(...)
  TaskPage.super.Ctor(self, ...)
  self._taskData = {}
  self._activityID = CactivityTasks.CHILDREN_DAY
end

function TaskPage:OnCreate()
  self._staticTxt1 = self:GetChild("Txt")
  self._taskPanel = self:GetChild("FrameTask")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._tipsBtn = self:GetChild("Tips")
  self._timeText = self:GetChild("EndTime")
  self._timeText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1796))
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._currencyIcon:Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._taskFrame = TableFrame.Create(self._taskPanel, self, false, false, false)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

function TaskPage:SetStaticRes()
  self._staticTxt1:SetText(TextManager.GetText(CStringRes:GetRecorder(1632).msgTextID))
  self._currencyItem = Item.Create(DataCommon.Cicada)
  self._currencyIcon:SetSprite(self._currencyItem:GetIcon().assetBundle, self._currencyItem:GetIcon().assetName)
end

function TaskPage:OnDestroy()
  if self._taskFrame then
    self._taskFrame:Destroy()
  end
  DialogManager.DestroySingletonDialog("activity.children.childrentipsdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function TaskPage:Refresh()
  self:RefreshCurrencyData()
  self:RefreshTaskData()
end

function TaskPage:RefreshCurrencyData()
  local haveCicadaNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.Cicada)
  self._currencyNum:SetText(NumberManager.GetShowNumber(haveCicadaNum))
end

function TaskPage:RefreshTaskData()
  for key, _ in pairs(self._taskData) do
    self._taskData[key] = nil
  end
  local allTasks = NekoData.BehaviorManager.BM_ActivityTasks:GetChildrenTasks()
  if allTasks then
    for _, value in pairs(allTasks) do
      table.insert(self._taskData, value)
    end
    table.sort(self._taskData, function(task1, task2)
      return task1:GetSortID() < task2:GetSortID()
    end)
  end
  self._taskFrame:ReloadAllCell()
end

function TaskPage:CellAtIndex(frame, index)
  if frame == self._taskFrame then
    return "activity.children.taskcell"
  end
end

function TaskPage:NumberOfCell(frame, index)
  if frame == self._taskFrame then
    return #self._taskData
  end
end

function TaskPage:DataAtIndex(frame, index)
  if frame == self._taskFrame then
    return self._taskData[index]
  end
end

function TaskPage:OnTipsBtnClicked()
  local dialogName = "activity.children.childrentipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1794).msgTextID)
  end
end

function TaskPage:OnCurrencyIconClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._currencyItem
    })
  end
end

return TaskPage
