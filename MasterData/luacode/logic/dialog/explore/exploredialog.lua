local CExploreLvUpCfg = BeanManager.GetTableByName("courtyard.cexplorelvup")
local SlotStateEnum = LuaNetManager.GetBeanDef("protocol.yard.caverntask")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ExploreDialog = class("ExploreDialog", Dialog)
ExploreDialog.AssetBundleName = "ui/layouts.yard"
ExploreDialog.AssetName = "YardExploreTask"

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(59) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(59)
  end
end

function ExploreDialog:Ctor(...)
  ExploreDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._enableRefresh = true
end

function ExploreDialog:OnCreate()
  self._lv = self:GetChild("TopMessage/LVNum")
  self._num = self:GetChild("TopMessage/Num")
  self._refreshNum = self:GetChild("Down/Num/Time/Num")
  self._progress = self:GetChild("Down/Loading/BackGround/Progress")
  self._time = self:GetChild("Down/Num/Time")
  self._panel = self:GetChild("Frame")
  self._iBtn = self:GetChild("TopMessage/Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._slotsFrame = TableFrame.Create(self._panel, self, false, true)
  self._initTimeWidth, self._initTimeHeight = self._time:GetDeltaSize()
  self:LoadLocalData()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshExploreSlot, Common.n_RefreshExploreSlot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshExploreSlotActive, Common.n_RefreshExploreSlotActive, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshExploreAllSlots, Common.n_RefreshAllExploreSlots, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTimesChanged, Common.n_RefreshTimesChanged, nil)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(59) then
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

function ExploreDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._slotsFrame:Destroy()
  if self._courtyardSceneController then
    self._courtyardSceneController:SetCameraAnimatorState(0)
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("magictree.chooseroledialog")
end

function ExploreDialog:Init(sceneController)
  self._courtyardSceneController = sceneController
end

function ExploreDialog:OnRefreshTimesChanged()
  local restTimes = NekoData.BehaviorManager.BM_Explore:GetRefreshTimes()
  local maxTimes = NekoData.BehaviorManager.BM_Explore:GetMaxRefreshTimes()
  local restTime = NekoData.BehaviorManager.BM_Explore:GetRefreshLeftTime()
  local totalTime = NekoData.BehaviorManager.BM_Explore:GetRefreshRate() * 60 * 1000
  local useTime = totalTime - restTime
  local str = ""
  if restTimes >= maxTimes then
    self._progress:SetFillAmount(1)
    self._refreshNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1328, {maxTimes, maxTimes}))
  else
    self._refreshNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1327, {restTimes, maxTimes}))
    if restTime // 1000 > 0 then
      str = NekoData.BehaviorManager.BM_Message:GetString(1329, {
        os.date("!%H", restTime // 1000),
        os.date("!%M", restTime // 1000),
        os.date("!%S", restTime // 1000)
      })
      self._progress:SetFillAmount(useTime / totalTime)
    else
      str = NekoData.BehaviorManager.BM_Message:GetString(1329, {
        "00",
        "00",
        "00"
      })
      self._progress:SetFillAmount(1)
    end
  end
  self._time:SetText(str)
  local textwidth, textheight = self._refreshNum:GetPreferredSize()
  self._refreshNum:SetDeltaSize(textwidth, textheight)
  if str == "" then
    self._time:SetDeltaSize(0, 0)
  else
    self._time:SetDeltaSize(self._initTimeWidth, self._initTimeHeight)
  end
end

function ExploreDialog:OnRefreshExploreAllSlots()
  self._num:SetText(#NekoData.BehaviorManager.BM_Explore:GetDispatchRoles())
  self._slots = NekoData.BehaviorManager.BM_Explore:GetSlotsInfo()
  self._slotsFrame:ReloadAllCell()
end

function ExploreDialog:OnRefreshExploreSlot(notification)
  self._num:SetText(#NekoData.BehaviorManager.BM_Explore:GetDispatchRoles())
  self._slots = NekoData.BehaviorManager.BM_Explore:GetSlotsInfo()
  local index = self:GetSlotIndexBySlotId(notification.userInfo.task.Id)
  if index then
    self._slotsFrame:RemoveCellsAtIndex({index})
    self._slotsFrame:InsertCellsAtIndex({index})
  end
end

function ExploreDialog:OnRefreshExploreSlotActive(notification)
  self._enableRefresh = true
  self._num:SetText(#NekoData.BehaviorManager.BM_Explore:GetDispatchRoles())
  self._slots = NekoData.BehaviorManager.BM_Explore:GetSlotsInfo()
  self._slotsFrame:FireEvent("PlayRefreshAnimation", notification.userInfo.cavernTask.Id)
end

function ExploreDialog:LoadLocalData()
  self:OnRefreshTimesChanged()
  self._lv:SetText(NekoData.BehaviorManager.BM_Explore:GetLevel())
  self._num:SetText(#NekoData.BehaviorManager.BM_Explore:GetDispatchRoles())
  self._slots = NekoData.BehaviorManager.BM_Explore:GetSlotsInfo()
  self._slotsFrame:ReloadAllCell()
  self._task = GameTimer.AddTask(0, 1, function()
    self._slotsFrame:FireEvent("RefreshTimeState")
    self:OnRefreshTimesChanged()
  end, nil)
end

function ExploreDialog:GetSlotIndexBySlotId(id)
  for i, v in ipairs(self._slots) do
    if v.slotId == id then
      return i
    end
  end
end

function ExploreDialog:NumberOfCell()
  return #self._slots
end

function ExploreDialog:CellAtIndex(frame, index)
  local slotInfo = self._slots[index]
  if slotInfo.taskState == SlotStateEnum.LOCK then
    return "explore.detaillockcell"
  elseif slotInfo.taskState == SlotStateEnum.UNLOCKING then
    return "explore.detailunlockcell"
  else
    return "explore.detailworkingcell"
  end
end

function ExploreDialog:DataAtIndex(frame, index)
  return self._slots[index]
end

function ExploreDialog:AddNewModal(dialog)
  if dialog._dialogName ~= "magictree.chooseroledialog" then
    self:GetRootWindow():SetActive(false)
  end
end

function ExploreDialog:OnIBtnClicked()
  if DialogManager.GetDialog("explore.descriptiondialog") then
    DialogManager.DestroySingletonDialog("explore.descriptiondialog")
  else
    DialogManager.CreateSingletonChildDialog("explore.descriptiondialog", self._dialogName, self:GetRootWindow())
  end
end

function ExploreDialog:OnBackBtnClicked()
  self:Destroy()
end

function ExploreDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return ExploreDialog
