-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/exploredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CExploreLvUpCfg = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ExploreDialog = class("ExploreDialog", Dialog)
ExploreDialog.AssetBundleName = "ui/layouts.yard"
ExploreDialog.AssetName = "YardExploreTask"
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(59) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(59)
  end
end

ExploreDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ExploreDialog
  ((ExploreDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._enableRefresh = true
end

ExploreDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, FinishGuide
  self._lv = self:GetChild("TopMessage/LVNum")
  self._num = self:GetChild("TopMessage/Num")
  self._refreshNum = self:GetChild("Down/Num/Time/Num")
  self._progress = self:GetChild("Down/Loading/BackGround/Progress")
  self._time = self:GetChild("Down/Num/Time")
  self._panel = self:GetChild("Frame")
  self._iBtn = self:GetChild("TopMessage/Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._slotsFrame = (TableFrame.Create)(self._panel, self, false, true)
  self._initTimeWidth = (self._time):GetDeltaSize()
  self:LoadLocalData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshExploreSlot, Common.n_RefreshExploreSlot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshExploreSlotActive, Common.n_RefreshExploreSlotActive, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshExploreAllSlots, Common.n_RefreshAllExploreSlots, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTimesChanged, Common.n_RefreshTimesChanged, nil)
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(59) then
    (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

ExploreDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (self._slotsFrame):Destroy()
  if self._courtyardSceneController then
    (self._courtyardSceneController):SetCameraAnimatorState(0)
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("magictree.chooseroledialog")
end

ExploreDialog.Init = function(self, sceneController)
  -- function num : 0_4
  self._courtyardSceneController = sceneController
end

ExploreDialog.OnRefreshTimesChanged = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local restTimes = ((NekoData.BehaviorManager).BM_Explore):GetRefreshTimes()
  local maxTimes = ((NekoData.BehaviorManager).BM_Explore):GetMaxRefreshTimes()
  local restTime = ((NekoData.BehaviorManager).BM_Explore):GetRefreshLeftTime()
  local totalTime = ((NekoData.BehaviorManager).BM_Explore):GetRefreshRate() * 60 * 1000
  local useTime = totalTime - restTime
  local str = ""
  if maxTimes <= restTimes then
    (self._progress):SetFillAmount(1)
    ;
    (self._refreshNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1328, {maxTimes, maxTimes}))
  else
    ;
    (self._refreshNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1327, {restTimes, maxTimes}))
    if restTime // 1000 > 0 then
      str = ((NekoData.BehaviorManager).BM_Message):GetString(1329, {(os.date)("!%H", restTime // 1000), (os.date)("!%M", restTime // 1000), (os.date)("!%S", restTime // 1000)})
      ;
      (self._progress):SetFillAmount(useTime / totalTime)
    else
      str = ((NekoData.BehaviorManager).BM_Message):GetString(1329, {"00", "00", "00"})
      ;
      (self._progress):SetFillAmount(1)
    end
  end
  ;
  (self._time):SetText(str)
  local textwidth, textheight = (self._refreshNum):GetPreferredSize()
  ;
  (self._refreshNum):SetDeltaSize(textwidth, textheight)
  if str == "" then
    (self._time):SetDeltaSize(0, 0)
  else
    ;
    (self._time):SetDeltaSize(self._initTimeWidth, self._initTimeHeight)
  end
end

ExploreDialog.OnRefreshExploreAllSlots = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self._num):SetText(#((NekoData.BehaviorManager).BM_Explore):GetDispatchRoles())
  self._slots = ((NekoData.BehaviorManager).BM_Explore):GetSlotsInfo()
  ;
  (self._slotsFrame):ReloadAllCell()
end

ExploreDialog.OnRefreshExploreSlot = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  (self._num):SetText(#((NekoData.BehaviorManager).BM_Explore):GetDispatchRoles())
  self._slots = ((NekoData.BehaviorManager).BM_Explore):GetSlotsInfo()
  local index = self:GetSlotIndexBySlotId(((notification.userInfo).task).Id)
  if index then
    (self._slotsFrame):RemoveCellsAtIndex({index})
    ;
    (self._slotsFrame):InsertCellsAtIndex({index})
  end
end

ExploreDialog.OnRefreshExploreSlotActive = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  self._enableRefresh = true
  ;
  (self._num):SetText(#((NekoData.BehaviorManager).BM_Explore):GetDispatchRoles())
  self._slots = ((NekoData.BehaviorManager).BM_Explore):GetSlotsInfo()
  ;
  (self._slotsFrame):FireEvent("PlayRefreshAnimation", ((notification.userInfo).cavernTask).Id)
end

ExploreDialog.LoadLocalData = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self:OnRefreshTimesChanged()
  ;
  (self._lv):SetText(((NekoData.BehaviorManager).BM_Explore):GetLevel())
  ;
  (self._num):SetText(#((NekoData.BehaviorManager).BM_Explore):GetDispatchRoles())
  self._slots = ((NekoData.BehaviorManager).BM_Explore):GetSlotsInfo()
  ;
  (self._slotsFrame):ReloadAllCell()
  self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_9_0 , upvalues : self
    (self._slotsFrame):FireEvent("RefreshTimeState")
    self:OnRefreshTimesChanged()
  end
, nil)
end

ExploreDialog.GetSlotIndexBySlotId = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  for i,v in ipairs(self._slots) do
    if v.slotId == id then
      return i
    end
  end
end

ExploreDialog.NumberOfCell = function(self)
  -- function num : 0_11
  return #self._slots
end

ExploreDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12 , upvalues : SlotStateEnum
  local slotInfo = (self._slots)[index]
  if slotInfo.taskState == SlotStateEnum.LOCK then
    return "explore.detaillockcell"
  else
    if slotInfo.taskState == SlotStateEnum.UNLOCKING then
      return "explore.detailunlockcell"
    else
      return "explore.detailworkingcell"
    end
  end
end

ExploreDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  return (self._slots)[index]
end

ExploreDialog.AddNewModal = function(self, dialog)
  -- function num : 0_14
  if dialog._dialogName ~= "magictree.chooseroledialog" then
    (self:GetRootWindow()):SetActive(false)
  end
end

ExploreDialog.OnIBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if (DialogManager.GetDialog)("explore.descriptiondialog") then
    (DialogManager.DestroySingletonDialog)("explore.descriptiondialog")
  else
    ;
    (DialogManager.CreateSingletonChildDialog)("explore.descriptiondialog", self._dialogName, self:GetRootWindow())
  end
end

ExploreDialog.OnBackBtnClicked = function(self)
  -- function num : 0_16
  self:Destroy()
end

ExploreDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return ExploreDialog

