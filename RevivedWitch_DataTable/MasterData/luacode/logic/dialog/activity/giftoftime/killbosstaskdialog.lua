-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbosstaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local TaskCfg = (BeanManager.GetTableByName)("mission.cbpdailytaskconfig")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local KillBossTaskDialog = class("KillBossTaskDialog", Dialog)
KillBossTaskDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossTaskDialog.AssetName = "BattlePassNewTask"
KillBossTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossTaskDialog
  ((KillBossTaskDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

KillBossTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._titleText = self:GetChild("Back/Title")
  ;
  (self._titleText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1948))
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskList, Common.n_NewDreamSpiralTaskRefresh, nil)
end

KillBossTaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

KillBossTaskDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(66, 3) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(66)
  end
  self:RefreshTaskList()
end

KillBossTaskDialog.RefreshTaskList = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskCfg, TaskStatus
  self._tasks = {}
  local tasks = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetDreamDelegateTasks()
  for _,data in pairs(tasks) do
    local items = {}
    local temptable = {}
    local cfg = TaskCfg:GetRecorder(data.taskid)
    ;
    (table.insert)(self._tasks, {task = data, cfg = cfg})
  end
  ;
  (table.sort)(self._tasks, function(a, b)
    -- function num : 0_4_0 , upvalues : _ENV
    local _, x = (math.modf)((a.task).taskstatus / 3)
    local _, y = (math.modf)((b.task).taskstatus / 3)
    if (a.task).taskstatus == (b.task).taskstatus then
      if (a.task).taskid >= (b.task).taskid then
        do return x ~= y end
        do return (b.task).taskstatus < (a.task).taskstatus end
        do return x < y end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  local moveToIdx = 0
  for k,v in ipairs(self._tasks) do
    if (v.task).taskstatus == TaskStatus.FINISHED then
      moveToIdx = k
      break
    end
  end
  do
    ;
    (self._frame):ReloadAllCell()
    if moveToIdx ~= 0 then
      (self._frame):MoveTopToIndex(moveToIdx)
    else
      ;
      (self._frame):MoveToTop()
    end
  end
end

KillBossTaskDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

KillBossTaskDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._tasks
end

KillBossTaskDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.giftoftime.killbosstaskcell"
end

KillBossTaskDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._tasks)[index]
end

KillBossTaskDialog.OnCommitClick = function(self, taskid)
  -- function num : 0_9 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommittask")
  protocol.taskid = taskid
  protocol:Send()
end

return KillBossTaskDialog

