local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local UIManager = CS.PixelNeko.UI.UIManager
local Time = CS.UnityEngine.Time
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CHexagonScene = BeanManager.GetTableByName("activity.chexagonscene")
local CChrisTimeConfig = BeanManager.GetTableByName("dungeonselect.cchristimeconfig")
local LoopTableFrame = require("framework.ui.frame.looptable.looptableframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local timeutils = require("logic.utils.timeutils")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local BaseActivity = class("BaseActivity", Dialog)
BaseActivity.AssetBundleName = "ui/layouts.basemainhud"
BaseActivity.AssetName = "BaseActivity"

local function AddActivityGameTimer(self)
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
  if not self._gameTimerID then
    self._gameTimerID = GameTimer.AddTask(5, 5, function()
      local leftIndex = self._activityPanel_bannerFrame:GetLeftIndex()
      if leftIndex then
        if leftIndex == #self._bannerList then
          leftIndex = 0
        end
        self._activityPanel_bannerFrame:MoveLeftToIndex(leftIndex + 1, true)
      end
    end)
  end
end

function BaseActivity:Ctor(...)
  BaseActivity.super.Ctor(self, ...)
  self._bannerList = nil
  self._iconList = nil
  self._gameTimerID = nil
end

function BaseActivity:OnCreate()
  self._activityPanel = self:GetRootWindow()
  self._activityPanel_entrance = self:GetChild("Entrance")
  self._activityPanel_entrance_redDot = self:GetChild("Entrance/RedDot")
  self._activityPanel_bannerPanel = self:GetChild("Frame")
  self._activityPanel_bannerDotPanel = self:GetChild("DotFrame")
  self._activityPanel_iconPanel = self:GetChild("IconFrame")
  self._activityPanel_entrance:Subscribe_PointerClickEvent(self.OnActivityEntranceClick, self)
  self._activityPanel_bannerFrame = LoopTableFrame.Create(self._activityPanel_bannerPanel, self, false, true, false, true, true, true)
  self._activityPanel_bannerDotFrame = TableFrame.Create(self._activityPanel_bannerDotPanel, self, false, false)
  self._activityPanel_iconFrame = TableFrame.Create(self._activityPanel_iconPanel, self, true, false, false, false)
  local dotcell = DialogManager.CreateDialog("activity.bannerdotcell", self._activityPanel_bannerDotPanel._uiObject)
  local _
  self._dotCellWidth, _ = dotcell:GetRootWindow():GetRectSize()
  dotcell:Destroy()
  dotcell:RootWindowDestroy()
  self._dotFramex, self._dotFramey = self._activityPanel_bannerDotPanel:GetAnchoredPosition()
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self._activityPanel_bannerDotPanel:GetSize()
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityPanel, Common.n_RefreshActivities, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_RefreshActivityRewards, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_RefreshActivityDailySupply, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshActivityRewards, Common.n_LocalTipsStateChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnHalloweenEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSRefreshHalloweenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSRefreshHalloweenShopRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSBirthShare, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSChangeWish, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSopenBirthReward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSBirthdayActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSBirthdayActivityEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshChristmasMailRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshChristmasScore, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnLocalRefreshChristmasSupportRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenChristmasSupportActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSChristmasSupportActivityEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshSpringFestivalRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SRefreshChildrenInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SDragonBoatFestivalInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnLocalRefreshDragonBoatFestivalRedpoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_NewDreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_NewDreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SWitchInAgainstBossUpLv, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SReturnAgainstBossInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SEndAgainstBossBattle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenBpPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSUnlockBpPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSReceivedBpAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshAnniversaryDailySupply, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshAnniversaryDailyTaskList, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshAnniversaryCumulativeTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenAnniversaryDraw, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenLabyrinth, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSTaskShopActRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSReceiveTaskShopAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSEchoShopRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSSummerEchoEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSSGetSummerEchoInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_SummerShopRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpenChallengeMode, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_OnSOpensummerReward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAll, Common.n_RefreshActivityShopRedDot, nil)
  self:RefreshAll()
end

function BaseActivity:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._activityPanel_bannerFrame:Destroy()
  self._activityPanel_bannerDotFrame:Destroy()
  self._activityPanel_iconFrame:Destroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
end

function BaseActivity:RefreshAll()
  self:RefreshActivityRewards()
  self:RefreshActivityPanel()
end

function BaseActivity:RefreshActivityRewards()
  self._activityPanel_entrance_redDot:SetActive(NekoData.BehaviorManager.BM_Activity:HaveGetReward())
  self:RefreshActivityPanel()
end

function BaseActivity:RefreshActivityPanel()
  local list = NekoData.BehaviorManager.BM_Activity:GetBanners()
  if #list < 0 then
    self._activityPanel:SetActive(false)
    if self._gameTimerID then
      GameTimer.RemoveTask(self._gameTimerID)
      self._gameTimerID = nil
    end
  else
    self._activityPanel:SetActive(true)
    local leftIndex = self._activityPanel_bannerFrame:GetLeftIndex()
    local lastLeftActivityId
    if leftIndex and self._bannerList and self._bannerList[leftIndex] then
      lastLeftActivityId = self._bannerList[leftIndex].id
    end
    self._bannerList = list
    local num = #self._bannerList
    if num == 1 then
      self._activityPanel_bannerFrame:SetSlide(false)
    else
      self._activityPanel_bannerFrame:SetSlide(true)
    end
    self._activityPanel_bannerFrame:ReloadAllCell()
    if not leftIndex then
      self._activityPanel_bannerFrame:MoveToLeft()
      AddActivityGameTimer(self)
    else
      local leftIndexTemp = leftIndex
      local data = self._bannerList[leftIndex]
      if not data then
        leftIndex = 1
      elseif lastLeftActivityId then
        for i, v in ipairs(self._bannerList) do
          if v.id == lastLeftActivityId then
            leftIndex = i
            break
          end
        end
      end
      if leftIndex ~= leftIndexTemp then
        self:visibleChangeDo(leftIndex)
      end
      self._activityPanel_bannerFrame:MoveLeftToIndex(leftIndex)
      if lastLeftActivityId ~= self._bannerList[leftIndex].id then
        AddActivityGameTimer(self)
      end
    end
    self._activityPanel_bannerDotFrame:ReloadAllCell()
    local height = self._activityPanel_bannerDotFrame:GetTotalLength()
    self._activityPanel_bannerDotPanel:SetSize(self._size_x, self._dotCellWidth * num, self._size_y, self._size_offset_y)
    self._activityPanel_bannerDotPanel:SetAnchoredPosition(self._dotFramex, self._dotFramey)
    self._activityPanel_bannerDotFrame:ReloadAllCell()
    self._iconList = {}
    for k, v in pairs(self._bannerList) do
      if v.record.displayRelation == 1 then
        table.insert(self._iconList, v)
      end
    end
    table.sort(self._iconList, function(a, b)
      return b.record.priority < a.record.priority
    end)
    self._activityPanel_iconFrame:ReloadAllCell()
    local entrances = NekoData.BehaviorManager.BM_Activity:GetEntrances()
    if 0 < #entrances then
      self._activityPanel_entrance:SetActive(true)
    else
      self._activityPanel_entrance:SetActive(false)
    end
  end
end

function BaseActivity:visibleChangeDo(cellIndex)
  local tag = not self._curActivityIndex and cellIndex or self._curActivityIndex and cellIndex and cellIndex ~= self._curActivityIndex
  if tag then
    self._curActivityIndex = cellIndex
    self._activityPanel_bannerDotFrame:FireEvent("SetPageDot")
  end
end

function BaseActivity:NumberOfCell(frame)
  if frame == self._activityPanel_iconFrame then
    return #self._iconList
  else
    return #self._bannerList
  end
end

function BaseActivity:CellAtIndex(frame)
  if frame == self._activityPanel_bannerFrame then
    return "activity.bannercell"
  elseif frame == self._activityPanel_bannerDotFrame then
    return "activity.bannerdotcell"
  elseif frame == self._activityPanel_iconFrame then
    return "activity.baseactivityiconcell"
  end
end

function BaseActivity:DataAtIndex(frame, index)
  if frame == self._activityPanel_bannerFrame then
    return self._bannerList[index]
  elseif frame == self._activityPanel_bannerDotFrame then
    return self._bannerList[index]
  elseif frame == self._activityPanel_iconFrame then
    return self._iconList[index]
  end
end

function BaseActivity:OnActivityEntranceClick()
  NekoData.BehaviorManager.BM_Activity:EnterActivity()
end

function BaseActivity:OnUpdate(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  for k, v in ipairs(self._iconList) do
    v.leftTime = v.leftTime - userInfo.unscaledDeltaTime
  end
  self._activityPanel_iconFrame:FireEvent("OnUpdate")
end

return BaseActivity
