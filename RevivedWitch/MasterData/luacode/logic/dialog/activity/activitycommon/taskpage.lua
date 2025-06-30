-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitycommon/taskpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CActivityTasks = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TaskPage = class("TaskPage", Dialog)
TaskPage.AssetBundleName = "ui/layouts.activitycommon"
TaskPage.AssetName = "ActivityCommon1Task"
local ProcessState = {Min = -1, Max = -2}
TaskPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskPage
  ((TaskPage.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._taskData = {}
  self._awardList = {}
end

local GetAwardIndex = function(self, awardId)
  -- function num : 0_1 , upvalues : _ENV
  for i,v in ipairs(self._awardData) do
    if (v.cfg).id == awardId then
      return i
    end
  end
end

local ShowMaxAward = function(self, awardId)
  -- function num : 0_2 , upvalues : Item, _ENV
  self._maxAwardData = (self._awardList)[awardId]
  local state = (self._maxAwardData).state
  ;
  ((self._maxAward).mask):SetActive(false)
  ;
  ((self._maxAward).getBack1):SetActive(state ~= 0)
  ;
  ((self._maxAward).getBack2):SetActive(state == 0)
  ;
  ((self._maxAward).getBtn):SetActive(false)
  ;
  ((self._maxAward).receivedBtn):SetActive(state == 2)
  local itemId = ((self._maxAwardData).cfg).rewardItem
  local needNum = ((self._maxAwardData).cfg).rewardNum
  local maxScore = ((self._maxAwardData).cfg).needNum
  local item = (Item.Create)(itemId)
  ;
  ((self._maxAward).icon):SetSprite(item:GetIconAB())
  ;
  ((self._maxAward).frame):SetSprite(item:GetPinJiImageAB())
  ;
  ((self._maxAward).count):SetText((NumberManager.GetNumber)(needNum))
  ;
  ((self._maxAward).score):SetText(maxScore)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TaskPage.OnCreate = function(self)
  -- function num : 0_3 , upvalues : _ENV, TableFrame
  self._tipTxt = self:GetChild("Back/Text")
  self._scoreNameTxt = self:GetChild("Back/Progress/Text")
  self._endTimeTxt = self:GetChild("Back/EndTimeBack/EndTime")
  ;
  (self:GetChild("Back/ItemBack/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2076))
  ;
  (self:GetChild("Back/Progress/Reward/Item/GetBack2/Text1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1899))
  ;
  (self:GetChild("Back/Progress/Reward/Item/GetBack1/Text2")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  ;
  (self:GetChild("Back/Progress/Reward/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2077))
  self._score = {panel = self:GetChild("Back/ItemBack"), num = self:GetChild("Back/ItemBack/Num"), icon = self:GetChild("Back/ItemBack/Item")}
  ;
  ((self._score).panel):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._maxAward = {panel = self:GetChild("Back/Progress/Reward"), mask = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Mask"), frame = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Frame"), icon = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Icon"), count = self:GetChild("Back/Progress/Reward/Item/ItemCell/_Count"), getBack1 = self:GetChild("Back/Progress/Reward/NumFrame/NumBack1"), getBack2 = self:GetChild("Back/Progress/Reward/NumFrame/NumBack2"), score = self:GetChild("Back/Progress/Reward/NumFrame/Num"), receivedBtn = self:GetChild("Back/Progress/Reward/Item/GetBack1"), getBtn = self:GetChild("Back/Progress/Reward/Item/GetBack2")}
  ;
  ((self._maxAward).panel):SetActive(false)
  self._title = self:GetChild("Back/Title")
  self._taskPanel = self:GetChild("Back/TaskFrame")
  self._awardPanel = self:GetChild("Back/Progress/Frame")
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, false)
  self._awardFrame = (TableFrame.Create)(self._awardPanel, self, false, true, false)
  self._tipBtn = self:GetChild("Back/Tips")
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardData, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardData, Common.n_OnSTaskShopActRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshAwardData, Common.n_OnSReceiveTaskShopAward, nil)
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

TaskPage.Refresh = function(self, delegate, style)
  -- function num : 0_5 , upvalues : Item, CImagePathTable, _ENV
  self._delegate = delegate
  self._style = style
  self._needCurrencyID = (delegate._bm):GetProcessAwardNeedCurrencyId(delegate._actId)
  self._needCurrencyItem = (Item.Create)(self._needCurrencyID)
  local imageRecord = CImagePathTable:GetRecorder(((self._style).cfg).activeTitle)
  if imageRecord then
    (self._title):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self:RefreshAwardData()
  self:RefreshTaskData()
  ;
  (self._tipTxt):SetText((TextManager.GetText)(((self._style).cfg).activeText))
  ;
  (self._scoreNameTxt):SetText((TextManager.GetText)((((self._awardData)[1]).cfg).numName))
  ;
  (self._endTimeTxt):SetText((TextManager.GetText)(((self._style).cfg).activeTime))
end

TaskPage.RefreshTaskData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for key,_ in pairs(self._taskData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._taskData)[key] = nil
  end
  local allTasks = ((self._delegate)._bm):GetTaskList((self._delegate)._actId)
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
      if b:GetID() >= a:GetID() then
        do return x ~= y end
        do return b:GetStatus() < a:GetStatus() end
        do return y < x end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  end
  ;
  (self._taskFrame):ReloadAllCell()
end

TaskPage.RefreshAwardData = function(self)
  -- function num : 0_7 , upvalues : _ENV, GetAwardIndex, ShowMaxAward
  self._awardData = ((self._delegate)._bm):GetProcessAwardCfgList((self._delegate)._actId)
  self._topInfo = {}
  for i,v in ipairs(self._awardData) do
    if (v.cfg).topShow ~= 0 then
      (table.insert)(self._topInfo, {index = i, awardId = (v.cfg).id})
    end
  end
  for key,_ in pairs(self._awardList) do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

    (self._awardList)[key] = nil
  end
  self._currencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._needCurrencyID)
  for i,v in ipairs(self._awardData) do
    local process = 0
    local state = v.isReceived and 1 or 0
    local front = ((self._delegate)._bm):GetProcessAwardCfg((v.cfg).id - 1, (v.cfg).activeID)
    if front then
      if front.needNum <= self._currencyNum then
        local diff = self._currencyNum - front.needNum
        local levelDiff = (v.cfg).needNum - front.needNum
        process = diff / levelDiff
        if levelDiff <= diff then
          state = state + 1
        else
          state = 0
        end
      else
        do
          state = 0
          local diff = self._currencyNum
          do
            do
              local levelDiff = (v.cfg).needNum
              process = diff / levelDiff
              if levelDiff <= diff then
                state = state + 1
              else
                state = 0
              end
              ;
              (table.insert)(self._awardList, {cfg = v.cfg, state = state, process = process, isLast = false})
              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC105: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._awardList)[#self._awardList]).isLast = true
  ;
  (self._awardFrame):ReloadAllCell()
  ;
  ((self._score).num):SetText(self._currencyNum)
  ;
  ((self._score).icon):SetSprite((self._needCurrencyItem):GetIconAB())
  local index = ((NekoData.BehaviorManager).BM_CommonActivity):HasProcessAward((self._delegate)._actId)
  if index then
    index = GetAwardIndex(self, index)
    ;
    (self._awardFrame):MoveLeftToIndex(index)
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
  if self._maxAwardId then
    ShowMaxAward(self, self._maxAwardId)
  end
end

TaskPage.OnBackBtnClicked = function(self)
  -- function num : 0_8
  (self.OnDestroy)()
end

TaskPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._taskFrame then
    return "activity.activitycommon.taskcell"
  else
    if frame == self._awardFrame then
      return "activity.activitycommon.taskawardcell"
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

TaskPage.OnTipBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local tipId = ((self._style).cfg).activeTip
  ;
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(tipId)
end

TaskPage.OnCommitClick = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  protocol.activityID = ((self._delegate)._bm):GetActivityTaskTypeID((self._delegate)._actId)
  protocol.taskID = id
  protocol:Send()
end

TaskPage.OnCommitMaxAwardClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if (self._maxAwardData).state == 1 and ((self._maxAwardData).cfg).needNum <= self._currencyNum then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.creceivetaskshop")
    csend.activityId = (self._delegate)._actId
    csend.rewardID = ((self._maxAwardData).cfg).id
    csend:Send()
  end
end

TaskPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_15 , upvalues : _ENV, ProcessState, GetAwardIndex, ShowMaxAward
  if frame == self._awardFrame and next(self._topInfo) ~= nil then
    local diff = 2
    local curAwardId = ((self._topInfo)[1]).awardId
    local curIndex = (math.ceil)(#self._awardData * proportion) + diff
    local curState = ProcessState.Min
    for i,v in ipairs(self._topInfo) do
      if (self._topInfo)[i - 1] and ((self._topInfo)[i - 1]).index <= curIndex then
        curAwardId = v.awardId
        curState = v.awardId
      end
    end
    if ((self._topInfo)[#self._topInfo]).index + diff <= curIndex then
      curState = ProcessState.Max
    end
    if curState ~= self._topBonusStatus then
      if curState == ProcessState.Max then
        ((self._maxAward).panel):SetActive(true)
        curAwardId = GetAwardIndex(self, curAwardId)
        ShowMaxAward(self, curAwardId)
        self._maxAwardId = curAwardId
        self._topBonusStatus = curState
      end
    end
  end
end

TaskPage.OnItemClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._needCurrencyItem})
  end
end

return TaskPage

