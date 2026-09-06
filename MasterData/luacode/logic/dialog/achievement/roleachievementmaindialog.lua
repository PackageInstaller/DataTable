local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CAchievementLevelConfig = BeanManager.GetTableByName("mission.cachievelevelconfig")
local Item = require("logic.manager.experimental.types.item")
local CAchievementMissionConfig = BeanManager.GetTableByName("mission.cachievemissionconfig")
local CAchieveBadgeGroupConfig = BeanManager.GetTableByName("mission.cachievebadgegroup")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local filterEnum = {
  "all",
  "achieve",
  "notAchieve"
}
local AchieveLevelAllIds = CAchievementLevelConfig:GetAllIds()
local AchieveMaxLevel = CAchievementLevelConfig:GetRecorder(AchieveLevelAllIds[#AchieveLevelAllIds]).id
local RoleAchievementMainDialog = class("RoleAchievementMainDialog", Dialog)
RoleAchievementMainDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementMainDialog.AssetName = "Achievement"

function RoleAchievementMainDialog:Ctor(...)
  RoleAchievementMainDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
  self._selectTab = nil
end

function RoleAchievementMainDialog:OnCreate()
  self._progressLevelBar = self:GetChild("DetailFrame/ProgressLevel/BackGround/Progress")
  self._progressLevelBarNum = self:GetChild("DetailFrame/ProgressLevel/EXPNum")
  self._levelNum = self:GetChild("DetailFrame/Level/LevelNum")
  self._achieveRate = self:GetChild("DetailFrame/Num1/Txt2")
  self._medalRate = self:GetChild("DetailFrame/Num2/Txt2")
  self._empty = self:GetChild("Empty")
  self._tabBtns = {}
  for i = 1, 4 do
    self._tabBtns[i] = {}
    self._tabBtns[i].btn = self:GetChild("Btn" .. i)
    self._tabBtns[i].redDot = self:GetChild("Btn" .. i .. "/RedDot")
    self._tabBtns[i].btn:Subscribe_PointerClickEvent(function()
      self:OnTabBtnClicked(i)
    end)
  end
  self._tabPanel = self:GetChild("Frame")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._filterBtns = {}
  for i, v in ipairs(filterEnum) do
    self._filterBtns[v] = self:GetChild("ToggleGroup/_Toggle_" .. tostring(i - 1))
    self._filterBtns[v]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(v)
    end)
  end
  self._maxLevelTxt = self:GetChild("DetailFrame/Max")
  self._awardItemPanel = self:GetChild("DetailFrame/Item")
  self._awardItemIcon = self:GetChild("DetailFrame/Item/ItemCell/_BackGround/Icon")
  self._awardItemSelect = self:GetChild("DetailFrame/Item/ItemCell/_BackGround/Select")
  self._awardItemFrame = self:GetChild("DetailFrame/Item/ItemCell/_BackGround/Frame")
  self._awardItemSelect:SetActive(false)
  self._awardItemNum = self:GetChild("DetailFrame/Item/ItemCell/_Count")
  self._awardItemLock = self:GetChild("DetailFrame/Item/Lock")
  self._awardItemLockTxt = self:GetChild("DetailFrame/Item/Lock/Txt")
  self._itemCell = self:GetChild("DetailFrame/Item/ItemCell")
  self._itemCell:Subscribe_PointerClickEvent(self.OnAwardItemClicked, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._lookBtn = self:GetChild("DetailFrame/LookBtn")
  self._getAwardBtn = self:GetChild("DetailFrame/Item/GetBtn")
  self._state = "all"
  self._nextstate = "all"
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._lookBtn:Subscribe_PointerClickEvent(self.OnLooktnClicked, self)
  self._getAwardBtn:Subscribe_PointerClickEvent(self.OnGetAwardBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.SetData, Common.n_RefreshAchievementLevelAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTask, Common.n_RefreshTask, nil)
  self:SetData()
end

function RoleAchievementMainDialog:OnDestroy()
  self._tabFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RoleAchievementMainDialog:SetData()
  self:RefreshAwardGetedState()
  local cur = self._achievement.process
  local total = 0
  local record = CAchievementLevelConfig:GetRecorder(self._achievement.level)
  if record then
    total = record.achievePoint
    self._progressLevelBar:SetFillAmount(cur / total)
    local str = TextManager.GetText(CStringres:GetRecorder(1299).msgTextID)
    str = string.gsub(str, "%$parameter1%$", tostring(cur))
    str = string.gsub(str, "%$parameter2%$", tostring(total))
    self._progressLevelBarNum:SetText(str)
  end
  local bags = self._achievement.badges
  local num = table.nums(bags)
  local max = 0
  local allIds = CAchieveBadgeGroupConfig:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAchieveBadgeGroupConfig:GetRecorder(allIds[i])
    max = max + #recorder.badgeIDList
  end
  self._medalRate:SetText(math.floor(1000 * num / max) / 10 .. "%")
  self:RefreshTask()
end

function RoleAchievementMainDialog:RefreshTask(notification)
  self._allTaskList = NekoData.BehaviorManager.BM_Task:GetAchievementTaskList()
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
    local record = CAchievementMissionConfig:GetRecorder(id)
    if not taskMap[record.tabID] then
      taskMap[record.tabID] = {}
    end
    if not taskMap[record.tabID][record.groupID] then
      taskMap[record.tabID][record.groupID] = {}
    end
    table.insert(taskMap[record.tabID][record.groupID], v)
    if v:GetStatus() == Status.COMMITED then
      finishTaskNum = finishTaskNum + 1
    end
    taskTotalNum = taskTotalNum + 1
  end
  for groupID, value in pairs(taskMap) do
    for groupId, taskList in pairs(value) do
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
  end
  self._mainTaskMap = {}
  for groupID, value in pairs(taskMap) do
    self._mainTaskMap[groupID] = {}
    for k, type in pairs(filterEnum) do
      self._mainTaskMap[groupID][type] = {}
    end
    local haveFinishedTask = false
    for groupId, taskList in pairs(value) do
      for i, v in ipairs(taskList) do
        table.insert(self._mainTaskMap[groupID].all, v)
        local status = v:GetStatus()
        if status ~= Status.COMMITED then
          table.insert(self._mainTaskMap[groupID].notAchieve, v)
        else
          table.insert(self._mainTaskMap[groupID].achieve, v)
        end
        if not haveFinishedTask and status == Status.FINISHED then
          haveFinishedTask = true
        end
      end
    end
    self._tabBtns[groupID].redDot:SetActive(haveFinishedTask)
    for k, type in pairs(filterEnum) do
      table.sort(self._mainTaskMap[groupID][type], function(a, b)
        local _, x = math.modf(a:GetStatus() / 3)
        local _, y = math.modf(b:GetStatus() / 3)
        if x == y then
          if a:GetStatus() == b:GetStatus() then
            return a:GetID() < b:GetID()
          else
            return a:GetStatus() > b:GetStatus()
          end
        else
          return x < y
        end
      end)
      local list = self._mainTaskMap[groupID][type]
      if type == "all" then
        local finishedList = {}
        local commitedList = {}
        local otherList = {}
        for i, v in ipairs(list) do
          if v:GetStatus() == Status.FINISHED then
            table.insert(finishedList, v)
          elseif v:GetStatus() == Status.COMMITED then
            table.insert(commitedList, v)
          else
            table.insert(otherList, v)
          end
        end
        table.sort(finishedList, function(a, b)
          return a:GetID() < b:GetID()
        end)
        table.sort(commitedList, function(a, b)
          return a:GetID() < b:GetID()
        end)
        table.sort(otherList, function(a, b)
          local a_status, b_status = a:GetStatus(), b:GetStatus()
          if a_status == b_status then
            return a:GetID() < b:GetID()
          else
            return a:GetStatus() < b:GetStatus()
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
          return a:GetID() < b:GetID()
        end)
      elseif type == "notAchieve" then
        table.sort(list, function(a, b)
          local a_status, b_status = a:GetStatus(), b:GetStatus()
          if a_status == b_status then
            return a:GetID() < b:GetID()
          else
            return a:GetStatus() < b:GetStatus()
          end
        end)
      end
    end
  end
  self._achieveRate:SetText(math.floor(1000 * finishTaskNum / taskTotalNum) / 10 .. "%")
  self:OnTabBtnClicked(self._selectTab or 1, true)
end

function RoleAchievementMainDialog:RefreshAwardGetedState()
  self._achievement = NekoData.BehaviorManager.BM_Task:GetAchievement()
  self._levelNum:SetText(self._achievement.level)
  local record = CAchievementLevelConfig:GetRecorder(self._achievement.level)
  local list = {}
  if self._achievement.unReceiveLevels and type(self._achievement.unReceiveLevels) == "table" then
    for _, v in pairs(self._achievement.unReceiveLevels) do
      if CAchievementLevelConfig:GetRecorder(v).rewardID ~= 0 then
        table.insert(list, v)
      end
    end
  end
  self._getAwardBtn:SetActive(false)
  self._achievement.unReceiveLevels = list
  if table.nums(self._achievement.unReceiveLevels) == 0 then
    if self._achievement.level >= AchieveMaxLevel then
      self._maxLevelTxt:SetActive(true)
      self._awardItemPanel:SetActive(false)
    else
      self._maxLevelTxt:SetActive(false)
      self._awardItemPanel:SetActive(true)
      self._awardItemLock:SetActive(true)
      local level = self._achievement.level + 1
      while CAchievementLevelConfig:GetRecorder(level) and CAchievementLevelConfig:GetRecorder(level).rewardID == 0 do
        level = level + 1
      end
      record = CAchievementLevelConfig:GetRecorder(level)
      self._awardItemLockTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1354, {level}))
      if record.rewardItem ~= 0 then
        self._item = Item.Create(record.rewardItem)
        local imageRecord = self._item:GetIcon()
        self._awardItemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._awardItemNum:SetText(NumberManager.GetShowNumber(record.itemNum))
        imageRecord = self._item:GetPinJiImage()
        self._awardItemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
    end
  else
    self._maxLevelTxt:SetActive(false)
    self._awardItemPanel:SetActive(true)
    self._awardItemLock:SetActive(false)
    record = CAchievementLevelConfig:GetRecorder(self._achievement.unReceiveLevels[1])
    if record and record.rewardItem ~= 0 then
      self._item = Item.Create(record.rewardItem)
      local imageRecord = self._item:GetIcon()
      self._awardItemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = self._item:GetPinJiImage()
      self._awardItemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._awardItemNum:SetText(NumberManager.GetShowNumber(record.itemNum))
      self._getAwardBtn:SetActive(true)
    end
  end
end

function RoleAchievementMainDialog:OnValueChanged(index)
  if not self.setIsOnType and self._filterBtns[index]:GetIsOnType() then
    local tabCell = self._tabFrame:GetCellAtIndex(self._selectTab)
    tabCell._filterType = index
    tabCell:RefreshTabCell(self._mainTaskMap[self._selectTab][tabCell._filterType])
  end
end

function RoleAchievementMainDialog:CellAtIndex(frame, index)
  if frame == self._tabFrame then
    return "achievement.roleachievementtabcell"
  end
end

function RoleAchievementMainDialog:OnTabBtnClicked(tabIndex, refresh)
  if not self._selectTab or self._selectTab ~= tabIndex or refresh then
    self._selectTab = tabIndex
    local tabCell = self._tabFrame:ToPage(self._selectTab)
    tabCell._filterType = filterEnum[1]
    tabCell:RefreshTabCell(self._mainTaskMap[self._selectTab][tabCell._filterType])
    for k, v in pairs(self._filterBtns) do
      self.setIsOnType = true
      v:SetIsOnType(k == tabCell._filterType)
    end
    self.setIsOnType = false
    for i, v in ipairs(self._tabBtns) do
      v.btn:SetSelected(self._selectTab == i)
    end
  end
end

function RoleAchievementMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleAchievementMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RoleAchievementMainDialog:OnLooktnClicked()
  DialogManager.CreateSingletonDialog("achievement.roleachievementmodalshowdialog"):SetData(self._achievement)
end

function RoleAchievementMainDialog:OnAwardItemClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self._itemCell:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

function RoleAchievementMainDialog:OnGetAwardBtnClicked()
  if self._achievement.unReceiveLevels and self._achievement.unReceiveLevels[1] then
    local protocol = LuaNetManager.CreateProtocol("protocol.task.creceiveachievelevelaward")
    if protocol then
      protocol.level = self._achievement.unReceiveLevels[1]
      protocol:Send()
    end
  end
end

function RoleAchievementMainDialog:SetEmpty(flag)
  self._empty:SetActive(flag)
end

return RoleAchievementMainDialog
