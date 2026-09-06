local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local TaskCfg = BeanManager.GetTableByName("mission.cbpdailytaskconfig")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local KillBossTaskDialog = class("KillBossTaskDialog", Dialog)
KillBossTaskDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossTaskDialog.AssetName = "BattlePassNewTask"

function KillBossTaskDialog:Ctor(...)
  KillBossTaskDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function KillBossTaskDialog:OnCreate()
  self._titleText = self:GetChild("Back/Title")
  self._titleText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1948))
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskList, Common.n_NewDreamSpiralTaskRefresh, nil)
end

function KillBossTaskDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function KillBossTaskDialog:Init()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(66, 3) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(66)
  end
  self:RefreshTaskList()
end

function KillBossTaskDialog:RefreshTaskList()
  self._tasks = {}
  local tasks = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetDreamDelegateTasks()
  for _, data in pairs(tasks) do
    local items = {}
    local temptable = {}
    local cfg = TaskCfg:GetRecorder(data.taskid)
    table.insert(self._tasks, {task = data, cfg = cfg})
  end
  table.sort(self._tasks, function(a, b)
    local _, x = math.modf(a.task.taskstatus / 3)
    local _, y = math.modf(b.task.taskstatus / 3)
    if x == y then
      if a.task.taskstatus == b.task.taskstatus then
        return a.task.taskid < b.task.taskid
      else
        return a.task.taskstatus > b.task.taskstatus
      end
    else
      return x < y
    end
  end)
  local moveToIdx = 0
  for k, v in ipairs(self._tasks) do
    if v.task.taskstatus == TaskStatus.FINISHED then
      moveToIdx = k
      break
    end
  end
  self._frame:ReloadAllCell()
  if moveToIdx ~= 0 then
    self._frame:MoveTopToIndex(moveToIdx)
  else
    self._frame:MoveToTop()
  end
end

function KillBossTaskDialog:OnBackBtnClicked()
  self:Destroy()
end

function KillBossTaskDialog:NumberOfCell(frame)
  return #self._tasks
end

function KillBossTaskDialog:CellAtIndex(frame, index)
  return "activity.giftoftime.killbosstaskcell"
end

function KillBossTaskDialog:DataAtIndex(frame, index)
  return self._tasks[index]
end

function KillBossTaskDialog:OnCommitClick(taskid)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommittask")
  protocol.taskid = taskid
  protocol:Send()
end

return KillBossTaskDialog
