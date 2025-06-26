-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/daily/dailytaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DailyTaskCell = class("DailyTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
DailyTaskCell.AssetBundleName = "ui/layouts.basetasklist"
DailyTaskCell.AssetName = "TaskStoryCell3"
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
DailyTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyTaskCell
  ((DailyTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

DailyTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back/Back")
  self._done = self:GetChild("Back/BackDone")
  self._name = self:GetChild("Back/Title1")
  self._commit = self:GetChild("Back/GetBtn")
  self._progress = {current = self:GetChild("Back/ProgressBack/Num/Num"), total = self:GetChild("Back/ProgressBack/Num/NumMax"), bar = self:GetChild("Back/ProgressBack/Progress")}
  self._desc = self:GetChild("Back/Detail")
  self._goto = self:GetChild("Back/GoBtn")
  self._activeValue = self:GetChild("Back/ActiveNum")
  self._tips = self:GetChild("Back/Tips")
  self._tipsText = self:GetChild("Back/Tips/Text")
  ;
  (self._commit):Subscribe_PointerClickEvent(self.OnCommitClick, self)
  ;
  (self._goto):Subscribe_PointerClickEvent(self.OnGoToClick, self)
end

DailyTaskCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

DailyTaskCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : Status
  (self._name):SetText((self._cellData):GetName())
  ;
  (self._desc):SetText((self._cellData):GetDesc())
  ;
  (self._activeValue):SetText((self._cellData):GetActiveValue())
  local progress = (self._cellData):GetProgress()
  ;
  ((self._progress).current):SetText((progress[1]).current)
  ;
  ((self._progress).total):SetText((progress[1]).total)
  ;
  ((self._progress).bar):SetFillAmount((progress[1]).current / (progress[1]).total)
  local status = (self._cellData):GetStatus()
  if (self._delegate)._isFullTo100 then
    (self._commit):SetActive(false)
    ;
    (self._done):SetActive(status == Status.COMMITED or status == Status.FINISHED)
    ;
    (self._back):SetActive(status ~= Status.COMMITED and status ~= Status.FINISHED)
  else
    (self._commit):SetActive(status == Status.FINISHED)
    ;
    (self._done):SetActive(status == Status.COMMITED)
    ;
    (self._back):SetActive(status ~= Status.COMMITED)
  end
  ;
  (self._goto):SetActive(not (self._cellData):CanJump() or status == Status.PROCESSING or status == Status.ACCEPTED)
  ;
  (self._tips):SetActive(false)
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

DailyTaskCell.OnCommitClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCommitClick((self._cellData):GetID())
end

DailyTaskCell.OnGoToClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  do
    if (self._cellData):IsLock() then
      local tipsTextID = (self._cellData):GetUnlockTextId()
      if tipsTextID then
        (self._tipsText):SetText((TextManager.GetText)(tipsTextID))
      end
      ;
      (self._tips):SetActive(true)
      if self._task then
        (ServerGameTimer.RemoveTask)(self._task)
        self._task = nil
      end
      self._task = (GameTimer.AddTask)(2, 0, function()
    -- function num : 0_5_0 , upvalues : self
    (self._tips):SetActive(false)
  end
, nil)
      return 
    end
    ;
    ((NekoData.BehaviorManager).BM_Task):HandleTask((self._cellData):GetID())
  end
end

DailyTaskCell.OnEvent = function(self, name, args)
  -- function num : 0_6 , upvalues : _ENV
  if name == "reload" then
    for _,i in pairs(args) do
      if i == (self._cellData):GetID() then
        (self:GetRootWindow()):SetAnimatorTrigger("onRefresh")
      end
    end
  end
end

return DailyTaskCell

