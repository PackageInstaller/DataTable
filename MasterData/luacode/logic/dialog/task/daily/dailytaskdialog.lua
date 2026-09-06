local DailyTaskDialog = class("DailyTaskDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
DailyTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskDialog.AssetName = "TaskActiveNew"
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local RedData = require("logic.manager.experimental.types.reddata")
local tm = NekoData.BehaviorManager.BM_Task

function DailyTaskDialog:Ctor(...)
  DailyTaskDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
  self._baseSceneController = nil
end

function DailyTaskDialog:OnCreate()
  self._listBoard = self:GetChild("Frame")
  self._helper = TableFrame.Create(self._listBoard, self, true, true, true)
  self._progress = self:GetChild("Active/ActiveLine")
  self._milestones = {}
  self._milestonesState = {}
  for i = 1, 5 do
    local base = "Active/Active" .. i
    self._milestones[i] = {
      board = self:GetChild(base),
      itemCell = self:GetChild(base .. "/Award/ItemCell"),
      itemIcon = self:GetChild(base .. "/Award/ItemCell/_BackGround/Icon"),
      itemNum = self:GetChild(base .. "/Award/ItemCell/_Count"),
      got = self:GetChild(base .. "/Award/Get"),
      num = self:GetChild(base .. "/Num"),
      dot = self:GetChild(base .. "/Dot"),
      graydot = self:GetChild(base .. "/DotGrey"),
      effect = self:GetChild(base .. "/Award/Effect")
    }
    if i == 5 then
      self._other = {
        itemCell = self:GetChild(base .. "/Award/ItemCell2"),
        itemIcon = self:GetChild(base .. "/Award/ItemCell2/_BackGround/Icon"),
        itemNum = self:GetChild(base .. "/Award/ItemCell2/_Count"),
        got = self:GetChild(base .. "/Award/Get2"),
        effect = self:GetChild(base .. "/Award/Effect2")
      }
      self._other.itemCell:Subscribe_PointerClickEvent(function()
        self:OnItemCellClick(i, 2)
      end)
    end
    self._milestonesState[i] = false
    self._milestones[i].itemCell:Subscribe_PointerClickEvent(function()
      self:OnItemCellClick(i)
    end)
  end
  self._active = self:GetChild("Active/ActiveToday")
  self._scroll = self:GetChild("Scrollbar")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._refreshTime = self:GetChild("Active/RefreshTimeText")
  self._dreamProgress = self:GetChild("BattlePassProgress/Loading/Loading/BackGround/Progress")
  self._dreamExpNum = self:GetChild("BattlePassProgress/Loading/Num/Num")
  self._dreamItem = self:GetChild("BattlePassProgress/Item")
  self._back = self:GetChild("BattlePassProgress/Back")
  self._back:Subscribe_PointerClickEvent(self.OnDreamBoxClick, self)
  self._redDot = self:GetChild("BattlePassProgress/RedDot")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnTaskRefresh, Common.n_RefreshDailyTask, nil)
  LuaNotificationCenter.AddObserver(self, self.ShowActiveTip, Common.n_RefreshDailyTask, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshWeekTask, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshWeekActiveValue, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMilestone, Common.n_GetActiveAward, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_DreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_DreamSpiralRefresh, nil)
  self:SetData()
  UIBackManager.SwitchToNext()
end

function DailyTaskDialog:OnDestroy()
  self._helper:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function DailyTaskDialog:Init(baseSceneController)
  self._baseSceneController = baseSceneController
end

function DailyTaskDialog:SetData()
  self:Refresh("daily")
end

function DailyTaskDialog:Refresh(state)
  if type(state) ~= "string" then
    self:RefreshCell(self._btnState)
    self:RefreshMilestone()
  else
    self:RefreshCell(state)
    self:RefreshMilestone()
  end
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  local has = mgr:HasUntakeAward()
  self._redDot:SetActive(has)
  local baseInfo = mgr:GetBaseInfo()
  local chipInfo = baseInfo.chipInfo
  self._dreamProgress:SetFillAmount(chipInfo.has / chipInfo.max)
  self._dreamExpNum:SetActive(chipInfo.max > 0)
  if chipInfo.max > 0 then
    self._dreamExpNum:SetText(string.format("%d/%d", chipInfo.has, chipInfo.max))
  end
end

function DailyTaskDialog:RefreshMilestone()
  if self._btnState == "daily" then
    self._activeInfo = tm:GetActiveInfo()
    local current = self._activeInfo.current
    local total = self._activeInfo.ranks[#self._activeInfo.ranks].value
    local tempCurrent = current - 10
    if 0 < tempCurrent then
      self._progress:SetFillAmount(tempCurrent / total)
    else
      self._progress:SetFillAmount(0)
    end
    for i, v in ipairs(self._milestones) do
      local info = self._activeInfo.ranks[i]
      v.num:SetText(info.value)
      v.num:SetActive(current < info.value)
      v.dot:SetActive(current >= info.value)
      v.graydot:SetActive(current < info.value)
      v.got:SetActive(info.got)
      if info.got then
        v.itemCell:SetAlpha(0.5)
      else
        v.itemCell:SetAlpha(1)
      end
      if i == 5 then
        local imageRecord = info.award[2]:GetIcon()
        self._other.itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._other.itemNum:SetText(NumberManager.GetShowNumber(info.award[2]:GetCount()))
        self._other.effect:SetActive(current >= info.value and not info.got)
        self._other.got:SetActive(info.got)
        if info.got then
          self._other.itemCell:SetAlpha(0.5)
        else
          self._other.itemCell:SetAlpha(1)
        end
      end
      local imageRecord = info.award[1]:GetIcon()
      v.itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      v.itemNum:SetText(NumberManager.GetShowNumber(info.award[1]:GetCount()))
      self._milestonesState[i] = current >= info.value
      v.effect:SetActive(current >= info.value and not info.got)
    end
    self._active:SetText(current)
    self._thisActiveNum = current
    self._refreshTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1304).msgTextID))
  elseif self._btnState == "week" then
    local current = tm:GetWeekCurrentActiveValue()
    local activeinfo = tm:GetWeekActiveValueMap()
    self._activeInfo = {}
    for k, v in pairs(activeinfo) do
      table.insert(self._activeInfo, {key = k, value = v})
    end
    table.sort(self._activeInfo, function(a, b)
      return a.key < b.key
    end)
    local total = self._activeInfo[#self._activeInfo].key
    local tempCurrent = current - 10
    if 0 < tempCurrent then
      self._progress:SetFillAmount(tempCurrent / total)
    else
      self._progress:SetFillAmount(0)
    end
    for i, v in ipairs(self._milestones) do
      local info = self._activeInfo[i]
      v.num:SetText(info.key)
      v.num:SetActive(current < info.key)
      v.dot:SetActive(current >= info.key)
      v.graydot:SetActive(current < info.key)
      v.got:SetActive(info.value == 1)
      if info.value == 1 then
        v.itemCell:SetAlpha(0.5)
      else
        v.itemCell:SetAlpha(1)
      end
      if i == 5 then
        local imageRecord = info.award[2]:GetIcon()
        self._other.itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._other.itemNum:SetText(NumberManager.GetShowNumber(info.award[2]:GetCount()))
        self._other.got:SetActive(info.value == 1)
        if info.got then
          self._other.itemCell:SetAlpha(0.5)
        else
          self._other.itemCell:SetAlpha(1)
        end
      end
      local imageRecord = info.award[1]:GetIcon()
      v.itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      v.itemNum:SetText(NumberManager.GetShowNumber(info.award[1]:GetCount()))
      self._milestonesState[i] = current >= info.key
      v.effect:SetActive(current >= info.key and not info.value == 1)
    end
    self._active:SetText(current)
    self._thisActiveNum = current
    self._refreshTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1303).msgTextID))
  end
end

function DailyTaskDialog:RefreshCell(state)
  self:RefreshTaskList(state)
end

function DailyTaskDialog:RefreshTaskList(state)
  self._btnState = state
  if state == "week" then
    self._isFullTo100 = tm:GetWeekCurrentActiveValue() >= 100
    local tasks = tm:GetWeektTaskList()
    self._tasks = tasks
    table.sort(self._tasks, function(a, b)
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
  elseif state == "daily" then
    self._isFullTo100 = 100 <= tm:GetActiveInfo().current
    local tasks = tm:GetTasksByGroup(2)
    self._tasks = {}
    local pendingTasks = {}
    local finishTasks = {}
    local unFinishTasks = {}
    for _, v in pairs(tasks) do
      if v:GetType() == 3 then
        if v:GetStatus() == Status.COMMITED then
          table.insert(finishTasks, v)
        elseif v:GetStatus() == Status.FINISHED then
          table.insert(pendingTasks, v)
        else
          table.insert(unFinishTasks, v)
        end
      end
    end
    table.sort(finishTasks, function(a, b)
      return a:GetSortID() < b:GetSortID()
    end)
    table.sort(unFinishTasks, function(a, b)
      return a:GetSortID() < b:GetSortID()
    end)
    table.sort(pendingTasks, function(a, b)
      return a:GetSortID() < b:GetSortID()
    end)
    if self._isFullTo100 then
      for i, v in ipairs(unFinishTasks) do
        table.insert(self._tasks, v)
      end
      for i, v in ipairs(pendingTasks) do
        table.insert(self._tasks, v)
      end
    else
      for i, v in ipairs(pendingTasks) do
        table.insert(self._tasks, v)
      end
      for i, v in ipairs(unFinishTasks) do
        table.insert(self._tasks, v)
      end
    end
    for i, v in ipairs(finishTasks) do
      table.insert(self._tasks, v)
    end
  end
  self._helper:ReloadAllCell()
  self._helper:MoveToTop(false)
end

function DailyTaskDialog:OnTaskRefresh()
  if self._btnState == "week" then
    return
  end
  self:Refresh("daily")
  self._refreshed = false
end

function DailyTaskDialog:OnAbandonClick(taskid)
  tm:TryAbandonTask(self._selected)
end

function DailyTaskDialog:OnAcceptClick(taskid)
  tm:TryAcceptTask(self._selected)
end

function DailyTaskDialog:OnRefreshClick(taskid)
  if tm:GetDailyRefreshCount() > 0 then
    if not self._refreshed then
      tm:RequestDailyTaskRefresh(taskid)
      self._refreshed = true
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100078)
  end
end

function DailyTaskDialog:OnCommitClick(taskid)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(6) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(6)
  end
  tm:TryCommitTask(taskid)
end

function DailyTaskDialog:OnItemCellClick(index, cellindex)
  cellindex = cellindex or 1
  if self._milestonesState[index] == true then
    if self._btnState == "daily" then
      local info = self._activeInfo.ranks[index]
      if self._activeInfo.current >= info.value and not info.got then
        tm:RequestActiveAward(info.value)
      elseif not info.got then
        local width, height = self._milestones[index].box:GetRectSize()
        local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
        tip:Init({
          item = self._activeInfo.ranks[index].award[cellindex]
        })
        tip:UpdatePosition(self._milestones[index].box)
        tip:SetTipsPosition(width, height, self._milestones[index].box:GetLocalPointInUiRootPanel())
      end
    elseif self._btnState == "week" then
      local current = tm:GetWeekCurrentActiveValue()
      local info = self._activeInfo[index]
      if current >= info.key and info.value == 0 then
        local req = LuaNetManager.CreateProtocol("protocol.task.creceiveweekactives")
        req.value = info.key
        req:Send()
      end
    end
  else
    local tempCfg
    if self._btnState == "week" then
      tempCfg = BeanManager.GetTableByName("mission.cweekmissionaward"):GetRecorder(self._activeInfo[index].key)
    elseif self._btnState == "daily" then
      tempCfg = BeanManager.GetTableByName("mission.cdailymissionaward"):GetRecorder(self._activeInfo.ranks[index].value)
    end
    if type(tempCfg.awardid) == "table" then
      local tempAward = Item.Create(tempCfg.awardid[cellindex])
      tempAward:SetCount(tempCfg.num[cellindex])
      local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
      tip:Init({
        item = tempAward,
        num = tempAward:GetCount()
      })
    else
      local tempAward = Item.Create(tempCfg.awardid)
      tempAward:SetCount(tempCfg.num)
      local tip = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
      tip:Init({
        item = tempAward,
        num = tempAward:GetCount()
      })
    end
  end
end

function DailyTaskDialog:OnDailyTaskBtnClicked()
  self:Refresh("daily")
end

function DailyTaskDialog:OnWeekTaskBtnClicked()
  self:Refresh("week")
end

function DailyTaskDialog:NumberOfCell(helper)
  return #self._tasks
end

function DailyTaskDialog:CellAtIndex(helper, index)
  local task = self._tasks[index]
  if task:IsSpecialDailyTask() then
    return "task.daily.goldentaskcell"
  else
    return "task.daily.dailytaskcell"
  end
end

function DailyTaskDialog:DataAtIndex(helper, index)
  return self._tasks[index]
end

function DailyTaskDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("task.daily.dailytaskdialog")
end

function DailyTaskDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function DailyTaskDialog:OnCurPosChange(helper, ratio)
  if helper == self._helper then
    self._scroll:SetScrollValue(1 - ratio)
  end
end

function DailyTaskDialog:OnDreamBoxClick()
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  if mgr:IsAgCoinActivityOpen() then
    if DialogManager.GetDialog("welfare.welfaremaindialog") then
      DialogManager.DestroySingletonDialog("welfare.welfaremaindialog")
    end
    local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true)
      dialog:SetSelectedTab(dialog.WelfareType.dreamSpiral)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
  end
end

function DailyTaskDialog:ShowActiveTip()
  if self._lastActiveNum and self._thisActiveNum then
    local addNum = self._thisActiveNum - self._lastActiveNum
    if 0 < addNum then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100295, {
        self._thisActiveNum - self._lastActiveNum
      })
    end
  end
  self._lastActiveNum = self._thisActiveNum
end

return DailyTaskDialog
