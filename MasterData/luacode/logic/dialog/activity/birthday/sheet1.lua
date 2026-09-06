local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitylogin"
Sheet1.AssetName = "ActivityLoginTaskMain"

function Sheet1:Ctor(...)
  Sheet1.super.Ctor(self, ...)
  self._puzzleData = {}
  self._taskData = {}
  self._boxData = {}
  self._wishBtnCanClick = false
  self._wishData = {}
  self._selectWishIndex = -1
  self._localRewardCfg = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID):GetCLoginMissionAwardCfg()
end

function Sheet1:OnCreate()
  self._tipsBtn = self:GetChild("Tips")
  self._tipsBtn:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._activityTime = self:GetChild("ActivityTime")
  self._chipUI = {}
  self._boxUI = {}
  for _, i in ipairs(self._localRewardCfg:GetAllIds()) do
    self._chipUI[i] = {}
    self._chipUI[i].root = self:GetChild("PuzzleArea/ChipGroup/Chip" .. i)
    self._chipUI[i].root:SetActive(false)
    self._boxUI[i] = {}
    self._boxUI[i].root = self:GetChild("BoxArea/Box" .. i)
    self._boxUI[i].open = self:GetChild("BoxArea/Box" .. i .. "/BoxOpen")
    self._boxUI[i].lock = self:GetChild("BoxArea/Box" .. i .. "/BoxLock")
    self._boxUI[i].canGet = self:GetChild("BoxArea/Box" .. i .. "/Box")
    self._boxUI[i].text = self:GetChild("BoxArea/Box" .. i .. "/Text")
    self._boxUI[i].status = 0
    self._boxUI[i].root:Subscribe_PointerClickEvent(function()
      self:OnBoxClicked(i)
    end, self)
  end
  self._wishImg = self:GetChild("PuzzleArea/WishImg")
  self._wishImgTxt = self:GetChild("PuzzleArea/WishImg/Text")
  self._shareBtn = self:GetChild("PuzzleArea/ShareBtn")
  self._shareItemCell = self:GetChild("PuzzleArea/TaskCellItem")
  self._shareItemCount = self:GetChild("PuzzleArea/TaskCellItem/Panel/ItemCell/_Count")
  self._shareItemIcon = self:GetChild("PuzzleArea/TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._shareItemFrame = self:GetChild("PuzzleArea/TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._shareItemGetMask = self:GetChild("PuzzleArea/TaskCellItem/ItemGet")
  self._getCellText = self:GetChild("PuzzleArea/TaskCellItem/ItemGet/Tips")
  self._shareBtnText = self:GetChild("PuzzleArea/ShareBtn/_Text")
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareBtnClicked, self)
  self._shareItemIcon:Subscribe_PointerClickEvent(self.OnShareItemCellClicked, self)
  self._wishBtn = self:GetChild("Wish")
  self._wishBtn:Subscribe_PointerClickEvent(self.OnWishBtnClicked, self)
  self._wishBtnReddot = self:GetChild("Wish/RedDot")
  self._wishRoot = self:GetChild("ActivityLoginWish")
  self._wishBack = self:GetChild("ActivityLoginWish/BigBack")
  self._wishRoot:SetActive(false)
  self._wishBack:Subscribe_PointerClickEvent(self.OnWishBackClicked, self)
  self._wishPanel = self:GetChild("ActivityLoginWish/Frame")
  self._wishFrame = TableFrame.Create(self._wishPanel, self, true, true, true)
  self._rewardProgress = self:GetChild("BoxArea/ProgressBack/Progress")
  self._rewardProgressText = self:GetChild("BoxArea/ProgressBack/Text")
  self._taskDetailTxt01 = self:GetChild("ActivityLoginTask/Detail")
  self._taskDetailTxt02 = self:GetChild("ActivityLoginTask/Tip")
  self._taskDetailTxt03 = self:GetChild("ActivityLoginTask/ProgressName")
  self._taskDetailGoBtn = self:GetChild("ActivityLoginTask/GoBtn")
  self._taskDetailGoBtnText = self:GetChild("ActivityLoginTask/GoBtn/Text")
  self._taskDetailRedDot = self:GetChild("ActivityLoginTask/GoBtn/RedDot")
  self._taskDetailGoBtn2 = self:GetChild("ActivityLoginTask/GoBtn2")
  self._taskDetailGoBtn2Text = self:GetChild("ActivityLoginTask/GoBtn2/Text")
  self._taskDetailItemCell = self:GetChild("ActivityLoginTask/TaskCellItem")
  self._taskDetailItemCellIcon = self:GetChild("ActivityLoginTask/TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._taskDetailItemCellCount = self:GetChild("ActivityLoginTask/TaskCellItem/Panel/ItemCell/_Count")
  self._taskDetailItemCellFrame = self:GetChild("ActivityLoginTask/TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._taskDetailItemCell:Subscribe_PointerClickEvent(self.OnTaskDetailItemCellClicked, self)
  self._taskDetailGoBtn:Subscribe_PointerClickEvent(self.OnTaskDetailGoBtnClicked, self)
  self._taskDetailGoBtn2:Subscribe_PointerClickEvent(self.OnTaskDetailGoBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.SetShareAndWishData, Common.n_OnSBirthShare, nil)
  LuaNotificationCenter.AddObserver(self, self.SetShareAndWishData, Common.n_OnSChangeWish, nil)
  LuaNotificationCenter.AddObserver(self, self.SetShareAndWishData, Common.n_OnSopenBirthReward, nil)
  LuaNotificationCenter.AddObserver(self, self.SetChipAndBoxData, Common.n_OnSopenBirthReward, nil)
  LuaNotificationCenter.AddObserver(self, self.SetTaskDetailData, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.SetTaskDetailData, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSRefreshActivityTask, Common.n_OnSRefreshActivityTask, nil)
  self:SetStaticRes()
end

function Sheet1:SetStaticRes()
  self._activityTime:SetText(TextManager.GetText(CStringRes:GetRecorder(1658).msgTextID))
  self._getCellText:SetText(TextManager.GetText(CStringRes:GetRecorder(2095).msgTextID))
  self._shareBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(2096).msgTextID))
  local allIDs = self._localRewardCfg:GetAllIds()
  for _, cfgID in ipairs(allIDs) do
    local record = self._localRewardCfg:GetRecorder(cfgID)
    self._boxUI[cfgID].text:SetText(TextManager.GetText(record.stagenameid))
  end
  local shareRecord = BeanManager.GetTableByName("sharesystem.csharereward"):GetRecorder(5)
  self._shareItem = Item.Create(shareRecord.itemID[1])
  local imageRecord = self._shareItem:GetIcon()
  self._shareItemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._shareItem:GetPinJiImage()
  self._shareItemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._shareItemCount:SetNumber(shareRecord.itemNum[1])
  self._rewardProgressText:SetText(TextManager.GetText(CStringRes:GetRecorder(2087).msgTextID))
end

function Sheet1:OnDestroy()
  if self._wishFrame then
    self._wishFrame:Destroy()
  end
end

function Sheet1:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID)
  self:SetShareAndWishData()
  self:SetChipAndBoxData()
  self:SetTaskDetailData()
end

function Sheet1:SetShareAndWishData()
  local allIDs = self._localRewardCfg:GetAllIds()
  local allGet = table.all(allIDs, function(_, v)
    return self._bm:GetRewardRecord()[v]
  end)
  if allGet then
    self._wishBtn:SetActive(true)
    self._wishImg:SetActive(true)
    self._shareBtn:SetActive(true)
    self._shareItemCell:SetActive(false)
    self._wishImgTxt:SetText(self._bm:GetWishRecordText())
    self._wishBtnReddot:SetActive(false)
    self._wishBtnCanClick = true
    self._shareItemGetMask:SetActive(self._bm:GetShareRecord() == 1)
  else
    self._wishBtn:SetActive(false)
    self._wishImg:SetActive(false)
    self._shareBtn:SetActive(false)
    self._shareItemCell:SetActive(false)
    self._wishBtnReddot:SetActive(false)
    self._wishBtnCanClick = false
    self._shareItemGetMask:SetActive(false)
  end
end

function Sheet1:SetChipAndBoxData()
  local remoteRewardData = self._bm:GetRewardRecord()
  local allIDs = self._localRewardCfg:GetAllIds()
  local lastCanGetBox = 0
  for _, cfgID in ipairs(allIDs) do
    local record = self._localRewardCfg:GetRecorder(cfgID)
    if remoteRewardData[cfgID] then
      self._chipUI[cfgID].root:SetActive(false)
      self._boxUI[cfgID].status = 2
      self._boxUI[cfgID].open:SetActive(true)
      self._boxUI[cfgID].lock:SetActive(false)
      self._boxUI[cfgID].canGet:SetActive(false)
      lastCanGetBox = cfgID
    else
      self._chipUI[cfgID].root:SetActive(true)
      self._boxUI[cfgID].open:SetActive(false)
      if self._bm:GetBoxCanGetStatus(record.missionid) then
        self._boxUI[cfgID].status = 1
        self._boxUI[cfgID].canGet:SetActive(true)
        self._boxUI[cfgID].lock:SetActive(false)
        lastCanGetBox = cfgID
      else
        self._boxUI[cfgID].status = 0
        self._boxUI[cfgID].canGet:SetActive(false)
        self._boxUI[cfgID].lock:SetActive(true)
      end
    end
  end
  self._rewardProgress:SetFillAmount(self._bm:GetBoxProgressNum(lastCanGetBox))
end

function Sheet1:OnBoxClicked(rewardID)
  local record = self._localRewardCfg:GetRecorder(rewardID)
  local dialog = DialogManager.CreateSingletonDialog("activity.birthday.rewarddetaildialog")
  if dialog then
    dialog:SetData(rewardID, self._boxUI[rewardID].status, record.costid, record.costnum, record.rewarditem, record.rewardnum)
  end
end

function Sheet1:OnShareItemCellClicked()
  local width, height = self._shareItemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._shareItem
    })
    tipsDialog:SetTipsPosition(width, height, self._shareItemCell:GetLocalPointInUiRootPanel())
  end
end

function Sheet1:OnTipsBtnClicked()
  local dialogName = "activity.birthday.tipsdialog"
  local dialog = DialogManager.CreateSingletonDialog(dialogName)
  if dialog then
    dialog:SetData(CStringRes:GetRecorder(1657).msgTextID, CStringRes:GetRecorder(1656).msgTextID)
  end
end

function Sheet1:OnShareBtnClicked()
  if self._bm:GetWishRecord() == -1 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100429)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("activity.birthday.sharefullscreendialog")
  if dialog then
    dialog:SetData()
  end
end

function Sheet1:OnWishBtnClicked()
  if not self._wishBtnCanClick then
    return
  end
  self._wishRoot:SetActive(true)
  local wishCfg = self._bm:GetCLoginWishCfg()
  if next(self._wishData) == nil then
    local allIDs = wishCfg:GetAllIds()
    for _, id in ipairs(allIDs) do
      local record = wishCfg:GetRecorder(id)
      table.insert(self._wishData, {
        textID = record.TextID,
        sortID = record.sequence,
        select = false,
        index = #self._wishData + 1
      })
    end
    table.sort(self._wishData, function(a, b)
      return a.sortID < b.sortID
    end)
  end
  self._selectWishIndex = self._bm:GetWishRecord()
  if self._selectWishIndex ~= -1 then
    self._wishData[self._selectWishIndex].select = true
  end
  self._wishFrame:ReloadAllCell()
end

function Sheet1:OnOneCellClicked(index)
  self._selectWishIndex = index
  for key, value in ipairs(self._wishData) do
    value.select = key == index
  end
  local lastPos = self._wishFrame:GetCurrentPosition()
  self._wishFrame:ReloadAllCell()
  if lastPos then
    self._wishFrame:MoveToAssignedPos(lastPos)
  end
  self._bm:SendCChangeWish(self._selectWishIndex)
  self._wishRoot:SetActive(false)
end

function Sheet1:OnWishBackClicked()
  self._wishRoot:SetActive(false)
end

function Sheet1:NumberOfCell(frame, index)
  return #self._wishData
end

function Sheet1:CellAtIndex(frame, index)
  return "activity.birthday.wishcell"
end

function Sheet1:DataAtIndex(frame, index)
  return self._wishData[index]
end

function Sheet1:SetTaskDetailData()
  self._firstProcessingTask, self._firstAcceptedTask, self._canAcceptTask = self._bm:GetNowTaskState()
  local remoteTaskData = NekoData.BehaviorManager.BM_ActivityTasks:GetBirthDayTasks()
  local localTaskData = self._bm:GetCLoginMission()
  self._taskDetailRedDot:SetActive(self._canAcceptTask)
  if self._firstProcessingTask ~= nil then
    self._taskDetailTask = self._firstProcessingTask
  elseif self._firstAcceptedTask ~= nil then
    self._taskDetailTask = self._firstAcceptedTask
  else
    local lastID = localTaskData:GetAllIds()[#localTaskData:GetAllIds()]
    local lastTask = remoteTaskData[lastID]
    if lastTask then
      self._taskDetailTask = lastTask
    end
  end
  if self._taskDetailTask then
    local taskCfg = self._taskDetailTask:GetConfig()
    local taskDescription = taskCfg.descriptionTextID
    self._taskDetailTxt01:SetText(TextManager.GetText(taskDescription[1]))
    self._taskDetailTxt02:SetText(TextManager.GetText(taskDescription[2]))
    self._taskDetailTxt03:SetText(TextManager.GetText(taskDescription[3]))
    self._taskDetailItem = Item.Create(taskCfg.itemid)
    local imageRecord = self._taskDetailItem:GetIcon()
    self._taskDetailItemCellIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = self._taskDetailItem:GetPinJiImage()
    self._taskDetailItemCellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._taskDetailItemCellCount:SetNumber(taskCfg.itemnum)
    if self._taskDetailTask:GetStatus() == TaskStatus.ACCEPTED then
      self._taskDetailGoBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1659).msgTextID))
      self._taskDetailGoBtn2Text:SetText(TextManager.GetText(CStringRes:GetRecorder(1659).msgTextID))
    else
      self._taskDetailGoBtnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1660).msgTextID))
      self._taskDetailGoBtn2Text:SetText(TextManager.GetText(CStringRes:GetRecorder(1660).msgTextID))
    end
    if self._canAcceptTask or self._taskDetailTask:GetStatus() == TaskStatus.PROCESSING then
      self._taskDetailGoBtn:SetActive(true)
      self._taskDetailGoBtn2:SetActive(false)
    elseif self._firstAcceptedTask then
      self._taskDetailGoBtn:SetActive(false)
      self._taskDetailGoBtn2:SetActive(true)
    else
      self._taskDetailGoBtn:SetActive(false)
      self._taskDetailGoBtn2:SetActive(true)
    end
  else
    LogError("Sheet1:SetTaskDetailData", "There are no tasks to display.")
  end
end

function Sheet1:OnSRefreshActivityTask(notification)
  if notification.userInfo.activityID ~= self._activityID then
    return
  end
  local taskID = notification.userInfo.taskinfo.taskid
  local remoteTaskData = NekoData.BehaviorManager.BM_ActivityTasks:GetBirthDayTasks()
  local theTask = remoteTaskData[taskID]
  if theTask:GetStatus() ~= TaskStatus.PROCESSING then
    return
  end
  if theTask:GetID() == 120001 then
    self:SetTaskDetailData()
    return
  end
  if DataCommon.BirtDayTimeLineId[taskID] == nil then
    LogErrorFormat("Sheet1:OnSRefreshActivityTask", "No BirtDayTimeLineId %d.", taskID)
    return
  end
  DialogManager.DestroySingletonDialog("activity.birthday.maindialog")
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if sceneController then
    sceneController._baseMainFSM:SetNumber("storyId", DataCommon.BirtDayTimeLineId[taskID])
  end
end

function Sheet1:OnTaskDetailGoBtnClicked()
  if self._canAcceptTask then
    self._activityID = self._bm:SendCAcceptActivityTask(self._taskDetailTask:GetID())
  elseif self._taskDetailTask:GetStatus() == TaskStatus.PROCESSING then
    NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._taskDetailTask)
  elseif self._firstAcceptedTask then
    LogInfo("Sheet1:OnCharBtnClicked", "Today's task has been completed.")
    NekoData.BehaviorManager.BM_Message:SendMessageById(100424)
  else
    LogInfo("Sheet1:OnCharBtnClicked", "All tasks have been completed.")
    NekoData.BehaviorManager.BM_Message:SendMessageById(100426)
  end
end

function Sheet1:OnTaskDetailItemCellClicked()
  local width, height = self._taskDetailItemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._taskDetailItem
    })
    tipsDialog:SetTipsPosition(width, height, self._taskDetailItemCell:GetLocalPointInUiRootPanel())
  end
end

return Sheet1
