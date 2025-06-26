-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/taskmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RedData = require("logic.manager.experimental.types.reddata")
local TaskMainDialog = class("TaskMainDialog", Dialog)
TaskMainDialog.AssetBundleName = "ui/layouts.basetasklist"
TaskMainDialog.AssetName = "TaskMain"
local tm = (NekoData.BehaviorManager).BM_Task
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.looptable.looptableframe")
local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_0
  local guideId = (notification.userInfo).guideID
  if guideId == 6 then
    local tabCell = (self._helper):GetCellAtIndex(2)
    if tabCell then
      if (notification.userInfo).guideStatus == "Start" then
        (tabCell._helper):SetSlide(false)
      else
        ;
        (tabCell._helper):SetSlide(true)
      end
    end
  end
end

TaskMainDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : TaskMainDialog
  ((TaskMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._mayPlayGuideEffect = false
  self._tabBtnData = {}
end

TaskMainDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, TabFrame, _ENV, RedData, HandleGuideStatusChanged
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuide = self:GetChild("BackBtn/Effect")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tabBtnPanel = self:GetChild("Frame")
  self._frame = self:GetChild("PageFrame")
  self._width = (self._tabBtnPanel):GetRectSize()
  self._anchoredx = (self._tabBtnPanel):GetAnchoredPosition()
  self._tabBtnFrame = (TableFrame.Create)(self._tabBtnPanel, self, false, false)
  self._helper = (TabFrame.Create)(self._frame, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  ;
  (table.insert)(self._tabBtnData, RedData.MainLineTask)
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen(2) then
    (table.insert)(self._tabBtnData, 5)
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
    (table.insert)(self._tabBtnData, 4)
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_MainLine) then
    (table.insert)(self._tabBtnData, 1)
  end
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
    (table.insert)(self._tabBtnData, 2)
  end
  local cellPanelWidth = self._width * #self._tabBtnData
  ;
  (self._tabBtnPanel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._tabBtnPanel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._tabBtnFrame):ReloadAllCell()
  self:SetRedData()
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(6) then
    self:ToPage(2)
  else
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(9) then
      self:ToPage(1)
    else
      if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Task_Every) then
        self:ToPage(2)
      else
        self:ToPage(1)
      end
    end
  end
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedData, Common.n_TaskRedChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

TaskMainDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._tabBtnFrame):Destroy()
  if self._helper then
    (self._helper):Destroy()
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TaskMainDialog.Init = function(self, baseSceneController)
  -- function num : 0_4
  self._baseSceneController = baseSceneController
end

TaskMainDialog.ToPage = function(self, id)
  -- function num : 0_5 , upvalues : _ENV, tm
  if id == 2 then
    (LuaNotificationCenter.AddObserver)(self, self.OnDailyTaskRefresh, Common.n_RefreshDailyTask, nil)
    tm:RequestDailyTask()
  else
    ;
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_RefreshDailyTask)
    ;
    (self._helper):ToPage(id)
  end
end

TaskMainDialog.OnDailyTaskRefresh = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._helper):ToPage(2)
  self._pressed = false
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_RefreshDailyTask)
end

TaskMainDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_7 , upvalues : RedData
  if helper == self._helper then
    if index == 1 then
      return "task.main.maintaskdialog"
    else
      if index == 2 then
        return "task.daily.dailytaskdialog"
      else
        if index == 3 then
          return "task.character.charactertaskdialog"
        else
          if index == 4 then
            return "achievement.roleachievementmaindialog"
          else
            if index == 5 then
              return "task.delegate.delegatetaskdialog"
            else
              if index == RedData.MainLineTask then
                return "task.mainline.mainlinetaskdialog"
              end
            end
          end
        end
      end
    end
  else
    local tag = (self._tabBtnData)[index]
    if tag == 1 then
      return "task.maintabtn.cell5"
    else
      if tag == 2 then
        return "task.maintabtn.cell2"
      else
        if tag == 3 then
          return "task.maintabtn.cell3"
        else
          if tag == 4 then
            return "task.maintabtn.cell4"
          else
            if tag == 5 then
              return "task.maintabtn.cell1"
            else
              if tag == RedData.MainLineTask then
                return "task.maintabtn.cell6"
              end
            end
          end
        end
      end
    end
  end
end

TaskMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._tabBtnData
end

TaskMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._tabBtnData)[index]
end

TaskMainDialog.DidToPage = function(self, helper, index)
  -- function num : 0_10
  (self._tabBtnFrame):FireEvent("SelectedTab", index)
end

TaskMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
end

TaskMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

TaskMainDialog.SetRedData = function(self)
  -- function num : 0_13 , upvalues : tm
  local redData = tm:GetRedData()
  ;
  (self._tabBtnFrame):FireEvent("RefreshRedDot", redData)
end

return TaskMainDialog

