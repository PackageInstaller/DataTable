local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local MainTaskDialog = class("MainTaskDialog", Dialog)
local TableFrame = require("logic.dialog.task.tasktableframe")
MainTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
MainTaskDialog.AssetName = "TaskStoryNew"
local tm = NekoData.BehaviorManager.BM_Task

function MainTaskDialog:Ctor(...)
  MainTaskDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
  self._soulRefineGuideEffectHandler = nil
end

function MainTaskDialog:OnCreate()
  self._board = self:GetChild("CellFrame")
  self._soulRefineGuideEffect = self:GetChild("Effect")
  self._detailFrame = self:GetChild("DetailPanel")
  self._detail = DialogManager.CreateDialog("task.main.maintaskdetailframe", self._detailFrame._uiObject)
  LuaNotificationCenter.AddObserver(self, self.OnTaskRefresh, Common.n_RefreshTask, nil)
  self._steps = {}
  self._running = false
  self:SetData()
  UIBackManager.SwitchToNext()
end

function MainTaskDialog:OnDestroy()
  if self._helper then
    self._helper:Destroy()
  end
  if self._detail then
    self._detail:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
  local ids = {}
  for _, v in pairs(tm:GetTasksByGroup(1)) do
    ids[#ids + 1] = v:GetID()
  end
  tm:MarkShownTasks(ids)
  if self._removeTimer then
    self._removeTimer = GameTimer.RemoveTask(self._removeTimer)
  end
  if self._tweenTimer then
    self._tweenTimer = GameTimer.RemoveTask(self._tweenTimer)
  end
  if self._refreshTimer then
    self._refreshTimer = GameTimer.RemoveTask(self._refreshTimer)
  end
end

function MainTaskDialog:SetData()
  self._helper = TableFrame.Create(nil, self._board, self, true, true, "ViewportSoftMask")
  self._helper:SetMargin(20, 20)
  self._tasks = tm:GetTasksByGroup(1)
  if table.nums(self._tasks) == 0 then
    self._detailFrame:SetActive(false)
    return
  end
  self._selected = self._tasks[1]:GetID()
  self:Refresh()
  self._helper:MoveToTop(false)
  self:OnCellClick(self._selected)
end

function MainTaskDialog:Refresh()
  tm:Cleanup()
  self._tasks = tm:GetTasksByGroup(1)
  self._helper:ReloadAllCell()
  self._detail:RefreshCell(tm:GetTask(self._selected), self)
  self:OnCellClick(self._selected)
end

function MainTaskDialog:OnTaskRefresh(notification)
  local task = notification.userInfo
  if task:GetGroupID() ~= 1 then
    return
  end
  if not task or task:GetStatus() == 1 then
    self:AddStep("remove", task)
  else
    for i, v in pairs(self._tasks) do
      if v:GetID() == task:GetID() then
        self:AddStep("refresh", task)
        return
      end
    end
    self:AddStep("add", task)
  end
end

function MainTaskDialog:AddStep(type, data)
  self._steps[#self._steps + 1] = {type = type, data = data}
  if not self._running then
    self:NextStep()
  end
end

function MainTaskDialog:NextStep()
  local step = self._steps[1]
  if not step then
    self._committed = false
    self._running = false
    return
  end
  self._running = true
  if step.type == "add" then
    local tasks = tm:GetTasksByGroup(1)
    local index
    for i, v in ipairs(tasks) do
      if v:GetID() == step.data:GetID() then
        index = i
        break
      end
    end
    assert(index, "new task not in list: " .. step.data:GetID())
    self._tasks = tasks
    self._helper:InsertCellsAtIndex({index}, true)
  elseif step.type == "refresh" then
    self._selected = step.data:GetID()
    self:Refresh()
    self._refreshTimer = GameTimer.AddTask(0.5, 0, function()
      self._refreshTimer = nil
      self:NextStep()
    end)
  elseif step.type == "remove" then
    local id = step.data:GetID()
    local canView
    for i, v in ipairs(self._tasks) do
      local logicCell = self._helper._logicCells[i]
      if logicCell and logicCell._visible and v:GetID() == id then
        canView = true
        break
      end
    end
    if canView then
      self._helper:FireEvent("remove", id)
    else
      self:OnCellFinish(id)
      self._removeTimer = GameTimer.AddTask(0.5, 0, function()
        self._removeTimer = nil
        self:NextStep()
      end)
    end
    local target
    for i, v in ipairs(self._tasks) do
      if v:GetID() ~= id then
        target = v:GetID()
        break
      end
    end
    if table.nums(self._tasks) == 0 or not target then
      self._detailFrame:SetActive(false)
    else
      self:OnCellClick(target)
    end
  end
  table.remove(self._steps, 1)
end

function MainTaskDialog:OnCellClick(id)
  self._selected = id
  self._helper:FireEvent("select", id)
  self._detail:RefreshCell(tm:GetTask(id), self)
end

function MainTaskDialog:OnCellFinish(id)
  for i, v in ipairs(self._tasks) do
    if v:GetID() == id then
      self._helper:RemoveCellsAtIndex({i}, true)
      table.remove(self._tasks, i)
      break
    end
  end
end

function MainTaskDialog:OnCommitClick(id)
  if not self._committed then
    tm:TryCommitTask(id)
    self._committed = true
  end
end

function MainTaskDialog:NumberOfCell(helper)
  return table.nums(self._tasks)
end

function MainTaskDialog:CellAtIndex(helper, index)
  return "task.main.maintaskcell"
end

function MainTaskDialog:DataAtIndex(helper, index)
  return self._tasks[index]
end

function MainTaskDialog:OnCurPosChange()
  if table.nums(self._tasks) ~= 0 then
    self:OnCellClick(self._selected)
  end
end

function MainTaskDialog:RemoveTweenParamsAtIndex(index)
  return 0.5, "linear"
end

function MainTaskDialog:InsertTweenParamsAtIndex(index)
  return 0.5, "linear"
end

function MainTaskDialog:OnRemoveTweenFinish(index)
  self._removeTimer = GameTimer.AddTask(0.5, 0, function()
    self._removeTimer = nil
    self:NextStep()
  end)
end

function MainTaskDialog:OnInsertTweenFinish(index)
  self._tweenTimer = GameTimer.AddTask(0.5, 0, function()
    self._tweenTimer = nil
    self:NextStep()
  end)
end

return MainTaskDialog
