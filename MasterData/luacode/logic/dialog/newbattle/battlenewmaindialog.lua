local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local VarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CSkillAutoWeightCfg = BeanManager.GetTableByName("skill.cskillautoweightcfg")
local cSkillItem = BeanManager.GetTableByName("item.cskillitem")
local CEnemyInfo = BeanManager.GetTableByName("battle.cenemyinfo")
local CElementEffect = BeanManager.GetTableByName("role.celementeffect")
local CBossNianPart = BeanManager.GetTableByName("activity.cbossnianpart")
local cdungeonbattleconfig = BeanManager.GetTableByName("dungeonbattle.cdungeonbattleconfig")
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local PlatformManager = CS.PixelNeko.P1.PlatformManager
local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local DamageNumCell = {
  AssetBundleName = "ui/layouts.battle",
  AssetName = "DamageNum"
}
local BattleNewMainDialog = class("BattleNewMainDialog", Dialog)
BattleNewMainDialog.AssetBundleName = "ui/layouts.battlenew"
BattleNewMainDialog.AssetName = "BattleNewMain"
local PowerAccumulateStateType = {
  Filling = 1,
  Full = 2,
  BreakOut = 3,
  Drain = 4
}
local PowerEnergyStateNum = 4
local GuideTimeType = {
  None = 0,
  BattleStart = 1,
  BattleWin = 2,
  BattleLose = 3,
  BOSSFirstWeak = 4,
  AutoBattleGuide = 1001,
  FrameFit120 = 1002,
  PowerFirstFull = 1003,
  BattleSpeedGuide = 1006
}
local AutoBattleModeType = {Optional = 1, Default = 2}

local function OnNewBattleGuide1tartStage1(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 1 then
    local dialog = DialogManager.GetDialog("battle.battletutorial.battletutorial1dialog")
    if dialog then
      self._alonePowerGuideEffectHandler = dialog._effect1:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1038))
    end
  else
    local dialog = DialogManager.GetDialog("battle.battletutorial.battletutorial2dialog")
    if dialog then
      self._powerGuideEffectHandler = dialog._effect2:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1039))
    end
  end
end

local function OnNewBattleGuide1Stage1End(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.guideID == 1 then
    local dialog = DialogManager.GetDialog("battle.battletutorial.battletutorial1dialog")
    if dialog then
      dialog._effect1:ReleaseEffect(self._alonePowerGuideEffectHandler)
      self._alonePowerGuideEffectHandler = nil
    end
  else
    local dialog = DialogManager.GetDialog("battle.battletutorial.battletutorial2dialog")
    if dialog then
      dialog._effect2:ReleaseEffect(self._powerGuideEffectHandler)
      self._powerGuideEffectHandler = nil
    end
  end
end

local function OnNewBattleGuideTimeType1003(self, notification)
  if notification.userInfo == 5 then
    self._battleGuideTimeType_1003_guide_stage5_countTime = 0
  end
end

local function RefreshBattleDuration(self, stepNum)
  if self._inBossRush or self._inUndecidedRoad or self._inSummerEchoesChallenge then
    local str = TextManager.GetText(CStringRes:GetRecorder(1099).msgTextID)
    self._battleDurationPanel_txt:SetText(string.gsub(str, "%$parameter1%$", tostring(math.floor(stepNum / 30))))
  end
  if self._inSpring or self._inAnniversaryDailyBattle then
    local limit = 0
    if self._inSpring then
      local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
      local bossRecorder = CBossNianPart:GetRecorderByValue("battleId", battleID)
      limit = bossRecorder.countDown
    elseif self._inAnniversaryDailyBattle then
      limit = tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(3).type)
    end
    local sec = tostring(limit - math.floor(stepNum / 30))
    local min = math.floor(sec / 60)
    sec = sec - min * 60
    if min < 10 then
      min = "0" .. min
    end
    sec = math.floor(sec)
    if sec < 10 then
      sec = "0" .. sec
    end
    local str = TextManager.GetText(CStringRes:GetRecorder(1722).msgTextID, min, sec)
    self._battleDurationPanel_txt:SetText(str)
  end
end

function BattleNewMainDialog:Ctor(...)
  BattleNewMainDialog.super.Ctor(self, ...)
  self._groupName = "Battle"
  self._hpCells = {}
  self._battleWorld = nil
  self._battleGuideTimeType_1003_guide_stage5_countTime = nil
  self._battleGuideTimeType_1003_guide_stage4_countTime = nil
  self._damageCells = {}
  self._recycleList = {}
  self._leftHpCells = {}
  self._leftHpCellsVisibleCount = {}
  self._summonHpCells = {}
  self._summonHpCellsVisibleCount = {}
  self._rightHpCells = {}
  self._rightHpCellsVisibleCount = {}
  self._entityList = {}
  self._width = 0
  self._height = 0
  self._leftPowerGridFullEffect = {}
  self._leftPowerLightDotEffect = {}
  self._leftPowerEffect = {}
  self._rightPowerGridFullEffect = {}
  self._rightPowerLightDotEffect = {}
  self._rightPowerEffect = {}
  self._alonePowerGridFullEffect = {}
  self._alonePowerLightDotEffect = {}
  self._alonePowerEffect = {}
  self._alonePowerFlowEffectHandler = nil
  self._alonePowerGridFullEffectHandlers = {}
  self._alonePowerLightDotEffectHandlers = {}
  self._alonePowerEffectHandlers = {}
  self._normalPowerFlowEffectHandler = nil
  self._magicSurgeEffectHandler = nil
  self._leftPowerGridFullEffectHandlers = {}
  self._leftPowerGridOtherEffectHandlers = {}
  self._leftPowerLightDotEffectHandlers = {}
  self._leftPowerEffectHandlers = {}
  self._rightPowerGridFullEffectHandlers = {}
  self._rightPowerLightDotEffectHandlers = {}
  self._rightPowerEffectHandlers = {}
  for i = 1, 7 do
    self._leftPowerGridFullEffectHandlers[i] = 0
    self._leftPowerGridOtherEffectHandlers[i] = 0
    self._leftPowerLightDotEffectHandlers[i] = 0
    self._rightPowerGridFullEffectHandlers[i] = 0
    self._rightPowerLightDotEffectHandlers[i] = 0
    self._alonePowerGridFullEffectHandlers[i] = 0
    self._alonePowerLightDotEffectHandlers[i] = 0
    self._alonePowerEffectHandlers[i] = 0
    self._leftPowerEffectHandlers[i] = 0
    self._rightPowerEffectHandlers[i] = 0
  end
  self._isInBattleGuideSpecialSkillEffect = false
  self._alonePowerGuideEffectHandler = nil
  self._powerGuideEffectHandler = nil
  self._assistRole = nil
  self._leftAssistNum = 0
  self._totalAssistNum = 0
  self._useSupportRole = false
  self._leftAssistNumBegin = 0
  self._playingBattleEndAnimation = false
  self._autoBattleInfo = nil
  self._autoCancelBtnEffectHandler = nil
  self._speedBtnEffectHandler = nil
  self._runtimePackerAgent = nil
  self._breakOutPowerGuideState = false
  self._breakOutPowerMaterial = {}
  self._breakOutPowerState = PowerAccumulateStateType.Filling
  self._leftPowerImgGridsFlyTask = {}
  self._rightPowerImgGridsFlyTask = {}
  self._leftPowerImgGridsFlyEffect = {}
  self._rightPowerImgGridsFlyEffect = {}
  self._totalNumForSecondHurt = {}
  self._totalTimeForSecondHurt = {}
  self._breakOutPowerTotalDamageNum = nil
  self._battleEnergyCountAnimationIsEnd = true
end

function BattleNewMainDialog:OnCreate()
  self._damageParent = self:GetChild("DamageNum")
  self._hpBar = self:GetChild("HPBar")
  self._staticHpBar = self:GetChild("HPCell")
  self._skillPanel = self:GetChild("SkillPanel")
  self._leftPowerGrids = {}
  self._leftPowerLightDot = {}
  self._rightPowerGrids = {}
  self._rightPowerLightDot = {}
  self._aloneProgress = self:GetChild("BattleProgressBackAlone")
  self._normalProgress = self:GetChild("BattleProgressBack")
  self._pauseBtn = self:GetChild("PauseBtn")
  self._enemyDetailBtn = self:GetChild("EnemyDetail")
  self._enemyDetailBtn:SetActive(CEnemyInfo:GetRecorder(NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().battleid) or false)
  self._leaveBtn = self:GetChild("LeaveBtn")
  self._pauseBtn:SetActive(false)
  self._leaveBtn:SetActive(false)
  self._winRetreatBtn = self:GetChild("WinBtn")
  self._loseRetreatBtn = self:GetChild("LoseBtn")
  self._detailBtn = self:GetChild("DetailBtn")
  self._gmBtn = self:GetChild("GMBtn")
  self._autoBtn = self:GetChild("AutoBtn")
  self._autoCancelBtn = self:GetChild("AutoBtnCancel")
  self._autoCancelBtnEffect = self:GetChild("AutoBtnCancel/Effect")
  self._speedBtn = self:GetChild("SpeedBtn")
  self._speedBtnEffect = self:GetChild("SpeedBtn/Effect")
  self._speedBtn:SetSelected(false)
  self._skipBtn = self:GetChild("SkipBtn")
  self._skipBtn:SetActive(false)
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleRetreat) then
    self._speedBtn:SetActive(false)
  end
  self._autoBtnGuide = self:GetChild("AutoBtn/Guide")
  self._speedBtnGuide = self:GetChild("SpeedBtn/Guide")
  self._pauseBtnGuide = self:GetChild("PauseBtn/Guide")
  if not NekoData.BehaviorManager.BM_Game:IsGM() then
    self._winRetreatBtn:SetActive(false)
    self._loseRetreatBtn:SetActive(false)
    self._detailBtn:SetActive(false)
    self._gmBtn:SetActive(false)
  end
  local curId = NekoData.BehaviorManager.BM_Dungeon:GetCurrentFloorId()
  local autoExplore = NekoData.BehaviorManager.BM_Game:GetFloorAutoExploreBySceneId(curId)
  if autoExplore then
    local battleid = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
    local battlecfg = cdungeonbattleconfig:GetRecorder(battleid)
    if battlecfg then
      self._skipBtn:SetActive(battlecfg.ifskip == 1)
    end
  end
  self._leftPowerImgGrids = {}
  self._rightPowerImgGrids = {}
  self._alonePowerImgGrids = {}
  self._alonePowerGrids = {}
  self._alonePowerLightDot = {}
  for i = 1, 7 do
    self._leftPowerImgGrids[i] = self:GetChild("BattleProgressBack/Y" .. i .. "Img")
    self._leftPowerGrids[i] = self:GetChild("BattleProgressBack/Y" .. i)
    self._leftPowerGridFullEffect[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/Effect")
    self._leftPowerLightDot[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/LightDot")
    self._leftPowerLightDotEffect[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/LightDot/Effect")
    self._leftPowerEffect[i] = self:GetChild("BattleProgressBack/EffectY" .. i)
    self._rightPowerImgGrids[i] = self:GetChild("BattleProgressBack/B" .. i .. "Img")
    self._rightPowerGrids[i] = self:GetChild("BattleProgressBack/B" .. i)
    self._rightPowerGridFullEffect[i] = self:GetChild("BattleProgressBack/B" .. i .. "/Effect")
    self._rightPowerLightDot[i] = self:GetChild("BattleProgressBack/B" .. i .. "/LightDot")
    self._rightPowerLightDotEffect[i] = self:GetChild("BattleProgressBack/B" .. i .. "/LightDot/Effect")
    self._rightPowerEffect[i] = self:GetChild("BattleProgressBack/EffectB" .. i)
    self._alonePowerImgGrids[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "Img")
    self._alonePowerGrids[i] = self:GetChild("BattleProgressBackAlone/B" .. i)
    self._alonePowerGridFullEffect[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/Effect")
    self._alonePowerLightDot[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/LightDot")
    self._alonePowerLightDotEffect[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/LightDot/Effect")
    self._alonePowerEffect[i] = self:GetChild("BattleProgressBackAlone/EffectB" .. i)
  end
  self._normalPowerFlowEffect = self:GetChild("BattleProgressBack/EffectBig")
  self._alonePowerFlowEffect = self:GetChild("BattleProgressBackAlone/EffectBig")
  self._alonePowerGuideEffect = self:GetChild("BattleProgressBackAlone/Effect")
  self._powerGuideEffect = self:GetChild("BattleProgressBack/Effect")
  self._magicSurgeEffect = self:GetChild("BattleProgressBack/EffectMoYong")
  self._breakOutPowerBtn = self:GetChild("BattleEnergyBtn")
  self._breakOutPowerStateUI = {}
  for i = 1, PowerEnergyStateNum do
    self._breakOutPowerStateUI[i] = self:GetChild("BattleEnergyBtn/Energy" .. i)
    self._breakOutPowerStateUI[i]:SetActive(false)
  end
  self._breakOutPowerEmptyUI = self:GetChild("BattleEnergyBtn/Energy0")
  self._breakOutPowerFullUI = self:GetChild("BattleEnergyBtn/Energy" .. PowerEnergyStateNum + 1)
  self._breakOutPowerEnergyFullEffect = self:GetChild("BattleEnergyBtn/Energy" .. PowerEnergyStateNum + 1 .. "/EffectEnergyFull")
  self._breakOutPowerFullUI:SetActive(false)
  self._breakOutPowerCountProgress = self:GetChild("BattleEnergyBtn/CountProgress")
  self._breakOutPowerCountNum = self:GetChild("BattleEnergyBtn/CountProgress/CountNum")
  self._breakOutPowerCountProgress:SetActive(false)
  self._breakOutPowerFullEffect = self:GetChild("BattleEnergyBtn/Effect")
  self._cdEndEffect = self:GetChild("BattleProgressBack/EnergyBtn/EffectCDEnd")
  self._effectEnergy = self:GetChild("EffectEnergy")
  self._breakOutPowerGuide = self:GetChild("BattleEnergyBtn/Guide")
  self._breakOutPowerTotalDamagePanel = self:GetChild("BattleEnergyCount")
  self._breakOutPowerTotalDamageNumTxt = self:GetChild("BattleEnergyCount/Num/Text")
  self._breakOutPowerTotalDamageNumEffect = self:GetChild("BattleEnergyCount/Num/Effect")
  self._breakOutPowerTotalDamageNumEffectAnchorMinX, self._breakOutPowerTotalDamageNumEffectAnchorMinY, self._breakOutPowerTotalDamageNumEffectAnchorMaxX, self._breakOutPowerTotalDamageNumEffectAnchorMaxY, self._breakOutPowerTotalDamageNumEffectOffsetMinX, self._breakOutPowerTotalDamageNumEffectOffsetMinY, self._breakOutPowerTotalDamageNumEffectOffsetMaxX, self._breakOutPowerTotalDamageNumEffectOffsetMaxY = self._breakOutPowerTotalDamageNumEffect:GetAnchorAndOffset()
  self._breakOutPowerTotalDamageNumTxtRectX = self._breakOutPowerTotalDamageNumTxt:GetRectSize()
  self._supportRole = self:GetChild("BattleAssistBack")
  self._supportRole:SetActive(false)
  self._supportRolePhoto = self:GetChild("BattleAssistBack/CharBack/Char")
  self._supportRoleFrame = self:GetChild("BattleAssistBack/Frame")
  self._supportRoleNum = self:GetChild("BattleAssistBack/Num")
  self._supportRoleSkillImg = self:GetChild("BattleAssistBack/Back/Mask/Photo")
  self._battleDurationPanel = self:GetChild("Time")
  self._battleDurationPanel_title = self:GetChild("Time/TimeTxt")
  self._battleDurationPanel_txt = self:GetChild("Time/Time")
  self._defaultModeAutoBattlePanel = self:GetChild("Auto")
  self._defaultModeAutoBattlePanelCancelBtn = self:GetChild("Auto/AutoCancelBtn")
  self._elementImg = self:GetChild("Element")
  self._stageShow = self:GetChild("ActivitySummer2ChallengeBattleText")
  self._stageTxt = self:GetChild("ActivitySummer2ChallengeBattleText/Txt")
  local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
  local battleSpecialId = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
  self._inBossRush = battleType == CBattleStartProtocol.BOSS_RUSH or battleType == CBattleStartProtocol.WEEK_BOSS
  self._inUndecidedRoad = battleType == CBattleStartProtocol.UNDECIDEDROAD
  self._inSpring = battleType == CBattleStartProtocol.SPRING_FESTIVAL
  self._inWeekBoss = battleType == CBattleStartProtocol.WEEK_BOSS
  self._inAnniversaryDailyBattle = battleType == CBattleStartProtocol.ANNIVERSARY and NekoData.BehaviorManager.BM_Anniversary:IsDailyBossLevel(battleSpecialId)
  local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  self._inSummerEchoesChallenge = battleType == CBattleStartProtocol.SUMMER_ECHO and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):IsChallengeBattle(battleID)
  if self._inSummerEchoesChallenge then
    self._stageShow:SetActive(true)
    self._stageTxt:SetText(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):GetStageStr(battleID))
  else
    self._stageShow:SetActive(false)
  end
  if self._inBossRush or self._inUndecidedRoad or self._inSpring or self._inAnniversaryDailyBattle or self._inSummerEchoesChallenge then
    self._battleDurationPanel:SetActive(true)
    if self._inSpring or self._inAnniversaryDailyBattle then
      self._battleDurationPanel_title:SetText(TextManager.GetText(CStringRes:GetRecorder(1721).msgTextID))
    end
    RefreshBattleDuration(self, 0)
  else
    self._battleDurationPanel:SetActive(false)
  end
  self._alonePowerWidth, self._alonePowerHeight = self._alonePowerGrids[1]:GetRectSize()
  self._leftPowerWidth, self._rightPowerHeight = self._leftPowerGrids[1]:GetRectSize()
  self._lightDotWidth, self._lightDotHeight = self._alonePowerLightDot[1]:GetRectSize()
  self._frame = TableFrame.Create(self._skillPanel, self, false, false)
  self._breakOutPowerUnlockState = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattlePowerBreakOut)
  self._breakOutPowerBtn:SetActive(self._breakOutPowerUnlockState)
  self._supportRole:Subscribe_PointerClickEvent(self.OnSupportRoleClick, self)
  self._pauseBtn:Subscribe_PointerClickEvent(self.OnPauseBtnClick, self)
  self._enemyDetailBtn:Subscribe_PointerClickEvent(self.OnEnemyDetailBtnClick, self)
  self._leaveBtn:Subscribe_PointerClickEvent(self.OnLeaveBtnClick, self)
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailBtnClick, self)
  self._gmBtn:Subscribe_PointerClickEvent(self.OnGMBtnClick, self)
  self._winRetreatBtn:Subscribe_PointerClickEvent(self.OnWinRetreatBtnClick, self)
  self._loseRetreatBtn:Subscribe_PointerClickEvent(self.OnLoseRetreatBtnClick, self)
  self._skipBtn:Subscribe_PointerClickEvent(self.OnWinSkipBtnClick, self)
  self._autoBtn:Subscribe_PointerClickEvent(self.OnAutoBtnClick, self)
  self._autoCancelBtn:Subscribe_PointerClickEvent(self.OnAutoCancelBtnClick, self)
  self._speedBtn:Subscribe_PointerClickEvent(self.OnSpeedBtnClick, self)
  self._breakOutPowerBtn:Subscribe_PointerClickEvent(self.OnBreakOutPowerBtnClick, self)
  self._defaultModeAutoBattlePanelCancelBtn:Subscribe_PointerClickEvent(self.OnAutoCancelBtnClick, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementBtnClick, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_BattleLateUpdate, nil)
  self._width, self._height = self._skillPanel:GetRectSize()
  self._rootWindowAnchoredx, self._rootWindowAnchoredy = self._skillPanel:GetAnchoredPosition()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshState, Common.n_FrameNumUsed, nil)
  LuaNotificationCenter.AddObserver(self, self.CreateBatttlerHPBar, Common.n_RoleAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.CreateBatttlerSummonHPBar, Common.n_RoleAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.DestroyBatttlerHPBar, Common.n_RoleDead, nil)
  LuaNotificationCenter.AddObserver(self, self.OnHPChanged, Common.n_HpChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnHPCellVisibleChange, Common.n_HpVisible, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDamageMiss, Common.n_DamageMiss, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillSuccess, Common.n_SkillSuccess, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillFail, Common.n_SkillFail, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSupportRoleUsed, Common.n_SupportRoleUsed, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleEquipSkillUsed, Common.n_RoleEquipSkillUsed, nil)
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuide1tartStage1, Common.n_NewBattleGuide1StartStage1, nil)
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuide1Stage1End, Common.n_NewBattleGuide1Stage1End, nil)
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
  LuaNotificationCenter.AddObserver(self, self.OnFillInBattlePower, Common.n_FillInBattlePower, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBattlePauseStateChange, Common.n_BattlePauseStateChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAccumulatePowerStateChange, Common.n_AccumulatePowerState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillBegin, Common.n_SkillBegin, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillInterrupted, Common.n_SkillInterrupted, nil)
  LuaNotificationCenter.AddObserver(self, self.OnInvincibleStateChange, Common.n_InvincibleStateChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnShieldValueChange, Common.n_ShieldValueChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnInBattleGuide, Common.n_InBattleGuide, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnActiveSkillStateChange, Common.n_ActiveSkillStateChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeSecondHurtShowState, Common.n_ChangeSecondHurtShowState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEntityNameChanging, Common.n_EntityNameChanging, nil)
  LuaNotificationCenter.AddObserver(self, self.OnOrderPowerSpecialUIEffect, Common.n_OrderPowerSpecialUIEffect, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBreakOutPowerNumberChange, Common.n_BreakOutPowerNumberChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBossViolentEnter, Common.n_BossViolentEnter, nil)
  local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  if battleID and battleID == 1120 then
    self:SetPauseBtnState(false)
  else
    self:SetPauseBtnState(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattlePause))
  end
  if battleID and (battleID == 1120 or battleID == 1122) then
    self._elementImg:SetActive(false)
  else
    self._elementImg:SetActive(true)
  end
  local plat = CS.PixelNeko.LuaManager.GetSystemType()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat ~= systemType.UNITY then
    if CS.PixelNeko.P1.GameApp.applicationPause then
      LogInfoFormat("BattleNewMainDialog", [[
CS.PixelNeko.P1.GameApp.applicationPause %s 

%s
]], CS.PixelNeko.P1.GameApp.applicationPause, debug.traceback())
    end
    LuaNotificationCenter.AddObserver(self, self.OnApplicationPause, Common.n_ApplicationPause, nil)
  end
  local buffShowMode = NekoData.BehaviorManager.BM_Game:GetBuffShowMode()
  if buffShowMode and buffShowMode == "Show" then
    LuaNotificationCenter.AddObserver(self, self.OnBuffsUpdate, Common.n_BuffsUpdate, nil)
  end
  LuaNotificationCenter.PostNotification(Common.n_NewBattleGuide1BattleNewMainDialogCreated, nil, nil)
  local battleInfoRecord = CBattleInfoTable:GetRecorder(NekoData.BehaviorManager.BM_Battle:GetBattleId())
  if battleInfoRecord and battleInfoRecord.auto == 1 then
    self._autoBtn:SetActive(true)
    self._autoCancelBtn:SetActive(false)
    NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight = 0
    LogInfoFormat("BattleNewMainDialog", "battleid %s cbattleinfo.auto = 1", NekoData.BehaviorManager.BM_Battle:GetBattleId())
  end
  if NekoData.BehaviorManager.BM_Battle:GetBattleType() == 19 then
    NekoData.DataManager.DM_Dungeon:SetMode("auto")
  end
  if NekoData.BehaviorManager.BM_Dungeon:GetMode() == "auto" then
    LogInfoFormat("BattleNewMainDialog", "battleid %s mode is auto, autobattleinfo.speed %s .autoFight 1", NekoData.BehaviorManager.BM_Battle:GetBattleId(), tonumber(CBattleConfig:GetRecorder(85).attr))
    NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight = 1
    NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().speed = tonumber(CBattleConfig:GetRecorder(85).attr)
  end
  local autoBattleInfo = NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleAuto) then
    self._autoBtn:SetActive(false)
    self._autoCancelBtn:SetActive(false)
  elseif NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleAuto) then
    if autoBattleInfo.speed == 1 then
      if not self._pause then
        NekoData.DataManager.DM_TimeScale:SetBattleNormalSpeed()
      end
      self._speedBtn:SetSelected(false)
    else
      if not self._pause then
        NekoData.DataManager.DM_TimeScale:SetBattleNTimesSpeed()
      end
      self._speedBtn:SetSelected(true)
      self._speedBtnEffectHandler = self._speedBtnEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1032))
    end
    if autoBattleInfo.autoFight == 0 then
      self._autoBtn:SetActive(true)
      self._autoCancelBtn:SetActive(false)
    elseif autoBattleInfo.autoFight == 1 then
      self._autoBtn:SetActive(false)
      self._autoCancelBtn:SetActive(true)
      self._autoCancelBtnEffectHandler = self._autoCancelBtnEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1032))
      if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Default then
        self._defaultModeAutoBattlePanel:SetActive(true)
      end
      local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
      if battleType == CBattleStartProtocol.FANTASY_CONFLICT then
        self._defaultModeAutoBattlePanel:SetActive(true)
      end
    end
  end
  self._baseDamageNumCell = UIManager.CreateLuaWindow(DamageNumCell.AssetBundleName .. ".assetbundle", DamageNumCell.AssetName, self._damageParent._uiObject)
  self._baseDamageNumCell:SetActive(false)
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.Battle, self)
  self._leftPowerImgGridsPosition = {}
  self._rightPowerImgGridsPosition = {}
  local _
  for i = 1, 7 do
    self._leftPowerImgGridsPosition[i] = {}
    self._rightPowerImgGridsPosition[i] = {}
    _, self._leftPowerImgGridsPosition[i].x, _, self._leftPowerImgGridsPosition[i].y = self._leftPowerImgGrids[i]:GetPosition()
    _, self._rightPowerImgGridsPosition[i].x, _, self._rightPowerImgGridsPosition[i].y = self._rightPowerImgGrids[i]:GetPosition()
  end
  self._leftPowerImgGridsSizeX, self._leftPowerImgGridsSizeY = self._leftPowerImgGrids[1]:GetRectSize()
  self._rightPowerImgGridsSizeX, self._rightPowerImgGridsSizeY = self._rightPowerImgGrids[1]:GetRectSize()
  self._breakOutPowerBtnPosition = {}
  _, self._breakOutPowerBtnPosition.x, _, self._breakOutPowerBtnPosition.y = self._breakOutPowerBtn:GetPosition()
  self._breakOutPowerBtnSizeX, self._breakOutPowerBtnSizeY = self._breakOutPowerBtn:GetRectSize()
  self:RefreshTeamElementInfo()
  self._newYearBattleCountText = self:GetChild("NewYearBattleCount/Num/Text")
  self._newYearBattleCount = self:GetChild("NewYearBattleCount")
  self._isSpring = battleType == CBattleStartProtocol.SPRING_FESTIVAL
  self._newYearBattleCount:SetActive(self._isSpring)
  if self._isSpring then
    self._totalDamage = 0
    self._newYearBattleCountText:SetText(self._totalDamage)
  end
end

function BattleNewMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("newbattle.battlepausedialog")
  DialogManager.DestroySingletonDialog("newbattle.battleroleskillsdetaildialog")
  DialogManager.DestroySingletonDialog("newbattle.battleguidetimetype1003stage4maskdialog")
  NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  NekoData.DataManager.DM_TimeScale:Clear()
  for k, v in pairs(self._leftHpCells) do
    self._leftHpCells[k]:Destroy()
    self._leftHpCells[k]:RootWindowDestroy()
    self._leftHpCells[k] = nil
    self._leftHpCellsVisibleCount[k] = nil
  end
  for k, v in pairs(self._summonHpCells) do
    self._summonHpCells[k]:Destroy()
    self._summonHpCells[k] = nil
    self._summonHpCellsVisibleCount[k] = nil
  end
  for k, v in pairs(self._rightHpCells) do
    self._rightHpCells[k]:Destroy()
    self._rightHpCells[k]:RootWindowDestroy()
    self._rightHpCells[k] = nil
    self._rightHpCellsVisibleCount[k] = nil
  end
  for k, v in pairs(self._damageCells) do
    self._damageCells[k]:Destroy()
    self._damageCells[k]:RootWindowDestroy()
    self._damageCells[k] = nil
  end
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  if self._runtimePackerAgent then
    self._runtimePackerAgent:Release()
  end
  if self._cdEndEffectHandler then
    self._cdEndEffect:ReleaseEffect(self._cdEndEffectHandler)
    self._cdEndEffectHandler = nil
  end
  if self._effectEnergyPowerEffectHandler then
    self._effectEnergy:ReleaseEffect(self._effectEnergyPowerEffectHandler)
    self._effectEnergyPowerEffectHandler = nil
  end
  for _, effObj in ipairs(self._leftPowerImgGridsFlyEffect) do
    effObj:Destroy()
    effObj:RootWindowDestroy()
  end
  for _, effObj in ipairs(self._rightPowerImgGridsFlyEffect) do
    effObj:Destroy()
    effObj:RootWindowDestroy()
  end
  if self._breakOutPowerBreakOutEffectHandler then
    self._breakOutPowerFullEffect:ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
    self._breakOutPowerBreakOutEffectHandler = nil
  end
  if self._showDamageTask then
    GameTimer.RemoveTask(self._showDamageTask)
  end
end

function BattleNewMainDialog:SetBattleWorld(battleWorld)
  self._battleWorld = battleWorld
end

function BattleNewMainDialog:SetPauseBtnState(state)
  self._pauseBtnState = state
end

function BattleNewMainDialog:AddAssistRole(assist, leftAssistNum, totalAssistNum)
  self._assistRole = assist
  self._leftAssistNum = leftAssistNum
  self._leftAssistNumBegin = leftAssistNum
  self._totalAssistNum = totalAssistNum
  local assistRoleSkillList = {}
  for _, v in ipairs(assist.skills) do
    if v ~= 0 then
      table.insert(assistRoleSkillList, v)
    end
  end
  local oneAssitSkillId
  for _, v in pairs(assistRoleSkillList) do
    oneAssitSkillId = v
  end
  if oneAssitSkillId then
    local record = CSkillTable:GetRecorder(oneAssitSkillId)
    if not record then
      LogErrorFormat("BattleNewMainDialog", "wrong assist skillid %d", oneAssitSkillId)
    end
    local imgRecord = CImagePathTable:GetRecorder(record.icon) or DataCommon.DefaultImageAsset
    self._supportRoleSkillImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  self._supportRoleNum:SetText(tostring(self._leftAssistNum) .. "/" .. tostring(self._totalAssistNum))
  if self._leftAssistNum > 0 then
    local supportRole = Role.Create(assist.id)
    if supportRole then
      local imageRecord = supportRole:GetSkillHeadImageRecord()
      self._supportRolePhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      LogError("BattleNewMainDialog", "roleId %s create Role Failed", assist.id)
      self._supportRole:SetActive(false)
    end
  else
    LogInfoFormat("BattleNewMainDialog", "leftAssistNum %s totalAssistNum %s", leftAssistNum, totalAssistNum)
  end
end

function BattleNewMainDialog:OnClicked(args)
  local dialog = DialogManager.GetDialog("newbattle.battleroleskillsdetaildialog")
  if dialog then
    dialog:Destroy()
  end
end

function BattleNewMainDialog:OnRefreshState(notification)
  RefreshBattleDuration(self, notification.userInfo)
  if self._assistRole and notification.userInfo == tonumber(CBattleConfig:GetRecorder(27).attr) and self._leftAssistNum > 0 then
    self._supportRole:SetActive(true)
  end
  if notification.userInfo == tonumber(CBattleConfig:GetRecorder(28).attr) then
    self._pauseBtn:SetActive(self._pauseBtnState)
    self._leaveBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleRetreat))
  end
  if self._battleGuideTimeType_1002_guide then
    if notification.userInfo == 121 then
      LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideTimeType1002Start, self, 1)
    elseif notification.userInfo == 241 then
      LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideTimeType1002Start, self, 2)
    end
  elseif self._battleGuideTimeType_1001_guide then
    if notification.userInfo == 10 then
      self:SetGuideFrame({
        guideTimeType = GuideTimeType.AutoBattleGuide,
        stage = 1
      }, nil, "Up", 2301127)
    end
  elseif NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.BATTLE_2X) == 0 then
    if notification.userInfo == 15 then
      self:SetGuideFrame({
        guideTimeType = GuideTimeType.BattleSpeedGuide,
        stage = 1
      }, nil, "Up", 2301126)
    end
  elseif self._battleGuideTimeType_1003_guide and notification.userInfo == 15 then
    self:SetGuideFrame({
      guideTimeType = GuideTimeType.PowerFirstFull,
      stage = 1
    }, nil, "Up", 2301167)
  end
  for _, v in ipairs(self._entityList) do
    if self._leftHpCells[v:GetEntityId()] then
      for index, skillId in ipairs(v:GetSkillList()) do
        local autoCDTime = v:GetSkillAutoCDTime(skillId)
        if 0 < autoCDTime then
          v:SetSkillAutoCDTime(skillId, autoCDTime - 1)
        end
      end
    end
  end
  if self._battleGuideTimeType_1003_guide_stage5_countTime then
    self._battleGuideTimeType_1003_guide_stage5_countTime = self._battleGuideTimeType_1003_guide_stage5_countTime + 1
    if 15 <= self._battleGuideTimeType_1003_guide_stage5_countTime then
      self._battleGuideTimeType_1003_guide_stage5_countTime = nil
      self:SetGuideFrame({
        guideTimeType = GuideTimeType.PowerFirstFull,
        stage = 5
      }, nil, "Up", 2301173)
    end
  end
  if self._battleGuideTimeType_1003_guide_stage4_countTime then
    self._battleGuideTimeType_1003_guide_stage4_countTime = self._battleGuideTimeType_1003_guide_stage4_countTime + 1
    if self._battleGuideTimeType_1003_guide_stage4_countTime >= 60 then
      self._battleGuideTimeType_1003_guide_stage4_countTime = nil
      DialogManager.DestroySingletonDialog("newbattle.battleguidetimetype1003stage4maskdialog")
      LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideTimeType1003, self, 4)
    end
  end
end

function BattleNewMainDialog:OnInBattleGuide(notification)
  if notification.userInfo == GuideTimeType.FrameFit120 then
    self._battleGuideTimeType_1002_guide = true
  elseif notification.userInfo == GuideTimeType.AutoBattleGuide then
    self._battleGuideTimeType_1001_guide = true
  elseif notification.userInfo == GuideTimeType.PowerFirstFull then
    self._battleGuideTimeType_1003_guide = true
  end
end

function BattleNewMainDialog:OnGlobalPointerDown(notification)
  if self._breakOutPowerGuideState then
    self._breakOutPowerGuideState = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  end
end

function BattleNewMainDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "BattleAssistShake" then
    self._supportRole:SetActive(false)
  elseif stateName == "BattleEnergyCount" then
    self._battleEnergyCountAnimationIsEnd = true
  end
end

local function SortAutoBattleSkillFunction(a, b, aWeight, bWeight)
  local aAutoCDTime = a.role:GetSkillAutoCDTime(a.skillId)
  local bAutoCDTime = b.role:GetSkillAutoCDTime(b.skillId)
  local aSkillIsInCD = a.role:GetSkillIsInCD(a.skillId)
  local bSkillIsInCD = b.role:GetSkillIsInCD(b.skillId)
  local aSkillIfEnergy = a.role:IfSkillIsEnergy(a.skillId)
  local bSkillIfEnergy = b.role:IfSkillIsEnergy(b.skillId)
  if aAutoCDTime == 0 and bAutoCDTime ~= 0 then
    return true
  elseif aAutoCDTime ~= 0 and bAutoCDTime == 0 then
    return false
  end
  if aSkillIsInCD and not bSkillIsInCD then
    return false
  elseif not aSkillIsInCD and bSkillIsInCD then
    return true
  end
  if aSkillIfEnergy and not bSkillIfEnergy then
    return false
  elseif not aSkillIfEnergy and bSkillIfEnergy then
    return true
  end
  if bWeight < aWeight then
    return true
  elseif aWeight < bWeight then
    return false
  end
  local aCost = 0
  local bCost = 0
  if CCostSkillTable:GetRecorder(a.skillId).OrderCost ~= 0 then
    aCost = CCostSkillTable:GetRecorder(a.skillId).OrderCost
  elseif CCostSkillTable:GetRecorder(a.skillId).ChaosCost ~= 0 then
    aCost = CCostSkillTable:GetRecorder(a.skillId).ChaosCost
  end
  if CCostSkillTable:GetRecorder(b.skillId).OrderCost ~= 0 then
    bCost = CCostSkillTable:GetRecorder(b.skillId).OrderCost
  elseif CCostSkillTable:GetRecorder(b.skillId).ChaosCost ~= 0 then
    bCost = CCostSkillTable:GetRecorder(b.skillId).ChaosCost
  end
  if aCost < bCost then
    return true
  elseif aCost > bCost then
    return false
  else
    local aSkillItemId, bSkillItemId
    local aRoleRecorder = RoleConfigTable:GetRecorder(a.role:GetConfigId())
    local bRoleRecorder = RoleConfigTable:GetRecorder(b.role:GetConfigId())
    if aRoleRecorder then
      local skillItemRecorder = cSkillItem:GetRecorder(aRoleRecorder.contractskillid)
      for _, skillid in ipairs(skillItemRecorder.skillID) do
        if a.skillId == skillid then
          aSkillItemId = aRoleRecorder.contractskillid
        end
        if b.skillId == skillid then
          bSkillItemId = aRoleRecorder.contractskillid
        end
      end
      local skillItemRecorder = cSkillItem:GetRecorder(aRoleRecorder.contractskillid2)
      for _, skillid in ipairs(skillItemRecorder.skillID) do
        if a.skillId == skillid then
          aSkillItemId = aRoleRecorder.contractskillid2
        end
        if b.skillId == skillid then
          bSkillItemId = aRoleRecorder.contractskillid2
        end
      end
    end
    if bRoleRecorder then
      local skillItemRecorder = cSkillItem:GetRecorder(bRoleRecorder.contractskillid)
      for _, skillid in ipairs(skillItemRecorder.skillID) do
        if a.skillId == skillid then
          aSkillItemId = bRoleRecorder.contractskillid
        end
        if b.skillId == skillid then
          bSkillItemId = bRoleRecorder.contractskillid
        end
      end
      local skillItemRecorder = cSkillItem:GetRecorder(bRoleRecorder.contractskillid2)
      for _, skillid in ipairs(skillItemRecorder.skillID) do
        if a.skillId == skillid then
          aSkillItemId = bRoleRecorder.contractskillid2
        end
        if b.skillId == skillid then
          bSkillItemId = bRoleRecorder.contractskillid2
        end
      end
    end
    if not aSkillItemId or not bSkillItemId then
      LogErrorFormat("BattleNewMainDialog", "roleid1 %s skillid1 %s or roleid2 %s skillid2 %s dont have cskillitem with roleconfig.contractskillid or roleconfig.contractskillid2", a.role:GetConfigId(), a.skillId, b.role:GetConfigId(), b.skillId)
    else
      local aSkill = Skill.Create(a.skillId, aSkillItemId or true)
      local bSkill = Skill.Create(b.skillId, bSkillItemId or true)
      if aSkill:GetSkillLevel() > bSkill:GetSkillLevel() then
        return true
      elseif aSkill:GetSkillLevel() < bSkill:GetSkillLevel() then
        return false
      end
    end
    return a.skillId > b.skillId
  end
end

function BattleNewMainDialog:OnUpdate(notification)
  local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  if battleID == 1120 then
    self._aloneProgress:SetActive(true)
    self._normalProgress:SetActive(false)
    if not self._alonePowerFlowEffectHandler then
      self._alonePowerFlowEffectHandler = self._alonePowerFlowEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1040))
    end
    local power, powerMax = NekoData.BehaviorManager.BM_Battle:GetPower1()
    local fullGridNum = math.floor(power)
    for i, v in ipairs(self._alonePowerGrids) do
      if i <= fullGridNum then
        v:SetActive(true)
        self._alonePowerImgGrids[i]:SetActive(true)
        self._alonePowerImgGrids[i]:SetFillAmount(1)
        if self._alonePowerLightDotEffectHandlers[i] ~= 0 and i ~= power then
          self._alonePowerLightDot[i]:SetActive(false)
          self._alonePowerLightDotEffect[i]:SetActive(false)
        end
        self._alonePowerGridFullEffect[i]:SetActive(true)
        if self._alonePowerGridFullEffectHandlers[i] == 0 then
          self._alonePowerGridFullEffectHandlers[i] = self._alonePowerGridFullEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1041))
        end
        if i == power then
          self._alonePowerLightDot[i]:SetActive(true)
          self._alonePowerLightDotEffect[i]:SetActive(true)
          if self._alonePowerLightDotEffectHandlers[i] == 0 then
            self._alonePowerLightDotEffectHandlers[i] = self._alonePowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1042))
          end
        end
      elseif i > power and power > i - 1 then
        v:SetActive(true)
        self._alonePowerImgGrids[i]:SetActive(true)
        self._alonePowerImgGrids[i]:SetFillAmount(power + 1 - i)
        self._alonePowerLightDot[i]:SetActive(true)
        self._alonePowerLightDotEffect[i]:SetActive(true)
        if self._alonePowerLightDotEffectHandlers[i] == 0 then
          self._alonePowerLightDotEffectHandlers[i] = self._alonePowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1043))
        end
        self._alonePowerLightDot[i]:SetXPosition(0, self._alonePowerWidth * (power + 1 - i) - self._lightDotWidth / 2)
        if self._alonePowerGridFullEffectHandlers[i] ~= 0 then
          self._alonePowerGridFullEffect[i]:SetActive(false)
        end
      else
        v:SetActive(false)
        self._alonePowerImgGrids[i]:SetActive(false)
        self._alonePowerLightDot[i]:SetActive(false)
        if self._alonePowerLightDotEffectHandlers[i] ~= 0 then
          self._alonePowerLightDotEffect[i]:SetActive(false)
        end
        if self._alonePowerGridFullEffectHandlers[i] ~= 0 then
          self._alonePowerGridFullEffect[i]:SetActive(false)
        end
      end
    end
  else
    self._aloneProgress:SetActive(false)
    self._normalProgress:SetActive(true)
    if self._breakOutPowerShow then
      if self._breakOutRedPowerIncreaseTask then
        if self._breakOutRedPowerIncreaseTask:update(notification.userInfo.deltaTime) then
          local power1 = tonumber(CBattleConfig:GetRecorder(8).attr)
          local fullGridNum1 = math.floor(power1)
          self:ShowLeftPowerGrid(fullGridNum1, power1)
          self._breakOutRedPowerIncreaseTask = nil
        else
          local power1 = self._breakOutRedPowerIncreaseTask.subject.value
          local fullGridNum1 = math.floor(power1)
          self:ShowLeftPowerGrid(fullGridNum1, power1)
        end
      end
      if self._breakOutBluePowerIncreaseTask then
        if self._breakOutBluePowerIncreaseTask:update(notification.userInfo.deltaTime) then
          local power2 = tonumber(CBattleConfig:GetRecorder(9).attr)
          local fullGridNum2 = math.floor(power2)
          self:ShowRightPowerGrid(fullGridNum2, power2)
          self._breakOutBluePowerIncreaseTask = nil
        else
          local power2 = self._breakOutBluePowerIncreaseTask.subject.value
          local fullGridNum2 = math.floor(power2)
          self:ShowRightPowerGrid(fullGridNum2, power2)
        end
      end
      if not self._breakOutRedPowerIncreaseTask and not self._breakOutBluePowerIncreaseTask then
        self._breakOutPowerShow = false
      end
    else
      local power1, power1Max = NekoData.BehaviorManager.BM_Battle:GetPower1()
      local power2, power2Max = NekoData.BehaviorManager.BM_Battle:GetPower2()
      local fullGridNum1 = math.floor(power1)
      local fullGridNum2 = math.floor(power2)
      self:ShowLeftPowerGrid(fullGridNum1, power1)
      self:ShowRightPowerGrid(fullGridNum2, power2)
      if self._battleGuideTimeType_1003_guide and fullGridNum2 >= CCostSkillTable:GetRecorder(6016201).ChaosCost then
        self._battleGuideTimeType_1003_guide_stage4_countTime = 0
        DialogManager.CreateSingletonDialog("newbattle.battleguidetimetype1003stage4maskdialog")
        self._battleGuideTimeType_1003_guide = false
      end
    end
  end
  local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
  for k, v in pairs(self._leftHpCells) do
    v:OnUpdate(leftBattlers[k], notification.userInfo.deltaTime)
  end
  local leftBattlersSummon = NekoData.BehaviorManager.BM_Battle:GetLeftBattlersSummon()
  for k, v in pairs(self._summonHpCells) do
    v:OnUpdate(leftBattlersSummon[k], notification.userInfo.deltaTime)
  end
  local rightBattlersSummon = NekoData.BehaviorManager.BM_Battle:GetRightBattlersSummon()
  for k, v in pairs(self._summonHpCells) do
    v:OnUpdate(rightBattlersSummon[k], notification.userInfo.deltaTime)
  end
  local rightBattlers = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
  for k, v in pairs(self._rightHpCells) do
    v:OnUpdate(rightBattlers[k], notification.userInfo.deltaTime)
  end
  for i, task in ipairs(self._leftPowerImgGridsFlyTask) do
    if task:update(notification.userInfo.deltaTime) then
      self._leftPowerImgGridsFlyEffect[i]:Destroy()
      self._leftPowerImgGridsFlyEffect[i]:RootWindowDestroy()
      table.remove(self._leftPowerImgGridsFlyTask, i)
      table.remove(self._leftPowerImgGridsFlyEffect, i)
    else
      self._leftPowerImgGridsFlyEffect[i]:GetRootWindow():SetPosition(0.5, task.subject.xValue, 0.5, task.subject.yValue)
    end
  end
  for i, task in ipairs(self._rightPowerImgGridsFlyTask) do
    if task:update(notification.userInfo.deltaTime) then
      self._rightPowerImgGridsFlyEffect[i]:Destroy()
      self._rightPowerImgGridsFlyEffect[i]:RootWindowDestroy()
      table.remove(self._rightPowerImgGridsFlyTask, i)
      table.remove(self._rightPowerImgGridsFlyEffect, i)
    else
      self._rightPowerImgGridsFlyEffect[i]:GetRootWindow():SetPosition(0.5, task.subject.xValue, 0.5, task.subject.yValue)
    end
  end
  for entityId, t in pairs(self._totalTimeForSecondHurt) do
    self._totalTimeForSecondHurt[entityId] = self._totalTimeForSecondHurt[entityId] + notification.userInfo.deltaTime
  end
  if self._breakOutPowerCountProgressAndNumTask then
    if self._breakOutPowerCountProgressAndNumTask:update(notification.userInfo.deltaTime) then
      self._breakOutPowerCountProgress:SetFillAmount(0)
      self._breakOutPowerCountNum:SetText(0)
      self._breakOutPowerCountProgressAndNumTask = nil
      self._breakOutPowerCountProgress:SetActive(false)
    else
      self._breakOutPowerCountProgress:SetFillAmount(self._breakOutPowerCountProgressAndNumTask.subject.value / self._breakOutPowerCountTotalTime)
      self._breakOutPowerCountNum:SetText(string.format("%.1f", self._breakOutPowerCountProgressAndNumTask.subject.value))
    end
  end
  if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Default and NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight == 1 then
    local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
    local hpExistUnder60 = false
    local breakOutState = self._breakOutPowerState == PowerAccumulateStateType.BreakOut
    for k, battler in pairs(leftBattlers) do
      if battler:IsAlive() then
        hpExistUnder60 = hpExistUnder60 or battler:GetHp() / battler:GetHpMax() < tonumber(CBattleConfig:GetRecorder(105).attr)
      end
    end
    local leftBattlersSummon = NekoData.BehaviorManager.BM_Battle:GetLeftBattlersSummon()
    for k, battler in pairs(leftBattlersSummon) do
      if battler:IsAlive() then
        hpExistUnder60 = hpExistUnder60 or battler:GetHp() / battler:GetHpMax() < tonumber(CBattleConfig:GetRecorder(105).attr)
      end
    end
    local roleAutoSkillList = {}
    local orderAutoSkillList = {}
    local disOrderAutoSkillList = {}
    for i, v in ipairs(self._entityList) do
      local skillList = {}
      if self._leftHpCells[v:GetEntityId()] then
        skillList = v:GetSkillList()
      end
      roleAutoSkillList[v:GetConfigId()] = roleAutoSkillList[v:GetConfigId()] or {}
      for index, skillId in ipairs(skillList) do
        table.insert(roleAutoSkillList[v:GetConfigId()], {role = v, skillId = skillId})
        if CCostSkillTable:GetRecorder(skillId).ChaosCost ~= 0 then
          table.insert(disOrderAutoSkillList, {role = v, skillId = skillId})
        elseif CCostSkillTable:GetRecorder(skillId).OrderCost ~= 0 then
          table.insert(orderAutoSkillList, {role = v, skillId = skillId})
        end
      end
    end
    local list = {}
    if hpExistUnder60 then
      if breakOutState then
        for roleId, v in pairs(roleAutoSkillList) do
          table.sort(v, function(a, b)
            return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).defendWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).defendWeight)
          end)
        end
        for roleId, v in pairs(roleAutoSkillList) do
          if v[1] then
            table.insert(list, {
              roleId = roleId,
              skillId = v[1].skillId,
              canClick = false
            })
          end
        end
      else
        table.sort(orderAutoSkillList, function(a, b)
          return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).defendWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).defendWeight)
        end)
        table.sort(disOrderAutoSkillList, function(a, b)
          return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).defendWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).defendWeight)
        end)
        if orderAutoSkillList[1] then
          table.insert(list, {
            roleId = orderAutoSkillList[1].role:GetConfigId(),
            skillId = orderAutoSkillList[1].skillId,
            canClick = false
          })
        end
        if disOrderAutoSkillList[1] then
          table.insert(list, {
            roleId = disOrderAutoSkillList[1].role:GetConfigId(),
            skillId = disOrderAutoSkillList[1].skillId,
            canClick = false
          })
        end
      end
    elseif breakOutState then
      for roleId, v in pairs(roleAutoSkillList) do
        table.sort(v, function(a, b)
          return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).attackWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).attackWeight)
        end)
      end
      for roleId, v in pairs(roleAutoSkillList) do
        if v[1] then
          table.insert(list, {
            roleId = roleId,
            skillId = v[1].skillId,
            canClick = false
          })
        end
      end
    else
      table.sort(orderAutoSkillList, function(a, b)
        return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).attackWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).attackWeight)
      end)
      table.sort(disOrderAutoSkillList, function(a, b)
        return SortAutoBattleSkillFunction(a, b, CSkillAutoWeightCfg:GetRecorder(a.skillId).attackWeight, CSkillAutoWeightCfg:GetRecorder(b.skillId).attackWeight)
      end)
      if orderAutoSkillList[1] then
        table.insert(list, {
          roleId = orderAutoSkillList[1].role:GetConfigId(),
          skillId = orderAutoSkillList[1].skillId,
          canClick = false
        })
      end
      if disOrderAutoSkillList[1] then
        table.insert(list, {
          roleId = disOrderAutoSkillList[1].role:GetConfigId(),
          skillId = disOrderAutoSkillList[1].skillId,
          canClick = false
        })
      end
    end
    local oldAutoSkillList = NekoData.BehaviorManager.BM_Battle:GetDefaultModeAutoBattleSkillInfo()
    local sameCount = 0
    for _, v in ipairs(oldAutoSkillList) do
      for _, inV in ipairs(list) do
        if v.roleId == inV.roleId and v.skillId == inV.skillId then
          sameCount = sameCount + 1
        end
      end
    end
    if sameCount ~= #list or #oldAutoSkillList ~= #list then
      for i, v in ipairs(list) do
        list[i].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
          arg.list[arg.index].canClick = true
        end, {list = list, index = i})
      end
      NekoData.BehaviorManager.BM_Battle:SaveDefaultModeAutoBattleSkillInfo(list)
      self._frame:FireEvent("ChangeAutoSkill", nil)
    end
  end
  if NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight == 1 then
    self:OnBreakOutPowerBtnClick()
  end
end

function BattleNewMainDialog:OnBattleEnd()
  DialogManager.DestroySingletonDialog("newbattle.battlenewmaindialog")
end

function BattleNewMainDialog:OnDialogDestroy(notification)
  local dialog = notification.userInfo
  if self._hpCells[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    self._hpCells[dialog._dialogKey] = nil
  end
end

function BattleNewMainDialog:CreateBatttlerHPBar(notification)
  if notification.userInfo.attribute.id == 20054 then
    local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
    for k, v in pairs(leftBattlers) do
      if v:GetEntityId() == notification.userInfo.entityid then
        if self._leftHpCells[k] then
          self._leftHpCells[k]:Destroy()
          self._leftHpCells[k]:RootWindowDestroy()
          self._leftHpCells[k] = nil
          self._leftHpCellsVisibleCount[k] = nil
        end
        local cell = DialogManager.CreateDialog("newbattle.hpleftcell", self._staticHpBar._uiObject)
        cell:SetData(v, self)
        self._leftHpCells[k] = cell
        NekoData.BehaviorManager.BM_Battle:RecordEntityBuff({
          entityid = notification.userInfo.entityid
        })
      end
    end
  elseif notification.userInfo.attribute.camp == BattleECS.Components.TypeComponent.CampType.Left then
    local leftBattlers = NekoData.BehaviorManager.BM_Battle:GetLeftBattlers()
    for k, v in pairs(leftBattlers) do
      if v:GetEntityId() == notification.userInfo.entityid then
        if self._leftHpCells[k] then
          self._leftHpCells[k]:Destroy()
          self._leftHpCells[k]:RootWindowDestroy()
          self._leftHpCells[k] = nil
          self._leftHpCellsVisibleCount[k] = nil
        end
        local cell = DialogManager.CreateDialog("newbattle.hpleftcell", self._staticHpBar._uiObject)
        cell:SetData(v, self)
        self._leftHpCells[k] = cell
        NekoData.BehaviorManager.BM_Battle:RecordEntityBuff({
          entityid = notification.userInfo.entityid
        })
        local showingEntityBuffRecord = NekoData.BehaviorManager.BM_Battle:GetEntityBuff()[notification.userInfo.entityid]
        if showingEntityBuffRecord then
          local buffList = showingEntityBuffRecord.buffList
          for k, v in pairs(buffList) do
            local info = {}
            info.buffid = k
            info.entityid = notification.userInfo.entityid
            info.counttime = v.counttime
            info.stacklayer = v.stacklayer
            cell:RefreshBuffs(info)
          end
        end
        while self._entityList[#self._entityList] do
          table.remove(self._entityList, #self._entityList)
        end
        for k, inV in pairs(leftBattlers) do
          if inV:IsRole() and (not inV:IsHaveAlternate() or inV:IsAlive()) then
            table.insert(self._entityList, inV)
          end
        end
        table.sort(self._entityList, function(a, b)
          local aKey = a:GetKey()
          local bKey = b:GetKey()
          if aKey == LineUpStation.ALTERNATE_BACK_ROW then
            aKey = LineUpStation.BACK_ROW
          end
          if aKey == LineUpStation.ALTERNATE_FRONT_ROW then
            aKey = LineUpStation.FRONT_ROW
          end
          if aKey == LineUpStation.ALTERNATE_MIDDLE_ROW then
            aKey = LineUpStation.MIDDLE_ROW
          end
          if bKey == LineUpStation.ALTERNATE_BACK_ROW then
            bKey = LineUpStation.BACK_ROW
          end
          if bKey == LineUpStation.ALTERNATE_FRONT_ROW then
            bKey = LineUpStation.FRONT_ROW
          end
          if bKey == LineUpStation.ALTERNATE_MIDDLE_ROW then
            bKey = LineUpStation.MIDDLE_ROW
          end
          return aKey > bKey
        end)
        if #self._entityList >= 1 then
          if self._runtimePackerAgent == nil then
            self:GenerateSkillAtlas()
          end
          if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Optional then
            local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
            if autoBattle then
              if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
                local newAutoSkillList = {}
                for _, v in ipairs(self._entityList) do
                  newAutoSkillList[v:GetConfigId()] = v:GetSkillList()[1]
                end
                for roleId, skillId in pairs(autoBattle.eruptSkill) do
                  if newAutoSkillList[roleId] then
                    newAutoSkillList[roleId] = skillId
                  end
                end
                autoBattle.eruptSkill = newAutoSkillList
                local list = {}
                for roleId, skillId in pairs(autoBattle.eruptSkill) do
                  if skillId ~= 0 then
                    table.insert(list, {
                      roleId = roleId,
                      skillId = skillId,
                      canClick = false
                    })
                    list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                      arg.list[arg.index].canClick = true
                    end, {
                      list = list,
                      index = #list
                    })
                  end
                end
                NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
              else
                local tag = {orderSKill = true, disorderSkill = true}
                for i, v in ipairs(self._entityList) do
                  if v:GetConfigId() == autoBattle.orderSKill.roleId then
                    tag.orderSKill = false
                  end
                  if v:GetConfigId() == autoBattle.disorderSkill.roleId then
                    tag.disorderSkill = false
                  end
                end
                if tag.orderSKill or tag.disorderSkill then
                  self:ResetAutoSkill(tag)
                else
                  local autoBattleInfo = NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo()
                  autoBattle.orderSKill.roleId = autoBattleInfo.orderSKill.roleId
                  autoBattle.orderSKill.skillId = autoBattleInfo.orderSKill.skillId
                  autoBattle.disorderSkill.roleId = autoBattleInfo.disorderSkill.roleId
                  autoBattle.disorderSkill.skillId = autoBattleInfo.disorderSkill.skillId
                end
                local list = {}
                if autoBattle.orderSKill.skillId ~= 0 then
                  table.insert(list, {
                    roleId = autoBattle.orderSKill.roleId,
                    skillId = autoBattle.orderSKill.skillId,
                    canClick = false
                  })
                  list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                    arg.list[arg.index].canClick = true
                  end, {
                    list = list,
                    index = #list
                  })
                end
                if autoBattle.disorderSkill.skillId ~= 0 then
                  table.insert(list, {
                    roleId = autoBattle.disorderSkill.roleId,
                    skillId = autoBattle.disorderSkill.skillId,
                    canClick = false
                  })
                  list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                    arg.list[arg.index].canClick = true
                  end, {
                    list = list,
                    index = #list
                  })
                end
                NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
              end
            end
          end
          local cellPanelWidth = self._width / 3 * #self._entityList
          self._skillPanel:SetSize(0, cellPanelWidth, 0, self._height)
          self._skillPanel:SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
          self._frame:ReloadAllCell()
          self._frame:FireEvent("ShowSkillCardFrame", v:GetEntityId())
        end
        break
      end
    end
  elseif notification.userInfo.attribute.camp == BattleECS.Components.TypeComponent.CampType.Right then
    local rightBattlers = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()
    for k, v in pairs(rightBattlers) do
      if v:GetEntityId() == notification.userInfo.entityid then
        if self._rightHpCells[k] then
          self._rightHpCells[k]:Destroy()
          self._rightHpCells[k]:RootWindowDestroy()
          self._rightHpCells[k] = nil
          self._rightHpCellsVisibleCount[k] = nil
        end
        local cell
        if v:IsBoss() then
          cell = DialogManager.CreateDialog("newbattle.bosshpcell", self._hpBar._uiObject)
          cell:SetData(v, self)
        else
          cell = DialogManager.CreateDialog("newbattle.hpleftcell", self._staticHpBar._uiObject)
          cell:SetData(v, self)
        end
        self._rightHpCells[k] = cell
        NekoData.BehaviorManager.BM_Battle:RecordEntityBuff({
          entityid = notification.userInfo.entityid
        })
        local showingEntityBuffRecord = NekoData.BehaviorManager.BM_Battle:GetEntityBuff()[notification.userInfo.entityid]
        if showingEntityBuffRecord then
          local buffList = showingEntityBuffRecord.buffList
          for k, v in pairs(buffList) do
            local info = {}
            info.buffid = k
            info.entityid = notification.userInfo.entityid
            info.counttime = v.counttime
            info.stacklayer = v.stacklayer
            cell:RefreshBuffs(info)
          end
        end
        break
      end
    end
  end
end

function BattleNewMainDialog:GenerateSkillAtlas()
end

function BattleNewMainDialog:CreateBatttlerSummonHPBar(notification)
  local leftBattlersSummon = NekoData.BehaviorManager.BM_Battle:GetLeftBattlersSummon()
  for k, v in pairs(leftBattlersSummon) do
    if v:GetEntityId() == notification.userInfo.entityid then
      if self._summonHpCells[v:GetEntityId()] then
        self._summonHpCells[v:GetEntityId()]:Destroy()
        self._summonHpCells[v:GetEntityId()] = nil
        self._summonHpCellsVisibleCount[v:GetEntityId()] = nil
      end
      local cell = DialogManager.CreateDialog("newbattle.hpleftcell", self._staticHpBar._uiObject)
      cell:SetData(v, self)
      self._summonHpCells[v:GetEntityId()] = cell
      NekoData.BehaviorManager.BM_Battle:RecordEntityBuff({
        entityid = notification.userInfo.entityid
      })
      break
    end
  end
  local rightBattlersSummon = NekoData.BehaviorManager.BM_Battle:GetRightBattlersSummon()
  for k, v in pairs(rightBattlersSummon) do
    if v:GetEntityId() == notification.userInfo.entityid then
      if self._summonHpCells[v:GetEntityId()] then
        self._summonHpCells[v:GetEntityId()]:Destroy()
        self._summonHpCells[v:GetEntityId()] = nil
        self._summonHpCellsVisibleCount[v:GetEntityId()] = nil
      end
      local cell = DialogManager.CreateDialog("newbattle.hpleftcell", self._staticHpBar._uiObject)
      cell:SetData(v, self)
      self._summonHpCells[v:GetEntityId()] = cell
      NekoData.BehaviorManager.BM_Battle:RecordEntityBuff({
        entityid = notification.userInfo.entityid
      })
      break
    end
  end
end

function BattleNewMainDialog:DestroyBatttlerHPBar(notification)
  local entitiId = notification.userInfo.entityId
  entitiId = entitiId or notification.userInfo.entityid
  if self._leftHpCells[entitiId] then
    self._leftHpCells[entitiId]._greenProgressBar:SetFillAmount(0)
    self._leftHpCells[entitiId]:Show(false)
    self._leftHpCells[entitiId] = nil
    self._leftHpCellsVisibleCount[entitiId] = nil
    self._frame:FireEvent("ShowSkillCardBack", entitiId)
    if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Optional then
      local tag = {}
      local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
      if NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight == 1 then
        if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
          local newAutoSkillList = {}
          for _, v in ipairs(self._entityList) do
            newAutoSkillList[v:GetConfigId()] = v:GetSkillList()[1]
          end
          for roleId, skillId in pairs(autoBattle.eruptSkill) do
            if newAutoSkillList[roleId] then
              newAutoSkillList[roleId] = skillId
            end
          end
          autoBattle.eruptSkill = newAutoSkillList
          local list = {}
          for roleId, skillId in pairs(autoBattle.eruptSkill) do
            if skillId ~= 0 then
              table.insert(list, {
                roleId = roleId,
                skillId = skillId,
                canClick = false
              })
              list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                arg.list[arg.index].canClick = true
              end, {
                list = list,
                index = #list
              })
            end
          end
          NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
          self._frame:FireEvent("ChangeAutoSkill", nil)
        else
          for i, v in ipairs(self._entityList) do
            if v:GetEntityId() == entitiId then
              if v:GetConfigId() == autoBattle.orderSKill.roleId then
                autoBattle.orderSKill.roleId = 0
                autoBattle.orderSKill.skillId = 0
                tag.orderSKill = true
              end
              if v:GetConfigId() == autoBattle.disorderSkill.roleId then
                autoBattle.disorderSkill.roleId = 0
                autoBattle.disorderSkill.skillId = 0
                tag.disorderSkill = true
              end
              break
            end
          end
          if tag.orderSKill or tag.disorderSkill then
            self:ResetAutoSkill(tag)
            local autoBattleInfo = NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo()
            autoBattleInfo.orderSKill.roleId = autoBattle.orderSKill.roleId
            autoBattleInfo.orderSKill.skillId = autoBattle.orderSKill.skillId
            autoBattleInfo.disorderSkill.roleId = autoBattle.disorderSkill.roleId
            autoBattleInfo.disorderSkill.skillId = autoBattle.disorderSkill.skillId
            local list = {}
            if autoBattle.orderSKill.skillId ~= 0 then
              table.insert(list, {
                roleId = autoBattle.orderSKill.roleId,
                skillId = autoBattle.orderSKill.skillId,
                canClick = false
              })
              list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                arg.list[arg.index].canClick = true
              end, {
                list = list,
                index = #list
              })
            end
            if autoBattle.disorderSkill.skillId ~= 0 then
              table.insert(list, {
                roleId = autoBattle.disorderSkill.roleId,
                skillId = autoBattle.disorderSkill.skillId,
                canClick = false
              })
              list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
                arg.list[arg.index].canClick = true
              end, {
                list = list,
                index = #list
              })
            end
            NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
            self._frame:FireEvent("ChangeAutoSkill", nil)
          end
        end
      end
    end
  end
  if self._rightHpCells[entitiId] then
    if self._rightHpCells[entitiId]._progressBar then
      self._rightHpCells[entitiId]._progressBar:SetFirstValue(0)
      self._rightHpCells[entitiId]._progressBar:SetSecondValue(0)
    else
      self._rightHpCells[entitiId]._greenProgressBar:SetFillAmount(0)
    end
    if self._rightHpCells[entitiId]._hpCurrent then
      self._rightHpCells[entitiId]._hpCurrent:SetText(0)
    end
    self._rightHpCells[entitiId]:Show(false)
    self._rightHpCells[entitiId] = nil
    self._rightHpCellsVisibleCount[entitiId] = nil
  end
  if self._summonHpCells[entitiId] then
    if notification.userInfo.damageNum ~= 0 then
      self._summonHpCells[entitiId]._greenProgressBar:SetFillAmount(0)
    end
    self._summonHpCells[entitiId]:Show(false)
    self._summonHpCells[entitiId]:Destroy()
    self._summonHpCells[entitiId] = nil
    self._summonHpCellsVisibleCount[entitiId] = nil
  end
end

function BattleNewMainDialog:ResetAutoSkill(tag)
  local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
  local yellow = {
    cost = 10000,
    skillId = 0,
    roleId = 0
  }
  local purple = {
    cost = 10000,
    skillId = 0,
    roleId = 0
  }
  for i, v in ipairs(self._entityList) do
    if self._leftHpCells[v:GetEntityId()] then
      for index, skillId in ipairs(v:GetSkillList()) do
        local skillCostRecord = CCostSkillTable:GetRecorder(skillId)
        local func1, func2, func1para, func2para
        if skillCostRecord.pureCost ~= "" then
          local rec = string.split(skillCostRecord.pureCost, ";")
          func1, func1para = self:GetFunction(rec[1])
          func2, func2para = self:GetFunction(rec[2])
        end
        if tag.orderSKill then
          local cost
          if skillCostRecord.OrderCost ~= 0 then
            cost = skillCostRecord.OrderCost
          elseif func1 and tonumber(func1(0)) ~= 0 then
            if func1para == "orderpwr" then
              cost = tonumber(func1(0))
            elseif func1para == "chaospwr" then
              cost = tonumber(func1(0))
            elseif func1para == "chaoscostreduce" then
              cost = tonumber(func1(v:GetskillPowerCostReduceChaos()))
            elseif func1para == "ordercostreduce" then
              cost = tonumber(func1(v:GetskillPowerCostReduceOrder()))
            end
          end
          if cost and cost < yellow.cost then
            yellow.cost = cost
            yellow.skillId = skillId
            yellow.roleId = v:GetConfigId()
          end
        end
        if tag.disorderSkill then
          local cost
          if skillCostRecord.ChaosCost ~= 0 then
            cost = skillCostRecord.ChaosCost
          elseif func2 and tonumber(func2(0)) ~= 0 then
            if func2para == "orderpwr" then
              cost = tonumber(func2(0))
            elseif func2para == "chaospwr" then
              cost = tonumber(func2(0))
            elseif func2para == "chaoscostreduce" then
              cost = tonumber(func2(v:GetskillPowerCostReduceChaos()))
            elseif func2para == "ordercostreduce" then
              cost = tonumber(func2(v:GetskillPowerCostReduceOrder()))
            end
          end
          if cost and cost < purple.cost then
            purple.cost = cost
            purple.skillId = skillId
            purple.roleId = v:GetConfigId()
          end
        end
      end
    end
  end
  if yellow.cost ~= 10000 then
    autoBattle.orderSKill.roleId = yellow.roleId
    autoBattle.orderSKill.skillId = yellow.skillId
  end
  if purple.cost ~= 10000 then
    autoBattle.disorderSkill.roleId = purple.roleId
    autoBattle.disorderSkill.skillId = purple.skillId
  end
end

function BattleNewMainDialog:OnSkillSuccess(notification)
  local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  local leftBefore = notification.userInfo.redcurrent + notification.userInfo.redchange
  local leftBeforePower = leftBefore // tonumber(CBattleConfig:GetRecorder(1).attr)
  local leftCurrentPower = notification.userInfo.redcurrent // tonumber(CBattleConfig:GetRecorder(1).attr)
  local rightBefore = notification.userInfo.bluecurrent + notification.userInfo.bluechange
  local rightBeforePower = rightBefore // tonumber(CBattleConfig:GetRecorder(2).attr)
  local rightCurrentPower = notification.userInfo.bluecurrent // tonumber(CBattleConfig:GetRecorder(2).attr)
  if battleID == 1120 then
    if leftCurrentPower ~= leftBeforePower then
      for i = leftCurrentPower + 1, leftBeforePower do
        self._alonePowerEffect[i]:SetActive(true)
        if self._alonePowerEffectHandlers[i] == 0 then
          self._alonePowerEffectHandlers[i] = self._alonePowerEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1048))
        end
      end
    end
  else
    if leftCurrentPower ~= leftBeforePower then
      for i = leftCurrentPower + 1, leftBeforePower do
        self._leftPowerEffect[i]:SetActive(true)
        if self._leftPowerEffectHandlers[i] == 0 then
          self._leftPowerEffectHandlers[i] = self._leftPowerEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1049))
        end
      end
    end
    if rightCurrentPower ~= rightBeforePower then
      for i = rightCurrentPower + 1, rightBeforePower do
        self._rightPowerEffect[i]:SetActive(true)
        if self._rightPowerEffectHandlers[i] == 0 then
          self._rightPowerEffectHandlers[i] = self._rightPowerEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1050))
        end
      end
    end
  end
  if self._breakOutPowerUnlockState and self._breakOutPowerState ~= PowerAccumulateStateType.Drain and rightCurrentPower ~= rightBeforePower then
    if not self._rightPowerImgGridsBaseCell then
      local dialogDefine = require("logic.dialog.newbattle.rightpowerimggridflyeffectcell")
      self._rightPowerImgGridsBaseCell = UIManager.CreateLuaWindow(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, self._normalProgress._uiObject)
      self._rightPowerImgGridsBaseCell:SetPosition(0, 0, 0, -10000)
      self._rightPowerImgGridsBaseCellSizeX, self._rightPowerImgGridsBaseCellSizeY = self._rightPowerImgGridsBaseCell:GetRectSize()
    end
    for i = rightCurrentPower + 1, rightBeforePower do
      local first = {
        xValue = self._rightPowerImgGridsPosition[i].x + self._rightPowerImgGridsSizeX / 2,
        yValue = self._rightPowerImgGridsPosition[i].y + self._rightPowerImgGridsSizeY / 2
      }
      local last = {
        xValue = self._breakOutPowerBtnPosition.x + self._breakOutPowerBtnSizeX / 2 - self._rightPowerImgGridsBaseCellSizeX / 2,
        yValue = self._breakOutPowerBtnPosition.y + self._breakOutPowerBtnSizeY / 2 - self._rightPowerImgGridsBaseCellSizeY / 2
      }
      table.insert(self._rightPowerImgGridsFlyTask, Tween.new(tonumber(CBattleConfig:GetRecorder(100).attr), first, last, CBattleConfig:GetRecorder(101).attr))
      table.insert(self._rightPowerImgGridsFlyEffect, DialogManager.CopyDialog("newbattle.rightpowerimggridflyeffectcell", self._rightPowerImgGridsBaseCell._uiObject, self._normalProgress._uiObject))
    end
  end
end

function BattleNewMainDialog:OnSkillFail(notification)
  self._frame:FireEvent("ShowSkillCard", notification.userInfo)
end

function BattleNewMainDialog:OnSupportRoleUsed(notification)
  self._leftAssistNum = self._leftAssistNum - notification.userInfo.count
  self._supportRoleNum:SetText(tostring(self._leftAssistNum) .. "/" .. tostring(self._totalAssistNum))
end

function BattleNewMainDialog:OnRoleEquipSkillUsed(notification)
end

function BattleNewMainDialog:ShouldLengthChange()
  return true
end

function BattleNewMainDialog:DestroyBossHPBar(entityid)
  if self._hpCells[entityid] then
    self._hpCells[entityid]:Destroy()
  end
end

function BattleNewMainDialog:OnHPCellVisibleChange(notification)
  local entityid = notification.userInfo.entityid
  local visible = notification.userInfo.visible
  if self._leftHpCells[entityid] then
    self._leftHpCellsVisibleCount[entityid] = self._leftHpCellsVisibleCount[entityid] or 0
    local preLeftHpCellsVisibleCount = self._leftHpCellsVisibleCount[entityid]
    if visible == 1 then
      self._leftHpCellsVisibleCount[entityid] = self._leftHpCellsVisibleCount[entityid] + 1
    elseif visible == 0 then
      self._leftHpCellsVisibleCount[entityid] = self._leftHpCellsVisibleCount[entityid] - 1
    end
    if self._leftHpCellsVisibleCount[entityid] >= 0 then
      if preLeftHpCellsVisibleCount < 0 then
        self._leftHpCells[entityid]:Show(true)
      end
    elseif self._leftHpCellsVisibleCount[entityid] < 0 and 0 <= preLeftHpCellsVisibleCount then
      self._leftHpCells[entityid]:Show(false, true)
    end
  end
  if self._summonHpCells[entityid] then
    self._summonHpCellsVisibleCount[entityid] = self._summonHpCellsVisibleCount[entityid] or 0
    local preSummonHpCellsVisibleCount = self._summonHpCellsVisibleCount[entityid]
    if visible == 1 then
      self._summonHpCellsVisibleCount[entityid] = self._summonHpCellsVisibleCount[entityid] + 1
    elseif visible == 0 then
      self._summonHpCellsVisibleCount[entityid] = self._summonHpCellsVisibleCount[entityid] - 1
    end
    if 0 <= self._summonHpCellsVisibleCount[entityid] then
      if preSummonHpCellsVisibleCount < 0 then
        self._summonHpCells[entityid]:Show(true)
      end
    elseif 0 > self._summonHpCellsVisibleCount[entityid] and 0 <= preSummonHpCellsVisibleCount then
      self._summonHpCells[entityid]:Show(false, true)
    end
  end
  if self._rightHpCells[entityid] then
    self._rightHpCellsVisibleCount[entityid] = self._rightHpCellsVisibleCount[entityid] or 0
    local preLeftHpCellsVisibleCount = self._rightHpCellsVisibleCount[entityid]
    if visible == 1 then
      self._rightHpCellsVisibleCount[entityid] = self._rightHpCellsVisibleCount[entityid] + 1
    elseif visible == 0 then
      self._rightHpCellsVisibleCount[entityid] = self._rightHpCellsVisibleCount[entityid] - 1
    end
    if 0 <= self._rightHpCellsVisibleCount[entityid] then
      if preLeftHpCellsVisibleCount < 0 then
        self._rightHpCells[entityid]:Show(true)
      end
    elseif 0 > self._rightHpCellsVisibleCount[entityid] and 0 <= preLeftHpCellsVisibleCount then
      self._rightHpCells[entityid]:Show(false, true)
    end
  end
end

function BattleNewMainDialog:RecycleDamageNumCell(cell)
  table.insert(self._recycleList, cell._dialogKey)
end

function BattleNewMainDialog:GetDamageNumCell()
  local count = #self._recycleList
  local dialogKey = self._recycleList[count]
  local cell
  if dialogKey then
    cell = self._damageCells[dialogKey]
    table.remove(self._recycleList, count)
    if not cell then
      LogError("DamageNumCells management failed.")
    end
  end
  if not cell then
    cell = DialogManager.CopyDialog("newbattle.damagenumcell", self._baseDamageNumCell._uiObject, self._damageParent._uiObject)
    cell:SetDelegate(self)
    self._damageCells[cell._dialogKey] = cell
  end
  return cell
end

function BattleNewMainDialog:OnHPChanged(notification)
  local battler = notification.userInfo.battler
  local damageType = notification.userInfo.damageType
  local hpChanged = notification.userInfo.hpChanged
  local skillid = notification.userInfo.skillid
  local realHpChanged = notification.userInfo.realHpChanged
  local cell = self:GetDamageNumCell()
  cell:Refresh(battler, damageType, hpChanged, skillid)
  if hpChanged < 0 and battler:IsRightCamp() then
    local entityId = battler:GetEntityId()
    self._totalNumForSecondHurt[entityId] = self._totalNumForSecondHurt[entityId] or 0
    self._totalNumForSecondHurt[entityId] = self._totalNumForSecondHurt[entityId] + math.abs(hpChanged)
    self._totalTimeForSecondHurt[entityId] = self._totalTimeForSecondHurt[entityId] or 1
    if self._breakOutPowerTotalDamageNum then
      self._breakOutPowerTotalDamageNum = self._breakOutPowerTotalDamageNum + math.abs(hpChanged)
      self._breakOutPowerTotalDamageNumTxt:SetText(self._breakOutPowerTotalDamageNum)
      self._breakOutPowerTotalDamageNumEffect:SetAnchorAndOffset(0, self._breakOutPowerTotalDamageNumEffectAnchorMinY, 1, self._breakOutPowerTotalDamageNumEffectAnchorMaxY, self._breakOutPowerTotalDamageNumTxtRectX - self._breakOutPowerTotalDamageNumTxt:GetPreferredSize(), self._breakOutPowerTotalDamageNumEffectOffsetMinY, 0, self._breakOutPowerTotalDamageNumEffectOffsetMaxY)
      if self._battleEnergyCountAnimationIsEnd then
        self._battleEnergyCountAnimationIsEnd = false
        self._breakOutPowerTotalDamagePanel:PlayAnimation("BattleEnergyCount")
      end
    end
    cell = nil
    if self._leftHpCells[entityId] then
      cell = self._leftHpCells[entityId]
    elseif self._rightHpCells[entityId] then
      cell = self._rightHpCells[entityId]
    elseif self._summonHpCells[entityId] then
      cell = self._summonHpCells[entityId]
    end
    if cell and cell.RefreshSecondHurtNum then
      cell:RefreshSecondHurtNum(math.ceil(self._totalNumForSecondHurt[entityId] / self._totalTimeForSecondHurt[entityId]), self._totalNumForSecondHurt[entityId])
    end
    if self._isSpring then
      self._totalDamage = self._totalDamage + math.abs(realHpChanged)
      self._newYearBattleCountText:SetText(NumberManager.GetSpringBattleDamageShowNumber(self._totalDamage))
    end
  end
end

function BattleNewMainDialog:OnDamageMiss(notification)
  local battler = notification.userInfo.battler
  local damageType = notification.userInfo.damageType
  local cell = self:GetDamageNumCell()
  cell:Refresh(battler, damageType)
end

function BattleNewMainDialog:NumberOfCell(frame)
  return #self._entityList
end

function BattleNewMainDialog:CellAtIndex(frame)
  return "newbattle.battleskillcell"
end

function BattleNewMainDialog:DataAtIndex(frame, index)
  return self._entityList[index]
end

function BattleNewMainDialog:OnPauseBtnClick()
  local postguide1003 = self._pauseGuideState
  if self._pauseGuideState then
    self._pauseGuideState = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  end
  if not self._playingBattleEndAnimation then
    LogInfo("BattleNewMainDialog", "OnPauseBtnClick and not self._playingBattleEndAnimation")
    local dialog = DialogManager.CreateSingletonDialog("newbattle.battlepausedialog")
    if dialog then
      dialog:SetData(NekoData.BehaviorManager.BM_Battle:GetBattleId())
    end
    NekoData.DataManager.DM_TimeScale:SetBattlePause()
    local categoryRecord = SoundLevelTable:GetRecorder(4)
    if categoryRecord then
      LuaAudioManager.PauseCategory(tonumber(categoryRecord.categoryID), true)
    end
    self._frame:FireEvent("ChangeLittleCharRaycastTarget", true)
    self._pause = true
  end
  if postguide1003 then
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideTimeType1003, self, 2)
  end
end

function BattleNewMainDialog:OnEnemyDetailBtnClick()
  if not self._playingBattleEndAnimation then
    LogInfo("BattleNewMainDialog", "OnEnemyDetailBtnClick and not self._playingBattleEndAnimation")
    local dialog = DialogManager.CreateSingletonDialog("newbattle.battlepausedialog")
    if dialog then
      dialog:SetData(NekoData.BehaviorManager.BM_Battle:GetBattleId(), "enemyinfo")
    end
    NekoData.DataManager.DM_TimeScale:SetBattlePause()
    local categoryRecord = SoundLevelTable:GetRecorder(4)
    if categoryRecord then
      LuaAudioManager.PauseCategory(tonumber(categoryRecord.categoryID), true)
    end
    self._frame:FireEvent("ChangeLittleCharRaycastTarget", true)
    self._pause = true
  end
end

function BattleNewMainDialog:OnLeaveBtnClick()
  self:OnPauseBtnClick()
  local dialog = DialogManager.GetDialog("newbattle.battlepausedialog")
  if dialog then
    dialog:OnLeaveBtnClick()
  end
end

function BattleNewMainDialog:OnApplicationPause(notification)
  local value = notification.userInfo
  if value and not DialogManager.GetDialog("newbattle.battleteachguidedialog") and not DialogManager.GetDialog("guide.guidedialoginbattle") and not DialogManager.GetDialog("newbattle.battlepausedialog") then
    DialogManager.DestroySingletonDialog("newbattle.battlecountdowndialog")
    self:OnPauseBtnClick()
  end
end

function BattleNewMainDialog:OnDetailBtnClick()
  local dialog = DialogManager.GetDialog("newbattle.battledetaildialog")
  if not dialog then
    DialogManager.CreateSingletonDialog("newbattle.battledetaildialog"):SetData()
    NekoData.DataManager.DM_TimeScale:SetBattlePause()
  end
end

function BattleNewMainDialog:OnGMBtnClick()
  local dialog = DialogManager.GetDialog("debug.battlegmdialog")
  if dialog then
    DialogManager.DestroySingletonDialog("debug.battlegmdialog")
  else
    DialogManager.CreateSingletonDialog("debug.battlegmdialog"):SetData({
      selfInvinvible = self._battleWorld:GetIsLeftGMInvincible(),
      enemyInvinvible = self._battleWorld:GetIsRightGMInvincible()
    })
  end
end

function BattleNewMainDialog:OnSupportRoleClick()
  if not self._playingBattleEndAnimation then
    if not self._pause then
      if not self._useSupportRole and self._leftAssistNumBegin == self._leftAssistNum then
        self._useSupportRole = true
        self:GetRootWindow():PlayAnimation("BattleAssistShake")
        local protocol = BattleClientProtocolManager.CreateProtocol("action.cpartner")
        NekoData.BehaviorManager.BM_Battle:SendProtocolToLogicWorld(protocol)
      end
    else
      DialogManager.DestroySingletonDialog("newbattle.battleroleskillsdetaildialog")
    end
  end
end

function BattleNewMainDialog:OnWinRetreatBtnClick()
  local protocol = BattleClientProtocolManager.CreateProtocol("action.cbattlekill")
  protocol.type = BattleEndType.LeftWinCBattleKill
  NekoData.BehaviorManager.BM_Battle:SendProtocolToLogicWorld(protocol)
end

function BattleNewMainDialog:OnLoseRetreatBtnClick()
  local protocol = BattleClientProtocolManager.CreateProtocol("action.cbattlekill")
  protocol.type = BattleEndType.RightWinCBattleKill
  NekoData.BehaviorManager.BM_Battle:SendProtocolToLogicWorld(protocol)
end

function BattleNewMainDialog:OnWinSkipBtnClick()
  local protocol = BattleClientProtocolManager.CreateProtocol("action.cbattlekill")
  protocol.type = BattleEndType.SkipWin
  NekoData.BehaviorManager.BM_Battle:SendProtocolToLogicWorld(protocol)
end

function BattleNewMainDialog:OnAutoBtnClick()
  if not self._playingBattleEndAnimation and NekoData.BehaviorManager.BM_Dungeon:GetMode() ~= "auto" then
    if not self._pause then
      self._autoBtn:SetActive(false)
      self._autoCancelBtn:SetActive(true)
      if self._autoCancelBtnEffectHandler then
        self._autoCancelBtnEffect:ReleaseEffect(self._autoCancelBtnEffectHandler)
        self._autoCancelBtnEffectHandler = nil
      end
      self._autoCancelBtnEffectHandler = self._autoCancelBtnEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1032))
      local tag = {}
      NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight = 1
      self._frame:FireEvent("ChangeAutoSkill", nil)
      if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Default then
        self._defaultModeAutoBattlePanel:SetActive(true)
      end
    else
      DialogManager.DestroySingletonDialog("newbattle.battleroleskillsdetaildialog")
    end
  end
  if self._autoBattleGuideState then
    self._autoBattleGuideState = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  end
end

function BattleNewMainDialog:OnAutoCancelBtnClick()
  if not self._playingBattleEndAnimation and NekoData.BehaviorManager.BM_Dungeon:GetMode() ~= "auto" then
    if not self._pause then
      if self._autoCancelBtnEffectHandler then
        self._autoCancelBtnEffect:ReleaseEffect(self._autoCancelBtnEffectHandler)
        self._autoCancelBtnEffectHandler = nil
      end
      self._autoBtn:SetActive(true)
      self._autoCancelBtn:SetActive(false)
      NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo().autoFight = 0
      self._frame:FireEvent("ChangeAutoSkill", nil)
      if NekoData.BehaviorManager.BM_Game:GetAutoBattleMode() == AutoBattleModeType.Default then
        self._defaultModeAutoBattlePanel:SetActive(false)
      end
    else
      DialogManager.DestroySingletonDialog("newbattle.battleroleskillsdetaildialog")
    end
  end
  if self._autoBattleGuideState then
    LogWarning("BattleNewMainDialog", "自动战斗引导点击Auto按钮结束，但是此处是取消自动战斗状态")
    self._autoBattleGuideState = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
  end
end

function BattleNewMainDialog:OnSpeedBtnClick()
  if not self._playingBattleEndAnimation and NekoData.BehaviorManager.BM_Dungeon:GetMode() ~= "auto" then
    if not self._pause then
      local autoBattle = NekoData.BehaviorManager.BM_Battle:GetAutoBattleInfo()
      if self._speedBtn:IsSelected() then
        NekoData.DataManager.DM_TimeScale:SetBattleNormalSpeed()
        self._speedBtn:SetSelected(false)
        autoBattle.speed = 1
        if self._speedBtnEffectHandler then
          self._speedBtnEffect:ReleaseEffect(self._speedBtnEffectHandler)
          self._speedBtnEffectHandler = nil
        end
      else
        NekoData.DataManager.DM_TimeScale:SetBattleNTimesSpeed()
        self._speedBtn:SetSelected(true)
        autoBattle.speed = tonumber(CBattleConfig:GetRecorder(85).attr)
        if self._speedBtnEffectHandler then
          self._speedBtnEffect:ReleaseEffect(self._speedBtnEffectHandler)
          self._speedBtnEffectHandler = nil
        end
        self._speedBtnEffectHandler = self._speedBtnEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1032))
      end
    else
      DialogManager.DestroySingletonDialog("newbattle.battleroleskillsdetaildialog")
    end
  end
  if self._battleSpeedGuideState then
    self._battleSpeedGuideState = false
    NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
    NekoData.BehaviorManager.BM_Game:SetGuideTag(GuidTypes.BATTLE_2X, 1)
  end
end

function BattleNewMainDialog:OnBreakOutPowerBtnClick()
  if self._breakOutPowerState == PowerAccumulateStateType.Full and self._breakOutPowerUnlockState then
    if self._breakOutPowerGuideState then
      self._breakOutPowerGuideState = false
      NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
    end
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
    local creq = BattleClientProtocolManager.CreateProtocol("action.cbreakoutpower")
    NekoData.BehaviorManager.BM_Battle:SendProtocolToLogicWorld(creq)
    self._breakOutPowerEnergyFullEffect:SetActive(false)
  end
end

function BattleNewMainDialog:RefreshTeamElementInfo()
  local teamId = NekoData.BehaviorManager.BM_SBattleStart:GetLineId()
  local currentTeamRoleList = NekoData.BehaviorManager.BM_Team:GetTeamRoles(teamId)
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station, roleId in pairs(currentTeamRoleList) do
    if roleId ~= 0 then
      haveTeamInfo = true
      stationElementTag[station] = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(roleId):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        table.insert(etherStationList, station)
      end
    end
  end
  if not haveTeamInfo then
    currentTeamRoleList = NekoData.BehaviorManager.BM_SBattleStart:GetLeftRoleMap()
    for station, v in pairs(currentTeamRoleList) do
      local roleId = v.id
      if roleId ~= 0 then
        stationElementTag[station] = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(roleId):GetElement()
        if stationElementTag[station] == ElementType.Ether then
          table.insert(etherStationList, station)
        end
      end
    end
  end
  if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
    end
  elseif stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
    end
  elseif stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
    end
  elseif stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
    end
  elseif stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
    end
  elseif stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
    for _, station in ipairs(etherStationList) do
      stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
    self._elementStage = 1
    if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
      self._elementStage = 2
    end
    self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
  end
  local StageType = {NoStage = 0}
  if self._elementStage then
    local elementRecord = CElementEffect:GetRecorder(self._elementStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
    local imgRecord = CImagePathTable:GetRecorder(elementRecord.image) or DataCommon.DefaultImageAsset
    self._elementImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  local battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  local bossRecorder = CBossNianPart:GetRecorderByValue("battleId", battleID)
  self._extraElemenEffect = {}
  if bossRecorder and bossRecorder.teamBuffTextID ~= -1 then
    self._extraElemenEffect.type = CBattleStartProtocol.SPRING_FESTIVAL
    self._extraElemenEffect.str = TextManager.GetText(bossRecorder.teamBuffTextID, bossRecorder.teamBuffValue1)
    self._extraElemenEffect.icon = bossRecorder.bossWeakIcon
    if self._elementStage == 2 and self._oneTotalElementValue == bossRecorder.element then
      self._extraElemenEffect.enable = true
    end
  end
  if self._inWeekBoss and NekoData.BehaviorManager.BM_WeekBoss:GetTeamAddtion() then
    self._extraElemenEffect.type = CBattleStartProtocol.WEEK_BOSS
  end
end

function BattleNewMainDialog:OnElementBtnClick()
  DialogManager.CreateSingletonDialog("teamedit.teamelementinfodialog"):SetData(self._oneTotalElementValue, self._elementStage, self._extraElemenEffect)
end

function BattleNewMainDialog:PlayBattleEndAnimation(protocol)
  if not self._playingBattleEndAnimation then
    DialogManager.DestroySingletonDialog("newbattle.battlepausedialog")
    if self._autoCancelBtnEffectHandler then
      self._autoCancelBtnEffect:ReleaseEffect(self._autoCancelBtnEffectHandler)
      self._autoCancelBtnEffectHandler = nil
    end
    if self._speedBtnEffectHandler then
      self._speedBtnEffect:ReleaseEffect(self._speedBtnEffectHandler)
      self._speedBtnEffectHandler = nil
    end
    if protocol.type == BattleEndType.LeftWinCBattleKill or protocol.type == BattleEndType.SkipWin or protocol.type == BattleEndType.LeftWin then
      self:GetRootWindow():PlayAnimation("BattleEndWin")
      for k, v in pairs(self._leftHpCells) do
        self._leftHpCells[k]:Show(false)
        self._leftHpCells[k] = nil
        self._leftHpCellsVisibleCount[k] = nil
      end
    elseif protocol.type == BattleEndType.LeftWinCBattleKill or protocol.type == BattleEndType.SkipWin or protocol.type == BattleEndType.RightWin or protocol.type == BattleEndType.RightWinOverTime then
      self:GetRootWindow():PlayAnimation("BattleEnd")
    end
    self._playingBattleEndAnimation = true
  end
  self._frame:FireEvent("ChangeSkillAutoEffectState", false)
end

function BattleNewMainDialog:SetGuideFrame(guideParam, guideId, direction, wordId)
  local guideUI
  if guideParam.guideTimeType == GuideTimeType.PowerFirstFull then
    if guideParam.stage == 1 then
      guideUI = self._pauseBtnGuide
      self._pauseGuideState = true
    else
      guideUI = self._breakOutPowerGuide
      self._breakOutPowerGuideState = true
    end
  elseif guideParam.guideTimeType == GuideTimeType.AutoBattleGuide then
    if guideParam.stage == 1 then
      guideUI = self._autoBtnGuide
      self._autoBattleGuideState = true
    end
  elseif guideParam.guideTimeType == GuideTimeType.BattleSpeedGuide and guideParam.stage == 1 then
    guideUI = self._speedBtnGuide
    self._battleSpeedGuideState = true
  end
  if guideUI then
    NekoData.BehaviorManager.BM_Guide:CreateGuideDialogInBattle(guideId, function()
      local width, height = guideUI:GetRectSize()
      local screenPos = guideUI:GetLocalPointInUiRootPanel()
      return {
        width = width,
        height = height,
        posX = screenPos.x,
        posY = screenPos.y
      }
    end, function()
      local width, height = guideUI:GetRectSize()
      local screenPos = guideUI:GetLocalPointInUiRootPanel()
      local posX = screenPos.x
      if guideParam.guideTimeType == GuideTimeType.PowerFirstFull then
        posX = posX - 218
      end
      return {
        width = width,
        height = height,
        posX = posX,
        posY = screenPos.y
      }
    end, direction, wordId)
    NekoData.DataManager.DM_TimeScale:SetBattleGuidePause()
  end
end

function BattleNewMainDialog:ChangeAutoBattleSkills()
  local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
  local list = {}
  if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
    for roleId, skillId in pairs(autoBattle.eruptSkill) do
      if skillId ~= 0 then
        table.insert(list, {
          roleId = roleId,
          skillId = skillId,
          canClick = false
        })
        list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
          arg.list[arg.index].canClick = true
        end, {
          list = list,
          index = #list
        })
      end
    end
  else
    if autoBattle.orderSKill.skillId ~= 0 then
      table.insert(list, {
        roleId = autoBattle.orderSKill.roleId,
        skillId = autoBattle.orderSKill.skillId,
        canClick = false
      })
      list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
        arg.list[arg.index].canClick = true
      end, {
        list = list,
        index = #list
      })
    end
    if autoBattle.disorderSkill.skillId ~= 0 then
      table.insert(list, {
        roleId = autoBattle.disorderSkill.roleId,
        skillId = autoBattle.disorderSkill.skillId,
        canClick = false
      })
      list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
        arg.list[arg.index].canClick = true
      end, {
        list = list,
        index = #list
      })
    end
  end
  NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
  self._frame:FireEvent("ChangeAutoSkill", nil)
end

function BattleNewMainDialog:OnBuffsUpdate(notification)
  local cell = self._leftHpCells[notification.userInfo.entityid] or self._rightHpCells[notification.userInfo.entityid] or self._summonHpCells[notification.userInfo.entityid]
  if cell then
    cell:RefreshBuffs(notification.userInfo)
    NekoData.BehaviorManager.BM_Battle:RecordEntityBuff(notification.userInfo)
  end
end

function BattleNewMainDialog:GetFunction(funcStr)
  if string.find(funcStr, "orderpwr") then
    local str = "return function(orderpwr) return " .. funcStr .. " end"
    return assert(load(str))(), "orderpwr"
  elseif string.find(funcStr, "chaoscostreduce") then
    local str = "return function(chaoscostreduce) return " .. funcStr .. " end"
    return assert(load(str))(), "chaoscostreduce"
  elseif string.find(funcStr, "ordercostreduce") then
    local str = "return function(ordercostreduce) return " .. funcStr .. " end"
    return assert(load(str))(), "ordercostreduce"
  elseif string.find(funcStr, "chaospwr") then
    local str = "return function(chaospwr) return " .. funcStr .. " end"
    return assert(load(str))(), "chaospwr"
  end
end

function BattleNewMainDialog:OnFillInBattlePower(notification)
  if self._magicSurgeEffectHandler then
    self._magicSurgeEffect:ReleaseEffect(self._magicSurgeEffectHandler)
    self._magicSurgeEffectHandler = nil
  end
  if not self._magicSurgeEffectHandler then
    self._magicSurgeEffectHandler = self._magicSurgeEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1051))
  end
  self._breakOutPowerShow = true
  local redPower = fixedpoint.tonumber(notification.userInfo.curRedPower)
  local attr1 = tonumber(CBattleConfig:GetRecorder(1).attr)
  if 0 < redPower % attr1 then
    redPower = redPower / attr1
  else
    redPower = redPower // attr1
  end
  local first = {value = redPower}
  local last = {
    value = tonumber(CBattleConfig:GetRecorder(8).attr)
  }
  self._breakOutRedPowerIncreaseTask = Tween.new(tonumber(CBattleConfig:GetRecorder(88).attr) / 30, first, last, "linear")
  local bluePower = fixedpoint.tonumber(notification.userInfo.curBluePower)
  local attr2 = tonumber(CBattleConfig:GetRecorder(2).attr)
  if 0 < bluePower % attr2 then
    bluePower = bluePower / attr2
  else
    bluePower = bluePower // attr2
  end
  first = {value = bluePower}
  last = {
    value = tonumber(CBattleConfig:GetRecorder(9).attr)
  }
  self._breakOutBluePowerIncreaseTask = Tween.new(tonumber(CBattleConfig:GetRecorder(88).attr) / 30, first, last, "linear")
end

function BattleNewMainDialog:OnBattlePauseStateChange(notification)
  self._frame:FireEvent("ChangeLittleCharRaycastTarget", notification.userInfo)
end

function BattleNewMainDialog:OnAccumulatePowerStateChange(notification)
  self._breakOutPowerState = notification.userInfo.state
  if self._breakOutPowerState == PowerAccumulateStateType.Filling then
    if self._cdEndEffectHandler then
      self._cdEndEffect:ReleaseEffect(self._cdEndEffectHandler)
      self._cdEndEffectHandler = nil
    end
    if not self._cdEndEffectHandler then
      self._cdEndEffectHandler = self._cdEndEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1108))
    end
  elseif self._breakOutPowerState == PowerAccumulateStateType.Full then
    self._breakOutPowerFullUI:SetActive(true)
    self._breakOutPowerEnergyFullEffect:SetActive(true)
  elseif self._breakOutPowerState == PowerAccumulateStateType.Drain then
    self._breakOutPowerTotalDamageNum = nil
    self._breakOutPowerTotalDamagePanel:PlayAnimation("BattleEnergyCountHide")
    self._battleEnergyCountAnimationIsEnd = true
    self._breakOutPowerEmptyUI:SetActive(true)
    for i = 1, PowerEnergyStateNum do
      self._breakOutPowerStateUI[i]:SetActive(false)
    end
    self._breakOutPowerFullUI:SetActive(false)
    if self._breakOutPowerBreakOutEffectHandler then
      self._breakOutPowerFullEffect:ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
      self._breakOutPowerBreakOutEffectHandler = nil
    end
    self._breakOutPowerCountProgress:SetActive(true)
    self._breakOutPowerCountTotalTime = tonumber(BattleECS.Utility.DataUtility.cBattleConstCfgTable[97].attr) / 30
    self._breakOutPowerCountProgress:SetFillAmount(1)
    self._breakOutPowerCountNum:SetText(self._breakOutPowerCountTotalTime)
    local first = {
      value = self._breakOutPowerCountTotalTime
    }
    local last = {value = 0}
    self._breakOutPowerCountProgressAndNumTask = Tween.new(self._breakOutPowerCountTotalTime, first, last, "linear")
    local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
    local list = {}
    if autoBattle.orderSKill.skillId ~= 0 then
      table.insert(list, {
        roleId = autoBattle.orderSKill.roleId,
        skillId = autoBattle.orderSKill.skillId,
        canClick = false
      })
      list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
        arg.list[arg.index].canClick = true
      end, {
        list = list,
        index = #list
      })
    end
    if autoBattle.disorderSkill.skillId ~= 0 then
      table.insert(list, {
        roleId = autoBattle.disorderSkill.roleId,
        skillId = autoBattle.disorderSkill.skillId,
        canClick = false
      })
      list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
        arg.list[arg.index].canClick = true
      end, {
        list = list,
        index = #list
      })
    end
    NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
    self._frame:FireEvent("ChangeAutoSkill", nil)
  elseif self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
    if self._effectEnergyPowerEffectHandler then
      self._effectEnergy:ReleaseEffect(self._effectEnergyPowerEffectHandler)
      self._effectEnergyPowerEffectHandler = nil
    end
    if not self._effectEnergyPowerEffectHandler then
      self._effectEnergyPowerEffectHandler = self._effectEnergy:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1107))
    end
    self._breakOutPowerTotalDamageNum = 0
    self._breakOutPowerTotalDamageNumTxt:SetText(self._breakOutPowerTotalDamageNum)
    self._breakOutPowerTotalDamageNumEffect:SetAnchorAndOffset(0, self._breakOutPowerTotalDamageNumEffectAnchorMinY, 1, self._breakOutPowerTotalDamageNumEffectAnchorMaxY, self._breakOutPowerTotalDamageNumTxtRectX - self._breakOutPowerTotalDamageNumTxt:GetPreferredSize(), self._breakOutPowerTotalDamageNumEffectOffsetMinY, 0, self._breakOutPowerTotalDamageNumEffectOffsetMaxY)
    self._breakOutPowerTotalDamagePanel:PlayAnimation("BattleEnergyCountShow")
    self._battleEnergyCountAnimationIsEnd = true
    for i = 1, PowerEnergyStateNum do
      self._breakOutPowerStateUI[i]:SetActive(false)
    end
    self._breakOutPowerFullUI:PlayAnimation("BattleEnergyFull")
    if self._breakOutPowerBreakOutEffectHandler then
      self._breakOutPowerFullEffect:ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
      self._breakOutPowerBreakOutEffectHandler = nil
    end
    self._breakOutPowerBreakOutEffectHandler = self._breakOutPowerFullEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1138))
    local autoBattle = NekoData.BehaviorManager.BM_Battle:GetTempAutoBattleInfo()
    local newAutoSkillList = {}
    for _, v in ipairs(self._entityList) do
      newAutoSkillList[v:GetConfigId()] = v:GetSkillList()[1]
    end
    for roleId, skillId in pairs(autoBattle.eruptSkill) do
      if newAutoSkillList[roleId] then
        newAutoSkillList[roleId] = skillId
      end
    end
    autoBattle.eruptSkill = newAutoSkillList
    local list = {}
    for roleId, skillId in pairs(autoBattle.eruptSkill) do
      if skillId ~= 0 then
        table.insert(list, {
          roleId = roleId,
          skillId = skillId,
          canClick = false
        })
        list[#list].loadTimeTask = GameTimer.AddTask(0, tonumber(CBattleConfig:GetRecorder(104).attr), function(arg)
          arg.list[arg.index].canClick = true
        end, {
          list = list,
          index = #list
        })
      end
    end
    NekoData.BehaviorManager.BM_Battle:SaveOptionalModeAutoBattleSkillInfo(list)
    self._frame:FireEvent("ChangeAutoSkill", nil)
  end
end

function BattleNewMainDialog:OnSkillBegin(notification)
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    cell:BeginShowSkillLoading(protocol.skillid, protocol.type, protocol.lasttime, protocol.skillattr)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell skillid %s", entityId, protocol.skillid)
  end
end

function BattleNewMainDialog:OnSkillInterrupted(notification)
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    cell:ClearSkillLoading(protocol.skillid)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell skillid %s", entityId, protocol.skillid)
  end
end

function BattleNewMainDialog:OnInvincibleStateChange(notification)
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    cell:RefreshInvincibleState(protocol.state)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

function BattleNewMainDialog:OnShieldValueChange(notification)
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    cell:RefreshShield(protocol)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

function BattleNewMainDialog:ShowLeftPowerGrid(fullGridNum1, power1)
  for i, v in ipairs(self._leftPowerGrids) do
    if i <= fullGridNum1 then
      v:SetActive(true)
      self._leftPowerImgGrids[i]:SetActive(true)
      self._leftPowerImgGrids[i]:SetFillAmount(1)
      if self._leftPowerLightDotEffectHandlers[i] ~= 0 and i ~= power1 then
        self._leftPowerLightDot[i]:SetActive(false)
        self._leftPowerLightDotEffect[i]:SetActive(false)
      end
      self._leftPowerGridFullEffect[i]:SetActive(true)
      if self._leftPowerGridFullEffectHandlers[i] == 0 and self._leftPowerGridOtherEffectHandlers[i] == 0 then
        self._leftPowerGridFullEffectHandlers[i] = self._leftPowerGridFullEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1045))
      end
      if i == power1 then
        self._leftPowerLightDot[i]:SetActive(true)
        self._leftPowerLightDotEffect[i]:SetActive(true)
        if self._leftPowerLightDotEffectHandlers[i] == 0 then
          self._leftPowerLightDotEffectHandlers[i] = self._leftPowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1042))
        end
        self._leftPowerLightDot[i]:SetXPosition(0, self._leftPowerWidth * (1 - (power1 + 1 - i)) - self._lightDotWidth / 2)
      end
    elseif power1 < i and power1 > i - 1 then
      v:SetActive(true)
      self._leftPowerImgGrids[i]:SetActive(true)
      self._leftPowerImgGrids[i]:SetFillAmount(power1 + 1 - i)
      self._leftPowerLightDot[i]:SetActive(true)
      self._leftPowerLightDotEffect[i]:SetActive(true)
      if self._leftPowerLightDotEffectHandlers[i] == 0 then
        self._leftPowerLightDotEffectHandlers[i] = self._leftPowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1042))
      end
      self._leftPowerLightDot[i]:SetXPosition(0, self._leftPowerWidth * (1 - (power1 + 1 - i)) - self._lightDotWidth / 2)
      if self._leftPowerGridOtherEffectHandlers[i] ~= 0 then
        self._leftPowerGridFullEffect[i]:SetActive(true)
      elseif self._leftPowerGridFullEffectHandlers[i] ~= 0 then
        self._leftPowerGridFullEffect[i]:SetActive(false)
      end
    else
      if self._leftPowerGridOtherEffectHandlers[i] ~= 0 then
        self._leftPowerGridFullEffect[i]:SetActive(true)
        v:SetActive(true)
      else
        v:SetActive(false)
        if self._leftPowerGridFullEffectHandlers[i] ~= 0 then
          self._leftPowerGridFullEffect[i]:SetActive(false)
        end
      end
      self._leftPowerImgGrids[i]:SetActive(false)
      self._leftPowerLightDot[i]:SetActive(false)
      if self._leftPowerLightDotEffectHandlers[i] ~= 0 then
        self._leftPowerLightDotEffect[i]:SetActive(false)
      end
    end
  end
end

function BattleNewMainDialog:ShowRightPowerGrid(fullGridNum2, power2)
  for i, v in ipairs(self._rightPowerGrids) do
    if i <= fullGridNum2 then
      v:SetActive(true)
      self._rightPowerImgGrids[i]:SetActive(true)
      self._rightPowerImgGrids[i]:SetFillAmount(1)
      if self._rightPowerLightDotEffectHandlers[i] ~= 0 and i ~= power2 then
        self._rightPowerLightDot[i]:SetActive(false)
        self._rightPowerLightDotEffect[i]:SetActive(false)
      end
      self._rightPowerGridFullEffect[i]:SetActive(true)
      if self._rightPowerGridFullEffectHandlers[i] == 0 then
        self._rightPowerGridFullEffectHandlers[i] = self._rightPowerGridFullEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1046))
      end
      if i == power2 then
        self._rightPowerLightDot[i]:SetActive(true)
        self._rightPowerLightDotEffect[i]:SetActive(true)
        if self._rightPowerLightDotEffectHandlers[i] == 0 then
          self._rightPowerLightDotEffectHandlers[i] = self._rightPowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1043))
        end
        self._rightPowerLightDot[i]:SetXPosition(0, self._leftPowerWidth * (power2 + 1 - i) - self._lightDotWidth / 2)
      end
    elseif power2 < i and power2 > i - 1 then
      v:SetActive(true)
      self._rightPowerImgGrids[i]:SetActive(true)
      self._rightPowerImgGrids[i]:SetFillAmount(power2 + 1 - i)
      self._rightPowerLightDot[i]:SetActive(true)
      self._rightPowerLightDotEffect[i]:SetActive(true)
      if self._rightPowerLightDotEffectHandlers[i] == 0 then
        self._rightPowerLightDotEffectHandlers[i] = self._rightPowerLightDotEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1043))
      end
      self._rightPowerLightDot[i]:SetXPosition(0, self._leftPowerWidth * (power2 + 1 - i) - self._lightDotWidth / 2)
      if self._rightPowerGridFullEffectHandlers[i] ~= 0 then
        self._rightPowerGridFullEffect[i]:SetActive(false)
      end
    else
      v:SetActive(false)
      self._rightPowerImgGrids[i]:SetActive(false)
      self._rightPowerLightDot[i]:SetActive(false)
      if self._rightPowerLightDotEffectHandlers[i] ~= 0 then
        self._rightPowerLightDotEffect[i]:SetActive(false)
      end
      if self._rightPowerGridFullEffectHandlers[i] ~= 0 then
        self._rightPowerGridFullEffect[i]:SetActive(false)
      end
    end
  end
end

function BattleNewMainDialog:OnActiveSkillStateChange(notification)
  self._frame:FireEvent("SkillCDStateChange", notification.userInfo)
end

function BattleNewMainDialog:OnChangeSecondHurtShowState(notification)
  local data = notification.userInfo
  local entityId = data.entityId
  self._totalNumForSecondHurt[entityId] = 0
  self._totalTimeForSecondHurt[entityId] = 1
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    if cell.RefreshSecondHurtNumShowState then
      cell:RefreshSecondHurtNumShowState(data.state)
    end
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

function BattleNewMainDialog:OnEntityNameChanging(notification)
  local protocol = notification.userInfo
  local entityId = protocol.entityId
  local cell
  if self._leftHpCells[entityId] then
    cell = self._leftHpCells[entityId]
  elseif self._rightHpCells[entityId] then
    cell = self._rightHpCells[entityId]
  elseif self._summonHpCells[entityId] then
    cell = self._summonHpCells[entityId]
  end
  if cell then
    cell:RefreshName()
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

function BattleNewMainDialog:OnOrderPowerSpecialUIEffect(notification)
  local effectId = notification.userInfo.effectType
  local i = notification.userInfo.powerGridIndex
  self._leftPowerGridFullEffect[i]:SetActive(true)
  if self._leftPowerGridOtherEffectHandlers[i] == 0 and effectId ~= -1 then
    self._leftPowerGridOtherEffectHandlers[i] = self._leftPowerGridFullEffect[i]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(effectId))
  elseif effectId == -1 and self._leftPowerGridOtherEffectHandlers[i] ~= 0 then
    self._leftPowerGridFullEffect[i]:ReleaseEffect(self._leftPowerGridOtherEffectHandlers[i])
    self._leftPowerGridOtherEffectHandlers[i] = 0
  end
end

function BattleNewMainDialog:OnBreakOutPowerNumberChange(notification)
  if self._breakOutPowerState == PowerAccumulateStateType.Filling then
    for i = 1, PowerEnergyStateNum do
      self._breakOutPowerStateUI[i]:SetActive(false)
    end
    if self._breakOutPowerStateUI[notification.userInfo.breakoutPower] then
      self._breakOutPowerStateUI[notification.userInfo.breakoutPower]:SetActive(true)
      self._breakOutPowerEmptyUI:SetActive(false)
    end
  end
end

function BattleNewMainDialog:OnBossViolentEnter(notification)
  for k, v in pairs(self._rightHpCells) do
    local bossEntity = NekoData.BehaviorManager.BM_Battle:GetRightBattlers()[k]
    if bossEntity and bossEntity:IsBoss() then
      self._rightHpCells[k]:StartViolent()
      break
    end
  end
end

function BattleNewMainDialog:OnBackBtnClicked()
  self:OnPauseBtnClick()
end

function BattleNewMainDialog:ShowDamage()
  local def = BattleClientProtocolManager.GetBeanDef("data.enum_camp")
  self._showDamageTask = GameTimer.AddTask(0, 1, function()
    local damageData = NekoData.BehaviorManager.BM_Battle:GetCurrentBattleDamage()
    self._totalDamage = 0
    for k, v in pairs(damageData) do
      if v.camp == def.LeftFighter then
        self._totalDamage = self._totalDamage + v.num
      end
    end
    LogError("self._totalDamage", self._totalDamage)
  end)
end

return BattleNewMainDialog
