local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CJigsawreSourceConfig = BeanManager.GetTableByName("activity.cjigsawresourceconfig")
local CJigsawMissionAward = BeanManager.GetTableByName("mission.cjigsawmissionaward")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local CalbumConfig = BeanManager.GetTableByName("handbook.calbumconfig")
local Item = require("logic.manager.experimental.types.item")
local Limit = 12
local PuzzleFinishDialog = class("PuzzleFinishDialog", Dialog)
PuzzleFinishDialog.AssetBundleName = "ui/layouts.activitypuzzle"
PuzzleFinishDialog.AssetName = "ActivityPuzzleFinish"

function PuzzleFinishDialog:Ctor(...)
  PuzzleFinishDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function PuzzleFinishDialog:OnCreate()
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
  self._goBookBtn = self:GetChild("BackImage/GoToBookBtn")
  self._shareBtn = self:GetChild("BackImage/ShareBtn")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tipbtn = self:GetChild("BackImage/Ibtn")
  self._puzzleImg = self:GetChild("BackImage/Puzzle")
  self._goBookBtn:Subscribe_PointerClickEvent(self.OnGoBookClicked, self)
  self._shareBtn:Subscribe_PointerClickEvent(self.OnShareClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._tipbtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshBoxs, Common.n_OnSRefreshPuzzlesAwards, nil)
end

function PuzzleFinishDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("activity.puzzle.puzzletipdialog")
end

function PuzzleFinishDialog:Init(id)
  self._actId = id
  self._rewardIds = CJigsawMissionAward:GetAllIds()
  self:RefreshBoxs()
  for k, v in pairs(CalbumConfig:GetAllIds()) do
    local record = CalbumConfig:GetRecorder(v)
    if record and record.event_id == id then
      local imageRecord = CImagePathTable:GetRecorder(record.picture) or DataCommon.DefaultImageAsset
      self._puzzleImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      break
    end
  end
end

function PuzzleFinishDialog:RefreshBoxs()
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

function PuzzleFinishDialog:OnBackBtnClicked()
  self:Destroy()
end

function PuzzleFinishDialog:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.puzzle.puzzletipdialog"):Init(self._actId)
end

function PuzzleFinishDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function PuzzleFinishDialog:OnGoBtnClick(index)
  if self._task[index]:IsLock() then
    return
  end
  self:Destroy()
  NekoData.BehaviorManager.BM_ActivityTasks:HandleTask(self._task[index])
end

function PuzzleFinishDialog:OnBoxsGetClick(index)
  local puzzleNum = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):GetPuzzleNum(self._actId)
  if puzzleNum < self._rewardIds[index] then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100381)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetprogressreward")
  if protocol then
    protocol.activityId = self._actId
    protocol.boxId = self._rewardIds[index]
    protocol:Send()
  end
end

function PuzzleFinishDialog:OnBoxsOpenedClick(index)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100382)
end

function PuzzleFinishDialog:OnGoBookClicked()
  self:Destroy()
  NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):JumpToBook()
end

function PuzzleFinishDialog:OnShareClicked()
  local CalbumConfig = BeanManager.GetTableByName("handbook.calbumconfig")
  for k, v in pairs(CalbumConfig:GetAllIds()) do
    local recorder = CalbumConfig:GetRecorder(v)
    if recorder.event_id == self._actId then
      DialogManager.CreateSingletonDialog("handbook.memorybookfullscreendialog"):SetData(recorder)
      break
    end
  end
end

function PuzzleFinishDialog:OnAwardCellClicked(index)
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

return PuzzleFinishDialog
