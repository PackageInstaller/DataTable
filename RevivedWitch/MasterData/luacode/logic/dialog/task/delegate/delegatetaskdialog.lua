-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/delegate/delegatetaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DelegateTaskDialog = class("DelegateTaskDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
DelegateTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
DelegateTaskDialog.AssetName = "BattlePassTask"
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local RedData = require("logic.manager.experimental.types.reddata")
DelegateTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DelegateTaskDialog
  ((DelegateTaskDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
  self._baseSceneController = nil
end

DelegateTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._listBoard = self:GetChild("Frame")
  self._taskFrame = (GridFrame.Create)(self._listBoard, self, false, 1, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  ;
  (self._leftArrow):SetActive(false)
  ;
  (self._rightArrow):SetActive(false)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._dreamProgress = self:GetChild("BattlePassProgress/Loading/Loading/BackGround/Progress")
  self._dreamExpNum = self:GetChild("BattlePassProgress/Loading/Num/Num")
  self._dreamItem = self:GetChild("BattlePassProgress/Item")
  self._redDot = self:GetChild("BattlePassProgress/RedDot")
  self._back = self:GetChild("BattlePassProgress/Back")
  self._dreamBox = self:GetChild("BattlePassProgress/Box")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnDreamBoxClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._deleCurNum = self:GetChild("Num/Num")
  self._deleMaxNum = self:GetChild("Num/NumMax")
  ;
  (UIBackManager.SwitchToNext)()
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetData, Common.n_DreamSpiralTaskRefresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshReddot, Common.n_DreamSpiralRefresh, nil)
end

DelegateTaskDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._taskFrame):Destroy()
end

DelegateTaskDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  self._info = manager:GetBaseInfo()
  self._refreshTime = manager:GetTaskRefreshTime()
  local has = manager:HasUntakeAward()
  ;
  (self._redDot):SetActive(has)
  local chipInfo = (self._info).chipInfo
  ;
  (self._dreamExpNum):SetText((string.format)("%d/%d", chipInfo.has, chipInfo.max))
  ;
  (self._dreamProgress):SetFillAmount(chipInfo.has / chipInfo.max)
  local tasks = manager:GetDreamDelegateTasks()
  self._limitTasks = {}
  for k,v in pairs(tasks) do
    if v.taskstatus == 3 then
      (table.insert)(self._limitTasks, {key = k, task = v})
    end
  end
  for k,v in pairs(tasks) do
    if v.taskstatus ~= 3 and v.taskstatus ~= 1 then
      (table.insert)(self._limitTasks, {key = k, task = v})
    end
  end
  ;
  (self._deleCurNum):SetText(#self._limitTasks)
  ;
  (self._deleMaxNum):SetText((self._info).taskMaxNum)
  local taskNum = #self._limitTasks + 1
  warn("task num: ", taskNum)
  if taskNum <= 4 then
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(false)
    ;
    (self._taskFrame):SetSlide(false)
  else
    ;
    (self._rightArrow):SetActive(true)
    ;
    (self._leftArrow):SetActive(false)
    ;
    (self._taskFrame):SetSlide(true)
  end
  ;
  (self._taskFrame):ReloadAllCell()
end

DelegateTaskDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._limitTasks + 1
end

DelegateTaskDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "task.delegate.delegatetaskcell"
end

DelegateTaskDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if index <= #self._limitTasks then
    local d = (self._limitTasks)[index]
    return {task = d.task, key = d.key}
  else
    do
      do return {refreshTime = self._refreshTime} end
    end
  end
end

DelegateTaskDialog.OnLeftArrowClicked = function(self)
  -- function num : 0_7
end

DelegateTaskDialog.OnRightArrowClick = function(self)
  -- function num : 0_8
end

DelegateTaskDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("task.daily.delegatetaskdialog")
end

DelegateTaskDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

DelegateTaskDialog.OnDreamBoxClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  if mgr:IsAgCoinActivityOpen() then
    if (DialogManager.GetDialog)("welfare.welfaremaindialog") then
      (DialogManager.DestroySingletonDialog)("welfare.welfaremaindialog")
    end
    local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true)
      dialog:SetSelectedTab((dialog.WelfareType).dreamSpiral)
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100033)
    end
  end
end

DelegateTaskDialog.OnCurPosChange = function(self, frame, prop)
  -- function num : 0_12
  local curPos = (self._taskFrame):GetCurrentPosition()
  local totalLen = (self._taskFrame):GetTotalLength()
  local width, _ = (self._listBoard):GetRectSize()
  if curPos <= 0 then
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(#self._limitTasks + 1 > 4)
  elseif totalLen - width <= curPos then
    (self._leftArrow):SetActive(true)
    ;
    (self._rightArrow):SetActive(false)
  else
    (self._rightArrow):SetActive(true)
    ;
    (self._leftArrow):SetActive(true)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DelegateTaskDialog.RefreshReddot = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)
  local has = manager:HasUntakeAward()
  ;
  (self._redDot):SetActive(has)
end

return DelegateTaskDialog

