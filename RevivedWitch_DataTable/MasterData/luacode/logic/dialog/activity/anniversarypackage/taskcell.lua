-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/taskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskCell = class("TaskCell", Dialog)
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
TaskCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskCell.AssetName = "Activity1YearOtherTaskCell"
TaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskCell
  ((TaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TaskCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GoBack/GetBtn")
  self._commitBtn_text = self:GetChild("GoBack/GetBtn/_Text")
  ;
  (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1865))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._goBtn_Text = self:GetChild("GoBack/GoBtn/_Text")
  ;
  (self._goBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1718))
  self._normalBack = self:GetChild("GoBack")
  self._greyBack = self:GetChild("Grey")
  self._greyBackText = self:GetChild("Grey/GotBtn/_Text")
  ;
  (self._greyBackText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  self._itemCell = {}
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  ;
  ((self._itemCell).cell):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._itemCell1 = {}
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell1).cell = self:GetChild("TaskCellItem (1)/Panel/ItemCell")
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell1).icon = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_BackGround/Icon")
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell1).frame = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_BackGround/Frame")
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell1).count = self:GetChild("TaskCellItem (1)/Panel/ItemCell/_Count")
  ;
  ((self._itemCell1).cell):Subscribe_PointerClickEvent(self.OnItem1Clicked, self)
  self._limit = self:GetChild("Limit")
  self._loading = self:GetChild("Loading")
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._commitBtn):Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

TaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

TaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Status
  self._task = data
  ;
  (self._name):SetText(data:GetName())
  local progress = (self._task):GetProgress()
  if #progress == 0 then
    (self._loading):SetActive(false)
  else
    ;
    (self._loading):SetActive(true)
    local text = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1058)).msgTextID
    text = (TextManager.GetText)(text)
    text = text:gsub("%$parameter(%d)", {["1"] = (progress[1]).current, ["2"] = (progress[1]).total})
    ;
    (self._progress):SetFillAmount((((self._task):GetProgress())[1]).current / (((self._task):GetProgress())[1]).total)
    ;
    (self._progressNum):SetText(text)
  end
  do
    local status = data:GetStatus()
    local greyShow = status == Status.COMMITED
    ;
    (self._greyBack):SetActive(greyShow)
    ;
    (self._normalBack):SetActive(not greyShow)
    ;
    (self._commitBtn):SetActive(status == Status.FINISHED)
    ;
    (self._goBtn):SetActive(status ~= Status.FINISHED)
    ;
    (self._commitBtn):SetActive(status == Status.FINISHED)
    local awards = data:GetAwards()
    local image = (awards[1]):GetIcon()
    ;
    ((self._itemCell).icon):SetSprite(image.assetBundle, image.assetName)
    image = (awards[1]):GetPinJiImage()
    ;
    ((self._itemCell).frame):SetSprite(image.assetBundle, image.assetName)
    ;
    ((self._itemCell).count):SetText((NumberManager.GetShowNumber)((awards[1]):GetCount()))
    -- DECOMPILER ERROR at PC135: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._itemCell).item = awards[1]
    if awards[2] then
      ((self._itemCell1).cell):SetActive(true)
      local image = (awards[2]):GetIcon()
      ;
      ((self._itemCell1).icon):SetSprite(image.assetBundle, image.assetName)
      image = (awards[2]):GetPinJiImage()
      ;
      ((self._itemCell1).frame):SetSprite(image.assetBundle, image.assetName)
      ;
      ((self._itemCell1).count):SetText((NumberManager.GetShowNumber)((awards[2]):GetCount()))
      -- DECOMPILER ERROR at PC175: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._itemCell1).item = awards[2]
    else
      ((self._itemCell1).cell):SetActive(false)
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

TaskCell.OnCommitClick = function(self)
  -- function num : 0_4 , upvalues : Status
  if (self._task):GetStatus() == Status.FINISHED then
    (self._delegate):OnCommitClick((self._task):GetID())
  end
end

TaskCell.OnItemClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = ((self._itemCell).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._itemCell).item})
    tipsDialog:SetTipsPosition(width, height, ((self._itemCell).cell):GetLocalPointInUiRootPanel())
  end
end

TaskCell.OnItem1Clicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local width, height = ((self._itemCell1).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._itemCell1).item})
    tipsDialog:SetTipsPosition(width, height, ((self._itemCell1).cell):GetLocalPointInUiRootPanel())
  end
end

TaskCell.OnGoBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._task)
end

return TaskCell

