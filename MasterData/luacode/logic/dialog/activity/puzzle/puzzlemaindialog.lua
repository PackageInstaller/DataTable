local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CJigsawreSourceConfig = BeanManager.GetTableByName("activity.cjigsawresourceconfig")
local CJigsawMissionAward = BeanManager.GetTableByName("mission.cjigsawmissionaward")
local CalbumConfig = BeanManager.GetTableByName("handbook.calbumconfig")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local Item = require("logic.manager.experimental.types.item")
local PuzzleMainDialog = class("PuzzleMainDialog", Dialog)
PuzzleMainDialog.AssetBundleName = "ui/layouts.activitypuzzle"
PuzzleMainDialog.AssetName = "ActivityPuzzleMain"

function PuzzleMainDialog:Ctor(...)
  PuzzleMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

local Limit = 12

function PuzzleMainDialog:OnCreate()
  self._taskCells = {}
  for i = 1, 3 do
    self._taskCells[i] = {}
    self._taskCells[i].cell = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i)
    self._taskCells[i].title = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Title")
    self._taskCells[i].progress = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Progress")
    self._taskCells[i].num = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Num/Num")
    self._taskCells[i].numMax = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/ProgressBack/Num/NumMax")
    self._taskCells[i].doneBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/DoneBtn")
    self._taskCells[i].goBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/GoBtn")
    self._taskCells[i].getBtn = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/GetBtn")
    self._taskCells[i].item = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Item")
    self._taskCells[i].cout = self:GetChild("BackImage/TaskBack/Frame/TaskCell" .. i .. "/Num")
    self._taskCells[i].goBtn:Subscribe_PointerClickEvent(function()
      self:OnGoBtnClick(i)
    end)
    self._taskCells[i].getBtn:Subscribe_PointerClickEvent(function()
      self:OnGetBtnClick(i)
    end)
  end
  self._currency = {
    curNum = self:GetChild("BackImage/TaskBack/CurrentNum/Num"),
    maxNum = self:GetChild("BackImage/TaskBack/MaxNum/Num"),
    curicon = self:GetChild("BackImage/TaskBack/CurrentNum/Item"),
    maxicon = self:GetChild("BackImage/TaskBack/MaxNum/Item")
  }
  self._boxs = {}
  self._progress = self:GetChild("BackImage/BoxArea/ProgressBack/progress")
  for i = 1, 5 do
    self._boxs[i] = {}
    self._boxs[i].num = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Num")
    self._boxs[i].dot = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Dot")
    self._boxs[i].dotGrey = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/DotGrey")
    self._boxs[i].get = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Get")
    self._boxs[i].effect = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Effect")
    self._boxs[i].icon = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Icon")
    self._boxs[i].frame = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Frame")
    self._boxs[i].select = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Select")
    self._boxs[i].count = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_Count")
    self._boxs[i].select:SetActive(false)
    self._boxs[i].icon:Subscribe_PointerClickEvent(function()
      self:OnAwardCellClicked(i)
    end)
  end
  self.puzzles = {}
  for i = 1, 12 do
    self.puzzles[i] = {}
    self.puzzles[i].lock = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Puzzle" .. i)
    self.puzzles[i].num = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Puzzle" .. i .. "/Num")
    self.puzzles[i].lock:Subscribe_PointerClickEvent(function()
      self:OnPuzzleGetClick(i)
    end)
  end
  self._line = self:GetChild("BackImage/PuzzleArea/PuzzleLock/Image")
  self._puzzleImg = self:GetChild("BackImage/PuzzleArea/PuzzleImg")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tipbtn = self:GetChild("BackImage/Ibtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._tipbtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTasks, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTasks, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGetNewPuzzle, Common.n_OnGetNewPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshBoxs, Common.n_OnSRefreshPuzzlesAwards, nil)
end

function PuzzleMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("activity.puzzle.puzzletipdialog")
end

function PuzzleMainDialog:Init(id)
  self._actId = id
  self._maxNum = CJigsawreSourceConfig:GetRecorder(self._actId).limit
  self._currency.maxNum:SetText(self._maxNum)
  local item = Item.Create(DataCommon.MemoryPieces)
  local imageRecord = item:GetIcon()
  self._currency.curicon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._currency.maxicon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._rewardIds = CJigsawMissionAward:GetAllIds()
  self:RefreshTasks()
  self:RefreshCurrency()
  self:RefreshBoxs()
  self:RefreshPuzzles()
  for k, v in pairs(CalbumConfig:GetAllIds()) do
    local record = CalbumConfig:GetRecorder(v)
    if record and record.event_id == id then
      local imageRecord = CImagePathTable:GetRecorder(record.picture) or DataCommon.DefaultImageAsset
      self._puzzleImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      break
    end
  end
end

function PuzzleMainDialog:RefreshTasks()
  local tasks = NekoData.BehaviorManager.BM_ActivityTasks:GetPuzzleTasks()
  for i = 1, 3 do
    self._taskCells[i].cell:SetActive(false)
  end
  if not tasks or next(tasks) == nil then
    return
  end
  local id = 1
  self._task = {}
  for i, task in pairs(tasks) do
    self._taskCells[id].cell:SetActive(true)
    self._taskCells[id].title:SetText(task:GetDesc())
    local reward = task:GetAwards()[1]
    local imageRecord = reward:GetIcon()
    self._taskCells[id].item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._taskCells[id].cout:SetText(reward:GetCount())
    self._taskCells[id].progress:SetFillAmount(task:GetProgress()[1].current / task:GetProgress()[1].total)
    self._taskCells[id].num:SetText(task:GetProgress()[1].current)
    self._taskCells[id].numMax:SetText(task:GetProgress()[1].total)
    if task:GetStatus() == TaskStatus.PROCESSING or task:IsLock() then
      self._taskCells[id].goBtn:SetActive(task:CanJump())
      self._taskCells[id].getBtn:SetActive(false)
      self._taskCells[id].doneBtn:SetActive(false)
    elseif task:GetStatus() == TaskStatus.FINISHED then
      self._taskCells[id].goBtn:SetActive(false)
      self._taskCells[id].getBtn:SetActive(true)
      self._taskCells[id].doneBtn:SetActive(false)
    elseif task:GetStatus() == TaskStatus.COMMITED then
      self._taskCells[id].goBtn:SetActive(false)
      self._taskCells[id].getBtn:SetActive(false)
      self._taskCells[id].doneBtn:SetActive(true)
    else
      LogError("taskstatus", task:GetStatus())
      self._taskCells[id].goBtn:SetActive(false)
      self._taskCells[id].getBtn:SetActive(false)
      self._taskCells[id].doneBtn:SetActive(false)
    end
    if 3 < id then
      LogError("PuzzleMainDialog", "Task beyond bounds")
      break
    end
    if not NekoData.BehaviorManager.BM_ActivityTasks:HaveFinishedTask(TasksProtocolDef.JIGSAW_PUZZLE) then
      LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
    end
    table.insert(self._task, task)
    id = id + 1
  end
end

function PuzzleMainDialog:RefreshCurrency()
  self._memoryPiecesNum = NekoData.BehaviorManager.BM_Currency:GetMemoryPieces()
  self._currency.curNum:SetText(self._memoryPiecesNum)
end

function PuzzleMainDialog:RefreshBoxs()
  local boxs = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleBoxsData(self._actId, self._memoryPiecesNum)
  if next(boxs) == nil then
    return
  end
  local imageRecord
  for k, v in pairs(self._rewardIds) do
    local record = CJigsawMissionAward:GetRecorder(v)
    local item = Item.Create(record.rewarditem)
    self._boxs[k].num:SetText(v)
    self._boxs[k].dot:SetActive(boxs[v].state ~= 0)
    self._boxs[k].dotGrey:SetActive(boxs[v].state == 0)
    self._boxs[k].get:SetActive(boxs[v].state == 2)
    self._boxs[k].effect:SetActive(boxs[v].state == 1)
    imageRecord = item:GetIcon()
    self._boxs[k].icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetPinJiImage()
    self._boxs[k].frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._boxs[k].count:SetText(record.quantity)
  end
  local interval = 0.25
  local num = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleNum(self._actId)
  if num == 0 then
    self._progress:SetFillAmount(0)
  elseif num == 1 then
    self._progress:SetFillAmount(0)
  elseif num >= Limit then
    self._progress:SetFillAmount(1)
  else
    local process = 0
    local gear = 0
    for k, v in pairs(self._rewardIds) do
      if k > gear and v <= num then
        gear = k
      end
    end
    process = (gear - 1) * interval + (num - self._rewardIds[gear]) / (self._rewardIds[gear + 1] - self._rewardIds[gear]) * interval
    self._progress:SetFillAmount(process)
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
end

function PuzzleMainDialog:RefreshPuzzles()
  self._puzzleData = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleData(self._actId, self._memoryPiecesNum)
  for k, data in pairs(self._puzzleData) do
    self.puzzles[k].lock:SetActive(data.state ~= 2)
    self.puzzles[k].num:SetActive(data.state ~= 2)
    local imageRecord = CImagePathTable:GetRecorder(data.image) or DataCommon.DefaultImageAsset
    self.puzzles[k].num:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local num = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleNum(self._actId)
  self._line:SetActive(Limit ~= num)
  self:RefreshBoxs()
end

function PuzzleMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function PuzzleMainDialog:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.puzzle.puzzletipdialog"):Init(self._actId)
end

function PuzzleMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function PuzzleMainDialog:OnGoBtnClick(index)
  if self._task[index]:IsLock() then
    return
  end
  self:Destroy()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task[index])
end

function PuzzleMainDialog:OnGetBtnClick(index)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.JIGSAW_PUZZLE
    protocol.taskID = self._task[index]:GetID()
    protocol:Send()
  end
end

function PuzzleMainDialog:OnPuzzleGetClick(index)
  if self._memoryPiecesNum < self._puzzleData[index].quantity then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100380)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cunlockpuzzle")
  if protocol then
    protocol.activityId = self._actId
    protocol.puzzleId = index
    protocol:Send()
  end
end

function PuzzleMainDialog:OnAwardCellClicked(index)
  local boxs = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleBoxsData(self._actId, self._memoryPiecesNum)
  if next(boxs) == nil then
    return
  end
  local imageRecord
  for k, v in pairs(self._rewardIds) do
    if k == index then
      local record = CJigsawMissionAward:GetRecorder(v)
      local item = Item.Create(record.rewarditem)
      if boxs[v].state == 0 then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100381)
        break
      end
      if boxs[v].state == 1 then
        do
          local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetprogressreward")
          if protocol then
            protocol.activityId = self._actId
            protocol.boxId = self._rewardIds[index]
            protocol:Send()
          end
        end
        break
      end
      if boxs[v].state == 2 then
        local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
        if tipsDialog then
          tipsDialog:Init({item = item})
        end
      end
      break
    end
  end
end

function PuzzleMainDialog:OnGetNewPuzzle(notification)
  local data = notification.userInfo
  if self._puzzleData[data.puzzleId].popupID ~= -1 then
    local dialogEffect = EffectFactory.CreateDialogEffect(13, self._puzzleData[data.puzzleId].popupID)
    dialogEffect:Run()
  end
  self:RefreshPuzzles()
end

return PuzzleMainDialog
