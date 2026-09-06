local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CFirstanniversaryCfg = BeanManager.GetTableByName("activity.cfirstanniversarycfg")
local CFirstAnniversaryTask = BeanManager.GetTableByName("mission.cfirstanniversarytask")
local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local TaskPage = class("TaskPage", Dialog)
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
TaskPage.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskPage.AssetName = "Activity1YearOtherTask"

function TaskPage:Ctor(...)
  TaskPage.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._taskData = {}
  self._awardList = {}
end

local function InitCfg()
  local result = {}
  local maxAward
  for _, v in ipairs(CFirstAnniversaryTask:GetAllIds()) do
    local record = CFirstAnniversaryTask:GetRecorder(v)
    if record.topShow == 1 then
      maxAward = record
    else
      table.insert(result, record)
    end
  end
  return result, maxAward
end

local function ShowMaxAward(self)
  local state = 0
  local package = NekoData.BehaviorManager.BM_Anniversary:GetPackageInfo()
  if package then
    local award = package.award
    state = award[#award]
    self._maxAwardState = state
  end
  self._maxAward.getBtn:SetActive(state == CommonAwardsSatus.UNLOCKED)
  self._maxAward.receivedBtn:SetActive(state == CommonAwardsSatus.FETCHED)
  local itemId = self._maxAwardData.rewardItem[1]
  local needNum = self._maxAwardData.rewardQuantity[1]
  local maxScore = self._maxAwardData.rewardNum
  local item = Item.Create(itemId)
  self._maxAward.icon:SetSprite(item:GetIconAB())
  self._maxAward.frame:SetSprite(item:GetPinJiImageAB())
  self._maxAward.count:SetText(NumberManager.GetNumber(needNum))
  self._maxAward.score:SetText(maxScore)
  self._item = item
end

function TaskPage:OnCreate()
  self:GetChild("Back/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2063))
  self:GetChild("Back/EndTimeBack/EndTime"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2064))
  self:GetChild("Back/ItemBack/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2062))
  self:GetChild("Back/Progress/Reward/GetBack2/Text1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1899))
  self:GetChild("Back/Progress/Reward/GetBack1/Text2"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  self:GetChild("Back/Progress/Reward/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2065))
  self._score = {
    num = self:GetChild("Back/ItemBack/Num"),
    icon = self:GetChild("Back/ItemBack/Item")
  }
  self._maxAward = {
    mask = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Mask"),
    frame = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Frame"),
    icon = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Icon"),
    count = self:GetChild("Back/Progress/Reward/Item/ItemCell/_Count"),
    score = self:GetChild("Back/Progress/Reward/NumFrame/Num"),
    receivedBtn = self:GetChild("Back/Progress/Reward/GetBack1"),
    getBtn = self:GetChild("Back/Progress/Reward/GetBack2")
  }
  self._taskPanel = self:GetChild("Back/TaskFrame")
  self._width, self._height = self._taskPanel:GetRectSize()
  self._awardPanel = self:GetChild("Back/Progress/Frame")
  self._taskFrame = TableFrame.Create(self._taskPanel, self, true, true, false)
  self._awardFrame = TableFrame.Create(self._awardPanel, self, false, true, false)
  self._maxAward.icon:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._tipBtn = self:GetChild("Back/Tips")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._talkText = self:GetChild("Back/Role/Dialog/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self:SwitchTalkText(1)
  self._awardData, self._maxAwardData = InitCfg()
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardData, Common.n_OnSOpenAnniversaryDraw, nil)
end

function TaskPage:OnDestroy()
  if self._taskFrame then
    self._taskFrame:Destroy()
  end
  if self._awardFrame then
    self._awardFrame:Destroy()
  end
end

function TaskPage:Refresh()
  self:RefreshAwardData()
  self:RefreshTaskData()
end

function TaskPage:RefreshTaskData()
  for key, _ in pairs(self._taskData) do
    self._taskData[key] = nil
  end
  local allTasks = NekoData.BehaviorManager.BM_ActivityTasks:GetTasks(CActivityTasks.ANNIVERSARY_DRAW)
  if allTasks then
    for _, value in pairs(allTasks) do
      table.insert(self._taskData, value)
    end
    table.sort(self._taskData, function(a, b)
      local _, x = math.modf(a:GetStatus() / 3)
      local _, y = math.modf(b:GetStatus() / 3)
      if x == y then
        if a:GetStatus() == b:GetStatus() then
          return a:GetSortID() > b:GetSortID()
        else
          return a:GetStatus() > b:GetStatus()
        end
      else
        return x > y
      end
    end)
  end
  self:SwitchTalkText()
  self._taskFrame:ReloadAllCell()
end

function TaskPage:RefreshAwardData()
  for key, _ in pairs(self._awardList) do
    self._awardList[key] = nil
  end
  local package = NekoData.BehaviorManager.BM_Anniversary:GetPackageInfo()
  if package then
    ShowMaxAward(self)
    local award = package.award
    for i, v in ipairs(self._awardData) do
      local process = 0
      local last = CFirstAnniversaryTask:GetRecorder(v.id - 1)
      if 0 < package.score and package.score >= v.rewardNum then
        process = 1
      elseif last and package.score <= v.rewardNum then
        process = (package.score - last.rewardNum) / (v.rewardNum - last.rewardNum)
      end
      table.insert(self._awardList, {
        cfg = v,
        state = award[i],
        process = process
      })
    end
    self._awardFrame:ReloadAllCell()
    self._score.num:SetText(package.score)
    if NekoData.BehaviorManager.BM_Anniversary:HasScoreAward() then
      for k, v in ipairs(self._awardList) do
        if v.state == 1 then
          self._awardFrame:MoveLeftToIndex(k)
          return
        end
      end
      self._awardFrame:MoveToRight()
    else
      for k, v in ipairs(self._awardList) do
        if v.state == 0 then
          self._awardFrame:MoveLeftToIndex(k)
          return
        end
      end
      self._awardFrame:MoveToRight()
    end
  end
end

function TaskPage:OnBackBtnClicked()
  self.OnDestroy()
end

function TaskPage:CellAtIndex(frame, index)
  if frame == self._taskFrame then
    return "activity.anniversarypackage.taskcell"
  elseif frame == self._awardFrame then
    return "activity.anniversarypackage.taskawardcell"
  end
end

function TaskPage:NumberOfCell(frame, index)
  if frame == self._taskFrame then
    return #self._taskData
  elseif frame == self._awardFrame then
    return #self._awardList
  end
end

function TaskPage:DataAtIndex(frame, index)
  if frame == self._taskFrame then
    return self._taskData[index]
  elseif frame == self._awardFrame then
    return self._awardList[index]
  end
end

function TaskPage:SwitchTalkText(id)
  local toShowTalkId = -1
  if self._randomTalkIdList == nil then
    self._randomTalkIdList = {}
    local allIds = CFirstanniversaryCfg:GetAllIds()
    for i = 1, #allIds do
      table.insert(self._randomTalkIdList, CFirstanniversaryCfg:GetRecorder(i).TextID)
    end
  end
  local randomId = math.random(#self._randomTalkIdList)
  if id then
    randomId = id
  end
  toShowTalkId = self._randomTalkIdList[randomId]
  self._talkText:SetText(TextManager.GetText(toShowTalkId))
end

function TaskPage:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(8)
end

function TaskPage:OnCommitClick(id)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  protocol.activityID = CActivityTasks.ANNIVERSARY_DRAW
  protocol.taskID = id
  protocol:Send()
end

function TaskPage:OnCommitMaxAwardClick()
end

function TaskPage:OnItemClicked()
  if self._maxAwardState == CommonAwardsSatus.UNLOCKED then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cfetchanniversarymissionaward")
    csend.awardId = self._maxAwardData.id
    csend:Send()
  else
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
    end
  end
end

function TaskPage:OnCurPosChange(frame, proportion)
  if frame == self._taskFrame then
    local total = self._taskFrame:GetTotalLength()
    if total > self._height then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(self._height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

return TaskPage
