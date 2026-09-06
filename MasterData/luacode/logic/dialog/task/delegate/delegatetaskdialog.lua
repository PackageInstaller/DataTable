local DelegateTaskDialog = class("DelegateTaskDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
DelegateTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
DelegateTaskDialog.AssetName = "BattlePassTask"
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local RedData = require("logic.manager.experimental.types.reddata")

function DelegateTaskDialog:Ctor(...)
  DelegateTaskDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
  self._baseSceneController = nil
end

function DelegateTaskDialog:OnCreate()
  self._listBoard = self:GetChild("Frame")
  self._taskFrame = GridFrame.Create(self._listBoard, self, false, 1, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._leftArrow:SetActive(false)
  self._rightArrow:SetActive(false)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._dreamProgress = self:GetChild("BattlePassProgress/Loading/Loading/BackGround/Progress")
  self._dreamExpNum = self:GetChild("BattlePassProgress/Loading/Num/Num")
  self._dreamItem = self:GetChild("BattlePassProgress/Item")
  self._redDot = self:GetChild("BattlePassProgress/RedDot")
  self._back = self:GetChild("BattlePassProgress/Back")
  self._dreamBox = self:GetChild("BattlePassProgress/Box")
  self._back:Subscribe_PointerClickEvent(self.OnDreamBoxClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._deleCurNum = self:GetChild("Num/Num")
  self._deleMaxNum = self:GetChild("Num/NumMax")
  UIBackManager.SwitchToNext()
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.SetData, Common.n_DreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshReddot, Common.n_DreamSpiralRefresh, nil)
end

function DelegateTaskDialog:OnDestroy()
  self._taskFrame:Destroy()
end

function DelegateTaskDialog:SetData()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  self._info = manager:GetBaseInfo()
  self._refreshTime = manager:GetTaskRefreshTime()
  local has = manager:HasUntakeAward()
  self._redDot:SetActive(has)
  local chipInfo = self._info.chipInfo
  self._dreamExpNum:SetText(string.format("%d/%d", chipInfo.has, chipInfo.max))
  self._dreamProgress:SetFillAmount(chipInfo.has / chipInfo.max)
  local tasks = manager:GetDreamDelegateTasks()
  self._limitTasks = {}
  for k, v in pairs(tasks) do
    if v.taskstatus == 3 then
      table.insert(self._limitTasks, {key = k, task = v})
    end
  end
  for k, v in pairs(tasks) do
    if v.taskstatus ~= 3 and v.taskstatus ~= 1 then
      table.insert(self._limitTasks, {key = k, task = v})
    end
  end
  self._deleCurNum:SetText(#self._limitTasks)
  self._deleMaxNum:SetText(self._info.taskMaxNum)
  local taskNum = #self._limitTasks + 1
  warn("task num: ", taskNum)
  if taskNum <= 4 then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
    self._taskFrame:SetSlide(false)
  else
    self._rightArrow:SetActive(true)
    self._leftArrow:SetActive(false)
    self._taskFrame:SetSlide(true)
  end
  self._taskFrame:ReloadAllCell()
end

function DelegateTaskDialog:NumberOfCell(frame)
  return #self._limitTasks + 1
end

function DelegateTaskDialog:CellAtIndex(frame)
  return "task.delegate.delegatetaskcell"
end

function DelegateTaskDialog:DataAtIndex(frame, index)
  if index <= #self._limitTasks then
    local d = self._limitTasks[index]
    return {
      task = d.task,
      key = d.key
    }
  else
    return {
      refreshTime = self._refreshTime
    }
  end
end

function DelegateTaskDialog:OnLeftArrowClicked()
end

function DelegateTaskDialog:OnRightArrowClick()
end

function DelegateTaskDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("task.daily.delegatetaskdialog")
end

function DelegateTaskDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function DelegateTaskDialog:OnDreamBoxClick()
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  if mgr:IsAgCoinActivityOpen() then
    if DialogManager.GetDialog("welfare.welfaremaindialog") then
      DialogManager.DestroySingletonDialog("welfare.welfaremaindialog")
    end
    local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true)
      dialog:SetSelectedTab(dialog.WelfareType.dreamSpiral)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
  end
end

function DelegateTaskDialog:OnCurPosChange(frame, prop)
  local curPos = self._taskFrame:GetCurrentPosition()
  local totalLen = self._taskFrame:GetTotalLength()
  local width, _ = self._listBoard:GetRectSize()
  if curPos <= 0 then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(#self._limitTasks + 1 > 4)
  elseif curPos >= totalLen - width then
    self._leftArrow:SetActive(true)
    self._rightArrow:SetActive(false)
  else
    self._rightArrow:SetActive(true)
    self._leftArrow:SetActive(true)
  end
end

function DelegateTaskDialog:RefreshReddot()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  local has = manager:HasUntakeAward()
  self._redDot:SetActive(has)
end

return DelegateTaskDialog
