-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/sevengrowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local TasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local SevenGrowCell = class("SevenGrowCell", Dialog)
SevenGrowCell.AssetBundleName = "ui/layouts.welfare"
SevenGrowCell.AssetName = "SevenGrowCell"
SevenGrowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SevenGrowCell
  ((SevenGrowCell.super).Ctor)(self, ...)
  self._item = nil
  self._task = nil
end

SevenGrowCell.OnCreate = function(self)
  -- function num : 0_1
  self._lightBack = self:GetChild("Light")
  self._backBack = self:GetChild("Back")
  self._title = self:GetChild("Title")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._progressNum = self:GetChild("ProgressBack/Num/Num")
  self._progressNumMax = self:GetChild("ProgressBack/Num/NumMax")
  self._itemCell = self:GetChild("ItemCell")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("ItemCell/_Count")
  self._tips = self:GetChild("Tips")
  self._tipsText = self:GetChild("Tips/Text")
  self._lockBtn = self:GetChild("LockBtn")
  self._goBtn = self:GetChild("GoBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._doneBtn = self:GetChild("DoneBtn")
  self._ongoingBtn = self:GetChild("OngoingBtn")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

SevenGrowCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (ServerGameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
end

SevenGrowCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, TaskStatus
  self._task = data.data
  self._isFirst = data.isFirst
  ;
  (self._lightBack):SetActive(self._isFirst)
  ;
  (self._backBack):SetActive(not self._isFirst)
  ;
  (self._title):SetText((self._task):GetDesc())
  ;
  (self._progress):SetFillAmount((((self._task):GetProgress())[1]).current / (((self._task):GetProgress())[1]).total)
  ;
  (self._progressNum):SetText((((self._task):GetProgress())[1]).current)
  ;
  (self._progressNumMax):SetText((((self._task):GetProgress())[1]).total)
  self._item = ((self._task):GetAwards())[1]
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)((((self._task):GetAwards())[1]):GetCount()))
  ;
  (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
  ;
  (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
  if (self._delegate)._lastTaskDay < (self._delegate)._nowTaskDay then
    (self._lockBtn):SetActive(true)
    ;
    (self._goBtn):SetActive(false)
    ;
    (self._ongoingBtn):SetActive(false)
    ;
    (self._getBtn):SetActive(false)
    ;
    (self._doneBtn):SetActive(false)
  else
    if (self._task):GetStatus() == TaskStatus.PROCESSING or (self._task):IsLock() then
      (self._lockBtn):SetActive(false)
      ;
      (self._goBtn):SetActive((self._task):CanJump())
      ;
      (self._ongoingBtn):SetActive(not (self._task):CanJump())
      ;
      (self._getBtn):SetActive(false)
      ;
      (self._doneBtn):SetActive(false)
    else
      if (self._task):GetStatus() == TaskStatus.FINISHED then
        (self._lockBtn):SetActive(false)
        ;
        (self._goBtn):SetActive(false)
        ;
        (self._ongoingBtn):SetActive(false)
        ;
        (self._getBtn):SetActive(true)
        ;
        (self._doneBtn):SetActive(false)
      else
        if (self._task):GetStatus() == TaskStatus.COMMITED then
          (self._lockBtn):SetActive(false)
          ;
          (self._goBtn):SetActive(false)
          ;
          (self._ongoingBtn):SetActive(false)
          ;
          (self._getBtn):SetActive(false)
          ;
          (self._doneBtn):SetActive(true)
        else
          ;
          (self._lockBtn):SetActive(false)
          ;
          (self._goBtn):SetActive(false)
          ;
          (self._ongoingBtn):SetActive(false)
          ;
          (self._getBtn):SetActive(false)
          ;
          (self._doneBtn):SetActive(false)
        end
      end
    end
  end
  local tipsTextID = (self._task):GetUnlockTextId()
  if tipsTextID then
    (self._tipsText):SetText((TextManager.GetText)(tipsTextID))
  end
  ;
  (self._tips):SetActive(false)
end

SevenGrowCell.OnItemCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

SevenGrowCell.OnGoBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._task):IsLock() then
    (self._tips):SetActive(true)
    if self._timer then
      (ServerGameTimer.RemoveTask)(self._timer)
      self._timer = nil
    end
    self._timer = (GameTimer.AddTask)(2, 0, function()
    -- function num : 0_5_0 , upvalues : self
    (self._tips):SetActive(false)
  end
, nil)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_ActivityTasks):HandleTask(self._task)
end

SevenGrowCell.OnGetBtnClick = function(self)
  -- function num : 0_6 , upvalues : _ENV, TasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = TasksProtocolDef.SEVEN_DAYS
    protocol.taskID = (self._task):GetID()
    protocol:Send()
  end
end

return SevenGrowCell

