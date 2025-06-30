-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/taskcellhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local TaskCellHelper = class("TaskCellHelper")
TaskCellHelper.Ctor = function(self, rootElement)
  -- function num : 0_0 , upvalues : TableFrame
  self._itemData = {}
  self._rootElement = rootElement
  self._cellTaskPanel = (self._rootElement):FindChild("CellTask")
  self._cellTaskFrame = (TableFrame.Create)(self._cellTaskPanel, self, false, false, false)
  self._progressNum = (self._rootElement):FindChild("TaskNum1")
  self._progressNumMax = (self._rootElement):FindChild("TaskNum2")
  self._getBtn = (self._rootElement):FindChild("GetBtn")
  self._goBtn = (self._rootElement):FindChild("GoBtn")
  self._taskBackNormal = (self._rootElement):FindChild("TaskBack")
  self._titleNormal = (self._rootElement):FindChild("TaskBack/Text")
  self._taskBackFinish = (self._rootElement):FindChild("TaskBackFinish")
  self._titleFinish = (self._rootElement):FindChild("TaskBackFinish/Text")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

TaskCellHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._cellTaskFrame then
    (self._cellTaskFrame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TaskCellHelper.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : TaskStatus
  self._task = data
  if self._task then
    (self._titleNormal):SetText((self._task):GetDesc())
    ;
    (self._titleFinish):SetText((self._task):GetDesc())
    ;
    (self._progressNum):SetText((((self._task):GetProgress())[1]).current)
    ;
    (self._progressNumMax):SetText((((self._task):GetProgress())[1]).total)
    if (self._task):GetStatus() == TaskStatus.PROCESSING then
      (self._goBtn):SetActive(true)
      ;
      (self._getBtn):SetActive(false)
      ;
      (self._taskBackNormal):SetActive(true)
      ;
      (self._taskBackFinish):SetActive(false)
      ;
      (self._titleNormal):SetActive(true)
      ;
      (self._titleFinish):SetActive(false)
    else
      if (self._task):GetStatus() == TaskStatus.FINISHED then
        (self._goBtn):SetActive(false)
        ;
        (self._getBtn):SetActive(true)
        ;
        (self._taskBackNormal):SetActive(false)
        ;
        (self._taskBackFinish):SetActive(true)
        ;
        (self._titleNormal):SetActive(false)
        ;
        (self._titleFinish):SetActive(true)
      else
        if (self._task):GetStatus() == TaskStatus.COMMITED then
          (self._goBtn):SetActive(false)
          ;
          (self._getBtn):SetActive(false)
          ;
          (self._taskBackNormal):SetActive(true)
          ;
          (self._taskBackFinish):SetActive(false)
          ;
          (self._titleNormal):SetActive(true)
          ;
          (self._titleFinish):SetActive(false)
        else
          ;
          (self._goBtn):SetActive(false)
          ;
          (self._getBtn):SetActive(false)
          ;
          (self._taskBackNormal):SetActive(true)
          ;
          (self._taskBackFinish):SetActive(false)
          ;
          (self._titleNormal):SetActive(true)
          ;
          (self._titleFinish):SetActive(false)
        end
      end
    end
    self._itemData = (self._task):GetAwards()
    ;
    (self._cellTaskFrame):ReloadAllCell()
  else
    ;
    (self._titleNormal):SetText("")
    ;
    (self._titleFinish):SetText("")
    ;
    (self._progressNum):SetText("")
    ;
    (self._progressNumMax):SetText("")
    ;
    (self._goBtn):SetActive(false)
    ;
    (self._getBtn):SetActive(false)
    ;
    (self._taskBackNormal):SetActive(true)
    ;
    (self._taskBackFinish):SetActive(false)
    ;
    (self._titleNormal):SetActive(true)
    ;
    (self._titleFinish):SetActive(false)
  end
end

TaskCellHelper.OnGoBtnClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):GetIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100410)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._task)
end

TaskCellHelper.OnGetBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, TasksProtocolDef
  if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):GetIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100410)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.DOUBLE_ELEVEN
    protocol.taskID = (self._task):GetID()
    protocol:Send()
  end
end

TaskCellHelper.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "activity.doubleeleven.taskitemcell"
end

TaskCellHelper.NumberOfCell = function(self, frame, index)
  -- function num : 0_6
  return #self._itemData
end

TaskCellHelper.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._itemData)[index]
end

return TaskCellHelper

