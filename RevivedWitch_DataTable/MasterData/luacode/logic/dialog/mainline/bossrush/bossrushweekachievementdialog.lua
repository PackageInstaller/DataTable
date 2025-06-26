-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekachievementdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CWeeklyBossAchieveMissionConfig = (BeanManager.GetTableByName)("dungeonselect.cweeklybossachievemissionconfig")
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local filterEnum = {"all", "achieve", "notAchieve"}
local BossRushWeekTaskType = 16
local BossRushWeekAchievementDialog = class("BossRushWeekAchievementDialog", Dialog)
BossRushWeekAchievementDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekAchievementDialog.AssetName = "BossRushWeekAchievement"
BossRushWeekAchievementDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekAchievementDialog
  ((BossRushWeekAchievementDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._init = false
  self._filterType = "all"
end

BossRushWeekAchievementDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, _ENV, filterEnum, TableFrame
  self._scrollBar = self:GetChild("Back2/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back2/Frame")
  self._filterBtns = {}
  for i,v in ipairs(filterEnum) do
    do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

      (self._filterBtns)[v] = self:GetChild("Back2/ToggleGroup/_Toggle_" .. tostring(i - 1))
      ;
      ((self._filterBtns)[v]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, v
    self:OnValueChanged(v)
  end
)
    end
  end
  self._titleTxt = self:GetChild("Back2/TitleBack/Title")
  self._closeBtn = self:GetChild("Back2/CloseBtn")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTask, Common.n_RefreshTask, nil)
  self._width = (self._panel):GetRectSize()
  self:Init()
end

BossRushWeekAchievementDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

BossRushWeekAchievementDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._titleTxt):SetText((TextManager.GetText)(1901562))
  self:RefreshTask()
end

BossRushWeekAchievementDialog.OnCloseBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BossRushWeekAchievementDialog.RefreshTask = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, BossRushWeekTaskType, Status, CWeeklyBossAchieveMissionConfig, filterEnum
  self._allTaskList = ((NekoData.BehaviorManager).BM_Task):GetTasksByType(BossRushWeekTaskType)
  if notification then
    local task = notification.userInfo
    for _,v in pairs(self._allTaskList) do
      if v:GetID() == task:GetID() and v:GetStatus() == Status.FINISHED and task:GetStatus() == Status.PROCESSING then
        return 
      end
    end
  end
  do
    local taskMap = {}
    local finishTaskNum = 0
    local taskTotalNum = 0
    for i,v in ipairs(self._allTaskList) do
      local id = v:GetID()
      local record = CWeeklyBossAchieveMissionConfig:GetRecorder(id)
      if not taskMap[record.groupID] then
        taskMap[record.groupID] = {}
      end
      ;
      (table.insert)(taskMap[record.groupID], v)
      if v:GetStatus() == Status.COMMITED then
        finishTaskNum = finishTaskNum + 1
      end
      taskTotalNum = taskTotalNum + 1
    end
    for groupId,taskList in pairs(taskMap) do
      (table.sort)(taskList, function(a, b)
    -- function num : 0_5_0
    local a_taskId, b_taskId = a:GetID(), b:GetID()
    do return a_taskId < b_taskId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      local firstUnachieveIndex = nil
      for i,v in ipairs(taskList) do
        local status = v:GetStatus()
        if status ~= Status.COMMITED then
          firstUnachieveIndex = i
          break
        end
      end
      do
        do
          while 1 do
            while firstUnachieveIndex and taskList[#taskList] and firstUnachieveIndex < #taskList do
              (table.remove)(taskList, #taskList)
            end
            break
          end
          -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    self._mainTaskMap = {}
    for k,type in pairs(filterEnum) do
      -- DECOMPILER ERROR at PC118: Confused about usage of register: R10 in 'UnsetPending'

      (self._mainTaskMap)[type] = {}
    end
    local sortedTaskList = {}
    for groupId,taskList in pairs(taskMap) do
      (table.insert)(sortedTaskList, {gid = groupId, tlist = taskList})
    end
    ;
    (table.sort)(sortedTaskList, function(a, b)
    -- function num : 0_5_1
    do return a.gid < b.gid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for _,outValue in ipairs(sortedTaskList) do
      taskList = outValue.tlist
      for i,v in ipairs(taskList) do
        (table.insert)((self._mainTaskMap).all, {gid = outValue.gid, task = v})
        local status = v:GetStatus()
        if status ~= Status.COMMITED then
          (table.insert)((self._mainTaskMap).notAchieve, {gid = outValue.gid, task = v})
        else
          ;
          (table.insert)((self._mainTaskMap).achieve, {gid = outValue.gid, task = v})
        end
      end
    end
    for k,type in pairs(filterEnum) do
      (table.sort)((self._mainTaskMap)[type], function(a, b)
    -- function num : 0_5_2 , upvalues : _ENV
    local _, x = (math.modf)((a.task):GetStatus() / 3)
    local _, y = (math.modf)((b.task):GetStatus() / 3)
    if (a.task):GetStatus() == (b.task):GetStatus() then
      if a.gid == b.gid then
        if (a.task):GetID() >= (b.task):GetID() then
          do return x ~= y end
          do return a.gid < b.gid end
          do return (b.task):GetStatus() < (a.task):GetStatus() end
          do return x < y end
          -- DECOMPILER ERROR: 8 unprocessed JMP targets
        end
      end
    end
  end
)
      local list = (self._mainTaskMap)[type]
      if type == "all" then
        local finishedList = {}
        local commitedList = {}
        local otherList = {}
        for i,v in ipairs(list) do
          if (v.task):GetStatus() == Status.FINISHED then
            (table.insert)(finishedList, v)
          else
            if (v.task):GetStatus() == Status.COMMITED then
              (table.insert)(commitedList, v)
            else
              ;
              (table.insert)(otherList, v)
            end
          end
        end
        ;
        (table.sort)(finishedList, function(a, b)
    -- function num : 0_5_3
    if (a.task):GetID() >= (b.task):GetID() then
      do return a.gid ~= b.gid end
      do return a.gid < b.gid end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
        ;
        (table.sort)(commitedList, function(a, b)
    -- function num : 0_5_4
    if (a.task):GetID() >= (b.task):GetID() then
      do return a.gid ~= b.gid end
      do return a.gid < b.gid end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
        ;
        (table.sort)(otherList, function(a, b)
    -- function num : 0_5_5
    local a_status, b_status = (a.task):GetStatus(), (b.task):GetStatus()
    if a.gid == b.gid then
      if (a.task):GetID() >= (b.task):GetID() then
        do return a_status ~= b_status end
        do return a.gid < b.gid end
        do return (a.task):GetStatus() < (b.task):GetStatus() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
        while list[#list] do
          (table.remove)(list, #list)
        end
        for i,v in ipairs(finishedList) do
          (table.insert)(list, v)
        end
        for i,v in ipairs(otherList) do
          (table.insert)(list, v)
        end
        for i,v in ipairs(commitedList) do
          (table.insert)(list, v)
        end
      else
        do
          do
            if type == "achieve" then
              (table.sort)(list, function(a, b)
    -- function num : 0_5_6
    if (a.task):GetID() >= (b.task):GetID() then
      do return a.gid ~= b.gid end
      do return a.gid < b.gid end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
            else
              if type == "notAchieve" then
                (table.sort)(list, function(a, b)
    -- function num : 0_5_7
    local a_status, b_status = (a.task):GetStatus(), (b.task):GetStatus()
    if a.gid == b.gid then
      if (a.task):GetID() >= (b.task):GetID() then
        do return a_status ~= b_status end
        do return a.gid < b.gid end
        do return (a.task):GetStatus() < (b.task):GetStatus() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
              end
            end
            -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC313: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    self._data = (self._mainTaskMap).all
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

BossRushWeekAchievementDialog.OnValueChanged = function(self, index)
  -- function num : 0_6
  if ((self._filterBtns)[index]):GetIsOnType() then
    self._data = (self._mainTaskMap)[index]
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

BossRushWeekAchievementDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_7
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

BossRushWeekAchievementDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  return #self._data
end

BossRushWeekAchievementDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "mainline.bossrush.bossrushweekachievementcell"
end

BossRushWeekAchievementDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return ((self._data)[index]).task
end

return BossRushWeekAchievementDialog

