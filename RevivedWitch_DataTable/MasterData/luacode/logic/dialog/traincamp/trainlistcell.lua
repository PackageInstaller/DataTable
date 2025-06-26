-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/trainlistcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLightTrainingCourse = (BeanManager.GetTableByName)("courtyard.clighttrainingcourse")
local ClightTrainingRarity = (BeanManager.GetTableByName)("courtyard.clighttrainingrarity")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TrainStatus = (LuaNetManager.GetBeanDef)("protocol.yard.train")
local TrainListCell = class("TrainListCell", Dialog)
TrainListCell.AssetBundleName = "ui/layouts.yard"
TrainListCell.AssetName = "TrainListCell"
TrainListCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrainListCell
  ((TrainListCell.super).Ctor)(self, ...)
end

TrainListCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._lockPanel = self:GetChild("Lock")
  self._unlockConditionTxt = self:GetChild("Lock/Title")
  self._unlockPanel = self:GetChild("Back")
  self._title = self:GetChild("Back/Title")
  self._level = self:GetChild("Back/Level")
  self._expPanel = self:GetChild("Back/Exp")
  self._expNum = self:GetChild("Back/Exp/Num")
  self._charPanel = self:GetChild("Back/Char")
  self._charEmpty = self:GetChild("Back/Char/Empty")
  self._charHave = self:GetChild("Back/Char/CharSmallCell")
  self._charHave_frame = self:GetChild("Back/Char/CharSmallCell/Frame")
  self._charHave_photo = self:GetChild("Back/Char/CharSmallCell/Photo")
  self._charHave_downRankBack = self:GetChild("Back/Char/CharSmallCell/DownRankBack")
  self._charHave_level = self:GetChild("Back/Char/CharSmallCell/Level/Num")
  self._charHave_rankBack = self:GetChild("Back/Char/CharSmallCell/RankBack")
  self._charHave_rank = self:GetChild("Back/Char/CharSmallCell/Rank")
  self._charHave_job = self:GetChild("Back/Char/CharSmallCell/Job")
  self._charHave_breakLevelBackBlack = self:GetChild("Back/Char/CharSmallCell/BreakLevelBackBlack")
  self._charHave_breakLevelBack = self:GetChild("Back/Char/CharSmallCell/BreakLevelBack")
  self._charHave_breakLevelNum = self:GetChild("Back/Char/CharSmallCell/BreakLevelNum")
  self._charHave_breakLevel = self:GetChild("Back/Char/CharSmallCell/BreakLevel")
  self._charHave_element = self:GetChild("Back/Char/CharSmallCell/Element")
  self._charHave_grey = self:GetChild("Back/Char/Train")
  self._charHave_greyTxt = self:GetChild("Back/Char/Train/Text")
  self._charHave_select = self:GetChild("Back/Char/CharSmallCell/Select")
  self._notStartPanel = self:GetChild("Back/Start")
  self._notStartPanel_costItemIcon = self:GetChild("Back/Start/Cost/Item")
  self._notStartPanel_costItemNum = self:GetChild("Back/Start/Cost/Num")
  self._notStartPanel_costTime = self:GetChild("Back/Start/Cost/Time")
  self._startBtn = self:GetChild("Back/Start/StartBtn")
  self._workingPanel = self:GetChild("Back/Training")
  self._workingPanel_time = self:GetChild("Back/Training/Time/Time")
  self._stopBtn = self:GetChild("Back/Training/StopBtn")
  self._finishPanel = self:GetChild("Back/Done")
  self._finishBtn = self:GetChild("Back/Done/DoneBtn")
  self._finishText = self:GetChild("Back/Done/Finish/Time")
  ;
  (self._finishText):SetText((TextManager.GetText)(800177))
  ;
  (self._charPanel):Subscribe_PointerClickEvent(self.OnCharClick, self)
  ;
  (self._startBtn):Subscribe_PointerClickEvent(self.OnStartClick, self)
  ;
  (self._stopBtn):Subscribe_PointerClickEvent(self.OnStopClick, self)
  ;
  (self._finishBtn):Subscribe_PointerClickEvent(self.OnFinishClick, self)
end

TrainListCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

TrainListCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CLightTrainingCourse, ClightTrainingRarity, CImagePathTable, TrainStatus, Item
  self._data = data
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if data.unlockLv then
    (self._lockPanel):SetActive(true)
    ;
    (self._unlockPanel):SetActive(false)
    ;
    (self._unlockConditionTxt):SetText((string.gsub)((TextManager.GetText)(800178), "%$parameter1%$", data.unlockLv))
  else
    ;
    (self._lockPanel):SetActive(false)
    ;
    (self._unlockPanel):SetActive(true)
    self:RefreshCharPanel()
    local record = CLightTrainingCourse:GetRecorder((data.trainTaskInfo).taskId)
    local rarityRecord = ClightTrainingRarity:GetRecorder(record.trainingrarity)
    ;
    (self._title):SetText((TextManager.GetText)(record.trainingnametxtid))
    local imageRecord = CImagePathTable:GetRecorder(rarityRecord.trainingraritypicid)
    ;
    (self._level):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._expNum):SetText((string.gsub)((TextManager.GetText)(800174), "%$parameter1%$", record.trainingexpgain))
    if (data.trainTaskInfo).status == TrainStatus.UN_START then
      (self._notStartPanel):SetActive(true)
      ;
      (self._workingPanel):SetActive(false)
      ;
      (self._finishPanel):SetActive(false)
      ;
      (self._charHave_grey):SetActive(false)
      local costItem = (Item.Create)(record.lightcostitem)
      self._costItemId = record.lightcostitem
      self._costItemNum = record.lightcostnum
      local imgRecord = costItem:GetIcon()
      ;
      (self._notStartPanel_costItemIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      if self._costItemNum <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._costItemId) then
        (self._notStartPanel_costItemNum):SetText((string.gsub)((TextManager.GetText)(800319), "%$parameter1%$", self._costItemNum))
      else
        ;
        (self._notStartPanel_costItemNum):SetText((string.gsub)((TextManager.GetText)(800175), "%$parameter1%$", self._costItemNum))
      end
      local time = record.trainingtime * 60
      local str = (TextManager.GetText)(800176)
      str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
      str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
      str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
      ;
      (self._notStartPanel_costTime):SetText(str)
    else
      do
        if (data.trainTaskInfo).status == TrainStatus.PROCESSING then
          (self._notStartPanel):SetActive(false)
          ;
          (self._workingPanel):SetActive(true)
          ;
          (self._finishPanel):SetActive(false)
          ;
          (self._charHave_grey):SetActive(true)
          ;
          (self._charHave_greyTxt):SetText((TextManager.GetText)(800181))
          self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:RefreshTime()
  end
, nil)
        else
          if (data.trainTaskInfo).status == TrainStatus.COMPLETE then
            (self._notStartPanel):SetActive(false)
            ;
            (self._workingPanel):SetActive(false)
            ;
            (self._finishPanel):SetActive(true)
            ;
            (self._charHave_grey):SetActive(true)
            ;
            (self._charHave_greyTxt):SetText((TextManager.GetText)(800177))
          end
        end
      end
    end
  end
end

TrainListCell.RefreshCharPanel = function(self)
  -- function num : 0_4 , upvalues : _ENV, TrainStatus
  local roleId = ((self._delegate)._roles)[((self._data).trainTaskInfo).index]
  if roleId and roleId ~= 0 then
    (self._charEmpty):SetActive(false)
    ;
    (self._charHave):SetActive(true)
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
    self._role = role
    local image = role:GetShapeLittleHeadImageRecord()
    ;
    (self._charHave_photo):SetSprite(image.assetBundle, image.assetName)
    image = role:GetSmallRarityFrameRecord()
    ;
    (self._charHave_frame):SetSprite(image.assetBundle, image.assetName)
    image = role:GetRarityBottomBackRecord()
    ;
    (self._charHave_downRankBack):SetSprite(image.assetBundle, image.assetName)
    ;
    (self._charHave_level):SetText(role:GetShowLv())
    image = role:GetRarityImageRecord()
    ;
    (self._charHave_rank):SetSprite(image.assetBundle, image.assetName)
    image = role:GetVocationImageRecord()
    ;
    (self._charHave_job):SetSprite(image.assetBundle, image.assetName)
    local breakLv = role:GetBreakLv()
    ;
    (self._charHave_breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._charHave_breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._charHave_breakLevelNum):SetActive(breakLv > 0)
    if breakLv > 0 then
      image = role:GetCurBreakFrame1ImageRecord()
      ;
      (self._charHave_breakLevelBack):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._charHave_breakLevelNum):SetText(breakLv)
    end
    image = role:GetElementImageRecord()
    ;
    (self._charHave_element):SetSprite(image.assetBundle, image.assetName)
  else
    (self._charEmpty):SetActive(true)
    ;
    (self._charHave):SetActive(false)
  end
  -- DECOMPILER ERROR at PC137: Unhandled construct in 'MakeBoolean' P1

  if roleId and roleId == 0 then
    (self._startBtn):SetInteractable(((self._data).trainTaskInfo).status ~= TrainStatus.UN_START)
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

TrainListCell.RefreshTime = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local taskInfo = ((NekoData.BehaviorManager).BM_TrainCamp):GetTrainTaskInfo(((self._data).trainTaskInfo).index)
  local time = taskInfo.leftTime // 1000
  local str = (TextManager.GetText)(800176)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
  ;
  (self._workingPanel_time):SetText(str)
end

TrainListCell.OnCharClick = function(self)
  -- function num : 0_6 , upvalues : TrainStatus, _ENV
  if ((self._data).trainTaskInfo).status == TrainStatus.UN_START then
    local dialog = (DialogManager.CreateSingletonDialog)("magictree.chooseroledialog")
    if dialog then
      dialog:Init(nil, DataCommon.TrainCamp, ((self._data).trainTaskInfo).index)
    end
  end
end

TrainListCell.SendCStartTrainProtocol = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local index = ((self._data).trainTaskInfo).index
  local cstarttrain = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttrain")
  cstarttrain.index = index
  cstarttrain.roleId = ((self._delegate)._roles)[index]
  cstarttrain:Send()
end

TrainListCell.OnStartClick = function(self)
  -- function num : 0_8 , upvalues : Item, _ENV, CLightTrainingCourse, ClightTrainingRarity
  local haveNum = nil
  local costItem = (Item.Create)(self._costItemId)
  if (string.sub)(self._costItemId, 1, 2) == "35" then
    haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._costItemId)
  else
    haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(self._costItemId)
  end
  if haveNum < self._costItemNum then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100224, {costItem:GetName()})
    return 
  end
  if (self._role):GetMaxLevel() <= (self._role):GetLevel() then
    local record = CLightTrainingCourse:GetRecorder(((self._data).trainTaskInfo).taskId)
    local rarityRecord = ClightTrainingRarity:GetRecorder(record.trainingrarity)
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(74, {(math.floor)(rarityRecord.manatransfer * record.trainingexpgain / 100)}, function()
    -- function num : 0_8_0 , upvalues : self
    self:SendCStartTrainProtocol()
  end
, {}, nil, {})
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(102, {costItem:GetName(), self._costItemNum}, function()
    -- function num : 0_8_1 , upvalues : self
    self:SendCStartTrainProtocol()
  end
, {}, nil, {})
    end
  end
end

TrainListCell.OnStopClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(75, nil, function()
    -- function num : 0_9_0 , upvalues : _ENV, self
    local cstoptrain = (LuaNetManager.CreateProtocol)("protocol.yard.cstoptrain")
    cstoptrain.index = ((self._data).trainTaskInfo).index
    cstoptrain:Send()
  end
, {}, nil, {})
end

TrainListCell.OnFinishClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local ccompletetrain = (LuaNetManager.CreateProtocol)("protocol.yard.ccompletetrain")
  ccompletetrain.index = ((self._data).trainTaskInfo).index
  ccompletetrain:Send()
end

TrainListCell.OnEvent = function(self, eventName, args)
  -- function num : 0_11 , upvalues : TrainStatus, _ENV
  if eventName == "SetRoleByChooseRoleDialog" and (self._data).trainTaskInfo then
    self:RefreshCharPanel()
  else
    if eventName == "Refresh" and (self._data).trainTaskInfo and ((self._data).trainTaskInfo).index == (args.trainTaskInfo).index then
      self:RefreshCell(args)
    else
      if eventName == "RefreshNotStartPanel" and (self._data).trainTaskInfo and ((self._data).trainTaskInfo).status == TrainStatus.UN_START then
        if self._costItemNum <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._costItemId) then
          (self._notStartPanel_costItemNum):SetText((string.gsub)((TextManager.GetText)(800319), "%$parameter1%$", self._costItemNum))
        else
          ;
          (self._notStartPanel_costItemNum):SetText((string.gsub)((TextManager.GetText)(800175), "%$parameter1%$", self._costItemNum))
        end
      end
    end
  end
end

return TrainListCell

