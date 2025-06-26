-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/puzzle/puzzlefinishdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CJigsawreSourceConfig = (BeanManager.GetTableByName)("activity.cjigsawresourceconfig")
local CJigsawMissionAward = (BeanManager.GetTableByName)("mission.cjigsawmissionaward")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local CalbumConfig = (BeanManager.GetTableByName)("handbook.calbumconfig")
local Item = require("logic.manager.experimental.types.item")
local Limit = 12
local PuzzleFinishDialog = class("PuzzleFinishDialog", Dialog)
PuzzleFinishDialog.AssetBundleName = "ui/layouts.activitypuzzle"
PuzzleFinishDialog.AssetName = "ActivityPuzzleFinish"
PuzzleFinishDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PuzzleFinishDialog
  ((PuzzleFinishDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

PuzzleFinishDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._boxs = {}
  self._progress = self:GetChild("BackImage/BoxArea/ProgressBack/progress")
  for i = 1, 5 do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._boxs)[i] = {}
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).num = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Num")
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).dot = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Dot")
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).dotGrey = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/DotGrey")
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).get = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Get")
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).effect = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/Effect")
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).icon = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Icon")
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).frame = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Frame")
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).select = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_BackGround/Select")
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._boxs)[i]).count = self:GetChild("BackImage/BoxArea/ProgressBack/Dot" .. i .. "/Award/ItemCell/_Count")
      ;
      (((self._boxs)[i]).select):SetActive(false)
      ;
      (((self._boxs)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnAwardCellClicked(i)
  end
)
    end
  end
  self._goBookBtn = self:GetChild("BackImage/GoToBookBtn")
  self._shareBtn = self:GetChild("BackImage/ShareBtn")
  self._backBtn = self:GetChild("BackImage/CloseBtn")
  self._tipbtn = self:GetChild("BackImage/Ibtn")
  self._puzzleImg = self:GetChild("BackImage/Puzzle")
  ;
  (self._goBookBtn):Subscribe_PointerClickEvent(self.OnGoBookClicked, self)
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._tipbtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshBoxs, Common.n_OnSRefreshPuzzlesAwards, nil)
end

PuzzleFinishDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("activity.puzzle.puzzletipdialog")
end

PuzzleFinishDialog.Init = function(self, id)
  -- function num : 0_3 , upvalues : CJigsawMissionAward, _ENV, CalbumConfig, CImagePathTable
  self._actId = id
  self._rewardIds = CJigsawMissionAward:GetAllIds()
  self:RefreshBoxs()
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

PuzzleFinishDialog.RefreshBoxs = function(self)
  -- function num : 0_4 , upvalues : _ENV, CJigsawMissionAward, Item, Limit
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

PuzzleFinishDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

PuzzleFinishDialog.OnTipBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.puzzle.puzzletipdialog")):Init(self._actId)
end

PuzzleFinishDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

PuzzleFinishDialog.OnGoBtnClick = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  if ((self._task)[index]):IsLock() then
    return 
  end
  self:Destroy()
  ;
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask((self._task)[index])
end

PuzzleFinishDialog.OnBoxsGetClick = function(self, index)
  -- function num : 0_9 , upvalues : _ENV
  local puzzleNum = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):GetPuzzleNum(self._actId)
  if puzzleNum < (self._rewardIds)[index] then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100381)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetprogressreward")
  if protocol then
    protocol.activityId = self._actId
    protocol.boxId = (self._rewardIds)[index]
    protocol:Send()
  end
end

PuzzleFinishDialog.OnBoxsOpenedClick = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100382)
end

PuzzleFinishDialog.OnGoBookClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self:Destroy()
  ;
  (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):JumpToBook()
end

PuzzleFinishDialog.OnShareClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local CalbumConfig = (BeanManager.GetTableByName)("handbook.calbumconfig")
  for k,v in pairs(CalbumConfig:GetAllIds()) do
    local recorder = CalbumConfig:GetRecorder(v)
    if recorder.event_id == self._actId then
      ((DialogManager.CreateSingletonDialog)("handbook.memorybookfullscreendialog")):SetData(recorder)
      break
    end
  end
end

PuzzleFinishDialog.OnAwardCellClicked = function(self, index)
  -- function num : 0_13 , upvalues : _ENV, CJigsawMissionAward, Item
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

return PuzzleFinishDialog

