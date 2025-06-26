-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/taskpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CFirstanniversaryCfg = (BeanManager.GetTableByName)("activity.cfirstanniversarycfg")
local CFirstAnniversaryTask = (BeanManager.GetTableByName)("mission.cfirstanniversarytask")
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local TaskPage = class("TaskPage", Dialog)
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
TaskPage.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskPage.AssetName = "Activity1YearOtherTask"
TaskPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskPage
  ((TaskPage.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._taskData = {}
  self._awardList = {}
end

local InitCfg = function()
  -- function num : 0_1 , upvalues : _ENV, CFirstAnniversaryTask
  local result = {}
  local maxAward = nil
  for _,v in ipairs(CFirstAnniversaryTask:GetAllIds()) do
    local record = CFirstAnniversaryTask:GetRecorder(v)
    if record.topShow == 1 then
      maxAward = record
    else
      ;
      (table.insert)(result, record)
    end
  end
  return result, maxAward
end

local ShowMaxAward = function(self)
  -- function num : 0_2 , upvalues : _ENV, CommonAwardsSatus, Item
  local state = 0
  local package = ((NekoData.BehaviorManager).BM_Anniversary):GetPackageInfo()
  do
    if package then
      local award = package.award
      state = award[#award]
      self._maxAwardState = state
    end
    ;
    ((self._maxAward).getBtn):SetActive(state == CommonAwardsSatus.UNLOCKED)
    ;
    ((self._maxAward).receivedBtn):SetActive(state == CommonAwardsSatus.FETCHED)
    local itemId = ((self._maxAwardData).rewardItem)[1]
    local needNum = ((self._maxAwardData).rewardQuantity)[1]
    local maxScore = (self._maxAwardData).rewardNum
    local item = (Item.Create)(itemId)
    ;
    ((self._maxAward).icon):SetSprite(item:GetIconAB())
    ;
    ((self._maxAward).frame):SetSprite(item:GetPinJiImageAB())
    ;
    ((self._maxAward).count):SetText((NumberManager.GetNumber)(needNum))
    ;
    ((self._maxAward).score):SetText(maxScore)
    self._item = item
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

TaskPage.OnCreate = function(self)
  -- function num : 0_3 , upvalues : _ENV, TableFrame, InitCfg
  (self:GetChild("Back/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2063))
  ;
  (self:GetChild("Back/EndTimeBack/EndTime")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2064))
  ;
  (self:GetChild("Back/ItemBack/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2062))
  ;
  (self:GetChild("Back/Progress/Reward/GetBack2/Text1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1899))
  ;
  (self:GetChild("Back/Progress/Reward/GetBack1/Text2")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  ;
  (self:GetChild("Back/Progress/Reward/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2065))
  self._score = {num = self:GetChild("Back/ItemBack/Num"), icon = self:GetChild("Back/ItemBack/Item")}
  self._maxAward = {mask = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Mask"), frame = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Frame"), icon = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Icon"), count = self:GetChild("Back/Progress/Reward/Item/ItemCell/_Count"), score = self:GetChild("Back/Progress/Reward/NumFrame/Num"), receivedBtn = self:GetChild("Back/Progress/Reward/GetBack1"), getBtn = self:GetChild("Back/Progress/Reward/GetBack2")}
  self._taskPanel = self:GetChild("Back/TaskFrame")
  self._width = (self._taskPanel):GetRectSize()
  self._awardPanel = self:GetChild("Back/Progress/Frame")
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, false)
  self._awardFrame = (TableFrame.Create)(self._awardPanel, self, false, true, false)
  ;
  ((self._maxAward).icon):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._tipBtn = self:GetChild("Back/Tips")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._talkText = self:GetChild("Back/Role/Dialog/Text")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self:SwitchTalkText(1)
  self._awardData = InitCfg()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardData, Common.n_OnSOpenAnniversaryDraw, nil)
end

TaskPage.OnDestroy = function(self)
  -- function num : 0_4
  if self._taskFrame then
    (self._taskFrame):Destroy()
  end
  if self._awardFrame then
    (self._awardFrame):Destroy()
  end
end

TaskPage.Refresh = function(self)
  -- function num : 0_5
  self:RefreshAwardData()
  self:RefreshTaskData()
end

TaskPage.RefreshTaskData = function(self)
  -- function num : 0_6 , upvalues : _ENV, CActivityTasks
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetTasks(CActivityTasks.ANNIVERSARY_DRAW)
  if allTasks then
    for _,value in pairs(allTasks) do
      (table.insert)(self._taskData, value)
    end
    ;
    (table.sort)(self._taskData, function(a, b)
    -- function num : 0_6_0 , upvalues : _ENV
    local _, x = (math.modf)(a:GetStatus() / 3)
    local _, y = (math.modf)(b:GetStatus() / 3)
    if a:GetStatus() == b:GetStatus() then
      if b:GetSortID() >= a:GetSortID() then
        do return x ~= y end
        do return b:GetStatus() < a:GetStatus() end
        do return y < x end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  end
  self:SwitchTalkText()
  ;
  (self._taskFrame):ReloadAllCell()
end

TaskPage.RefreshAwardData = function(self)
  -- function num : 0_7 , upvalues : _ENV, ShowMaxAward, CFirstAnniversaryTask
  for key,_ in pairs(self._awardList) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._awardList)[key] = nil
  end
  local package = ((NekoData.BehaviorManager).BM_Anniversary):GetPackageInfo()
  if package then
    ShowMaxAward(self)
    local award = package.award
    for i,v in ipairs(self._awardData) do
      local process = 0
      local last = CFirstAnniversaryTask:GetRecorder(v.id - 1)
      if package.score > 0 and v.rewardNum <= package.score then
        process = 1
      else
        if last and package.score <= v.rewardNum then
          process = (package.score - last.rewardNum) / (v.rewardNum - last.rewardNum)
        end
      end
      ;
      (table.insert)(self._awardList, {cfg = v, state = award[i], process = process})
    end
    ;
    (self._awardFrame):ReloadAllCell()
    ;
    ((self._score).num):SetText(package.score)
    if ((NekoData.BehaviorManager).BM_Anniversary):HasScoreAward() then
      for k,v in ipairs(self._awardList) do
        if v.state == 1 then
          (self._awardFrame):MoveLeftToIndex(k)
          return 
        end
      end
      ;
      (self._awardFrame):MoveToRight()
    else
      for k,v in ipairs(self._awardList) do
        if v.state == 0 then
          (self._awardFrame):MoveLeftToIndex(k)
          return 
        end
      end
      ;
      (self._awardFrame):MoveToRight()
    end
  end
end

TaskPage.OnBackBtnClicked = function(self)
  -- function num : 0_8
  (self.OnDestroy)()
end

TaskPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._taskFrame then
    return "activity.anniversarypackage.taskcell"
  else
    if frame == self._awardFrame then
      return "activity.anniversarypackage.taskawardcell"
    end
  end
end

TaskPage.NumberOfCell = function(self, frame, index)
  -- function num : 0_10
  if frame == self._taskFrame then
    return #self._taskData
  else
    if frame == self._awardFrame then
      return #self._awardList
    end
  end
end

TaskPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._taskFrame then
    return (self._taskData)[index]
  else
    if frame == self._awardFrame then
      return (self._awardList)[index]
    end
  end
end

TaskPage.SwitchTalkText = function(self, id)
  -- function num : 0_12 , upvalues : CFirstanniversaryCfg, _ENV
  local toShowTalkId = -1
  if self._randomTalkIdList == nil then
    self._randomTalkIdList = {}
    local allIds = CFirstanniversaryCfg:GetAllIds()
    for i = 1, #allIds do
      (table.insert)(self._randomTalkIdList, (CFirstanniversaryCfg:GetRecorder(i)).TextID)
    end
  end
  do
    local randomId = (math.random)(#self._randomTalkIdList)
    if id then
      randomId = id
    end
    toShowTalkId = (self._randomTalkIdList)[randomId]
    ;
    (self._talkText):SetText((TextManager.GetText)(toShowTalkId))
  end
end

TaskPage.OnTipBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(8)
end

TaskPage.OnCommitClick = function(self, id)
  -- function num : 0_14 , upvalues : _ENV, CActivityTasks
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  protocol.activityID = CActivityTasks.ANNIVERSARY_DRAW
  protocol.taskID = id
  protocol:Send()
end

TaskPage.OnCommitMaxAwardClick = function(self)
  -- function num : 0_15
end

TaskPage.OnItemClicked = function(self)
  -- function num : 0_16 , upvalues : CommonAwardsSatus, _ENV
  if self._maxAwardState == CommonAwardsSatus.UNLOCKED then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchanniversarymissionaward")
    csend.awardId = (self._maxAwardData).id
    csend:Send()
  else
    do
      local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({item = self._item})
      end
    end
  end
end

TaskPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_17
  if frame == self._taskFrame then
    local total = (self._taskFrame):GetTotalLength()
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
end

return TaskPage

