-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/daily/goldentaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GoldenTaskCell = class("GoldenTaskCell", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
GoldenTaskCell.AssetBundleName = "ui/layouts.basetasklist"
GoldenTaskCell.AssetName = "TaskStoryCell2"
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
GoldenTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GoldenTaskCell
  ((GoldenTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GoldenTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back/Back")
  self._done = self:GetChild("Back/BackDone")
  self._name = self:GetChild("Back/Title1")
  self._refresh = self:GetChild("Back/Refresh")
  self._commit = self:GetChild("Back/GetBtn")
  self._progress = {current = self:GetChild("Back/ProgressBack/Num/Num"), total = self:GetChild("Back/ProgressBack/Num/NumMax"), bar = self:GetChild("Back/ProgressBack/Progress")}
  self._desc = self:GetChild("Back/Detail")
  self._tip = self:GetChild("Back/Ibtn")
  self._goto = self:GetChild("Back/GoBtn")
  self._activeValue = self:GetChild("Back/ActiveNum")
  ;
  (self._refresh):Subscribe_PointerClickEvent(self.OnRefreshClick, self)
  ;
  (self._commit):Subscribe_PointerClickEvent(self.OnCommitClick, self)
  ;
  (self._tip):Subscribe_PointerClickEvent(self.OnTipClick, self)
  ;
  (self._goto):Subscribe_PointerClickEvent(self.OnGoToClick, self)
  self._refreshBoard = self:GetChild("Back/RefreshTime")
  self._refreshCount = self:GetChild("Back/RefreshTime/Num")
end

GoldenTaskCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

GoldenTaskCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, Status
  (self._name):SetText((self._cellData):GetName())
  ;
  (self._desc):SetText((self._cellData):GetDesc())
  ;
  (self._activeValue):SetText((self._cellData):GetActiveValue())
  ;
  (self._refreshCount):SetText(((NekoData.BehaviorManager).BM_Task):GetDailyRefreshCount())
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
  (self._refresh):SetActive(status == Status.PROCESSING)
  ;
  (self._goto):SetActive(not (self._cellData):CanJump() or status == Status.PROCESSING)
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

GoldenTaskCell.OnRefreshClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(32, nil, function()
    -- function num : 0_4_0 , upvalues : self
    (self._delegate):OnRefreshClick((self._cellData):GetID())
  end
)
end

GoldenTaskCell.OnCommitClick = function(self)
  -- function num : 0_5
  (self._delegate):OnCommitClick((self._cellData):GetID())
end

GoldenTaskCell.OnTipClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("task.tasktipdialog")):SetData(self._cellData)
end

GoldenTaskCell.OnGoToClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Task):HandleTask((self._cellData):GetID())
end

GoldenTaskCell.OnEvent = function(self, name, args)
  -- function num : 0_8 , upvalues : _ENV
  if name == "reload" then
    for _,i in pairs(args) do
      if i == (self._cellData):GetID() then
        (self:GetRootWindow()):SetAnimatorTrigger("onRefresh")
      end
    end
  end
end

return GoldenTaskCell

