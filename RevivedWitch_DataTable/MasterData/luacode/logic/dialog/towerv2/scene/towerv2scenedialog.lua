-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2scenedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local TowerV2SceneDialog = class("TowerV2SceneDialog", Dialog)
TowerV2SceneDialog.AssetBundleName = "ui/layouts.stair"
TowerV2SceneDialog.AssetName = "StairMain"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(61, 1) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(61)
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV, FinishGuide
  local guideId = (notification.userInfo).guideID
  if guideId == 63 and (notification.userInfo).guideStatus == "Start" then
    ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(13)
  end
  if guideId == 62 and (notification.userInfo).guideStatus == "Start" then
    self:RefreshBuffShow(true)
  end
  if guideId == 61 and (notification.userInfo).guideStatus == "Start" then
    self:SetStartActive(nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

TowerV2SceneDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : TowerV2SceneDialog, TowerV2SceneParts
  ((TowerV2SceneDialog.super).Ctor)(self, ...)
  self._controller = nil
  self._raycastHits = nil
  self._freezeCount = 0
  self._parts = (TowerV2SceneParts.Create)(self)
end

TowerV2SceneDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : PhysicsStaticFunctions, _ENV, HandleGuideStatusChanged
  self._panel = self:GetChild("Panel")
  self._back = self:GetChild("Panel/BackBtn")
  self._title = self:GetChild("Panel/TitleBack/Title")
  self._resume = self:GetChild("Panel/DownArea/GoOnBtn")
  self._start = {self:GetChild("Panel/GoBtn"), self:GetChild("Panel/DownArea/DualBtn/GoBtn")}
  self._team = self:GetChild("Panel/DownArea/DualBtn/TeamBtn")
  self._exploreDesc = self:GetChild("Panel/DownArea/ExploreTxt")
  self._chooseDesc = self:GetChild("Panel/DownArea/ChooseTxt")
  self._cost = {panel = self:GetChild("Panel/DownArea/CostBack"), value = self:GetChild("Panel/DownArea/CostBack/Txt2"), insufficient = self:GetChild("Panel/DownArea/CostBack/Txt2Red")}
  self._teams = {
links = {}
}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

      ((self._teams).links)[i] = self:GetChild("Panel/Link" .. i)
    end
  end
  for i = 1, 6 do
    local path_t = "Panel/Char" .. i
    -- DECOMPILER ERROR at PC99: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._teams)[i] = {board = self:GetChild(path_t), icon = self:GetChild(path_t .. "/Back/Photo"), hp = self:GetChild(path_t .. "/Frame"), dot = self:GetChild(path_t .. "/Dot")}
    ;
    (((self._teams)[i]).dot):SetActive(false)
  end
  self._choiceEffects = {self:GetChild("Panel/Effect/Active_L"), self:GetChild("Panel/Effect/Active_M"), self:GetChild("Panel/Effect/Active_R")}
  self._nodeCount = self:GetChild("Panel/Detail/Count/Num")
  self._nodeTotal = self:GetChild("Panel/Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Panel/Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Panel/Detail/Count/Box/NewRedDot1")
  self._refesh = {text = self:GetChild("Panel/Detail/Refresh/Time"), info = self:GetChild("Panel/Detail/Refresh/Ibtn")}
  self._positionFrame = self:GetChild("Panel/PositionFrame")
  self._positionMark = self:GetChild("Panel/StairPositionCurrent")
  self._spirit = {text = self:GetChild("Panel/TopGroup/VIT/Text"), button = self:GetChild("Panel/TopGroup/VIT/Add"), reddot = self:GetChild("Panel/TopGroup/VIT/RedDot")}
  self._buff = self:GetChild("Panel/BuffBtn")
  self._buffRedpoint = self:GetChild("Panel/BuffBtn/Effect")
  self._auto = {enable = self:GetChild("Panel/AutoBtn"), disable = self:GetChild("Panel/AutoBtnCancel")}
  self._progress = {start = self:GetChild("Panel/TitleBack/Empty"), 
text = {desc = self:GetChild("Panel/TitleBack/Txt1"), value = self:GetChild("Panel/TitleBack/Txt2")}
}
  self._progressFrame = self:GetChild("Panel/TitleBack")
  self._effect = self:GetChild("Panel/Detail/Effect/UI_TX_XianJie_fly")
  self._startHandle = {}
  self:BindStart(self.OnStartClick)
  ;
  (self._team):Subscribe_PointerClickEvent(self.OnTeamClick, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackClick, self)
  ;
  ((self._refesh).info):Subscribe_PointerClickEvent((self._parts).OnRefreshInfoClick, self._parts)
  ;
  (self._rewardPreview):Subscribe_PointerClickEvent((self._parts).OnPreviewRewardClick, self._parts)
  ;
  ((self._spirit).button):Subscribe_PointerClickEvent((self._parts).OnSpiritClick, self._parts)
  ;
  (self._buff):Subscribe_PointerClickEvent((self._parts).OnBuffClick, self._parts)
  ;
  ((self._auto).enable):Subscribe_PointerClickEvent(self.OnAutoEnableClick, self)
  ;
  ((self._auto).disable):Subscribe_PointerClickEvent(self.OnAutoDisableClick, self)
  for i = 1, 6 do
    (((self._teams)[i]).board):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : self, i
    (self._parts):OnTeamCharClicked(i)
  end
, self)
  end
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_UpdateEvent(self.OnUpdate, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewStair, Common.n_TowerV2Refresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStairResponse, Common.n_TowerV2Response, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAutoExploreChange, Common.n_TowerV2AutoExplore, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_TowerV2Reward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  ;
  (self._parts):OnCreate()
  ;
  (self._effect):SetActive(false)
  self:RefreshBuffShow()
end

TowerV2SceneDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._parts):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2defeatdialog")
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2rewarddialog")
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2completedialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleteachguidedialog")
end

TowerV2SceneDialog.BindStart = function(self, func)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in pairs(self._startHandle) do
    ((self._start)[i]):Unsubscribe_PointerClickEvent(v)
  end
  self._startHandle = {}
  for i,v in pairs(self._start) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

    (self._startHandle)[i] = v:Subscribe_PointerClickEvent(func, self)
  end
end

TowerV2SceneDialog.SetStartActive = function(self, state)
  -- function num : 0_6 , upvalues : bm_towerv2, _ENV
  if state == 1 then
    ((self._start)[1]):SetActive(true)
    ;
    ((self._start)[2]):SetActive(false)
    ;
    (self._team):SetActive(false)
    ;
    ((self._auto).enable):SetActive(false)
    ;
    ((self._auto).disable):SetActive(false)
  else
    if state == 2 then
      ((self._start)[1]):SetActive(false)
      ;
      ((self._start)[2]):SetActive(true)
      ;
      (self._team):SetActive(true)
      ;
      ((self._auto).enable):SetActive(false)
      ;
      ((self._auto).disable):SetActive(false)
    else
      ;
      ((self._start)[1]):SetActive(false)
      ;
      ((self._start)[2]):SetActive(false)
      ;
      (self._team):SetActive(false)
      if bm_towerv2:CanAutoExplore() and (((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(61) or ((NekoData.BehaviorManager).BM_Guide):HasFinished(61)) then
        ((self._auto).enable):SetActive(not bm_towerv2:IsInAutoExplore())
        ;
        ((self._auto).disable):SetActive(bm_towerv2:IsInAutoExplore())
      else
        ;
        ((self._auto).enable):SetActive(false)
        ;
        ((self._auto).disable):SetActive(false)
      end
    end
  end
end

TowerV2SceneDialog.Init = function(self, sceneController)
  -- function num : 0_7 , upvalues : bm_towerv2
  self._controller = sceneController
  ;
  (self._parts):Init()
  local tower_state = bm_towerv2:GetState()
  if tower_state == "finished" or tower_state == "complete" then
    self._state = "Finish"
  else
    if tower_state == "continue" then
      self._state = "Prepare"
    else
      if tower_state == "fresh" then
        self._state = "Start"
      else
        if tower_state == "retreat" then
          self._state = "Retreat"
        else
          if tower_state == "reset" or tower_state == "buffchoose" then
            self._state = "Reset"
          end
        end
      end
    end
  end
  ;
  (self._chooseDesc):SetActive(false)
  ;
  (self._exploreDesc):SetActive(false)
  ;
  (self._resume):SetActive(false)
  local show_team = self._state == "Reset" or self._state == "Retreat"
  if show_team then
    self:SetStartActive(2)
  else
    self:SetStartActive(1)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local show_progress_text = function(self, show)
  -- function num : 0_8
  (((self._progress).text).value):SetActive(show)
  ;
  (((self._progress).text).desc):SetActive(show)
  ;
  ((self._progress).start):SetActive(not show)
end

TowerV2SceneDialog.Refresh = function(self)
  -- function num : 0_9 , upvalues : bm_towerv2
  (self._parts):Refresh()
  ;
  (self._chooseDesc):SetActive((self._controller):GetState() == "choosing")
  ;
  (self._exploreDesc):SetActive((self._controller):GetState() == "running")
  self:RefreshAutoState()
  ;
  ((self._cost).panel):SetActive(not bm_towerv2:IsFreshStart() or bm_towerv2:GetReachedCount() == 0)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

TowerV2SceneDialog.RefreshAutoState = function(self)
  -- function num : 0_10 , upvalues : bm_towerv2, _ENV
  if bm_towerv2:CanAutoExplore() and (((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(61) or ((NekoData.BehaviorManager).BM_Guide):HasFinished(61)) then
    ((self._auto).enable):SetActive(not bm_towerv2:IsInAutoExplore())
    ;
    ((self._auto).disable):SetActive(bm_towerv2:IsInAutoExplore())
  else
    ;
    ((self._auto).enable):SetActive(false)
    ;
    ((self._auto).disable):SetActive(false)
  end
end

TowerV2SceneDialog.OnAutoExploreChange = function(self)
  -- function num : 0_11
  self:RefreshAutoState()
  self._autoclick = false
end

TowerV2SceneDialog.OnStairResponse = function(self)
  -- function num : 0_12
  self:Refresh()
  ;
  (self._exploreDesc):SetActive(true)
  ;
  ((self._cost).panel):SetActive(false)
end

TowerV2SceneDialog.OnNewStair = function(self)
  -- function num : 0_13 , upvalues : bm_towerv2
  local state = bm_towerv2:GetState()
  if state == "fresh" then
    self:Refresh()
    ;
    (self._chooseDesc):SetActive(false)
    ;
    (self._exploreDesc):SetActive(false)
    ;
    (self._resume):SetActive(false)
    self:SetStartActive(1)
    ;
    (self._parts):ResetMark()
  else
    ;
    ((self._cost).panel):SetActive(false)
    ;
    (self._parts):ResetMark()
    self:Refresh()
    self:SetStartActive(0)
    ;
    (self._progressFrame):SetActive(true)
  end
end

TowerV2SceneDialog.MoveMid = function(self, ...)
  -- function num : 0_14
  (self._parts):MoveMid(...)
end

TowerV2SceneDialog.IsHit = function(self, position)
  -- function num : 0_15 , upvalues : UIManager, PhysicsStaticFunctions, _ENV
  local mainCamera = (self._controller):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("DormMain", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  local count = nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  return (((self._raycastHits)[0]).collider).gameObject
end

TowerV2SceneDialog.OnMouseClicked = function(self, args)
  -- function num : 0_16
  if self._freezeCount > 0 then
    return 
  end
  local object = self:IsHit(args.position)
  if object then
    (self._controller):OnStairClick(object)
  end
end

TowerV2SceneDialog.AddNewModal = function(self)
  -- function num : 0_17
end

TowerV2SceneDialog.SetChooseTextActive = function(self, active)
  -- function num : 0_18
  (self._chooseDesc):SetActive(active)
end

TowerV2SceneDialog.SaveChooseTextActiveStateAndHide = function(self)
  -- function num : 0_19
  self._chooseTextActiveState = (self._chooseDesc):IsActive()
  ;
  (self._chooseDesc):SetActive(false)
end

TowerV2SceneDialog.RestoreChooseTextActiveState = function(self)
  -- function num : 0_20
  if self._chooseTextActiveState then
    (self._chooseDesc):SetActive(self._chooseTextActiveState)
  end
end

TowerV2SceneDialog.SetExploreTextActive = function(self, active)
  -- function num : 0_21
  (self._exploreDesc):SetActive(active)
end

TowerV2SceneDialog.Freeze = function(self, preserve)
  -- function num : 0_22
  self._freezeCount = self._freezeCount + 1
  if not preserve then
    (self:GetRootWindow()):SetActive(false)
  end
end

TowerV2SceneDialog.Thaw = function(self)
  -- function num : 0_23 , upvalues : _ENV
  self._freezeCount = (math.max)(0, self._freezeCount - 1)
  if self._freezeCount == 0 then
    (self:GetRootWindow()):SetActive(true)
  end
end

TowerV2SceneDialog.ShowContinue = function(self)
  -- function num : 0_24 , upvalues : bm_towerv2
  if bm_towerv2:GetState() == "retreat" then
    self:BindStart(self.OnRetreatClick)
    ;
    ((self._cost).panel):SetActive(true)
    self:SetStartActive(2)
  else
    self:BindStart(self.OnStartClick)
    ;
    ((self._cost).panel):SetActive(bm_towerv2:IsFreshStart())
    self:SetStartActive(1)
  end
  ;
  (self._parts):RefreshCost()
end

TowerV2SceneDialog.ShowRetreat = function(self)
  -- function num : 0_25
  self:SetStartActive(2)
  self:BindStart(self.OnRetreatClick)
  ;
  (self._parts):RefreshCost()
  ;
  ((self._cost).panel):SetActive(true)
end

TowerV2SceneDialog.ShowChooseText = function(self)
  -- function num : 0_26
  (self._chooseDesc):SetActive(true)
  ;
  (self._exploreDesc):SetActive(false)
end

TowerV2SceneDialog.HideChooseText = function(self)
  -- function num : 0_27
  (self._chooseDesc):SetActive(false)
end

TowerV2SceneDialog.HideButton = function(self)
  -- function num : 0_28
  self:SetStartActive(0)
end

TowerV2SceneDialog.OnStairRefresh = function(self, notification)
  -- function num : 0_29
  self:Refresh()
end

TowerV2SceneDialog.OnBackClick = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if self._freezeCount > 0 then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((CS.UnityEngine).Time).timeScale = 0
  ;
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(59, nil, function()
    -- function num : 0_30_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((CS.UnityEngine).Time).timeScale = 1
    self:Freeze()
    ;
    ((EffectFactory.CreateJumpBackEffect)(66)):Run()
  end
, nil, function()
    -- function num : 0_30_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((CS.UnityEngine).Time).timeScale = 1
  end
)
end

TowerV2SceneDialog.OnStartClick = function(self)
  -- function num : 0_31 , upvalues : bm_towerv2, _ENV, show_progress_text
  do
    if (bm_towerv2:IsFreshStart() or bm_towerv2:GetReachedCount() ~= 0) and bm_towerv2:GetState() ~= "continue" then
      local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
      if ((NekoData.BehaviorManager).BM_Currency):GetSpirit() < cost then
        ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
        return 
      end
    end
    if bm_towerv2:IsFreshStart() or bm_towerv2:GetState() == "reset" then
      bm_towerv2:FreshStart()
    end
    ;
    (self._controller):StartChasing(nil, false)
    self:SetStartActive(0)
    ;
    ((self._cost).panel):SetActive(false)
    ;
    (self._chooseDesc):SetActive(false)
    ;
    (self._exploreDesc):SetActive(true)
    show_progress_text(self, true)
  end
end

TowerV2SceneDialog.OnRetreatClick = function(self)
  -- function num : 0_32 , upvalues : bm_towerv2, _ENV
  local cost = ((bm_towerv2:GetFloorInfoByIndex(1)).cfg).apCost
  if cost <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit() then
    bm_towerv2:Retreat()
    self:SetStartActive(0)
    ;
    ((self._cost).panel):SetActive(false)
  else
    ;
    ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

TowerV2SceneDialog.OnTeamClick = function(self)
  -- function num : 0_33 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("teamedit.towerv2teameditdialog"))
  local dialog = nil
  local t = nil
  if self._state == "Retreat" then
    t = "retreat"
  else
    if self._state == "Finish" then
      t = "forward"
    end
  end
  dialog:GoTowerBattle(t)
end

TowerV2SceneDialog.OnPreviewRewardClick = function(self)
  -- function num : 0_34
  if self._freezeCount > 0 then
    return 
  end
  ;
  (self._parts):OnPreviewRewardClick()
end

TowerV2SceneDialog.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_35
  (self._parts):OnUpdate(deltaTime, unscaledDeltaTime)
end

TowerV2SceneDialog.TryAutoCloseAccount = function(self)
  -- function num : 0_36 , upvalues : bm_towerv2, _ENV
  if not bm_towerv2:IsInAutoExplore() then
    return 
  end
  self._accountTimer = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_36_0 , upvalues : _ENV
    (DialogManager.DestroySingletonDialog)("bag.itemaccountdialog")
  end
)
end

TowerV2SceneDialog.ClearAutoClose = function(self)
  -- function num : 0_37 , upvalues : _ENV
  if self._accountTimer then
    (GameTimer.RemoveTask)(self._accountTimer)
  end
end

TowerV2SceneDialog.ShowEffect = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local effect = (EffectFactory.CreateAnimationEffect)(nil, "UI_TX_XianJie_fly")
  effect:Bind((self._effect):GetUIObject())
  local root = (EffectFactory.CreateComposedEffect)()
  return root
end

TowerV2SceneDialog.SetChoiceEffectActive = function(self, type, active)
  -- function num : 0_39 , upvalues : _ENV
  local r = {[1] = true, [3] = true}
  if type == "ternary" then
    r[2] = true
  end
  for i,v in ipairs(self._choiceEffects) do
    v:SetActive(not r[i] or active)
  end
end

TowerV2SceneDialog.OnAutoEnableClick = function(self)
  -- function num : 0_40 , upvalues : bm_towerv2
  if self._autoclick then
    return 
  end
  bm_towerv2:StartAutoExplore()
  self._autoclick = true
end

TowerV2SceneDialog.OnAutoDisableClick = function(self)
  -- function num : 0_41 , upvalues : bm_towerv2
  if self._autoclick then
    return 
  end
  bm_towerv2:StopAutoExplore()
  self._autoclick = true
end

TowerV2SceneDialog.OnAutoExploreChange = function(self)
  -- function num : 0_42
  self._autoclick = false
  self:Refresh()
end

TowerV2SceneDialog.RefreshBuffShow = function(self, showAutoByGuide)
  -- function num : 0_43 , upvalues : _ENV
  ;
  (self._buff):SetActive(((NekoData.BehaviorManager).BM_Guide):HasFinished(62) or showAutoByGuide)
end

return TowerV2SceneDialog

