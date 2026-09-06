local RedData = require("logic.manager.experimental.types.reddata")
local TaskMainDialog = class("TaskMainDialog", Dialog)
TaskMainDialog.AssetBundleName = "ui/layouts.basetasklist"
TaskMainDialog.AssetName = "TaskMain"
local tm = NekoData.BehaviorManager.BM_Task
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.looptable.looptableframe")

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 6 then
    local tabCell = self._helper:GetCellAtIndex(2)
    if tabCell then
      if notification.userInfo.guideStatus == "Start" then
        tabCell._helper:SetSlide(false)
      else
        tabCell._helper:SetSlide(true)
      end
    end
  end
end

function TaskMainDialog:Ctor(...)
  TaskMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._mayPlayGuideEffect = false
  self._tabBtnData = {}
end

function TaskMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuide = self:GetChild("BackBtn/Effect")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tabBtnPanel = self:GetChild("Frame")
  self._frame = self:GetChild("PageFrame")
  self._width, self._height = self._tabBtnPanel:GetRectSize()
  self._anchoredx, self._anchoredy = self._tabBtnPanel:GetAnchoredPosition()
  self._tabBtnFrame = TableFrame.Create(self._tabBtnPanel, self, false, false)
  self._helper = TabFrame.Create(self._frame, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  table.insert(self._tabBtnData, RedData.MainLineTask)
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(2) then
    table.insert(self._tabBtnData, 5)
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    table.insert(self._tabBtnData, 4)
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_MainLine) then
    table.insert(self._tabBtnData, 1)
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    table.insert(self._tabBtnData, 2)
  end
  local cellPanelWidth = self._width * #self._tabBtnData
  self._tabBtnPanel:SetSize(0, cellPanelWidth, 0, self._height)
  self._tabBtnPanel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  self._tabBtnFrame:ReloadAllCell()
  self:SetRedData()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(6) then
    self:ToPage(2)
  elseif NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(9) then
    self:ToPage(1)
  elseif NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    self:ToPage(2)
  else
    self:ToPage(1)
  end
  LuaNotificationCenter.AddObserver(self, self.SetRedData, Common.n_TaskRedChange, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function TaskMainDialog:OnDestroy()
  self._tabBtnFrame:Destroy()
  if self._helper then
    self._helper:Destroy()
  end
  UIBackManager.SetUIBackShow(false)
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function TaskMainDialog:Init(baseSceneController)
  self._baseSceneController = baseSceneController
end

function TaskMainDialog:ToPage(id)
  if id == 2 then
    LuaNotificationCenter.AddObserver(self, self.OnDailyTaskRefresh, Common.n_RefreshDailyTask, nil)
    tm:RequestDailyTask()
  else
    LuaNotificationCenter.RemoveObserver(self, Common.n_RefreshDailyTask)
    self._helper:ToPage(id)
  end
end

function TaskMainDialog:OnDailyTaskRefresh()
  self._helper:ToPage(2)
  self._pressed = false
  LuaNotificationCenter.RemoveObserver(self, Common.n_RefreshDailyTask)
end

function TaskMainDialog:CellAtIndex(helper, index)
  if helper == self._helper then
    if index == 1 then
      return "task.main.maintaskdialog"
    elseif index == 2 then
      return "task.daily.dailytaskdialog"
    elseif index == 3 then
      return "task.character.charactertaskdialog"
    elseif index == 4 then
      return "achievement.roleachievementmaindialog"
    elseif index == 5 then
      return "task.delegate.delegatetaskdialog"
    elseif index == RedData.MainLineTask then
      return "task.mainline.mainlinetaskdialog"
    end
  else
    local tag = self._tabBtnData[index]
    if tag == 1 then
      return "task.maintabtn.cell5"
    elseif tag == 2 then
      return "task.maintabtn.cell2"
    elseif tag == 3 then
      return "task.maintabtn.cell3"
    elseif tag == 4 then
      return "task.maintabtn.cell4"
    elseif tag == 5 then
      return "task.maintabtn.cell1"
    elseif tag == RedData.MainLineTask then
      return "task.maintabtn.cell6"
    end
  end
end

function TaskMainDialog:NumberOfCell(frame, index)
  return #self._tabBtnData
end

function TaskMainDialog:DataAtIndex(frame, index)
  return self._tabBtnData[index]
end

function TaskMainDialog:DidToPage(helper, index)
  self._tabBtnFrame:FireEvent("SelectedTab", index)
end

function TaskMainDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("task.taskmaindialog")
end

function TaskMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function TaskMainDialog:SetRedData()
  local redData = tm:GetRedData()
  self._tabBtnFrame:FireEvent("RefreshRedDot", redData)
end

return TaskMainDialog
