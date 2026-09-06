local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CActivityTasks = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TaskPage = class("TaskPage", Dialog)
TaskPage.AssetBundleName = "ui/layouts.activitycommon"
TaskPage.AssetName = "ActivityCommon1Task"
local ProcessState = {Min = -1, Max = -2}

function TaskPage:Ctor(...)
  TaskPage.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._taskData = {}
  self._awardList = {}
end

local function GetAwardIndex(self, awardId)
  for i, v in ipairs(self._awardData) do
    if v.cfg.id == awardId then
      return i
    end
  end
end

local function ShowMaxAward(self, awardId)
  self._maxAwardData = self._awardList[awardId]
  local state = self._maxAwardData.state
  self._maxAward.mask:SetActive(false)
  self._maxAward.getBack1:SetActive(state ~= 0)
  self._maxAward.getBack2:SetActive(state == 0)
  self._maxAward.getBtn:SetActive(false)
  self._maxAward.receivedBtn:SetActive(state == 2)
  local itemId = self._maxAwardData.cfg.rewardItem
  local needNum = self._maxAwardData.cfg.rewardNum
  local maxScore = self._maxAwardData.cfg.needNum
  local item = Item.Create(itemId)
  self._maxAward.icon:SetSprite(item:GetIconAB())
  self._maxAward.frame:SetSprite(item:GetPinJiImageAB())
  self._maxAward.count:SetText(NumberManager.GetNumber(needNum))
  self._maxAward.score:SetText(maxScore)
end

function TaskPage:OnCreate()
  self._tipTxt = self:GetChild("Back/Text")
  self._scoreNameTxt = self:GetChild("Back/Progress/Text")
  self._endTimeTxt = self:GetChild("Back/EndTimeBack/EndTime")
  self:GetChild("Back/ItemBack/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2076))
  self:GetChild("Back/Progress/Reward/Item/GetBack2/Text1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1899))
  self:GetChild("Back/Progress/Reward/Item/GetBack1/Text2"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  self:GetChild("Back/Progress/Reward/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2077))
  self._score = {
    panel = self:GetChild("Back/ItemBack"),
    num = self:GetChild("Back/ItemBack/Num"),
    icon = self:GetChild("Back/ItemBack/Item")
  }
  self._score.panel:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._maxAward = {
    panel = self:GetChild("Back/Progress/Reward"),
    mask = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Mask"),
    frame = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Frame"),
    icon = self:GetChild("Back/Progress/Reward/Item/ItemCell/_BackGround/Icon"),
    count = self:GetChild("Back/Progress/Reward/Item/ItemCell/_Count"),
    getBack1 = self:GetChild("Back/Progress/Reward/NumFrame/NumBack1"),
    getBack2 = self:GetChild("Back/Progress/Reward/NumFrame/NumBack2"),
    score = self:GetChild("Back/Progress/Reward/NumFrame/Num"),
    receivedBtn = self:GetChild("Back/Progress/Reward/Item/GetBack1"),
    getBtn = self:GetChild("Back/Progress/Reward/Item/GetBack2")
  }
  self._maxAward.panel:SetActive(false)
  self._title = self:GetChild("Back/Title")
  self._taskPanel = self:GetChild("Back/TaskFrame")
  self._awardPanel = self:GetChild("Back/Progress/Frame")
  self._taskFrame = TableFrame.Create(self._taskPanel, self, true, true, false)
  self._awardFrame = TableFrame.Create(self._awardPanel, self, false, true, false)
  self._tipBtn = self:GetChild("Back/Tips")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardData, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTaskData, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardData, Common.n_OnSTaskShopActRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardData, Common.n_OnSReceiveTaskShopAward, nil)
end

function TaskPage:OnDestroy()
  if self._taskFrame then
    self._taskFrame:Destroy()
  end
  if self._awardFrame then
    self._awardFrame:Destroy()
  end
end

function TaskPage:Refresh(delegate, style)
  self._delegate = delegate
  self._style = style
  self._needCurrencyID = delegate._bm:GetProcessAwardNeedCurrencyId(delegate._actId)
  self._needCurrencyItem = Item.Create(self._needCurrencyID)
  local imageRecord = CImagePathTable:GetRecorder(self._style.cfg.activeTitle)
  if imageRecord then
    self._title:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self:RefreshAwardData()
  self:RefreshTaskData()
  self._tipTxt:SetText(TextManager.GetText(self._style.cfg.activeText))
  self._scoreNameTxt:SetText(TextManager.GetText(self._awardData[1].cfg.numName))
  self._endTimeTxt:SetText(TextManager.GetText(self._style.cfg.activeTime))
end

function TaskPage:RefreshTaskData()
  for key, _ in pairs(self._taskData) do
    self._taskData[key] = nil
  end
  local allTasks = self._delegate._bm:GetTaskList(self._delegate._actId)
  if allTasks then
    for _, value in pairs(allTasks) do
      table.insert(self._taskData, value)
    end
    table.sort(self._taskData, function(a, b)
      local _, x = math.modf(a:GetStatus() / 3)
      local _, y = math.modf(b:GetStatus() / 3)
      if x == y then
        if a:GetStatus() == b:GetStatus() then
          return a:GetID() > b:GetID()
        else
          return a:GetStatus() > b:GetStatus()
        end
      else
        return x > y
      end
    end)
  end
  self._taskFrame:ReloadAllCell()
end

function TaskPage:RefreshAwardData()
  self._awardData = self._delegate._bm:GetProcessAwardCfgList(self._delegate._actId)
  self._topInfo = {}
  for i, v in ipairs(self._awardData) do
    if v.cfg.topShow ~= 0 then
      table.insert(self._topInfo, {
        index = i,
        awardId = v.cfg.id
      })
    end
  end
  for key, _ in pairs(self._awardList) do
    self._awardList[key] = nil
  end
  self._currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._needCurrencyID)
  for i, v in ipairs(self._awardData) do
    local process = 0
    local state = v.isReceived and 1 or 0
    local front = self._delegate._bm:GetProcessAwardCfg(v.cfg.id - 1, v.cfg.activeID)
    if front then
      if self._currencyNum >= front.needNum then
        local diff = self._currencyNum - front.needNum
        local levelDiff = v.cfg.needNum - front.needNum
        process = diff / levelDiff
        if diff >= levelDiff then
          state = state + 1
        else
          state = 0
        end
      else
        state = 0
      end
    else
      local diff = self._currencyNum
      local levelDiff = v.cfg.needNum
      process = diff / levelDiff
      if diff >= levelDiff then
        state = state + 1
      else
        state = 0
      end
    end
    table.insert(self._awardList, {
      cfg = v.cfg,
      state = state,
      process = process,
      isLast = false
    })
  end
  self._awardList[#self._awardList].isLast = true
  self._awardFrame:ReloadAllCell()
  self._score.num:SetText(self._currencyNum)
  self._score.icon:SetSprite(self._needCurrencyItem:GetIconAB())
  local index = NekoData.BehaviorManager.BM_CommonActivity:HasProcessAward(self._delegate._actId)
  if index then
    index = GetAwardIndex(self, index)
    self._awardFrame:MoveLeftToIndex(index)
  else
    for k, v in ipairs(self._awardList) do
      if v.state == 0 then
        self._awardFrame:MoveLeftToIndex(k)
        return
      end
    end
    self._awardFrame:MoveToRight()
  end
  if self._maxAwardId then
    ShowMaxAward(self, self._maxAwardId)
  end
end

function TaskPage:OnBackBtnClicked()
  self.OnDestroy()
end

function TaskPage:CellAtIndex(frame, index)
  if frame == self._taskFrame then
    return "activity.activitycommon.taskcell"
  elseif frame == self._awardFrame then
    return "activity.activitycommon.taskawardcell"
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

function TaskPage:OnTipBtnClicked()
  local tipId = self._style.cfg.activeTip
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(tipId)
end

function TaskPage:OnCommitClick(id)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  protocol.activityID = self._delegate._bm:GetActivityTaskTypeID(self._delegate._actId)
  protocol.taskID = id
  protocol:Send()
end

function TaskPage:OnCommitMaxAwardClick()
  if self._maxAwardData.state == 1 and self._currencyNum >= self._maxAwardData.cfg.needNum then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.creceivetaskshop")
    csend.activityId = self._delegate._actId
    csend.rewardID = self._maxAwardData.cfg.id
    csend:Send()
  end
end

function TaskPage:OnCurPosChange(frame, proportion)
  if frame == self._awardFrame and next(self._topInfo) ~= nil then
    local diff = 2
    local curAwardId = self._topInfo[1].awardId
    local curIndex = math.ceil(#self._awardData * proportion) + diff
    local curState = ProcessState.Min
    for i, v in ipairs(self._topInfo) do
      if self._topInfo[i - 1] and curIndex >= self._topInfo[i - 1].index then
        curAwardId = v.awardId
        curState = v.awardId
      end
    end
    if curIndex >= self._topInfo[#self._topInfo].index + diff then
      curState = ProcessState.Max
    end
    if curState ~= self._topBonusStatus then
      if curState == ProcessState.Max then
      else
        self._maxAward.panel:SetActive(true)
        curAwardId = GetAwardIndex(self, curAwardId)
        ShowMaxAward(self, curAwardId)
        self._maxAwardId = curAwardId
      end
      self._topBonusStatus = curState
    end
  end
end

function TaskPage:OnItemClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._needCurrencyItem
    })
  end
end

return TaskPage
