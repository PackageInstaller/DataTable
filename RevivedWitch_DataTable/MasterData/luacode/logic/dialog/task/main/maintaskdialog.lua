-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/main/maintaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local MainTaskDialog = class("MainTaskDialog", Dialog)
local TableFrame = require("logic.dialog.task.tasktableframe")
MainTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
MainTaskDialog.AssetName = "TaskStoryNew"
local tm = (NekoData.BehaviorManager).BM_Task
MainTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainTaskDialog
  ((MainTaskDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._soulRefineGuideEffectHandler = nil
end

MainTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._board = self:GetChild("CellFrame")
  self._soulRefineGuideEffect = self:GetChild("Effect")
  self._detailFrame = self:GetChild("DetailPanel")
  self._detail = (DialogManager.CreateDialog)("task.main.maintaskdetailframe", (self._detailFrame)._uiObject)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTaskRefresh, Common.n_RefreshTask, nil)
  self._steps = {}
  self._running = false
  self:SetData()
  ;
  (UIBackManager.SwitchToNext)()
end

MainTaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, tm
  if self._helper then
    (self._helper):Destroy()
  end
  if self._detail then
    (self._detail):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  local ids = {}
  for _,v in pairs(tm:GetTasksByGroup(1)) do
    ids[#ids + 1] = v:GetID()
  end
  tm:MarkShownTasks(ids)
  if self._removeTimer then
    self._removeTimer = (GameTimer.RemoveTask)(self._removeTimer)
  end
  if self._tweenTimer then
    self._tweenTimer = (GameTimer.RemoveTask)(self._tweenTimer)
  end
  if self._refreshTimer then
    self._refreshTimer = (GameTimer.RemoveTask)(self._refreshTimer)
  end
end

MainTaskDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : TableFrame, tm, _ENV
  self._helper = (TableFrame.Create)(nil, self._board, self, true, true, "ViewportSoftMask")
  ;
  (self._helper):SetMargin(20, 20)
  self._tasks = tm:GetTasksByGroup(1)
  if (table.nums)(self._tasks) == 0 then
    (self._detailFrame):SetActive(false)
    return 
  end
  self._selected = ((self._tasks)[1]):GetID()
  self:Refresh()
  ;
  (self._helper):MoveToTop(false)
  self:OnCellClick(self._selected)
end

MainTaskDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : tm
  tm:Cleanup()
  self._tasks = tm:GetTasksByGroup(1)
  ;
  (self._helper):ReloadAllCell()
  ;
  (self._detail):RefreshCell(tm:GetTask(self._selected), self)
  self:OnCellClick(self._selected)
end

MainTaskDialog.OnTaskRefresh = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local task = notification.userInfo
  if task:GetGroupID() ~= 1 then
    return 
  end
  if not task or task:GetStatus() == 1 then
    self:AddStep("remove", task)
  else
    for i,v in pairs(self._tasks) do
      if v:GetID() == task:GetID() then
        self:AddStep("refresh", task)
        return 
      end
    end
    self:AddStep("add", task)
  end
end

MainTaskDialog.AddStep = function(self, type, data)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  (self._steps)[#self._steps + 1] = {type = type, data = data}
  if not self._running then
    self:NextStep()
  end
end

MainTaskDialog.NextStep = function(self)
  -- function num : 0_7 , upvalues : tm, _ENV
  local step = (self._steps)[1]
  if not step then
    self._committed = false
    self._running = false
    return 
  end
  self._running = true
  if step.type == "add" then
    local tasks = (tm:GetTasksByGroup(1))
    -- DECOMPILER ERROR at PC15: Overwrote pending register: R3 in 'AssignReg'

    local index = .end
    for i,v in ipairs(tasks) do
      if v:GetID() == (step.data):GetID() then
        index = i
        break
      end
    end
    do
      do
        assert(index, "new task not in list: " .. (step.data):GetID())
        self._tasks = tasks
        ;
        (self._helper):InsertCellsAtIndex({index}, true)
        if step.type == "refresh" then
          self._selected = (step.data):GetID()
          self:Refresh()
          self._refreshTimer = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_7_0 , upvalues : self
    self._refreshTimer = nil
    self:NextStep()
  end
)
        else
          if step.type == "remove" then
            local id = ((step.data):GetID())
            -- DECOMPILER ERROR at PC71: Overwrote pending register: R3 in 'AssignReg'

            local canView = .end
            for i,v in ipairs(self._tasks) do
              local logicCell = ((self._helper)._logicCells)[i]
              if logicCell and logicCell._visible and v:GetID() == id then
                canView = true
                break
              end
            end
            do
              if canView then
                (self._helper):FireEvent("remove", id)
              else
                self:OnCellFinish(id)
                self._removeTimer = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_7_1 , upvalues : self
    self._removeTimer = nil
    self:NextStep()
  end
)
              end
              local target = nil
              for i,v in ipairs(self._tasks) do
                if v:GetID() ~= id then
                  target = v:GetID()
                  break
                end
              end
              do
                do
                  if (table.nums)(self._tasks) == 0 or not target then
                    (self._detailFrame):SetActive(false)
                  else
                    self:OnCellClick(target)
                  end
                  ;
                  (table.remove)(self._steps, 1)
                end
              end
            end
          end
        end
      end
    end
  end
end

MainTaskDialog.OnCellClick = function(self, id)
  -- function num : 0_8 , upvalues : tm
  self._selected = id
  ;
  (self._helper):FireEvent("select", id)
  ;
  (self._detail):RefreshCell(tm:GetTask(id), self)
end

MainTaskDialog.OnCellFinish = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in ipairs(self._tasks) do
    if v:GetID() == id then
      (self._helper):RemoveCellsAtIndex({i}, true)
      ;
      (table.remove)(self._tasks, i)
      break
    end
  end
end

MainTaskDialog.OnCommitClick = function(self, id)
  -- function num : 0_10 , upvalues : tm
  if not self._committed then
    tm:TryCommitTask(id)
    self._committed = true
  end
end

MainTaskDialog.NumberOfCell = function(self, helper)
  -- function num : 0_11 , upvalues : _ENV
  return (table.nums)(self._tasks)
end

MainTaskDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  return "task.main.maintaskcell"
end

MainTaskDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  return (self._tasks)[index]
end

MainTaskDialog.OnCurPosChange = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if (table.nums)(self._tasks) ~= 0 then
    self:OnCellClick(self._selected)
  end
end

MainTaskDialog.RemoveTweenParamsAtIndex = function(self, index)
  -- function num : 0_15
  return 0.5, "linear"
end

MainTaskDialog.InsertTweenParamsAtIndex = function(self, index)
  -- function num : 0_16
  return 0.5, "linear"
end

MainTaskDialog.OnRemoveTweenFinish = function(self, index)
  -- function num : 0_17 , upvalues : _ENV
  self._removeTimer = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_17_0 , upvalues : self
    self._removeTimer = nil
    self:NextStep()
  end
)
end

MainTaskDialog.OnInsertTweenFinish = function(self, index)
  -- function num : 0_18 , upvalues : _ENV
  self._tweenTimer = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_18_0 , upvalues : self
    self._tweenTimer = nil
    self:NextStep()
  end
)
end

return MainTaskDialog

