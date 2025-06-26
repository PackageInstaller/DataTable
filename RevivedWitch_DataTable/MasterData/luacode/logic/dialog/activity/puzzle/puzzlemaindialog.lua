-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/puzzle/puzzlemaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CJigsawreSourceConfig = (BeanManager.GetTableByName)("activity.cjigsawresourceconfig")
local CJigsawMissionAward = (BeanManager.GetTableByName)("mission.cjigsawmissionaward")
local CalbumConfig = (BeanManager.GetTableByName)("handbook.calbumconfig")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local Item = require("logic.manager.experimental.types.item")
local PuzzleMainDialog = class("PuzzleMainDialog", Dialog)
PuzzleMainDialog.AssetBundleName = "ui/layouts.activitypuzzle"
PuzzleMainDialog.AssetName = "ActivityPuzzleMain"
PuzzleMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PuzzleMainDialog
  ((PuzzleMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

local Limit = 12
PuzzleMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._taskCells = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

      (self._taskCells)[i] = {}
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).cell = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).title = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Title")
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).progress = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Progress")
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).num = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Num/Num")
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).numMax = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Num/NumMax")
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).doneBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/DoneBtn")
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).goBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/GoBtn")
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).getBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/GetBtn")
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).item = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Item")
      -- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._taskCells)[i]).cout = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Num")
      ;
      (((self._taskCells)[i]).goBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGoBtnClick(i)
  end
)
      ;
      (((self._taskCells)[i]).getBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnGetBtnClick(i)
  end
)
    end
  end
  self._currency = {curNum = self:GetChild("BackImage/TaskBack/CurrentNum/Num"), maxNum = self:GetChild("BackImage/TaskBack/MaxNum/Num"), curicon = self:GetChild("BackImage/TaskBack/CurrentNum/Item"), maxicon = self:GetChild("BackImage/TaskBack/MaxNum/Item")}
  self._boxs = {}
  self._progress = self:GetChild("BackImage/BoxArea/ProgressBack/progress")
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R5 in 'UnsetPending'

    (self._boxs)[i] = {}
    -- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).num = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Num")
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).dot = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Dot")
    -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).dotGrey = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/DotGrey")
    -- DECOMPILER ERROR at PC178: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).get = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Get")
    -- DECOMPILER ERROR at PC187: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).effect = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Effect")
    -- DECOMPILER ERROR at PC196: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).icon = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Icon")
    -- DECOMPILER ERROR at PC205: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).frame = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Frame")
    -- DECOMPILER ERROR at PC214: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).select = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Select")
    -- DECOMPILER ERROR at PC223: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._boxs)[i]).count = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_Count")
    ;
    (((self._boxs)[i]).select):SetActive(false)
    ;
    (((self._boxs)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnAwardCellClicked(i)
  end
)
  end
  self.puzzles = {}
  for i = 1, 12 do
    -- DECOMPILER ERROR at PC246: Confused about usage of register: R5 in 'UnsetPending'

    (self.puzzles)[i] = {}
    -- DECOMPILER ERROR at PC254: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.puzzles)[i]).lock = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Puzzle" .. i)
    -- DECOMPILER ERROR at PC263: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.puzzles)[i]).num = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Puzzle" .. i .. "/Num")
    ;
    (((self.puzzles)[i]).lock):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, i
    self:OnPuzzleGetClick(i)
  end
)
  end
  self._line = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Image")
  self._puzzleImg = self:GetChild("BackImage/PuzzleArea/PuzzleImg")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tipbtn = self:GetChild("BackImage/Ibtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._tipbtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTasks, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTasks, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGetNewPuzzle, Common.n_OnGetNewPuzzle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshBoxs, Common.n_OnSRefreshPuzzlesAwards, nil)
end

PuzzleMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("activity.puzzle.puzzletipdialog")
end

PuzzleMainDialog.Init = function(self, id)
  -- function num : 0_3 , upvalues : CJigsawreSourceConfig, Item, _ENV, CJigsawMissionAward, CalbumConfig, CImagePathTable
  self._actId = id
  self._maxNum = (CJigsawreSourceConfig:GetRecorder(self._actId)).limit
  ;
  ((self._currency).maxNum):SetText(self._maxNum)
  local item = (Item.Create)(DataCommon.MemoryPieces)
  local imageRecord = item:GetIcon()
  ;
  ((self._currency).curicon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  ((self._currency).maxicon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._rewardIds = CJigsawMissionAward:GetAllIds()
  self:RefreshTasks()
  self:RefreshCurrency()
  self:RefreshBoxs()
  self:RefreshPuzzles()
  for k,v in pairs(CalbumConfig:GetAllIds()) do
    local record = CalbumConfig:GetRecorder(v)
    if record and record.event_id == id then
      if not CImagePathTable:GetRecorder(record.picture) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._puzzleImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      break
    end
  end
end

PuzzleMainDialog.RefreshTasks = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskStatus, TasksProtocolDef
  local tasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetPuzzleTasks()
  for i = 1, 3 do
    (((self._taskCells)[i]).cell):SetActive(false)
  end
  do
    if not tasks or next(tasks) == nil then
      return 
    end
    local id = 1
    self._task = {}
    for i,task in pairs(tasks) do
      (((self._taskCells)[id]).cell):SetActive(true)
      ;
      (((self._taskCells)[id]).title):SetText(task:GetDesc())
      local reward = (task:GetAwards())[1]
      local imageRecord = reward:GetIcon()
      ;
      (((self._taskCells)[id]).item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (((self._taskCells)[id]).cout):SetText(reward:GetCount())
      ;
      (((self._taskCells)[id]).progress):SetFillAmount(((task:GetProgress())[1]).current / ((task:GetProgress())[1]).total)
      ;
      (((self._taskCells)[id]).num):SetText(((task:GetProgress())[1]).current)
      ;
      (((self._taskCells)[id]).numMax):SetText(((task:GetProgress())[1]).total)
      if task:GetStatus() == TaskStatus.PROCESSING or task:IsLock() then
        (((self._taskCells)[id]).goBtn):SetActive(task:CanJump())
        ;
        (((self._taskCells)[id]).getBtn):SetActive(false)
        ;
        (((self._taskCells)[id]).doneBtn):SetActive(false)
      else
        if task:GetStatus() == TaskStatus.FINISHED then
          (((self._taskCells)[id]).goBtn):SetActive(false)
          ;
          (((self._taskCells)[id]).getBtn):SetActive(true)
          ;
          (((self._taskCells)[id]).doneBtn):SetActive(false)
        else
          if task:GetStatus() == TaskStatus.COMMITED then
            (((self._taskCells)[id]).goBtn):SetActive(false)
            ;
            (((self._taskCells)[id]).getBtn):SetActive(false)
            ;
            (((self._taskCells)[id]).doneBtn):SetActive(true)
          else
            LogError("taskstatus", task:GetStatus())
            ;
            (((self._taskCells)[id]).goBtn):SetActive(false)
            ;
            (((self._taskCells)[id]).getBtn):SetActive(false)
            ;
            (((self._taskCells)[id]).doneBtn):SetActive(false)
          end
        end
      end
      if id > 3 then
        LogError("PuzzleMainDialog", "Task beyond bounds")
        break
      end
      if not ((NekoData.BehaviorManager).BM_ActivityTasks):HaveFinishedTask(TasksProtocolDef.JIGSAW_PUZZLE) then
        (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, nil)
      end
      ;
      (table.insert)(self._task, task)
      id = id + 1
    end
  end
end

PuzzleMainDialog.RefreshCurrency = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._memoryPiecesNum = ((NekoData.BehaviorManager).BM_Currency):GetMemoryPieces()
  ;
  ((self._currency).curNum):SetText(self._memoryPiecesNum)
end

PuzzleMainDialog.RefreshBoxs = function(self)
  -- function num : 0_6 , upvalues : _ENV, CJigsawMissionAward, Item, Limit
  local boxs = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleBoxsData(self._actId, self._memoryPiecesNum)
  if next(boxs) == nil then
    return 
  end
  local imageRecord = nil
  for k,v in pairs(self._rewardIds) do
    local record = CJigsawMissionAward:GetRecorder(v)
    local item = (Item.Create)(record.rewarditem)
    ;
    (((self._boxs)[k]).num):SetText(v)
    ;
    (((self._boxs)[k]).dot):SetActive((boxs[v]).state ~= 0)
    ;
    (((self._boxs)[k]).dotGrey):SetActive((boxs[v]).state == 0)
    ;
    (((self._boxs)[k]).get):SetActive((boxs[v]).state == 2)
    ;
    (((self._boxs)[k]).effect):SetActive((boxs[v]).state == 1)
    imageRecord = item:GetIcon()
    ;
    (((self._boxs)[k]).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetPinJiImage()
    ;
    (((self._boxs)[k]).frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (((self._boxs)[k]).count):SetText(record.quantity)
  end
  local interval = 0.25
  local num = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleNum(self._actId)
  if num == 0 then
    (self._progress):SetFillAmount(0)
  elseif num == 1 then
    (self._progress):SetFillAmount(0)
  elseif Limit <= num then
    (self._progress):SetFillAmount(1)
  else
    local process = 0
    local gear = 0
    for k,v in pairs(self._rewardIds) do
      if gear < k and v <= num then
        gear = k
      end
    end
    process = (gear - 1) * interval + (num - (self._rewardIds)[gear]) / ((self._rewardIds)[gear + 1] - (self._rewardIds)[gear]) * interval
    ;
    (self._progress):SetFillAmount(process)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, nil)
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

PuzzleMainDialog.RefreshPuzzles = function(self)
  -- function num : 0_7 , upvalues : _ENV, CImagePathTable, Limit
  self._puzzleData = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleData(self._actId, self._memoryPiecesNum)
  for k,data in pairs(self._puzzleData) do
    (((self.puzzles)[k]).lock):SetActive(data.state ~= 2)
    ;
    (((self.puzzles)[k]).num):SetActive(data.state ~= 2)
    if not CImagePathTable:GetRecorder(data.image) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (((self.puzzles)[k]).num):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local num = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleNum(self._actId)
  ;
  (self._line):SetActive(Limit ~= num)
  self:RefreshBoxs()
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

PuzzleMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

PuzzleMainDialog.OnTipBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.puzzle.puzzletipdialog")):Init(self._actId)
end

PuzzleMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

PuzzleMainDialog.OnGoBtnClick = function(self, index)
  -- function num : 0_11 , upvalues : _ENV
  if ((self._task)[index]):IsLock() then
    return 
  end
  self:Destroy()
  ;
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask((self._task)[index])
end

PuzzleMainDialog.OnGetBtnClick = function(self, index)
  -- function num : 0_12 , upvalues : _ENV, TasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.JIGSAW_PUZZLE
    protocol.taskID = ((self._task)[index]):GetID()
    protocol:Send()
  end
end

PuzzleMainDialog.OnPuzzleGetClick = function(self, index)
  -- function num : 0_13 , upvalues : _ENV
  if self._memoryPiecesNum < ((self._puzzleData)[index]).quantity then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100380)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cunlockpuzzle")
  if protocol then
    protocol.activityId = self._actId
    protocol.puzzleId = index
    protocol:Send()
  end
end

PuzzleMainDialog.OnAwardCellClicked = function(self, index)
  -- function num : 0_14 , upvalues : _ENV, CJigsawMissionAward, Item
  local boxs = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleBoxsData(self._actId, self._memoryPiecesNum)
  if next(boxs) == nil then
    return 
  end
  local imageRecord = nil
  for k,v in pairs(self._rewardIds) do
    if k == index then
      local record = CJigsawMissionAward:GetRecorder(v)
      local item = (Item.Create)(record.rewarditem)
      if (boxs[v]).state == 0 then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100381)
        break
      end
      if (boxs[v]).state == 1 then
        do
          local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetprogressreward")
          if protocol then
            protocol.activityId = self._actId
            protocol.boxId = (self._rewardIds)[index]
            protocol:Send()
          end
          do break end
          do
            do
              if (boxs[v]).state == 2 then
                local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
                if tipsDialog then
                  tipsDialog:Init({item = item})
                end
              end
              do break end
              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

PuzzleMainDialog.OnGetNewPuzzle = function(self, notification)
  -- function num : 0_15 , upvalues : _ENV
  local data = notification.userInfo
  do
    if ((self._puzzleData)[data.puzzleId]).popupID ~= -1 then
      local dialogEffect = (EffectFactory.CreateDialogEffect)(13, ((self._puzzleData)[data.puzzleId]).popupID)
      dialogEffect:Run()
    end
    self:RefreshPuzzles()
  end
end

return PuzzleMainDialog

