-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/sheet1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Sheet1 = class("Sheet1", Dialog)
Sheet1.AssetBundleName = "ui/layouts.activitylogin"
Sheet1.AssetName = "ActivityLoginTaskMain"
Sheet1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet1, _ENV
  ((Sheet1.super).Ctor)(self, ...)
  self._puzzleData = {}
  self._taskData = {}
  self._boxData = {}
  self._wishBtnCanClick = false
  self._wishData = {}
  self._selectWishIndex = -1
  self._localRewardCfg = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)):GetCLoginMissionAwardCfg()
end

Sheet1.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._activityTime = self:GetChild("ActivityTime")
  self._chipUI = {}
  self._boxUI = {}
  for _,i in ipairs((self._localRewardCfg):GetAllIds()) do
    do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

      (self._chipUI)[i] = {}
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._chipUI)[i]).root = self:GetChild("PuzzleArea/ChipGroup/Chip" .. i)
      ;
      (((self._chipUI)[i]).root):SetActive(false)
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._boxUI)[i] = {}
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).root = self:GetChild("BoxArea/Box" .. i)
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).open = self:GetChild("BoxArea/Box" .. i .. "/BoxOpen")
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).lock = self:GetChild("BoxArea/Box" .. i .. "/BoxLock")
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).canGet = self:GetChild("BoxArea/Box" .. i .. "/Box")
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).text = self:GetChild("BoxArea/Box" .. i .. "/Text")
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._boxUI)[i]).status = 0
      ;
      (((self._boxUI)[i]).root):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnBoxClicked(i)
  end
, self)
    end
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
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareBtnClicked, self)
  ;
  (self._shareItemIcon):Subscribe_PointerClickEvent(self.OnShareItemCellClicked, self)
  self._wishBtn = self:GetChild("Wish")
  ;
  (self._wishBtn):Subscribe_PointerClickEvent(self.OnWishBtnClicked, self)
  self._wishBtnReddot = self:GetChild("Wish/RedDot")
  self._wishRoot = self:GetChild("ActivityLoginWish")
  self._wishBack = self:GetChild("ActivityLoginWish/BigBack")
  ;
  (self._wishRoot):SetActive(false)
  ;
  (self._wishBack):Subscribe_PointerClickEvent(self.OnWishBackClicked, self)
  self._wishPanel = self:GetChild("ActivityLoginWish/Frame")
  self._wishFrame = (TableFrame.Create)(self._wishPanel, self, true, true, true)
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
  ;
  (self._taskDetailItemCell):Subscribe_PointerClickEvent(self.OnTaskDetailItemCellClicked, self)
  ;
  (self._taskDetailGoBtn):Subscribe_PointerClickEvent(self.OnTaskDetailGoBtnClicked, self)
  ;
  (self._taskDetailGoBtn2):Subscribe_PointerClickEvent(self.OnTaskDetailGoBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetShareAndWishData, Common.n_OnSBirthShare, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetShareAndWishData, Common.n_OnSChangeWish, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetShareAndWishData, Common.n_OnSopenBirthReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetChipAndBoxData, Common.n_OnSopenBirthReward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetTaskDetailData, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetTaskDetailData, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSRefreshActivityTask, Common.n_OnSRefreshActivityTask, nil)
  self:SetStaticRes()
end

Sheet1.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, Item
  (self._activityTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1658)).msgTextID))
  ;
  (self._getCellText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2095)).msgTextID))
  ;
  (self._shareBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2096)).msgTextID))
  local allIDs = (self._localRewardCfg):GetAllIds()
  for _,cfgID in ipairs(allIDs) do
    local record = (self._localRewardCfg):GetRecorder(cfgID)
    ;
    (((self._boxUI)[cfgID]).text):SetText((TextManager.GetText)(record.stagenameid))
  end
  local shareRecord = ((BeanManager.GetTableByName)("sharesystem.csharereward")):GetRecorder(5)
  self._shareItem = (Item.Create)((shareRecord.itemID)[1])
  local imageRecord = (self._shareItem):GetIcon()
  ;
  (self._shareItemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._shareItem):GetPinJiImage()
  ;
  (self._shareItemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._shareItemCount):SetNumber((shareRecord.itemNum)[1])
  ;
  (self._rewardProgressText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2087)).msgTextID))
end

Sheet1.OnDestroy = function(self)
  -- function num : 0_3
  if self._wishFrame then
    (self._wishFrame):Destroy()
  end
end

Sheet1.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)
  self:SetShareAndWishData()
  self:SetChipAndBoxData()
  self:SetTaskDetailData()
end

Sheet1.SetShareAndWishData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local allIDs = (self._localRewardCfg):GetAllIds()
  local allGet = (table.all)(allIDs, function(_, v)
    -- function num : 0_5_0 , upvalues : self
    return ((self._bm):GetRewardRecord())[v]
  end
)
  if allGet then
    (self._wishBtn):SetActive(true)
    ;
    (self._wishImg):SetActive(true)
    ;
    (self._shareBtn):SetActive(true)
    ;
    (self._shareItemCell):SetActive(true)
    ;
    (self._wishImgTxt):SetText((self._bm):GetWishRecordText())
    ;
    (self._wishBtnReddot):SetActive((self._bm):GetWishRecord() == -1)
    self._wishBtnCanClick = true
    ;
    (self._shareItemGetMask):SetActive((self._bm):GetShareRecord() == 1)
  else
    (self._wishBtn):SetActive(false)
    ;
    (self._wishImg):SetActive(false)
    ;
    (self._shareBtn):SetActive(false)
    ;
    (self._shareItemCell):SetActive(false)
    ;
    (self._wishBtnReddot):SetActive(false)
    self._wishBtnCanClick = false
    ;
    (self._shareItemGetMask):SetActive(false)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

Sheet1.SetChipAndBoxData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local remoteRewardData = (self._bm):GetRewardRecord()
  local allIDs = (self._localRewardCfg):GetAllIds()
  local lastCanGetBox = 0
  for _,cfgID in ipairs(allIDs) do
    local record = (self._localRewardCfg):GetRecorder(cfgID)
    if remoteRewardData[cfgID] then
      (((self._chipUI)[cfgID]).root):SetActive(false)
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self._boxUI)[cfgID]).status = 2
      ;
      (((self._boxUI)[cfgID]).open):SetActive(true)
      ;
      (((self._boxUI)[cfgID]).lock):SetActive(false)
      ;
      (((self._boxUI)[cfgID]).canGet):SetActive(false)
      lastCanGetBox = cfgID
    else
      ;
      (((self._chipUI)[cfgID]).root):SetActive(true)
      ;
      (((self._boxUI)[cfgID]).open):SetActive(false)
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R10 in 'UnsetPending'

      if (self._bm):GetBoxCanGetStatus(record.missionid) then
        ((self._boxUI)[cfgID]).status = 1
        ;
        (((self._boxUI)[cfgID]).canGet):SetActive(true)
        ;
        (((self._boxUI)[cfgID]).lock):SetActive(false)
        lastCanGetBox = cfgID
      else
        -- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((self._boxUI)[cfgID]).status = 0
        ;
        (((self._boxUI)[cfgID]).canGet):SetActive(false)
        ;
        (((self._boxUI)[cfgID]).lock):SetActive(true)
      end
    end
  end
  ;
  (self._rewardProgress):SetFillAmount((self._bm):GetBoxProgressNum(lastCanGetBox))
end

Sheet1.OnBoxClicked = function(self, rewardID)
  -- function num : 0_7 , upvalues : _ENV
  local record = (self._localRewardCfg):GetRecorder(rewardID)
  local dialog = (DialogManager.CreateSingletonDialog)("activity.birthday.rewarddetaildialog")
  if dialog then
    dialog:SetData(rewardID, ((self._boxUI)[rewardID]).status, record.costid, record.costnum, record.rewarditem, record.rewardnum)
  end
end

Sheet1.OnShareItemCellClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local width, height = (self._shareItemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._shareItem})
    tipsDialog:SetTipsPosition(width, height, (self._shareItemCell):GetLocalPointInUiRootPanel())
  end
end

Sheet1.OnTipsBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  local dialogName = "activity.birthday.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1657)).msgTextID, (CStringRes:GetRecorder(1656)).msgTextID)
  end
end

Sheet1.OnShareBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if (self._bm):GetWishRecord() == -1 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100429)
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("activity.birthday.sharefullscreendialog")
  if dialog then
    dialog:SetData()
  end
end

Sheet1.OnWishBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self._wishBtnCanClick then
    return 
  end
  ;
  (self._wishRoot):SetActive(true)
  local wishCfg = (self._bm):GetCLoginWishCfg()
  do
    if next(self._wishData) == nil then
      local allIDs = wishCfg:GetAllIds()
      for _,id in ipairs(allIDs) do
        local record = wishCfg:GetRecorder(id)
        ;
        (table.insert)(self._wishData, {textID = record.TextID, sortID = record.sequence, select = false, index = #self._wishData + 1})
      end
      ;
      (table.sort)(self._wishData, function(a, b)
    -- function num : 0_11_0
    do return a.sortID < b.sortID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    self._selectWishIndex = (self._bm):GetWishRecord()
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

    if self._selectWishIndex ~= -1 then
      ((self._wishData)[self._selectWishIndex]).select = true
    end
    ;
    (self._wishFrame):ReloadAllCell()
  end
end

Sheet1.OnOneCellClicked = function(self, index)
  -- function num : 0_12 , upvalues : _ENV
  self._selectWishIndex = index
  for key,value in ipairs(self._wishData) do
    value.select = key == index
  end
  local lastPos = (self._wishFrame):GetCurrentPosition()
  ;
  (self._wishFrame):ReloadAllCell()
  if lastPos then
    (self._wishFrame):MoveToAssignedPos(lastPos)
  end
  ;
  (self._bm):SendCChangeWish(self._selectWishIndex)
  ;
  (self._wishRoot):SetActive(false)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Sheet1.OnWishBackClicked = function(self)
  -- function num : 0_13
  (self._wishRoot):SetActive(false)
end

Sheet1.NumberOfCell = function(self, frame, index)
  -- function num : 0_14
  return #self._wishData
end

Sheet1.CellAtIndex = function(self, frame, index)
  -- function num : 0_15
  return "activity.birthday.wishcell"
end

Sheet1.DataAtIndex = function(self, frame, index)
  -- function num : 0_16
  return (self._wishData)[index]
end

Sheet1.SetTaskDetailData = function(self)
  -- function num : 0_17 , upvalues : _ENV, Item, TaskStatus, CStringRes
  self._firstProcessingTask = (self._bm):GetNowTaskState()
  local remoteTaskData = ((NekoData.BehaviorManager).BM_ActivityTasks):GetBirthDayTasks()
  local localTaskData = (self._bm):GetCLoginMission()
  -- DECOMPILER ERROR at PC14: Overwrote pending register: R3 in 'AssignReg'

  -- DECOMPILER ERROR at PC15: Overwrote pending register: R3 in 'AssignReg'

  R3_PC3(R3_PC3, self._canAcceptTask)
  -- DECOMPILER ERROR at PC18: Overwrote pending register: R3 in 'AssignReg'

  -- DECOMPILER ERROR at PC21: Overwrote pending register: R3 in 'AssignReg'

  if R3_PC3 ~= nil then
    self._taskDetailTask = R3_PC3
  else
    -- DECOMPILER ERROR at PC24: Overwrote pending register: R3 in 'AssignReg'

    -- DECOMPILER ERROR at PC27: Overwrote pending register: R3 in 'AssignReg'

    if R3_PC3 ~= nil then
      self._taskDetailTask = R3_PC3
    else
      -- DECOMPILER ERROR at PC30: Overwrote pending register: R3 in 'AssignReg'

      R3_PC3 = R3_PC3(localTaskData)
      R3_PC3 = R3_PC3[#localTaskData:GetAllIds()]
      local lastID = nil
      local lastTask = remoteTaskData[lastID]
      if lastTask then
        self._taskDetailTask = lastTask
      end
    end
  end
  do
    if self._taskDetailTask then
      local taskCfg = (self._taskDetailTask):GetConfig()
      local taskDescription = taskCfg.descriptionTextID
      ;
      (self._taskDetailTxt01):SetText((TextManager.GetText)(taskDescription[1]))
      ;
      (self._taskDetailTxt02):SetText((TextManager.GetText)(taskDescription[2]))
      ;
      (self._taskDetailTxt03):SetText((TextManager.GetText)(taskDescription[3]))
      self._taskDetailItem = (Item.Create)(taskCfg.itemid)
      local imageRecord = (self._taskDetailItem):GetIcon()
      ;
      (self._taskDetailItemCellIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (self._taskDetailItem):GetPinJiImage()
      ;
      (self._taskDetailItemCellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._taskDetailItemCellCount):SetNumber(taskCfg.itemnum)
      if (self._taskDetailTask):GetStatus() == TaskStatus.ACCEPTED then
        (self._taskDetailGoBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1659)).msgTextID))
        ;
        (self._taskDetailGoBtn2Text):SetText((TextManager.GetText)((CStringRes:GetRecorder(1659)).msgTextID))
      else
        ;
        (self._taskDetailGoBtnText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1660)).msgTextID))
        ;
        (self._taskDetailGoBtn2Text):SetText((TextManager.GetText)((CStringRes:GetRecorder(1660)).msgTextID))
      end
      if self._canAcceptTask or (self._taskDetailTask):GetStatus() == TaskStatus.PROCESSING then
        (self._taskDetailGoBtn):SetActive(true)
        ;
        (self._taskDetailGoBtn2):SetActive(false)
      else
        if self._firstAcceptedTask then
          (self._taskDetailGoBtn):SetActive(false)
          ;
          (self._taskDetailGoBtn2):SetActive(true)
        else
          ;
          (self._taskDetailGoBtn):SetActive(false)
          ;
          (self._taskDetailGoBtn2):SetActive(true)
        end
      end
    else
      do
        LogError("Sheet1:SetTaskDetailData", "There are no tasks to display.")
      end
    end
  end
end

Sheet1.OnSRefreshActivityTask = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV, TaskStatus
  if (notification.userInfo).activityID ~= self._activityID then
    return 
  end
  local taskID = ((notification.userInfo).taskinfo).taskid
  local remoteTaskData = ((NekoData.BehaviorManager).BM_ActivityTasks):GetBirthDayTasks()
  local theTask = remoteTaskData[taskID]
  if theTask:GetStatus() ~= TaskStatus.PROCESSING then
    return 
  end
  if theTask:GetID() == 120001 then
    self:SetTaskDetailData()
    return 
  end
  if (DataCommon.BirtDayTimeLineId)[taskID] == nil then
    LogErrorFormat("Sheet1:OnSRefreshActivityTask", "No BirtDayTimeLineId %d.", taskID)
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("activity.birthday.maindialog")
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if sceneController then
    (sceneController._baseMainFSM):SetNumber("storyId", (DataCommon.BirtDayTimeLineId)[taskID])
  end
end

Sheet1.OnTaskDetailGoBtnClicked = function(self)
  -- function num : 0_19 , upvalues : TaskStatus, _ENV
  if self._canAcceptTask then
    self._activityID = (self._bm):SendCAcceptActivityTask((self._taskDetailTask):GetID())
  else
    if (self._taskDetailTask):GetStatus() == TaskStatus.PROCESSING then
      ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._taskDetailTask)
    else
      if self._firstAcceptedTask then
        LogInfo("Sheet1:OnCharBtnClicked", "Today\'s task has been completed.")
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100424)
      else
        LogInfo("Sheet1:OnCharBtnClicked", "All tasks have been completed.")
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100426)
      end
    end
  end
end

Sheet1.OnTaskDetailItemCellClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local width, height = (self._taskDetailItemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._taskDetailItem})
    tipsDialog:SetTipsPosition(width, height, (self._taskDetailItemCell):GetLocalPointInUiRootPanel())
  end
end

return Sheet1

