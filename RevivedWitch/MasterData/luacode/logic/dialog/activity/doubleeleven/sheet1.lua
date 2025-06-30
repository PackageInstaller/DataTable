-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/sheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local TaskCellHelper = require("logic.dialog.activity.doubleeleven.taskcellhelper")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local sortHelper = {[TaskStatus.FINISHED] = 1, [TaskStatus.PROCESSING] = 2, [TaskStatus.COMMITED] = 3}
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activityeleven"
Sheet1.AssetName = "ActivityElevenTask"
Sheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet1
  ((Sheet1.super).Ctor)(self, ...)
  self._taskData = {}
end

Sheet1.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TaskCellHelper, TableFrame, _ENV
  self._uiTips1 = self:GetChild("UITips1")
  self._uiTips2 = self:GetChild("UITips2")
  self._uiTips3 = self:GetChild("UITips3")
  self._activeTime = self:GetChild("ActiveTime")
  self._tipsBtn = self:GetChild("Tips")
  self._taskPanel = self:GetChild("FrameTask")
  self._activityElevenTaskCell = self:GetChild("ActivityElevenTaskCell")
  self._taskCellhelper = (TaskCellHelper.Create)(self._activityElevenTaskCell)
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, function(_, notification)
    -- function num : 0_1_0 , upvalues : self
    self:RefreshTaskData(notification, false)
  end
, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function(_, notification)
    -- function num : 0_1_1 , upvalues : self
    self:RefreshTaskData(notification, true)
  end
, Common.n_OnSRefreshActivityTask, nil)
  self:SetStaticRes()
end

Sheet1.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._uiTips1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1645)).msgTextID))
  ;
  (self._uiTips2):SetText((TextManager.GetText)((CStringRes:GetRecorder(1642)).msgTextID))
  ;
  (self._uiTips3):SetText((TextManager.GetText)((CStringRes:GetRecorder(1640)).msgTextID))
  ;
  (self._activeTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1641)).msgTextID))
end

Sheet1.OnDestroy = function(self)
  -- function num : 0_3
  if self._taskCellhelper then
    (self._taskCellhelper):OnDestroy()
  end
  if self._taskFrame then
    (self._taskFrame):Destroy()
  end
end

Sheet1.SetData = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self._activityIDForTask = (self._bm):SendGetTasksProtocol()
  self:RefreshTaskData({
userInfo = {activityID = self._activityIDForTask}
})
end

Sheet1.RefreshTaskData = function(self, notification, refresh)
  -- function num : 0_5 , upvalues : _ENV, sortHelper
  if (notification.userInfo).activityID ~= self._activityIDForTask then
    return 
  end
  self._firstTask = nil
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R8 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetDoubleElevenTasks()
  if allTasks then
    for _,value in pairs(allTasks) do
      if (value:GetConfig()).refreshType == 1 then
        self._firstTask = value
      else
        ;
        (table.insert)(self._taskData, value)
      end
    end
    ;
    (table.sort)(self._taskData, function(taskA, taskB)
    -- function num : 0_5_0 , upvalues : sortHelper
    local sortIdA1 = sortHelper[taskA:GetStatus()]
    local sortIdB1 = sortHelper[taskB:GetStatus()]
    if sortIdA1 == nil then
      sortIdA1 = 99
    end
    if sortIdB1 == nil then
      sortIdB1 = 99
    end
    local sortIdA2 = taskA:GetSortID()
    local sortIdB2 = taskB:GetSortID()
    if sortIdA2 >= sortIdB2 then
      do return sortIdA1 ~= sortIdB1 end
      do return sortIdA1 < sortIdB1 end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
  if self._taskCellhelper then
    (self._taskCellhelper):RefreshCell(self._firstTask)
  end
  ;
  (self._taskFrame):ReloadAllCell()
  ;
  (self._taskFrame):MoveToTop()
end

Sheet1.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.doubleeleven.taskcell"
end

Sheet1.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  return #self._taskData
end

Sheet1.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._taskData)[index]
end

Sheet1.OnTipsBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  local dialogName = "activity.doubleeleven.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1643)).msgTextID, (CStringRes:GetRecorder(1644)).msgTextID)
  end
end

return Sheet1

