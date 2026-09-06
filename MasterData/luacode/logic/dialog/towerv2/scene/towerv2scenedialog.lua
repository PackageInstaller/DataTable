local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local RedDotManager = require("logic.redpoint.reddotmanager")
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local TowerV2SceneDialog = class("TowerV2SceneDialog", Dialog)
TowerV2SceneDialog.AssetBundleName = "ui/layouts.stair"
TowerV2SceneDialog.AssetName = "StairMain"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(61, 1) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(61)
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 63 and notification.userInfo.guideStatus == "Start" then
    DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(13)
  end
  if guideId == 62 and notification.userInfo.guideStatus == "Start" then
    self:RefreshBuffShow(true)
  end
  if guideId == 61 and notification.userInfo.guideStatus == "Start" then
    self:SetStartActive(nil)
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

function TowerV2SceneDialog:Ctor(...)
  TowerV2SceneDialog.super.Ctor(self, ...)
  self._controller = nil
  self._raycastHits = nil
  self._freezeCount = 0
  self._parts = TowerV2SceneParts.Create(self)
end

function TowerV2SceneDialog:OnCreate()
  self._panel = self:GetChild("Panel")
  self._back = self:GetChild("Panel/BackBtn")
  self._title = self:GetChild("Panel/TitleBack/Title")
  self._resume = self:GetChild("Panel/DownArea/GoOnBtn")
  self._start = {
    self:GetChild("Panel/GoBtn"),
    self:GetChild("Panel/DownArea/DualBtn/GoBtn")
  }
  self._team = self:GetChild("Panel/DownArea/DualBtn/TeamBtn")
  self._exploreDesc = self:GetChild("Panel/DownArea/ExploreTxt")
  self._chooseDesc = self:GetChild("Panel/DownArea/ChooseTxt")
  self._teams = {
    links = {}
  }
  for i = 1, 3 do
    self._teams.links[i] = self:GetChild("Panel/Link" .. i)
  end
  for i = 1, 6 do
    local path_t = "Panel/Char" .. i
    self._teams[i] = {
      board = self:GetChild(path_t),
      icon = self:GetChild(path_t .. "/Back/Photo"),
      hp = self:GetChild(path_t .. "/Frame"),
      dot = self:GetChild(path_t .. "/Dot")
    }
    self._teams[i].dot:SetActive(false)
  end
  self._choiceEffects = {
    self:GetChild("Panel/Effect/Active_L"),
    self:GetChild("Panel/Effect/Active_M"),
    self:GetChild("Panel/Effect/Active_R")
  }
  self._nodeCount = self:GetChild("Panel/Detail/Count/Num")
  self._nodeTotal = self:GetChild("Panel/Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Panel/Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Panel/Detail/Count/Box/NewRedDot1")
  self._refesh = {
    text = self:GetChild("Panel/Detail/Refresh/Time"),
    info = self:GetChild("Panel/Detail/Refresh/Ibtn")
  }
  self._positionFrame = self:GetChild("Panel/PositionFrame")
  self._positionMark = self:GetChild("Panel/StairPositionCurrent")
  self._topgroup = self:GetChild("Panel/TopGroup")
  self._topgroup:SetActive(false)
  self._spirit = {
    text = self:GetChild("Panel/TopGroup/VIT/Text"),
    button = self:GetChild("Panel/TopGroup/VIT/Add"),
    reddot = self:GetChild("Panel/TopGroup/VIT/RedDot")
  }
  self._buff = self:GetChild("Panel/BuffBtn")
  self._buffRedpoint = self:GetChild("Panel/BuffBtn/Effect")
  self._auto = {
    enable = self:GetChild("Panel/AutoBtn"),
    disable = self:GetChild("Panel/AutoBtnCancel")
  }
  self._auto.enable:SetActive(false)
  self._auto.disable:SetActive(false)
  self._progress = {
    start = self:GetChild("Panel/TitleBack/Empty"),
    text = {
      desc = self:GetChild("Panel/TitleBack/Txt1"),
      value = self:GetChild("Panel/TitleBack/Txt2")
    }
  }
  self._progressFrame = self:GetChild("Panel/TitleBack")
  self._effect = self:GetChild("Panel/Detail/Effect/UI_TX_XianJie_fly")
  self._rankBtn = self:GetChild("Panel/RankBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self._parts.OnRankBtnClick, self._parts)
  self._packBtn = self:GetChild("Panel/PackBtn")
  self._packBtn:Subscribe_PointerClickEvent(self._parts.OnPackBtnClick, self._parts)
  self._packBtnEffect = self:GetChild("Panel/PackBtn/Effect")
  self._packBtnEffect:SetActive(false)
  self._packBtnRedDot = self:GetChild("Panel/PackBtn/RedDot")
  self._packBtnRedDot:SetActive(false)
  self._startHandle = {}
  self:BindStart(self.OnStartClick)
  self._team:Subscribe_PointerClickEvent(self.OnTeamClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackClick, self)
  self._refesh.info:Subscribe_PointerClickEvent(self._parts.OnRefreshInfoClick, self._parts)
  self._rewardPreview:Subscribe_PointerClickEvent(self._parts.OnPreviewRewardClick, self._parts)
  self._spirit.button:Subscribe_PointerClickEvent(self._parts.OnSpiritClick, self._parts)
  self._buff:Subscribe_PointerClickEvent(self._parts.OnBuffClick, self._parts)
  self._auto.enable:Subscribe_PointerClickEvent(self.OnAutoEnableClick, self)
  self._auto.disable:Subscribe_PointerClickEvent(self.OnAutoDisableClick, self)
  for i = 1, 6 do
    self._teams[i].board:Subscribe_PointerClickEvent(function()
      self._parts:OnTeamCharClicked(i)
    end, self)
  end
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  self:GetRootWindow():Subscribe_UpdateEvent(self.OnUpdate, self)
  LuaNotificationCenter.AddObserver(self, self.OnNewStair, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStairResponse, Common.n_TowerV2Response, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAutoExploreChange, Common.n_TowerV2AutoExplore, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_TowerV2Reward, nil)
  LuaNotificationCenter.AddObserver(self, self.HideWnd, Common.n_BattleStateEnter, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  self._parts:OnCreate()
  self._effect:SetActive(false)
  self:RefreshBuffShow()
end

function TowerV2SceneDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._parts:Destroy()
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2defeatdialog")
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2rewarddialog")
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2completedialog")
  DialogManager.DestroySingletonDialog("newbattle.battleteachguidedialog")
end

function TowerV2SceneDialog:BindStart(func)
  for i, v in pairs(self._startHandle) do
    self._start[i]:Unsubscribe_PointerClickEvent(v)
  end
  self._startHandle = {}
  for i, v in pairs(self._start) do
    self._startHandle[i] = v:Subscribe_PointerClickEvent(func, self)
  end
end

function TowerV2SceneDialog:SetStartActive(state)
  if state == 1 then
    self._start[1]:SetActive(true)
    self._start[2]:SetActive(false)
    self._team:SetActive(false)
    self._auto.enable:SetActive(false)
    self._auto.disable:SetActive(false)
  elseif state == 2 then
    self._start[1]:SetActive(false)
    self._start[2]:SetActive(true)
    self._team:SetActive(true)
    self._auto.enable:SetActive(false)
    self._auto.disable:SetActive(false)
  else
    self._start[1]:SetActive(false)
    self._start[2]:SetActive(false)
    self._team:SetActive(false)
    if bm_towerv2:CanAutoExplore() and (NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(61) or NekoData.BehaviorManager.BM_Guide:HasFinished(61)) then
      self._auto.enable:SetActive(not bm_towerv2:IsInAutoExplore())
      self._auto.disable:SetActive(bm_towerv2:IsInAutoExplore())
    else
      self._auto.enable:SetActive(false)
      self._auto.disable:SetActive(false)
    end
  end
end

function TowerV2SceneDialog:Init(sceneController)
  RedDotManager.ClearTowerRedDot()
  self._controller = sceneController
  self._parts:Init()
  local tower_state = bm_towerv2:GetState()
  if tower_state == "finished" or tower_state == "complete" then
    self._state = "Finish"
  elseif tower_state == "continue" then
    self._state = "Prepare"
  elseif tower_state == "fresh" then
    self._state = "Start"
  elseif tower_state == "retreat" then
    self._state = "Retreat"
  elseif tower_state == "reset" or tower_state == "buffchoose" then
    self._state = "Reset"
  end
  self._chooseDesc:SetActive(false)
  self._exploreDesc:SetActive(false)
  self._resume:SetActive(false)
  local show_team = self._state == "Reset" or self._state == "Retreat"
  if show_team then
    self:SetStartActive(2)
  else
    self:SetStartActive(1)
  end
end

local function show_progress_text(self, show)
  self._progress.text.value:SetActive(show)
  self._progress.text.desc:SetActive(show)
  self._progress.start:SetActive(not show)
end

function TowerV2SceneDialog:Refresh()
  self._parts:Refresh()
  self._chooseDesc:SetActive(self._controller:GetState() == "choosing")
  self._exploreDesc:SetActive(self._controller:GetState() == "running")
  self:RefreshAutoState()
end

function TowerV2SceneDialog:RefreshAutoState()
  if bm_towerv2:CanAutoExplore() and (NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(61) or NekoData.BehaviorManager.BM_Guide:HasFinished(61)) then
    if self._controller:GetState() == "start" or self._controller:GetState() == "retreatandwait" then
      self._auto.enable:SetActive(false)
      self._auto.disable:SetActive(false)
    else
      self._auto.enable:SetActive(not bm_towerv2:IsInAutoExplore())
      self._auto.disable:SetActive(bm_towerv2:IsInAutoExplore())
    end
  else
    self._auto.enable:SetActive(false)
    self._auto.disable:SetActive(false)
  end
end

function TowerV2SceneDialog:OnAutoExploreChange()
  self:RefreshAutoState()
  self._autoclick = false
end

function TowerV2SceneDialog:OnStairResponse()
  self:Refresh()
  self._exploreDesc:SetActive(true)
end

function TowerV2SceneDialog:OnNewStair()
  local state = bm_towerv2:GetState()
  if state == "fresh" then
    self:BindStart(self.OnStartClick)
    self:Refresh()
    self._chooseDesc:SetActive(false)
    self._exploreDesc:SetActive(false)
    self._resume:SetActive(false)
    self:SetStartActive(1)
    self._parts:ResetMark()
  else
    self._parts:ResetMark()
    self:Refresh()
    self:SetStartActive(0)
    self._progressFrame:SetActive(true)
  end
end

function TowerV2SceneDialog:MoveMid(...)
  self._parts:MoveMid(...)
end

function TowerV2SceneDialog:IsHit(position)
  local mainCamera = self._controller:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return
  end
  return self._raycastHits[0].collider.gameObject
end

function TowerV2SceneDialog:OnMouseClicked(args)
  if self._freezeCount > 0 then
    return
  end
  local object = self:IsHit(args.position)
  if object then
    self._controller:OnStairClick(object)
  end
end

function TowerV2SceneDialog:AddNewModal()
end

function TowerV2SceneDialog:SetChooseTextActive(active)
  self._chooseDesc:SetActive(active)
end

function TowerV2SceneDialog:SaveChooseTextActiveStateAndHide()
  self._chooseTextActiveState = self._chooseDesc:IsActive()
  self._chooseDesc:SetActive(false)
end

function TowerV2SceneDialog:RestoreChooseTextActiveState()
  if self._chooseTextActiveState then
    self._chooseDesc:SetActive(self._chooseTextActiveState)
  end
end

function TowerV2SceneDialog:SetExploreTextActive(active)
  self._exploreDesc:SetActive(active)
end

function TowerV2SceneDialog:HideWnd()
  self:GetRootWindow():SetActive(false)
end

function TowerV2SceneDialog:Freeze(preserve)
  self._freezeCount = self._freezeCount + 1
  if not preserve then
    self:GetRootWindow():SetActive(false)
  end
end

function TowerV2SceneDialog:Thaw()
  self._freezeCount = math.max(0, self._freezeCount - 1)
  if self._freezeCount == 0 then
    self:GetRootWindow():SetActive(true)
  end
end

function TowerV2SceneDialog:ShowContinue()
  if bm_towerv2:GetState() == "retreat" then
    self:BindStart(self.OnRetreatClick)
    self:SetStartActive(2)
  else
    self:BindStart(self.OnStartClick)
    self:SetStartActive(1)
  end
  self._parts:RefreshCost()
end

function TowerV2SceneDialog:ShowRetreat()
  self:SetStartActive(2)
  self:BindStart(self.OnRetreatClick)
  self._parts:RefreshCost()
end

function TowerV2SceneDialog:ShowChooseText()
  self._chooseDesc:SetActive(true)
  self._exploreDesc:SetActive(false)
end

function TowerV2SceneDialog:HideChooseText()
  self._chooseDesc:SetActive(false)
end

function TowerV2SceneDialog:HideButton()
  self:SetStartActive(0)
end

function TowerV2SceneDialog:OnStairRefresh(notification)
  self:Refresh()
end

function TowerV2SceneDialog:OnBackClick()
  if self._freezeCount > 0 then
    return
  end
  CS.UnityEngine.Time.timeScale = 0
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(59, nil, function()
    CS.UnityEngine.Time.timeScale = 1
    self:Freeze()
    EffectFactory.CreateJumpBackEffect(66):Run()
  end, nil, function()
    CS.UnityEngine.Time.timeScale = 1
  end)
end

function TowerV2SceneDialog:OnStartClick()
  if (bm_towerv2:IsFreshStart() or bm_towerv2:GetReachedCount() ~= 0) and bm_towerv2:GetState() ~= "continue" then
    local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
    if cost > NekoData.BehaviorManager.BM_Currency:GetSpirit() then
      NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
      return
    end
  end
  if bm_towerv2:IsFreshStart() or bm_towerv2:GetState() == "reset" then
    bm_towerv2:FreshStart()
  end
  self._controller:StartChasing(nil, false)
  self:SetStartActive(0)
  self._chooseDesc:SetActive(false)
  self._exploreDesc:SetActive(true)
  show_progress_text(self, true)
end

function TowerV2SceneDialog:OnRetreatClick()
  local cost = bm_towerv2:GetFloorInfoByIndex(1).cfg.apCost
  if cost <= NekoData.BehaviorManager.BM_Currency:GetSpirit() then
    bm_towerv2:Retreat()
    self:SetStartActive(0)
  else
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function TowerV2SceneDialog:OnRankBtnClick()
  DialogManager.CreateSingletonDialog("towerv2.scene.towerv2rankdialog")
end

function TowerV2SceneDialog:OnPackBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.crougetowerupdateunreceivedreward")
  csend:Send()
  DialogManager.CreateSingletonDialog("towerv2.scene.towerv2packdialog")
end

function TowerV2SceneDialog:OnTeamClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.towerv2teameditdialog")
  local t
  if self._state == "Retreat" then
    t = "retreat"
  elseif self._state == "Finish" then
    t = "forward"
  end
  dialog:GoTowerBattle(t)
end

function TowerV2SceneDialog:OnPreviewRewardClick()
  if self._freezeCount > 0 then
    return
  end
  self._parts:OnPreviewRewardClick()
end

function TowerV2SceneDialog:OnUpdate(deltaTime, unscaledDeltaTime)
  self._parts:OnUpdate(deltaTime, unscaledDeltaTime)
end

function TowerV2SceneDialog:TryAutoCloseAccount()
  if not bm_towerv2:IsInAutoExplore() then
    return
  end
  self._accountTimer = GameTimer.AddTask(1, 0, function()
    DialogManager.DestroySingletonDialog("bag.itemaccountdialog")
  end)
end

function TowerV2SceneDialog:ClearAutoClose()
  if self._accountTimer then
    GameTimer.RemoveTask(self._accountTimer)
  end
end

function TowerV2SceneDialog:ShowEffect()
  local effect = EffectFactory.CreateAnimationEffect(nil, "UI_TX_XianJie_fly")
  effect:Bind(self._effect:GetUIObject())
  local root = EffectFactory.CreateComposedEffect()
  return root
end

function TowerV2SceneDialog:SetChoiceEffectActive(type, active)
  local r = {
    [1] = true,
    [3] = true
  }
  if type == "ternary" then
    r[2] = true
  end
  for i, v in ipairs(self._choiceEffects) do
    v:SetActive(r[i] and active)
  end
end

function TowerV2SceneDialog:OnAutoEnableClick()
  if self._autoclick then
    return
  end
  bm_towerv2:StartAutoExplore()
  self._autoclick = true
end

function TowerV2SceneDialog:OnAutoDisableClick()
  if self._autoclick then
    return
  end
  bm_towerv2:StopAutoExplore()
  self._autoclick = true
end

function TowerV2SceneDialog:OnAutoExploreChange()
  self._autoclick = false
  self:Refresh()
end

function TowerV2SceneDialog:RefreshBuffShow(showAutoByGuide)
  self._buff:SetActive(NekoData.BehaviorManager.BM_Guide:HasFinished(62) or showAutoByGuide)
  self._rankBtn:SetActive(NekoData.BehaviorManager.BM_Guide:HasFinished(62) or showAutoByGuide)
  self._packBtn:SetActive(NekoData.BehaviorManager.BM_Guide:HasFinished(62) or showAutoByGuide)
end

return TowerV2SceneDialog
