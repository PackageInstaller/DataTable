-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/children/taskpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local CactivityTasks = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
local TaskPage = class("TaskPage", Dialog)
TaskPage.AssetBundleName = "ui/layouts.activitychildrensday"
TaskPage.AssetName = "ActivityChildrensDayTask"
TaskPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskPage, CactivityTasks
  ((TaskPage.super).Ctor)(self, ...)
  self._taskData = {}
  self._activityID = CactivityTasks.CHILDREN_DAY
end

TaskPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._staticTxt1 = self:GetChild("Txt")
  self._taskPanel = self:GetChild("FrameTask")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("NowNum")
  self._tipsBtn = self:GetChild("Tips")
  self._timeText = self:GetChild("EndTime")
  ;
  (self._timeText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1796))
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  ;
  (self._currencyIcon):Subscribe_PointerClickEvent(self.OnCurrencyIconClicked, self)
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, false, false, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self:SetStaticRes()
end

TaskPage.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, Item
  (self._staticTxt1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1632)).msgTextID))
  self._currencyItem = (Item.Create)(DataCommon.Cicada)
  ;
  (self._currencyIcon):SetSprite(((self._currencyItem):GetIcon()).assetBundle, ((self._currencyItem):GetIcon()).assetName)
end

TaskPage.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._taskFrame then
    (self._taskFrame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.children.childrentipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

TaskPage.Refresh = function(self)
  -- function num : 0_4
  self:RefreshCurrencyData()
  self:RefreshTaskData()
end

TaskPage.RefreshCurrencyData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local haveCicadaNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.Cicada)
  ;
  (self._currencyNum):SetText((NumberManager.GetShowNumber)(haveCicadaNum))
end

TaskPage.RefreshTaskData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetChildrenTasks()
  if allTasks then
    for _,value in pairs(allTasks) do
      (table.insert)(self._taskData, value)
    end
    ;
    (table.sort)(self._taskData, function(task1, task2)
    -- function num : 0_6_0
    do return task1:GetSortID() < task2:GetSortID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  ;
  (self._taskFrame):ReloadAllCell()
end

TaskPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._taskFrame then
    return "activity.children.taskcell"
  end
end

TaskPage.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  if frame == self._taskFrame then
    return #self._taskData
  end
end

TaskPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._taskFrame then
    return (self._taskData)[index]
  end
end

TaskPage.OnTipsBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, CStringRes
  local dialogName = "activity.children.childrentipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1794)).msgTextID)
  end
end

TaskPage.OnCurrencyIconClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._currencyItem})
  end
end

return TaskPage

