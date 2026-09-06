local CWeeklyBossAchieveMissionConfig = BeanManager.GetTableByName("dungeonselect.cweeklybossachievemissionconfig")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local filterEnum = {
  "all",
  "achieve",
  "notAchieve"
}
local BossRushWeekTaskType = 16
local BossRushWeekAchievementDialog = class("BossRushWeekAchievementDialog", Dialog)
BossRushWeekAchievementDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekAchievementDialog.AssetName = "BossRushWeekAchievement"

function BossRushWeekAchievementDialog:Ctor(...)
  BossRushWeekAchievementDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._init = false
  self._filterType = "all"
end

function BossRushWeekAchievementDialog:OnCreate()
  self._scrollBar = self:GetChild("Back2/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back2/Frame")
  self._filterBtns = {}
  for i, v in ipairs(filterEnum) do
    self._filterBtns[v] = self:GetChild("Back2/ToggleGroup/_Toggle_" .. tostring(i - 1))
    self._filterBtns[v]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(v)
    end)
  end
  self._titleTxt = self:GetChild("Back2/TitleBack/Title")
  self._closeBtn = self:GetChild("Back2/CloseBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTask, Common.n_RefreshTask, nil)
  self._width, self._height = self._panel:GetRectSize()
  self:Init()
end

function BossRushWeekAchievementDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function BossRushWeekAchievementDialog:Init()
  self._titleTxt:SetText(TextManager.GetText(1901562))
  self:RefreshTask()
end

function BossRushWeekAchievementDialog:OnCloseBtnClicked()
  self:Destroy()
end

function BossRushWeekAchievementDialog:RefreshTask(notification)
  self._allTaskList = NekoData.BehaviorManager.BM_Task:GetTasksByType(BossRushWeekTaskType)
  if notification then
    local task = notification.userInfo
    for _, v in pairs(self._allTaskList) do
      if v:GetID() == task:GetID() and v:GetStatus() == Status.FINISHED and task:GetStatus() == Status.PROCESSING then
        return
      end
    end
  end
  local taskMap = {}
  local finishTaskNum = 0
  local taskTotalNum = 0
  for i, v in ipairs(self._allTaskList) do
    local id = v:GetID()
    local record = CWeeklyBossAchieveMissionConfig:GetRecorder(id)
    if not taskMap[record.groupID] then
      taskMap[record.groupID] = {}
    end
    table.insert(taskMap[record.groupID], v)
    if v:GetStatus() == Status.COMMITED then
      finishTaskNum = finishTaskNum + 1
    end
    taskTotalNum = taskTotalNum + 1
  end
  for groupId, taskList in pairs(taskMap) do
    table.sort(taskList, function(a, b)
      local a_taskId, b_taskId = a:GetID(), b:GetID()
      return a_taskId < b_taskId
    end)
    local firstUnachieveIndex
    for i, v in ipairs(taskList) do
      local status = v:GetStatus()
      if status ~= Status.COMMITED then
        firstUnachieveIndex = i
        break
      end
    end
    if firstUnachieveIndex then
      while taskList[#taskList] do
        if firstUnachieveIndex < #taskList then
          table.remove(taskList, #taskList)
        else
          break
        end
      end
    end
  end
  self._mainTaskMap = {}
  for k, type in pairs(filterEnum) do
    self._mainTaskMap[type] = {}
  end
  local sortedTaskList = {}
  for groupId, taskList in pairs(taskMap) do
    table.insert(sortedTaskList, {gid = groupId, tlist = taskList})
  end
  table.sort(sortedTaskList, function(a, b)
    return a.gid < b.gid
  end)
  for _, outValue in ipairs(sortedTaskList) do
    taskList = outValue.tlist
    for i, v in ipairs(taskList) do
      table.insert(self._mainTaskMap.all, {
        gid = outValue.gid,
        task = v
      })
      local status = v:GetStatus()
      if status ~= Status.COMMITED then
        table.insert(self._mainTaskMap.notAchieve, {
          gid = outValue.gid,
          task = v
        })
      else
        table.insert(self._mainTaskMap.achieve, {
          gid = outValue.gid,
          task = v
        })
      end
    end
  end
  for k, type in pairs(filterEnum) do
    table.sort(self._mainTaskMap[type], function(a, b)
      local _, x = math.modf(a.task:GetStatus() / 3)
      local _, y = math.modf(b.task:GetStatus() / 3)
      if x == y then
        if a.task:GetStatus() == b.task:GetStatus() then
          if a.gid == b.gid then
            return a.task:GetID() < b.task:GetID()
          else
            return a.gid < b.gid
          end
        else
          return a.task:GetStatus() > b.task:GetStatus()
        end
      else
        return x < y
      end
    end)
    local list = self._mainTaskMap[type]
    if type == "all" then
      local finishedList = {}
      local commitedList = {}
      local otherList = {}
      for i, v in ipairs(list) do
        if v.task:GetStatus() == Status.FINISHED then
          table.insert(finishedList, v)
        elseif v.task:GetStatus() == Status.COMMITED then
          table.insert(commitedList, v)
        else
          table.insert(otherList, v)
        end
      end
      table.sort(finishedList, function(a, b)
        if a.gid == b.gid then
          return a.task:GetID() < b.task:GetID()
        else
          return a.gid < b.gid
        end
      end)
      table.sort(commitedList, function(a, b)
        if a.gid == b.gid then
          return a.task:GetID() < b.task:GetID()
        else
          return a.gid < b.gid
        end
      end)
      table.sort(otherList, function(a, b)
        local a_status, b_status = a.task:GetStatus(), b.task:GetStatus()
        if a_status == b_status then
          if a.gid == b.gid then
            return a.task:GetID() < b.task:GetID()
          else
            return a.gid < b.gid
          end
        else
          return a.task:GetStatus() < b.task:GetStatus()
        end
      end)
      while list[#list] do
        table.remove(list, #list)
      end
      for i, v in ipairs(finishedList) do
        table.insert(list, v)
      end
      for i, v in ipairs(otherList) do
        table.insert(list, v)
      end
      for i, v in ipairs(commitedList) do
        table.insert(list, v)
      end
    elseif type == "achieve" then
      table.sort(list, function(a, b)
        if a.gid == b.gid then
          return a.task:GetID() < b.task:GetID()
        else
          return a.gid < b.gid
        end
      end)
    elseif type == "notAchieve" then
      table.sort(list, function(a, b)
        local a_status, b_status = a.task:GetStatus(), b.task:GetStatus()
        if a_status == b_status then
          if a.gid == b.gid then
            return a.task:GetID() < b.task:GetID()
          else
            return a.gid < b.gid
          end
        else
          return a.task:GetStatus() < b.task:GetStatus()
        end
      end)
    end
  end
  self._data = self._mainTaskMap.all
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function BossRushWeekAchievementDialog:OnValueChanged(index)
  if self._filterBtns[index]:GetIsOnType() then
    self._data = self._mainTaskMap[index]
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
end

function BossRushWeekAchievementDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function BossRushWeekAchievementDialog:NumberOfCell(frame)
  return #self._data
end

function BossRushWeekAchievementDialog:CellAtIndex(frame, index)
  return "mainline.bossrush.bossrushweekachievementcell"
end

function BossRushWeekAchievementDialog:DataAtIndex(frame, index)
  return self._data[index].task
end

return BossRushWeekAchievementDialog
