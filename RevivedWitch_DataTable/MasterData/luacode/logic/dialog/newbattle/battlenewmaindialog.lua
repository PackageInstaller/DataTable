-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlenewmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local VarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CSkillAutoWeightCfg = (BeanManager.GetTableByName)("skill.cskillautoweightcfg")
local cSkillItem = (BeanManager.GetTableByName)("item.cskillitem")
local CEnemyInfo = (BeanManager.GetTableByName)("battle.cenemyinfo")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CBossNianPart = (BeanManager.GetTableByName)("activity.cbossnianpart")
local cdungeonbattleconfig = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local PlatformManager = ((CS.PixelNeko).P1).PlatformManager
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local DamageNumCell = {AssetBundleName = "ui/layouts.battle", AssetName = "DamageNum"}
local BattleNewMainDialog = class("BattleNewMainDialog", Dialog)
BattleNewMainDialog.AssetBundleName = "ui/layouts.battlenew"
BattleNewMainDialog.AssetName = "BattleNewMain"
local PowerAccumulateStateType = {Filling = 1, Full = 2, BreakOut = 3, Drain = 4}
local PowerEnergyStateNum = 4
local GuideTimeType = {None = 0, BattleStart = 1, BattleWin = 2, BattleLose = 3, BOSSFirstWeak = 4, AutoBattleGuide = 1001, FrameFit120 = 1002, PowerFirstFull = 1003, BattleSpeedGuide = 1006}
local AutoBattleModeType = {Optional = 1, Default = 2}
local OnNewBattleGuide1tartStage1 = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if userInfo.guideID == 1 then
    local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial1dialog")
    if dialog then
      self._alonePowerGuideEffectHandler = (dialog._effect1):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1038))
    end
  else
    do
      local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial2dialog")
      if dialog then
        self._powerGuideEffectHandler = (dialog._effect2):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1039))
      end
    end
  end
end

local OnNewBattleGuide1Stage1End = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if userInfo.guideID == 1 then
    local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial1dialog")
    if dialog then
      (dialog._effect1):ReleaseEffect(self._alonePowerGuideEffectHandler)
      self._alonePowerGuideEffectHandler = nil
    end
  else
    do
      local dialog = (DialogManager.GetDialog)("battle.battletutorial.battletutorial2dialog")
      if dialog then
        (dialog._effect2):ReleaseEffect(self._powerGuideEffectHandler)
        self._powerGuideEffectHandler = nil
      end
    end
  end
end

local OnNewBattleGuideTimeType1003 = function(self, notification)
  -- function num : 0_2
  if notification.userInfo == 5 then
    self._battleGuideTimeType_1003_guide_stage5_countTime = 0
  end
end

local RefreshBattleDuration = function(self, stepNum)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, CBossNianPart
  do
    if self._inBossRush or self._inUndecidedRoad or self._inSummerEchoesChallenge then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1099)).msgTextID)
      ;
      (self._battleDurationPanel_txt):SetText((string.gsub)(str, "%$parameter1%$", tostring((math.floor)(stepNum / 30))))
    end
    if self._inSpring or self._inAnniversaryDailyBattle then
      local limit = 0
      if self._inSpring then
        local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
        local bossRecorder = CBossNianPart:GetRecorderByValue("battleId", battleID)
        limit = bossRecorder.countDown
      else
        do
          if self._inAnniversaryDailyBattle then
            limit = tonumber((((BeanManager.GetTableByName)("dungeonselect.canniversaryspecialcfg")):GetRecorder(3)).type)
          end
          local sec = tostring(limit - (math.floor)(stepNum / 30))
          local min = (math.floor)(sec / 60)
          sec = sec - min * 60
          if min < 10 then
            min = "0" .. min
          end
          sec = (math.floor)(sec)
          if sec < 10 then
            sec = "0" .. sec
          end
          local str = (TextManager.GetText)((CStringRes:GetRecorder(1722)).msgTextID, min, sec)
          ;
          (self._battleDurationPanel_txt):SetText(str)
        end
      end
    end
  end
end

BattleNewMainDialog.Ctor = function(self, ...)
  -- function num : 0_4 , upvalues : BattleNewMainDialog, PowerAccumulateStateType
  ((BattleNewMainDialog.super).Ctor)(self, ...)
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
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

    (self._leftPowerGridFullEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._leftPowerGridOtherEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._leftPowerLightDotEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._rightPowerGridFullEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._rightPowerLightDotEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._alonePowerGridFullEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._alonePowerLightDotEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._alonePowerEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC93: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._leftPowerEffectHandlers)[i] = 0
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._rightPowerEffectHandlers)[i] = 0
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

BattleNewMainDialog.OnCreate = function(self)
  -- function num : 0_5 , upvalues : CEnemyInfo, _ENV, cdungeonbattleconfig, PowerEnergyStateNum, CBattleStartProtocol, CStringRes, RefreshBattleDuration, TableFrame, OnNewBattleGuide1tartStage1, OnNewBattleGuide1Stage1End, OnNewBattleGuideTimeType1003, CBattleInfoTable, CBattleConfig, AutoBattleModeType, UIManager, DamageNumCell
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
  ;
  (self._enemyDetailBtn):SetActive(CEnemyInfo:GetRecorder((((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).battleid) or false)
  self._leaveBtn = self:GetChild("LeaveBtn")
  ;
  (self._pauseBtn):SetActive(false)
  ;
  (self._leaveBtn):SetActive(false)
  self._winRetreatBtn = self:GetChild("WinBtn")
  self._loseRetreatBtn = self:GetChild("LoseBtn")
  self._detailBtn = self:GetChild("DetailBtn")
  self._gmBtn = self:GetChild("GMBtn")
  self._autoBtn = self:GetChild("AutoBtn")
  self._autoCancelBtn = self:GetChild("AutoBtnCancel")
  self._autoCancelBtnEffect = self:GetChild("AutoBtnCancel/Effect")
  self._speedBtn = self:GetChild("SpeedBtn")
  self._speedBtnEffect = self:GetChild("SpeedBtn/Effect")
  ;
  (self._speedBtn):SetSelected(false)
  self._skipBtn = self:GetChild("SkipBtn")
  ;
  (self._skipBtn):SetActive(false)
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleRetreat) then
    (self._speedBtn):SetActive(false)
  end
  self._autoBtnGuide = self:GetChild("AutoBtn/Guide")
  self._speedBtnGuide = self:GetChild("SpeedBtn/Guide")
  self._pauseBtnGuide = self:GetChild("PauseBtn/Guide")
  if not ((NekoData.BehaviorManager).BM_Game):IsGM() then
    (self._winRetreatBtn):SetActive(false)
    ;
    (self._loseRetreatBtn):SetActive(false)
    ;
    (self._detailBtn):SetActive(false)
    ;
    (self._gmBtn):SetActive(false)
  end
  local curId = ((NekoData.BehaviorManager).BM_Dungeon):GetCurrentFloorId()
  local autoExplore = ((NekoData.BehaviorManager).BM_Game):GetFloorAutoExploreBySceneId(curId)
  if autoExplore then
    local battleid = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
    local battlecfg = cdungeonbattleconfig:GetRecorder(battleid)
    ;
    (self._skipBtn):SetActive(battlecfg.ifskip == 1)
  end
  self._leftPowerImgGrids = {}
  self._rightPowerImgGrids = {}
  self._alonePowerImgGrids = {}
  self._alonePowerGrids = {}
  self._alonePowerLightDot = {}
  for i = 1, 7 do
    -- DECOMPILER ERROR at PC216: Confused about usage of register: R7 in 'UnsetPending'

    (self._leftPowerImgGrids)[i] = self:GetChild("BattleProgressBack/Y" .. i .. "Img")
    -- DECOMPILER ERROR at PC223: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._leftPowerGrids)[i] = self:GetChild("BattleProgressBack/Y" .. i)
    -- DECOMPILER ERROR at PC231: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._leftPowerGridFullEffect)[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/Effect")
    -- DECOMPILER ERROR at PC239: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._leftPowerLightDot)[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/LightDot")
    -- DECOMPILER ERROR at PC247: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._leftPowerLightDotEffect)[i] = self:GetChild("BattleProgressBack/Y" .. i .. "/LightDot/Effect")
    -- DECOMPILER ERROR at PC254: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._leftPowerEffect)[i] = self:GetChild("BattleProgressBack/EffectY" .. i)
    -- DECOMPILER ERROR at PC262: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerImgGrids)[i] = self:GetChild("BattleProgressBack/B" .. i .. "Img")
    -- DECOMPILER ERROR at PC269: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerGrids)[i] = self:GetChild("BattleProgressBack/B" .. i)
    -- DECOMPILER ERROR at PC277: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerGridFullEffect)[i] = self:GetChild("BattleProgressBack/B" .. i .. "/Effect")
    -- DECOMPILER ERROR at PC285: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerLightDot)[i] = self:GetChild("BattleProgressBack/B" .. i .. "/LightDot")
    -- DECOMPILER ERROR at PC293: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerLightDotEffect)[i] = self:GetChild("BattleProgressBack/B" .. i .. "/LightDot/Effect")
    -- DECOMPILER ERROR at PC300: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._rightPowerEffect)[i] = self:GetChild("BattleProgressBack/EffectB" .. i)
    -- DECOMPILER ERROR at PC308: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerImgGrids)[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "Img")
    -- DECOMPILER ERROR at PC315: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerGrids)[i] = self:GetChild("BattleProgressBackAlone/B" .. i)
    -- DECOMPILER ERROR at PC323: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerGridFullEffect)[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/Effect")
    -- DECOMPILER ERROR at PC331: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerLightDot)[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/LightDot")
    -- DECOMPILER ERROR at PC339: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerLightDotEffect)[i] = self:GetChild("BattleProgressBackAlone/B" .. i .. "/LightDot/Effect")
    -- DECOMPILER ERROR at PC346: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._alonePowerEffect)[i] = self:GetChild("BattleProgressBackAlone/EffectB" .. i)
  end
  self._normalPowerFlowEffect = self:GetChild("BattleProgressBack/EffectBig")
  self._alonePowerFlowEffect = self:GetChild("BattleProgressBackAlone/EffectBig")
  self._alonePowerGuideEffect = self:GetChild("BattleProgressBackAlone/Effect")
  self._powerGuideEffect = self:GetChild("BattleProgressBack/Effect")
  self._magicSurgeEffect = self:GetChild("BattleProgressBack/EffectMoYong")
  self._breakOutPowerBtn = self:GetChild("BattleEnergyBtn")
  self._breakOutPowerStateUI = {}
  for i = 1, PowerEnergyStateNum do
    -- DECOMPILER ERROR at PC384: Confused about usage of register: R7 in 'UnsetPending'

    (self._breakOutPowerStateUI)[i] = self:GetChild("BattleEnergyBtn/Energy" .. i)
    ;
    ((self._breakOutPowerStateUI)[i]):SetActive(false)
  end
  self._breakOutPowerEmptyUI = self:GetChild("BattleEnergyBtn/Energy0")
  self._breakOutPowerFullUI = self:GetChild("BattleEnergyBtn/Energy" .. PowerEnergyStateNum + 1)
  self._breakOutPowerEnergyFullEffect = self:GetChild("BattleEnergyBtn/Energy" .. PowerEnergyStateNum + 1 .. "/EffectEnergyFull")
  ;
  (self._breakOutPowerFullUI):SetActive(false)
  self._breakOutPowerCountProgress = self:GetChild("BattleEnergyBtn/CountProgress")
  self._breakOutPowerCountNum = self:GetChild("BattleEnergyBtn/CountProgress/CountNum")
  ;
  (self._breakOutPowerCountProgress):SetActive(false)
  self._breakOutPowerFullEffect = self:GetChild("BattleEnergyBtn/Effect")
  self._cdEndEffect = self:GetChild("BattleProgressBack/EnergyBtn/EffectCDEnd")
  self._effectEnergy = self:GetChild("EffectEnergy")
  self._breakOutPowerGuide = self:GetChild("BattleEnergyBtn/Guide")
  self._breakOutPowerTotalDamagePanel = self:GetChild("BattleEnergyCount")
  self._breakOutPowerTotalDamageNumTxt = self:GetChild("BattleEnergyCount/Num/Text")
  self._breakOutPowerTotalDamageNumEffect = self:GetChild("BattleEnergyCount/Num/Effect")
  self._breakOutPowerTotalDamageNumEffectAnchorMinX = (self._breakOutPowerTotalDamageNumEffect):GetAnchorAndOffset()
  self._breakOutPowerTotalDamageNumTxtRectX = (self._breakOutPowerTotalDamageNumTxt):GetRectSize()
  self._supportRole = self:GetChild("BattleAssistBack")
  ;
  (self._supportRole):SetActive(false)
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
  local battleType = ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType()
  local battleSpecialId = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
  self._inBossRush = battleType == CBattleStartProtocol.BOSS_RUSH or battleType == CBattleStartProtocol.WEEK_BOSS
  self._inUndecidedRoad = battleType == CBattleStartProtocol.UNDECIDEDROAD
  self._inSpring = battleType == CBattleStartProtocol.SPRING_FESTIVAL
  self._inWeekBoss = battleType == CBattleStartProtocol.WEEK_BOSS
  self._inAnniversaryDailyBattle = (battleType == CBattleStartProtocol.ANNIVERSARY and ((NekoData.BehaviorManager).BM_Anniversary):IsDailyBossLevel(battleSpecialId))
  local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
  self._inSummerEchoesChallenge = (battleType == CBattleStartProtocol.SUMMER_ECHO and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):IsChallengeBattle(battleID))
  if self._inSummerEchoesChallenge then
    (self._stageShow):SetActive(true)
    ;
    (self._stageTxt):SetText((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):GetStageStr(battleID))
  else
    (self._stageShow):SetActive(false)
  end
  if self._inBossRush or self._inUndecidedRoad or self._inSpring or self._inAnniversaryDailyBattle or self._inSummerEchoesChallenge then
    (self._battleDurationPanel):SetActive(true)
    if self._inSpring or self._inAnniversaryDailyBattle then
      (self._battleDurationPanel_title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1721)).msgTextID))
    end
    RefreshBattleDuration(self, 0)
  else
    (self._battleDurationPanel):SetActive(false)
  end
  self._alonePowerWidth = ((self._alonePowerGrids)[1]):GetRectSize()
  self._leftPowerWidth = ((self._leftPowerGrids)[1]):GetRectSize()
  self._lightDotWidth = ((self._alonePowerLightDot)[1]):GetRectSize()
  self._frame = (TableFrame.Create)(self._skillPanel, self, false, false)
  self._breakOutPowerUnlockState = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattlePowerBreakOut)
  ;
  (self._breakOutPowerBtn):SetActive(self._breakOutPowerUnlockState)
  ;
  (self._supportRole):Subscribe_PointerClickEvent(self.OnSupportRoleClick, self)
  ;
  (self._pauseBtn):Subscribe_PointerClickEvent(self.OnPauseBtnClick, self)
  ;
  (self._enemyDetailBtn):Subscribe_PointerClickEvent(self.OnEnemyDetailBtnClick, self)
  ;
  (self._leaveBtn):Subscribe_PointerClickEvent(self.OnLeaveBtnClick, self)
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailBtnClick, self)
  ;
  (self._gmBtn):Subscribe_PointerClickEvent(self.OnGMBtnClick, self)
  ;
  (self._winRetreatBtn):Subscribe_PointerClickEvent(self.OnWinRetreatBtnClick, self)
  ;
  (self._loseRetreatBtn):Subscribe_PointerClickEvent(self.OnLoseRetreatBtnClick, self)
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnWinSkipBtnClick, self)
  ;
  (self._autoBtn):Subscribe_PointerClickEvent(self.OnAutoBtnClick, self)
  ;
  (self._autoCancelBtn):Subscribe_PointerClickEvent(self.OnAutoCancelBtnClick, self)
  ;
  (self._speedBtn):Subscribe_PointerClickEvent(self.OnSpeedBtnClick, self)
  ;
  (self._breakOutPowerBtn):Subscribe_PointerClickEvent(self.OnBreakOutPowerBtnClick, self)
  ;
  (self._defaultModeAutoBattlePanelCancelBtn):Subscribe_PointerClickEvent(self.OnAutoCancelBtnClick, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementBtnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_LateUpdate, nil)
  self._width = (self._skillPanel):GetRectSize()
  self._rootWindowAnchoredx = (self._skillPanel):GetAnchoredPosition()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshState, Common.n_FrameNumUsed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.CreateBatttlerHPBar, Common.n_RoleAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.CreateBatttlerSummonHPBar, Common.n_RoleAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.DestroyBatttlerHPBar, Common.n_RoleDead, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHPChanged, Common.n_HpChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHPCellVisibleChange, Common.n_HpVisible, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDamageMiss, Common.n_DamageMiss, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillSuccess, Common.n_SkillSuccess, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillFail, Common.n_SkillFail, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSupportRoleUsed, Common.n_SupportRoleUsed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleEquipSkillUsed, Common.n_RoleEquipSkillUsed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuide1tartStage1, Common.n_NewBattleGuide1StartStage1, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuide1Stage1End, Common.n_NewBattleGuide1Stage1End, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFillInBattlePower, Common.n_FillInBattlePower, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattlePauseStateChange, Common.n_BattlePauseStateChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAccumulatePowerStateChange, Common.n_AccumulatePowerState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillBegin, Common.n_SkillBegin, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillInterrupted, Common.n_SkillInterrupted, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnInvincibleStateChange, Common.n_InvincibleStateChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShieldValueChange, Common.n_ShieldValueChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnInBattleGuide, Common.n_InBattleGuide, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActiveSkillStateChange, Common.n_ActiveSkillStateChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeSecondHurtShowState, Common.n_ChangeSecondHurtShowState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEntityNameChanging, Common.n_EntityNameChanging, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnOrderPowerSpecialUIEffect, Common.n_OrderPowerSpecialUIEffect, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBreakOutPowerNumberChange, Common.n_BreakOutPowerNumberChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBossViolentEnter, Common.n_BossViolentEnter, nil)
  local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
  if battleID and battleID == 1120 then
    self:SetPauseBtnState(false)
  else
    self:SetPauseBtnState(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattlePause))
  end
  if battleID and (battleID == 1120 or battleID == 1122) then
    (self._elementImg):SetActive(false)
  else
    (self._elementImg):SetActive(true)
  end
  local plat = ((((_ENV.CS).PixelNeko).LuaManager).GetSystemType)()
  local systemType = (_ENV.require)("protocols.bean.protocol.common.systemtype")
  if plat ~= systemType.UNITY then
    if ((((_ENV.CS).PixelNeko).P1).GameApp).applicationPause then
      (_ENV.LogInfoFormat)("BattleNewMainDialog", "CS.PixelNeko.P1.GameApp.applicationPause %s \n\n%s\n", ((((_ENV.CS).PixelNeko).P1).GameApp).applicationPause, ((_ENV.debug).traceback)())
    end
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnApplicationPause, Common.n_ApplicationPause, nil)
  end
  local buffShowMode = ((NekoData.BehaviorManager).BM_Game):GetBuffShowMode()
  if buffShowMode and buffShowMode == "Show" then
    (LuaNotificationCenter.AddObserver)(self, self.OnBuffsUpdate, Common.n_BuffsUpdate, nil)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuide1BattleNewMainDialogCreated, nil, nil)
  local battleInfoRecord = CBattleInfoTable:GetRecorder(((NekoData.BehaviorManager).BM_Battle):GetBattleId())
  if battleInfoRecord and battleInfoRecord.auto == 1 then
    (self._autoBtn):SetActive(true)
    ;
    (self._autoCancelBtn):SetActive(false)
    ;
    (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight = 0
    ;
    (_ENV.LogInfoFormat)("BattleNewMainDialog", "battleid %s cbattleinfo.auto = 1", ((NekoData.BehaviorManager).BM_Battle):GetBattleId())
  end
  if ((NekoData.BehaviorManager).BM_Battle):GetBattleType() == 19 then
    ((NekoData.DataManager).DM_Dungeon):SetMode("auto")
  end
  if ((NekoData.BehaviorManager).BM_Dungeon):GetMode() == "auto" then
    (_ENV.LogInfoFormat)("BattleNewMainDialog", "battleid %s mode is auto, autobattleinfo.speed %s .autoFight 1", ((NekoData.BehaviorManager).BM_Battle):GetBattleId(), (_ENV.tonumber)((CBattleConfig:GetRecorder(85)).attr))
    ;
    (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight = 1
    ;
    (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).speed = (_ENV.tonumber)((CBattleConfig:GetRecorder(85)).attr)
  end
  local autoBattleInfo = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleAuto) then
    (self._autoBtn):SetActive(false)
    ;
    (self._autoCancelBtn):SetActive(false)
  elseif ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleAuto) then
    if autoBattleInfo.speed == 1 then
      if not self._pause then
        ((NekoData.DataManager).DM_TimeScale):SetBattleNormalSpeed()
      end
      ;
      (self._speedBtn):SetSelected(false)
    else
      if not self._pause then
        ((NekoData.DataManager).DM_TimeScale):SetBattleNTimesSpeed()
      end
      ;
      (self._speedBtn):SetSelected(true)
      self._speedBtnEffectHandler = (self._speedBtnEffect):AddEffectSync(((_ENV.EffectUtil).GetAssetBundleNameAndAssetName)(1032))
    end
    if autoBattleInfo.autoFight == 0 then
      (self._autoBtn):SetActive(true)
      ;
      (self._autoCancelBtn):SetActive(false)
    elseif autoBattleInfo.autoFight == 1 then
      (self._autoBtn):SetActive(false)
      ;
      (self._autoCancelBtn):SetActive(true)
      self._autoCancelBtnEffectHandler = (self._autoCancelBtnEffect):AddEffectSync(((_ENV.EffectUtil).GetAssetBundleNameAndAssetName)(1032))
      if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Default then
        (self._defaultModeAutoBattlePanel):SetActive(true)
      end
    end
  end
  self._baseDamageNumCell = (UIManager.CreateLuaWindow)(DamageNumCell.AssetBundleName .. ".assetbundle", DamageNumCell.AssetName, (self._damageParent)._uiObject)
  ;
  (self._baseDamageNumCell):SetActive(false)
  ;
  ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).Battle, self)
  self._leftPowerImgGridsPosition = {}
  self._rightPowerImgGridsPosition = {}
  local _ = nil
  for i = 1, 7 do
    -- DECOMPILER ERROR at PC1510: Confused about usage of register: R17 in 'UnsetPending'

    (self._leftPowerImgGridsPosition)[i] = {}
    -- DECOMPILER ERROR at PC1514: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self._rightPowerImgGridsPosition)[i] = {}
    -- DECOMPILER ERROR at PC1528: Confused about usage of register: R19 in 'UnsetPending'

    -- DECOMPILER ERROR at PC1530: Confused about usage of register: R17 in 'UnsetPending'

    -- DECOMPILER ERROR at PC1531: Overwrote pending register: R12 in 'AssignReg'

    -- DECOMPILER ERROR at PC1545: Confused about usage of register: R19 in 'UnsetPending'

    -- DECOMPILER ERROR at PC1546: Overwrote pending register: R12 in 'AssignReg'

    -- DECOMPILER ERROR at PC1547: Confused about usage of register: R17 in 'UnsetPending'

    -- DECOMPILER ERROR at PC1548: Overwrote pending register: R12 in 'AssignReg'

  end
  self._leftPowerImgGridsSizeX = ((self._leftPowerImgGrids)[1]):GetRectSize()
  self._rightPowerImgGridsSizeX = ((self._rightPowerImgGrids)[1]):GetRectSize()
  self._breakOutPowerBtnPosition = {}
  -- DECOMPILER ERROR at PC1579: Confused about usage of register: R15 in 'UnsetPending'

  -- DECOMPILER ERROR at PC1580: Overwrote pending register: R12 in 'AssignReg'

  -- DECOMPILER ERROR at PC1581: Confused about usage of register: R13 in 'UnsetPending'

  -- DECOMPILER ERROR at PC1582: Overwrote pending register: R12 in 'AssignReg'

  self._breakOutPowerBtnSizeX = (self._breakOutPowerBtn):GetRectSize()
  self:RefreshTeamElementInfo()
  self._newYearBattleCountText = self:GetChild("NewYearBattleCount/Num/Text")
  self._newYearBattleCount = self:GetChild("NewYearBattleCount")
  self._isSpring = battleType == CBattleStartProtocol.SPRING_FESTIVAL
  ;
  (self._newYearBattleCount):SetActive(self._isSpring)
  if self._isSpring then
    self._totalDamage = 0
    ;
    (self._newYearBattleCountText):SetText(self._totalDamage)
  end
  -- DECOMPILER ERROR: 37 unprocessed JMP targets
end

BattleNewMainDialog.OnDestroy = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battlepausedialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleroleskillsdetaildialog")
  ;
  (DialogManager.DestroySingletonDialog)("newbattle.battleguidetimetype1003stage4maskdialog")
  ;
  ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
  ;
  ((NekoData.DataManager).DM_TimeScale):Clear()
  for k,v in pairs(self._leftHpCells) do
    ((self._leftHpCells)[k]):Destroy()
    ;
    ((self._leftHpCells)[k]):RootWindowDestroy()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._leftHpCells)[k] = nil
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._leftHpCellsVisibleCount)[k] = nil
  end
  for k,v in pairs(self._summonHpCells) do
    ((self._summonHpCells)[k]):Destroy()
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._summonHpCells)[k] = nil
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._summonHpCellsVisibleCount)[k] = nil
  end
  for k,v in pairs(self._rightHpCells) do
    ((self._rightHpCells)[k]):Destroy()
    ;
    ((self._rightHpCells)[k]):RootWindowDestroy()
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._rightHpCells)[k] = nil
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._rightHpCellsVisibleCount)[k] = nil
  end
  for k,v in pairs(self._damageCells) do
    ((self._damageCells)[k]):Destroy()
    ;
    ((self._damageCells)[k]):RootWindowDestroy()
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self._damageCells)[k] = nil
  end
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  if self._runtimePackerAgent then
    (self._runtimePackerAgent):Release()
  end
  if self._cdEndEffectHandler then
    (self._cdEndEffect):ReleaseEffect(self._cdEndEffectHandler)
    self._cdEndEffectHandler = nil
  end
  if self._effectEnergyPowerEffectHandler then
    (self._effectEnergy):ReleaseEffect(self._effectEnergyPowerEffectHandler)
    self._effectEnergyPowerEffectHandler = nil
  end
  for _,effObj in ipairs(self._leftPowerImgGridsFlyEffect) do
    effObj:Destroy()
    effObj:RootWindowDestroy()
  end
  for _,effObj in ipairs(self._rightPowerImgGridsFlyEffect) do
    effObj:Destroy()
    effObj:RootWindowDestroy()
  end
  if self._breakOutPowerBreakOutEffectHandler then
    (self._breakOutPowerFullEffect):ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
    self._breakOutPowerBreakOutEffectHandler = nil
  end
  if self._showDamageTask then
    (GameTimer.RemoveTask)(self._showDamageTask)
  end
end

BattleNewMainDialog.SetBattleWorld = function(self, battleWorld)
  -- function num : 0_7
  self._battleWorld = battleWorld
end

BattleNewMainDialog.SetPauseBtnState = function(self, state)
  -- function num : 0_8
  self._pauseBtnState = state
end

BattleNewMainDialog.AddAssistRole = function(self, assist, leftAssistNum, totalAssistNum)
  -- function num : 0_9 , upvalues : _ENV, CSkillTable, CImagePathTable, Role
  self._assistRole = assist
  self._leftAssistNum = leftAssistNum
  self._leftAssistNumBegin = leftAssistNum
  self._totalAssistNum = totalAssistNum
  local assistRoleSkillList = {}
  for _,v in ipairs(assist.skills) do
    if v ~= 0 then
      (table.insert)(assistRoleSkillList, v)
    end
  end
  local oneAssitSkillId = nil
  for _,v in pairs(assistRoleSkillList) do
    oneAssitSkillId = v
  end
  if oneAssitSkillId then
    local record = CSkillTable:GetRecorder(oneAssitSkillId)
    if not record then
      LogErrorFormat("BattleNewMainDialog", "wrong assist skillid %d", oneAssitSkillId)
    end
    if not CImagePathTable:GetRecorder(record.icon) then
      local imgRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._supportRoleSkillImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  do
    ;
    (self._supportRoleNum):SetText(tostring(self._leftAssistNum) .. "/" .. tostring(self._totalAssistNum))
    if self._leftAssistNum > 0 then
      local supportRole = (Role.Create)(assist.id)
      if supportRole then
        local imageRecord = supportRole:GetSkillHeadImageRecord()
        ;
        (self._supportRolePhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        do
          do
            LogError("BattleNewMainDialog", "roleId %s create Role Failed", assist.id)
            ;
            (self._supportRole):SetActive(false)
            LogInfoFormat("BattleNewMainDialog", "leftAssistNum %s totalAssistNum %s", leftAssistNum, totalAssistNum)
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnClicked = function(self, args)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battleroleskillsdetaildialog")
  if dialog then
    dialog:Destroy()
  end
end

BattleNewMainDialog.OnRefreshState = function(self, notification)
  -- function num : 0_11 , upvalues : RefreshBattleDuration, _ENV, CBattleConfig, GuideTimeType, GuidTypes
  RefreshBattleDuration(self, notification.userInfo)
  if self._assistRole and notification.userInfo == tonumber((CBattleConfig:GetRecorder(27)).attr) and self._leftAssistNum > 0 then
    (self._supportRole):SetActive(true)
  end
  if notification.userInfo == tonumber((CBattleConfig:GetRecorder(28)).attr) then
    (self._pauseBtn):SetActive(self._pauseBtnState)
    ;
    (self._leaveBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleRetreat))
  end
  if self._battleGuideTimeType_1002_guide then
    if notification.userInfo == 121 then
      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1002Start, self, 1)
    else
      if notification.userInfo == 241 then
        (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1002Start, self, 2)
      end
    end
  else
    -- DECOMPILER ERROR at PC88: Unhandled construct in 'MakeBoolean' P1

    if self._battleGuideTimeType_1001_guide and notification.userInfo == 10 then
      self:SetGuideFrame({guideTimeType = GuideTimeType.AutoBattleGuide, stage = 1}, nil, "Up", 2301127)
    end
  end
  -- DECOMPILER ERROR at PC109: Unhandled construct in 'MakeBoolean' P1

  if ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.BATTLE_2X) == 0 and notification.userInfo == 15 then
    self:SetGuideFrame({guideTimeType = GuideTimeType.BattleSpeedGuide, stage = 1}, nil, "Up", 2301126)
  end
  if self._battleGuideTimeType_1003_guide and notification.userInfo == 15 then
    self:SetGuideFrame({guideTimeType = GuideTimeType.PowerFirstFull, stage = 1}, nil, "Up", 2301167)
  end
  for _,v in ipairs(self._entityList) do
    if (self._leftHpCells)[v:GetEntityId()] then
      for index,skillId in ipairs(v:GetSkillList()) do
        local autoCDTime = v:GetSkillAutoCDTime(skillId)
        if autoCDTime > 0 then
          v:SetSkillAutoCDTime(skillId, autoCDTime - 1)
        end
      end
    end
  end
  if self._battleGuideTimeType_1003_guide_stage5_countTime then
    self._battleGuideTimeType_1003_guide_stage5_countTime = self._battleGuideTimeType_1003_guide_stage5_countTime + 1
    if self._battleGuideTimeType_1003_guide_stage5_countTime >= 15 then
      self._battleGuideTimeType_1003_guide_stage5_countTime = nil
      self:SetGuideFrame({guideTimeType = GuideTimeType.PowerFirstFull, stage = 5}, nil, "Up", 2301173)
    end
  end
  if self._battleGuideTimeType_1003_guide_stage4_countTime then
    self._battleGuideTimeType_1003_guide_stage4_countTime = self._battleGuideTimeType_1003_guide_stage4_countTime + 1
    if self._battleGuideTimeType_1003_guide_stage4_countTime >= 60 then
      self._battleGuideTimeType_1003_guide_stage4_countTime = nil
      ;
      (DialogManager.DestroySingletonDialog)("newbattle.battleguidetimetype1003stage4maskdialog")
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1003, self, 4)
    end
  end
end

BattleNewMainDialog.OnInBattleGuide = function(self, notification)
  -- function num : 0_12 , upvalues : GuideTimeType
  if notification.userInfo == GuideTimeType.FrameFit120 then
    self._battleGuideTimeType_1002_guide = true
  else
    if notification.userInfo == GuideTimeType.AutoBattleGuide then
      self._battleGuideTimeType_1001_guide = true
    else
      if notification.userInfo == GuideTimeType.PowerFirstFull then
        self._battleGuideTimeType_1003_guide = true
      end
    end
  end
end

BattleNewMainDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  if self._breakOutPowerGuideState then
    self._breakOutPowerGuideState = false
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
  end
end

BattleNewMainDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_14
  if stateName == "BattleAssistShake" then
    (self._supportRole):SetActive(false)
  else
    if stateName == "BattleEnergyCount" then
      self._battleEnergyCountAnimationIsEnd = true
    end
  end
end

local SortAutoBattleSkillFunction = function(a, b, aWeight, bWeight)
  -- function num : 0_15 , upvalues : CCostSkillTable, RoleConfigTable, cSkillItem, _ENV, Skill
  local aAutoCDTime = (a.role):GetSkillAutoCDTime(a.skillId)
  local bAutoCDTime = (b.role):GetSkillAutoCDTime(b.skillId)
  local aSkillIsInCD = (a.role):GetSkillIsInCD(a.skillId)
  local bSkillIsInCD = (b.role):GetSkillIsInCD(b.skillId)
  local aSkillIfEnergy = (a.role):IfSkillIsEnergy(a.skillId)
  local bSkillIfEnergy = (b.role):IfSkillIsEnergy(b.skillId)
  if aAutoCDTime == 0 and bAutoCDTime ~= 0 then
    return true
  else
    if aAutoCDTime ~= 0 and bAutoCDTime == 0 then
      return false
    end
  end
  if aSkillIsInCD and not bSkillIsInCD then
    return false
  else
    if not aSkillIsInCD and bSkillIsInCD then
      return true
    end
  end
  if aSkillIfEnergy and not bSkillIfEnergy then
    return false
  else
    if not aSkillIfEnergy and bSkillIfEnergy then
      return true
    end
  end
  if bWeight < aWeight then
    return true
  else
    if aWeight < bWeight then
      return false
    end
  end
  local aCost = 0
  local bCost = 0
  if (CCostSkillTable:GetRecorder(a.skillId)).OrderCost ~= 0 then
    aCost = (CCostSkillTable:GetRecorder(a.skillId)).OrderCost
  else
    if (CCostSkillTable:GetRecorder(a.skillId)).ChaosCost ~= 0 then
      aCost = (CCostSkillTable:GetRecorder(a.skillId)).ChaosCost
    end
  end
  if (CCostSkillTable:GetRecorder(b.skillId)).OrderCost ~= 0 then
    bCost = (CCostSkillTable:GetRecorder(b.skillId)).OrderCost
  else
    if (CCostSkillTable:GetRecorder(b.skillId)).ChaosCost ~= 0 then
      bCost = (CCostSkillTable:GetRecorder(b.skillId)).ChaosCost
    end
  end
  if aCost < bCost then
    return true
  else
    if bCost < aCost then
      return false
    else
      local aSkillItemId, bSkillItemId = nil, nil
      local aRoleRecorder = RoleConfigTable:GetRecorder((a.role):GetConfigId())
      local bRoleRecorder = RoleConfigTable:GetRecorder((b.role):GetConfigId())
      if aRoleRecorder then
        local skillItemRecorder = cSkillItem:GetRecorder(aRoleRecorder.contractskillid)
        for _,skillid in ipairs(skillItemRecorder.skillID) do
          if a.skillId == skillid then
            aSkillItemId = aRoleRecorder.contractskillid
          end
          if b.skillId == skillid then
            bSkillItemId = aRoleRecorder.contractskillid
          end
        end
        local skillItemRecorder = cSkillItem:GetRecorder(aRoleRecorder.contractskillid2)
        for _,skillid in ipairs(skillItemRecorder.skillID) do
          if a.skillId == skillid then
            aSkillItemId = aRoleRecorder.contractskillid2
          end
          if b.skillId == skillid then
            bSkillItemId = aRoleRecorder.contractskillid2
          end
        end
      end
      do
        if bRoleRecorder then
          local skillItemRecorder = cSkillItem:GetRecorder(bRoleRecorder.contractskillid)
          for _,skillid in ipairs(skillItemRecorder.skillID) do
            if a.skillId == skillid then
              aSkillItemId = bRoleRecorder.contractskillid
            end
            if b.skillId == skillid then
              bSkillItemId = bRoleRecorder.contractskillid
            end
          end
          local skillItemRecorder = cSkillItem:GetRecorder(bRoleRecorder.contractskillid2)
          for _,skillid in ipairs(skillItemRecorder.skillID) do
            if a.skillId == skillid then
              aSkillItemId = bRoleRecorder.contractskillid2
            end
            if b.skillId == skillid then
              bSkillItemId = bRoleRecorder.contractskillid2
            end
          end
        end
        do
          if not aSkillItemId or not bSkillItemId then
            LogErrorFormat("BattleNewMainDialog", "roleid1 %s skillid1 %s or roleid2 %s skillid2 %s dont have cskillitem with roleconfig.contractskillid or roleconfig.contractskillid2", (a.role):GetConfigId(), a.skillId, (b.role):GetConfigId(), b.skillId)
          else
            local aSkill = (Skill.Create)(a.skillId, aSkillItemId or true)
            local bSkill = (Skill.Create)(b.skillId, bSkillItemId or true)
            if bSkill:GetSkillLevel() < aSkill:GetSkillLevel() then
              return true
            else
              if aSkill:GetSkillLevel() < bSkill:GetSkillLevel() then
                return false
              end
            end
          end
          do
            do
              do return b.skillId < a.skillId end
              -- DECOMPILER ERROR: 2 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnUpdate = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV, CBattleConfig, CCostSkillTable, AutoBattleModeType, PowerAccumulateStateType, SortAutoBattleSkillFunction, CSkillAutoWeightCfg
  local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
  if battleID == 1120 then
    (self._aloneProgress):SetActive(true)
    ;
    (self._normalProgress):SetActive(false)
    if not self._alonePowerFlowEffectHandler then
      self._alonePowerFlowEffectHandler = (self._alonePowerFlowEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1040))
    end
    local power, powerMax = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
    local fullGridNum = (math.floor)(power)
    for i,v in ipairs(self._alonePowerGrids) do
      if i <= fullGridNum then
        v:SetActive(true)
        ;
        ((self._alonePowerImgGrids)[i]):SetActive(true)
        ;
        ((self._alonePowerImgGrids)[i]):SetFillAmount(1)
        if (self._alonePowerLightDotEffectHandlers)[i] ~= 0 and i ~= power then
          ((self._alonePowerLightDot)[i]):SetActive(false)
          ;
          ((self._alonePowerLightDotEffect)[i]):SetActive(false)
        end
        ;
        ((self._alonePowerGridFullEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC88: Confused about usage of register: R11 in 'UnsetPending'

        if (self._alonePowerGridFullEffectHandlers)[i] == 0 then
          (self._alonePowerGridFullEffectHandlers)[i] = ((self._alonePowerGridFullEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1041))
        end
        if i == power then
          ((self._alonePowerLightDot)[i]):SetActive(true)
          ;
          ((self._alonePowerLightDotEffect)[i]):SetActive(true)
          -- DECOMPILER ERROR at PC114: Confused about usage of register: R11 in 'UnsetPending'

          if (self._alonePowerLightDotEffectHandlers)[i] == 0 then
            (self._alonePowerLightDotEffectHandlers)[i] = ((self._alonePowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1042))
          end
        end
      else
        if power < i and i - 1 < power then
          v:SetActive(true)
          ;
          ((self._alonePowerImgGrids)[i]):SetActive(true)
          ;
          ((self._alonePowerImgGrids)[i]):SetFillAmount(power + 1 - i)
          ;
          ((self._alonePowerLightDot)[i]):SetActive(true)
          ;
          ((self._alonePowerLightDotEffect)[i]):SetActive(true)
          -- DECOMPILER ERROR at PC158: Confused about usage of register: R11 in 'UnsetPending'

          if (self._alonePowerLightDotEffectHandlers)[i] == 0 then
            (self._alonePowerLightDotEffectHandlers)[i] = ((self._alonePowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1043))
          end
          ;
          ((self._alonePowerLightDot)[i]):SetXPosition(0, self._alonePowerWidth * (power + 1 - i) - self._lightDotWidth / 2)
          if (self._alonePowerGridFullEffectHandlers)[i] ~= 0 then
            ((self._alonePowerGridFullEffect)[i]):SetActive(false)
          end
        else
          v:SetActive(false)
          ;
          ((self._alonePowerImgGrids)[i]):SetActive(false)
          ;
          ((self._alonePowerLightDot)[i]):SetActive(false)
          if (self._alonePowerLightDotEffectHandlers)[i] ~= 0 then
            ((self._alonePowerLightDotEffect)[i]):SetActive(false)
          end
          if (self._alonePowerGridFullEffectHandlers)[i] ~= 0 then
            ((self._alonePowerGridFullEffect)[i]):SetActive(false)
          end
        end
      end
    end
  else
    do
      ;
      (self._aloneProgress):SetActive(false)
      ;
      (self._normalProgress):SetActive(true)
      if self._breakOutPowerShow then
        if self._breakOutRedPowerIncreaseTask then
          if (self._breakOutRedPowerIncreaseTask):update((notification.userInfo).deltaTime) then
            local power1 = tonumber((CBattleConfig:GetRecorder(8)).attr)
            local fullGridNum1 = (math.floor)(power1)
            self:ShowLeftPowerGrid(fullGridNum1, power1)
            self._breakOutRedPowerIncreaseTask = nil
          else
            do
              local power1 = ((self._breakOutRedPowerIncreaseTask).subject).value
              do
                local fullGridNum1 = (math.floor)(power1)
                self:ShowLeftPowerGrid(fullGridNum1, power1)
                if self._breakOutBluePowerIncreaseTask then
                  if (self._breakOutBluePowerIncreaseTask):update((notification.userInfo).deltaTime) then
                    local power2 = tonumber((CBattleConfig:GetRecorder(9)).attr)
                    local fullGridNum2 = (math.floor)(power2)
                    self:ShowRightPowerGrid(fullGridNum2, power2)
                    self._breakOutBluePowerIncreaseTask = nil
                  else
                    do
                      local power2 = ((self._breakOutBluePowerIncreaseTask).subject).value
                      do
                        local fullGridNum2 = (math.floor)(power2)
                        self:ShowRightPowerGrid(fullGridNum2, power2)
                        if not self._breakOutRedPowerIncreaseTask and not self._breakOutBluePowerIncreaseTask then
                          self._breakOutPowerShow = false
                        end
                        local power1, power1Max = ((NekoData.BehaviorManager).BM_Battle):GetPower1()
                        local power2, power2Max = ((NekoData.BehaviorManager).BM_Battle):GetPower2()
                        local fullGridNum1 = (math.floor)(power1)
                        do
                          local fullGridNum2 = (math.floor)(power2)
                          self:ShowLeftPowerGrid(fullGridNum1, power1)
                          self:ShowRightPowerGrid(fullGridNum2, power2)
                          if self._battleGuideTimeType_1003_guide and (CCostSkillTable:GetRecorder(6016201)).ChaosCost <= fullGridNum2 then
                            self._battleGuideTimeType_1003_guide_stage4_countTime = 0
                            ;
                            (DialogManager.CreateSingletonDialog)("newbattle.battleguidetimetype1003stage4maskdialog")
                            self._battleGuideTimeType_1003_guide = false
                          end
                          local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
                          for k,v in pairs(self._leftHpCells) do
                            v:OnUpdate(leftBattlers[k], (notification.userInfo).deltaTime)
                          end
                          local leftBattlersSummon = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlersSummon()
                          for k,v in pairs(self._summonHpCells) do
                            v:OnUpdate(leftBattlersSummon[k], (notification.userInfo).deltaTime)
                          end
                          local rightBattlersSummon = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlersSummon()
                          for k,v in pairs(self._summonHpCells) do
                            v:OnUpdate(rightBattlersSummon[k], (notification.userInfo).deltaTime)
                          end
                          local rightBattlers = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
                          for k,v in pairs(self._rightHpCells) do
                            v:OnUpdate(rightBattlers[k], (notification.userInfo).deltaTime)
                          end
                          for i,task in ipairs(self._leftPowerImgGridsFlyTask) do
                            if task:update((notification.userInfo).deltaTime) then
                              ((self._leftPowerImgGridsFlyEffect)[i]):Destroy()
                              ;
                              ((self._leftPowerImgGridsFlyEffect)[i]):RootWindowDestroy()
                              ;
                              (table.remove)(self._leftPowerImgGridsFlyTask, i)
                              ;
                              (table.remove)(self._leftPowerImgGridsFlyEffect, i)
                            else
                              ;
                              (((self._leftPowerImgGridsFlyEffect)[i]):GetRootWindow()):SetPosition(0.5, (task.subject).xValue, 0.5, (task.subject).yValue)
                            end
                          end
                          for i,task in ipairs(self._rightPowerImgGridsFlyTask) do
                            if task:update((notification.userInfo).deltaTime) then
                              ((self._rightPowerImgGridsFlyEffect)[i]):Destroy()
                              ;
                              ((self._rightPowerImgGridsFlyEffect)[i]):RootWindowDestroy()
                              ;
                              (table.remove)(self._rightPowerImgGridsFlyTask, i)
                              ;
                              (table.remove)(self._rightPowerImgGridsFlyEffect, i)
                            else
                              ;
                              (((self._rightPowerImgGridsFlyEffect)[i]):GetRootWindow()):SetPosition(0.5, (task.subject).xValue, 0.5, (task.subject).yValue)
                            end
                          end
                          for entityId,t in pairs(self._totalTimeForSecondHurt) do
                            -- DECOMPILER ERROR at PC512: Confused about usage of register: R12 in 'UnsetPending'

                            (self._totalTimeForSecondHurt)[entityId] = (self._totalTimeForSecondHurt)[entityId] + (notification.userInfo).deltaTime
                          end
                          if self._breakOutPowerCountProgressAndNumTask then
                            if (self._breakOutPowerCountProgressAndNumTask):update((notification.userInfo).deltaTime) then
                              (self._breakOutPowerCountProgress):SetFillAmount(0)
                              ;
                              (self._breakOutPowerCountNum):SetText(0)
                              self._breakOutPowerCountProgressAndNumTask = nil
                              ;
                              (self._breakOutPowerCountProgress):SetActive(false)
                            else
                              ;
                              (self._breakOutPowerCountProgress):SetFillAmount(((self._breakOutPowerCountProgressAndNumTask).subject).value / self._breakOutPowerCountTotalTime)
                              ;
                              (self._breakOutPowerCountNum):SetText((string.format)("%.1f", ((self._breakOutPowerCountProgressAndNumTask).subject).value))
                            end
                          end
                          if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Default and (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
                            local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
                            local hpExistUnder60 = false
                            local breakOutState = self._breakOutPowerState == PowerAccumulateStateType.BreakOut
                            for k,battler in pairs(leftBattlers) do
                              hpExistUnder60 = not battler:IsAlive() or hpExistUnder60 or battler:GetHp() / battler:GetHpMax() < tonumber((CBattleConfig:GetRecorder(105)).attr)
                            end
                            local leftBattlersSummon = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlersSummon()
                            for k,battler in pairs(leftBattlersSummon) do
                              hpExistUnder60 = not battler:IsAlive() or hpExistUnder60 or battler:GetHp() / battler:GetHpMax() < tonumber((CBattleConfig:GetRecorder(105)).attr)
                            end
                            local roleAutoSkillList = {}
                            local orderAutoSkillList = {}
                            local disOrderAutoSkillList = {}
                            for i,v in ipairs(self._entityList) do
                              local skillList = {}
                              if (self._leftHpCells)[v:GetEntityId()] then
                                skillList = v:GetSkillList()
                              end
                              if not roleAutoSkillList[v:GetConfigId()] then
                                roleAutoSkillList[v:GetConfigId()] = {}
                                for index,skillId in ipairs(skillList) do
                                  (table.insert)(roleAutoSkillList[v:GetConfigId()], {role = v, skillId = skillId})
                                  if (CCostSkillTable:GetRecorder(skillId)).ChaosCost ~= 0 then
                                    (table.insert)(disOrderAutoSkillList, {role = v, skillId = skillId})
                                  elseif (CCostSkillTable:GetRecorder(skillId)).OrderCost ~= 0 then
                                    (table.insert)(orderAutoSkillList, {role = v, skillId = skillId})
                                  end
                                end
                                -- DECOMPILER ERROR at PC716: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC716: LeaveBlock: unexpected jumping out IF_STMT

                              end
                            end
                            local list = {}
                            if hpExistUnder60 then
                              if breakOutState then
                                for roleId,v in pairs(roleAutoSkillList) do
                                  (table.sort)(v, function(a, b)
    -- function num : 0_16_0 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).defendWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).defendWeight)
  end
)
                                end
                                for roleId,v in pairs(roleAutoSkillList) do
                                  if v[1] then
                                    (table.insert)(list, {roleId = roleId, skillId = (v[1]).skillId, canClick = false})
                                  end
                                end
                              else
                                (table.sort)(orderAutoSkillList, function(a, b)
    -- function num : 0_16_1 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).defendWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).defendWeight)
  end
)
                                ;
                                (table.sort)(disOrderAutoSkillList, function(a, b)
    -- function num : 0_16_2 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).defendWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).defendWeight)
  end
)
                                if orderAutoSkillList[1] then
                                  (table.insert)(list, {roleId = ((orderAutoSkillList[1]).role):GetConfigId(), skillId = (orderAutoSkillList[1]).skillId, canClick = false})
                                end
                                if disOrderAutoSkillList[1] then
                                  (table.insert)(list, {roleId = ((disOrderAutoSkillList[1]).role):GetConfigId(), skillId = (disOrderAutoSkillList[1]).skillId, canClick = false})
                                end
                              end
                            elseif breakOutState then
                              for roleId,v in pairs(roleAutoSkillList) do
                                (table.sort)(v, function(a, b)
    -- function num : 0_16_3 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).attackWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).attackWeight)
  end
)
                              end
                              for roleId,v in pairs(roleAutoSkillList) do
                                if v[1] then
                                  (table.insert)(list, {roleId = roleId, skillId = (v[1]).skillId, canClick = false})
                                end
                              end
                            else
                              (table.sort)(orderAutoSkillList, function(a, b)
    -- function num : 0_16_4 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).attackWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).attackWeight)
  end
)
                              ;
                              (table.sort)(disOrderAutoSkillList, function(a, b)
    -- function num : 0_16_5 , upvalues : SortAutoBattleSkillFunction, CSkillAutoWeightCfg
    return SortAutoBattleSkillFunction(a, b, (CSkillAutoWeightCfg:GetRecorder(a.skillId)).attackWeight, (CSkillAutoWeightCfg:GetRecorder(b.skillId)).attackWeight)
  end
)
                              if orderAutoSkillList[1] then
                                (table.insert)(list, {roleId = ((orderAutoSkillList[1]).role):GetConfigId(), skillId = (orderAutoSkillList[1]).skillId, canClick = false})
                              end
                              if disOrderAutoSkillList[1] then
                                (table.insert)(list, {roleId = ((disOrderAutoSkillList[1]).role):GetConfigId(), skillId = (disOrderAutoSkillList[1]).skillId, canClick = false})
                              end
                            end
                            local oldAutoSkillList = ((NekoData.BehaviorManager).BM_Battle):GetDefaultModeAutoBattleSkillInfo()
                            local sameCount = 0
                            for _,v in ipairs(oldAutoSkillList) do
                              for _,inV in ipairs(list) do
                                if v.roleId == inV.roleId and v.skillId == inV.skillId then
                                  sameCount = sameCount + 1
                                end
                              end
                            end
                            if sameCount ~= #list or #oldAutoSkillList ~= #list then
                              for i,v in ipairs(list) do
                                -- DECOMPILER ERROR at PC930: Confused about usage of register: R22 in 'UnsetPending'

                                (list[i]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_16_6
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = i})
                              end
                              ;
                              ((NekoData.BehaviorManager).BM_Battle):SaveDefaultModeAutoBattleSkillInfo(list)
                              ;
                              (self._frame):FireEvent("ChangeAutoSkill", nil)
                            end
                          end
                          if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
                            self:OnBreakOutPowerBtnClick()
                          end
                          -- DECOMPILER ERROR: 26 unprocessed JMP targets
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnBattleEnd = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("newbattle.battlenewmaindialog")
end

BattleNewMainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_18
  local dialog = notification.userInfo
  if (self._hpCells)[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._hpCells)[dialog._dialogKey] = nil
  end
end

BattleNewMainDialog.CreateBatttlerHPBar = function(self, notification)
  -- function num : 0_19 , upvalues : _ENV, LineUpStation, AutoBattleModeType, PowerAccumulateStateType, CBattleConfig
  if ((notification.userInfo).attribute).id == 20054 then
    local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
    for k,v in pairs(leftBattlers) do
      if v:GetEntityId() == (notification.userInfo).entityid then
        if (self._leftHpCells)[k] then
          ((self._leftHpCells)[k]):Destroy()
          ;
          ((self._leftHpCells)[k]):RootWindowDestroy()
          -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._leftHpCells)[k] = nil
          -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._leftHpCellsVisibleCount)[k] = nil
        end
        local cell = (DialogManager.CreateDialog)("newbattle.hpleftcell", (self._staticHpBar)._uiObject)
        cell:SetData(v, self)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._leftHpCells)[k] = cell
        ;
        ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff({entityid = (notification.userInfo).entityid})
      end
    end
  else
    do
      if ((notification.userInfo).attribute).camp == (((BattleECS.Components).TypeComponent).CampType).Left then
        local leftBattlers = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlers()
        for k,v in pairs(leftBattlers) do
          if v:GetEntityId() == (notification.userInfo).entityid then
            if (self._leftHpCells)[k] then
              ((self._leftHpCells)[k]):Destroy()
              ;
              ((self._leftHpCells)[k]):RootWindowDestroy()
              -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (self._leftHpCells)[k] = nil
              -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (self._leftHpCellsVisibleCount)[k] = nil
            end
            local cell = (DialogManager.CreateDialog)("newbattle.hpleftcell", (self._staticHpBar)._uiObject)
            cell:SetData(v, self)
            -- DECOMPILER ERROR at PC112: Confused about usage of register: R9 in 'UnsetPending'

            ;
            (self._leftHpCells)[k] = cell
            ;
            ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff({entityid = (notification.userInfo).entityid})
            local showingEntityBuffRecord = (((NekoData.BehaviorManager).BM_Battle):GetEntityBuff())[(notification.userInfo).entityid]
            if showingEntityBuffRecord then
              local buffList = showingEntityBuffRecord.buffList
              for k,v in pairs(buffList) do
                local info = {}
                info.buffid = k
                info.entityid = (notification.userInfo).entityid
                info.counttime = v.counttime
                info.stacklayer = v.stacklayer
                cell:RefreshBuffs(info)
              end
            end
            do
              while (self._entityList)[#self._entityList] do
                (table.remove)(self._entityList, #self._entityList)
              end
              for k,inV in pairs(leftBattlers) do
                if inV:IsRole() and (not inV:IsHaveAlternate() or inV:IsAlive()) then
                  (table.insert)(self._entityList, inV)
                end
              end
              ;
              (table.sort)(self._entityList, function(a, b)
    -- function num : 0_19_0 , upvalues : LineUpStation
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
    do return bKey < aKey end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
              if #self._entityList >= 1 then
                if self._runtimePackerAgent == nil then
                  self:GenerateSkillAtlas()
                end
                if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
                  local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
                  if autoBattle then
                    if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
                      local newAutoSkillList = {}
                      for _,v in ipairs(self._entityList) do
                        newAutoSkillList[v:GetConfigId()] = (v:GetSkillList())[1]
                      end
                      for roleId,skillId in pairs(autoBattle.eruptSkill) do
                        if newAutoSkillList[roleId] then
                          newAutoSkillList[roleId] = skillId
                        end
                      end
                      autoBattle.eruptSkill = newAutoSkillList
                      local list = {}
                      for roleId,skillId in pairs(autoBattle.eruptSkill) do
                        if skillId ~= 0 then
                          (table.insert)(list, {roleId = roleId, skillId = skillId, canClick = false})
                          -- DECOMPILER ERROR at PC277: Confused about usage of register: R18 in 'UnsetPending'

                          ;
                          (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_19_1
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
                        end
                      end
                      ;
                      ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
                    else
                      do
                        local tag = {orderSKill = true, disorderSkill = true}
                        for i,v in ipairs(self._entityList) do
                          if v:GetConfigId() == (autoBattle.orderSKill).roleId then
                            tag.orderSKill = false
                          end
                          if v:GetConfigId() == (autoBattle.disorderSkill).roleId then
                            tag.disorderSkill = false
                          end
                        end
                        do
                          if tag.orderSKill or tag.disorderSkill then
                            self:ResetAutoSkill(tag)
                          else
                            local autoBattleInfo = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
                            -- DECOMPILER ERROR at PC328: Confused about usage of register: R13 in 'UnsetPending'

                            ;
                            (autoBattle.orderSKill).roleId = (autoBattleInfo.orderSKill).roleId
                            -- DECOMPILER ERROR at PC332: Confused about usage of register: R13 in 'UnsetPending'

                            ;
                            (autoBattle.orderSKill).skillId = (autoBattleInfo.orderSKill).skillId
                            -- DECOMPILER ERROR at PC336: Confused about usage of register: R13 in 'UnsetPending'

                            ;
                            (autoBattle.disorderSkill).roleId = (autoBattleInfo.disorderSkill).roleId
                            -- DECOMPILER ERROR at PC340: Confused about usage of register: R13 in 'UnsetPending'

                            ;
                            (autoBattle.disorderSkill).skillId = (autoBattleInfo.disorderSkill).skillId
                          end
                          do
                            do
                              local list = {}
                              if (autoBattle.orderSKill).skillId ~= 0 then
                                (table.insert)(list, {roleId = (autoBattle.orderSKill).roleId, skillId = (autoBattle.orderSKill).skillId, canClick = false})
                                -- DECOMPILER ERROR at PC376: Confused about usage of register: R13 in 'UnsetPending'

                                ;
                                (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_19_2
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
                              end
                              if (autoBattle.disorderSkill).skillId ~= 0 then
                                (table.insert)(list, {roleId = (autoBattle.disorderSkill).roleId, skillId = (autoBattle.disorderSkill).skillId, canClick = false})
                                -- DECOMPILER ERROR at PC411: Confused about usage of register: R13 in 'UnsetPending'

                                ;
                                (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_19_3
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
                              end
                              ;
                              ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
                              do
                                do
                                  local cellPanelWidth = self._width / 3 * #self._entityList
                                  ;
                                  (self._skillPanel):SetSize(0, cellPanelWidth, 0, self._height)
                                  ;
                                  (self._skillPanel):SetAnchoredPosition(self._rootWindowAnchoredx, self._rootWindowAnchoredy)
                                  ;
                                  (self._frame):ReloadAllCell()
                                  ;
                                  (self._frame):FireEvent("ShowSkillCardFrame", v:GetEntityId())
                                  do break end
                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC445: LeaveBlock: unexpected jumping out IF_STMT

                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      else
        do
          if ((notification.userInfo).attribute).camp == (((BattleECS.Components).TypeComponent).CampType).Right then
            local rightBattlers = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlers()
            for k,v in pairs(rightBattlers) do
              if v:GetEntityId() == (notification.userInfo).entityid then
                if (self._rightHpCells)[k] then
                  ((self._rightHpCells)[k]):Destroy()
                  ;
                  ((self._rightHpCells)[k]):RootWindowDestroy()
                  -- DECOMPILER ERROR at PC486: Confused about usage of register: R8 in 'UnsetPending'

                  ;
                  (self._rightHpCells)[k] = nil
                  -- DECOMPILER ERROR at PC488: Confused about usage of register: R8 in 'UnsetPending'

                  ;
                  (self._rightHpCellsVisibleCount)[k] = nil
                end
                local cell = nil
                if v:IsBoss() then
                  cell = (DialogManager.CreateDialog)("newbattle.bosshpcell", (self._hpBar)._uiObject)
                  cell:SetData(v, self)
                else
                  cell = (DialogManager.CreateDialog)("newbattle.hpleftcell", (self._staticHpBar)._uiObject)
                  cell:SetData(v, self)
                end
                -- DECOMPILER ERROR at PC518: Confused about usage of register: R9 in 'UnsetPending'

                ;
                (self._rightHpCells)[k] = cell
                ;
                ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff({entityid = (notification.userInfo).entityid})
                local showingEntityBuffRecord = (((NekoData.BehaviorManager).BM_Battle):GetEntityBuff())[(notification.userInfo).entityid]
                if showingEntityBuffRecord then
                  local buffList = showingEntityBuffRecord.buffList
                  for k,v in pairs(buffList) do
                    local info = {}
                    info.buffid = k
                    info.entityid = (notification.userInfo).entityid
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
      end
    end
  end
end

BattleNewMainDialog.GenerateSkillAtlas = function(self)
  -- function num : 0_20
end

BattleNewMainDialog.CreateBatttlerSummonHPBar = function(self, notification)
  -- function num : 0_21 , upvalues : _ENV
  local leftBattlersSummon = ((NekoData.BehaviorManager).BM_Battle):GetLeftBattlersSummon()
  for k,v in pairs(leftBattlersSummon) do
    if v:GetEntityId() == (notification.userInfo).entityid then
      if (self._summonHpCells)[v:GetEntityId()] then
        ((self._summonHpCells)[v:GetEntityId()]):Destroy()
        -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._summonHpCells)[v:GetEntityId()] = nil
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._summonHpCellsVisibleCount)[v:GetEntityId()] = nil
      end
      local cell = (DialogManager.CreateDialog)("newbattle.hpleftcell", (self._staticHpBar)._uiObject)
      cell:SetData(v, self)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self._summonHpCells)[v:GetEntityId()] = cell
      ;
      ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff({entityid = (notification.userInfo).entityid})
      break
    end
  end
  do
    local rightBattlersSummon = ((NekoData.BehaviorManager).BM_Battle):GetRightBattlersSummon()
    for k,v in pairs(rightBattlersSummon) do
      if v:GetEntityId() == (notification.userInfo).entityid then
        if (self._summonHpCells)[v:GetEntityId()] then
          ((self._summonHpCells)[v:GetEntityId()]):Destroy()
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._summonHpCells)[v:GetEntityId()] = nil
          -- DECOMPILER ERROR at PC95: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self._summonHpCellsVisibleCount)[v:GetEntityId()] = nil
        end
        local cell = (DialogManager.CreateDialog)("newbattle.hpleftcell", (self._staticHpBar)._uiObject)
        cell:SetData(v, self)
        -- DECOMPILER ERROR at PC109: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self._summonHpCells)[v:GetEntityId()] = cell
        ;
        ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff({entityid = (notification.userInfo).entityid})
        break
      end
    end
  end
end

BattleNewMainDialog.DestroyBatttlerHPBar = function(self, notification)
  -- function num : 0_22 , upvalues : _ENV, AutoBattleModeType, PowerAccumulateStateType, CBattleConfig
  local entitiId = (notification.userInfo).entityId
  if not entitiId then
    entitiId = (notification.userInfo).entityid
  end
  if (self._leftHpCells)[entitiId] then
    (((self._leftHpCells)[entitiId])._greenProgressBar):SetFillAmount(0)
    ;
    ((self._leftHpCells)[entitiId]):Show(false)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._leftHpCells)[entitiId] = nil
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._leftHpCellsVisibleCount)[entitiId] = nil
    ;
    (self._frame):FireEvent("ShowSkillCardBack", entitiId)
    if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Optional then
      local tag = {}
      local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
      if (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight == 1 then
        if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
          local newAutoSkillList = {}
          for _,v in ipairs(self._entityList) do
            newAutoSkillList[v:GetConfigId()] = (v:GetSkillList())[1]
          end
          for roleId,skillId in pairs(autoBattle.eruptSkill) do
            if newAutoSkillList[roleId] then
              newAutoSkillList[roleId] = skillId
            end
          end
          autoBattle.eruptSkill = newAutoSkillList
          local list = {}
          for roleId,skillId in pairs(autoBattle.eruptSkill) do
            if skillId ~= 0 then
              (table.insert)(list, {roleId = roleId, skillId = skillId, canClick = false})
              -- DECOMPILER ERROR at PC113: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_22_0
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
            end
          end
          ;
          ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
          ;
          (self._frame):FireEvent("ChangeAutoSkill", nil)
        else
          do
            for i,v in ipairs(self._entityList) do
              -- DECOMPILER ERROR at PC143: Confused about usage of register: R10 in 'UnsetPending'

              if v:GetEntityId() == entitiId then
                if v:GetConfigId() == (autoBattle.orderSKill).roleId then
                  (autoBattle.orderSKill).roleId = 0
                  -- DECOMPILER ERROR at PC145: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  (autoBattle.orderSKill).skillId = 0
                  tag.orderSKill = true
                end
                -- DECOMPILER ERROR at PC154: Confused about usage of register: R10 in 'UnsetPending'

                if v:GetConfigId() == (autoBattle.disorderSkill).roleId then
                  (autoBattle.disorderSkill).roleId = 0
                  -- DECOMPILER ERROR at PC156: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  (autoBattle.disorderSkill).skillId = 0
                  tag.disorderSkill = true
                end
                break
              end
            end
            do
              if tag.orderSKill or tag.disorderSkill then
                self:ResetAutoSkill(tag)
                local autoBattleInfo = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
                -- DECOMPILER ERROR at PC178: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (autoBattleInfo.orderSKill).roleId = (autoBattle.orderSKill).roleId
                -- DECOMPILER ERROR at PC182: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (autoBattleInfo.orderSKill).skillId = (autoBattle.orderSKill).skillId
                -- DECOMPILER ERROR at PC186: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (autoBattleInfo.disorderSkill).roleId = (autoBattle.disorderSkill).roleId
                -- DECOMPILER ERROR at PC190: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (autoBattleInfo.disorderSkill).skillId = (autoBattle.disorderSkill).skillId
                local list = {}
                if (autoBattle.orderSKill).skillId ~= 0 then
                  (table.insert)(list, {roleId = (autoBattle.orderSKill).roleId, skillId = (autoBattle.orderSKill).skillId, canClick = false})
                  -- DECOMPILER ERROR at PC226: Confused about usage of register: R7 in 'UnsetPending'

                  ;
                  (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_22_1
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
                end
                if (autoBattle.disorderSkill).skillId ~= 0 then
                  (table.insert)(list, {roleId = (autoBattle.disorderSkill).roleId, skillId = (autoBattle.disorderSkill).skillId, canClick = false})
                  -- DECOMPILER ERROR at PC261: Confused about usage of register: R7 in 'UnsetPending'

                  ;
                  (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_22_2
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
                end
                ;
                ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
                ;
                (self._frame):FireEvent("ChangeAutoSkill", nil)
              end
              do
                if (self._rightHpCells)[entitiId] then
                  if ((self._rightHpCells)[entitiId])._progressBar then
                    (((self._rightHpCells)[entitiId])._progressBar):SetFirstValue(0)
                    ;
                    (((self._rightHpCells)[entitiId])._progressBar):SetSecondValue(0)
                  else
                    ;
                    (((self._rightHpCells)[entitiId])._greenProgressBar):SetFillAmount(0)
                  end
                  if ((self._rightHpCells)[entitiId])._hpCurrent then
                    (((self._rightHpCells)[entitiId])._hpCurrent):SetText(0)
                  end
                  ;
                  ((self._rightHpCells)[entitiId]):Show(false)
                  -- DECOMPILER ERROR at PC318: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  (self._rightHpCells)[entitiId] = nil
                  -- DECOMPILER ERROR at PC320: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  (self._rightHpCellsVisibleCount)[entitiId] = nil
                end
                if (self._summonHpCells)[entitiId] then
                  if (notification.userInfo).damageNum ~= 0 then
                    (((self._summonHpCells)[entitiId])._greenProgressBar):SetFillAmount(0)
                  end
                  ;
                  ((self._summonHpCells)[entitiId]):Show(false)
                  ;
                  ((self._summonHpCells)[entitiId]):Destroy()
                  -- DECOMPILER ERROR at PC345: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  (self._summonHpCells)[entitiId] = nil
                  -- DECOMPILER ERROR at PC347: Confused about usage of register: R3 in 'UnsetPending'

                  ;
                  (self._summonHpCellsVisibleCount)[entitiId] = nil
                end
              end
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.ResetAutoSkill = function(self, tag)
  -- function num : 0_23 , upvalues : _ENV, CCostSkillTable
  local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
  local yellow = {cost = 10000, skillId = 0, roleId = 0}
  local purple = {cost = 10000, skillId = 0, roleId = 0}
  for i,v in ipairs(self._entityList) do
    if (self._leftHpCells)[v:GetEntityId()] then
      for index,skillId in ipairs(v:GetSkillList()) do
        local skillCostRecord = (CCostSkillTable:GetRecorder(skillId))
        local func1, func2, func1para, func2para = nil, nil, nil, nil
        do
          if skillCostRecord.pureCost ~= "" then
            local rec = (string.split)(skillCostRecord.pureCost, ";")
            func1 = self:GetFunction(rec[1])
            func2 = self:GetFunction(rec[2])
          end
          do
            if tag.orderSKill then
              local cost = nil
              if skillCostRecord.OrderCost ~= 0 then
                cost = skillCostRecord.OrderCost
              else
                if func1 and tonumber(func1(0)) ~= 0 then
                  if func1para == "orderpwr" then
                    cost = tonumber(func1(0))
                  else
                    if func1para == "chaospwr" then
                      cost = tonumber(func1(0))
                    else
                      if func1para == "chaoscostreduce" then
                        cost = tonumber(func1(v:GetskillPowerCostReduceChaos()))
                      else
                        if func1para == "ordercostreduce" then
                          cost = tonumber(func1(v:GetskillPowerCostReduceOrder()))
                        end
                      end
                    end
                  end
                end
              end
              if cost and cost < yellow.cost then
                yellow.cost = cost
                yellow.skillId = skillId
                yellow.roleId = v:GetConfigId()
              end
            end
            do
              if tag.disorderSkill then
                local cost = nil
                if skillCostRecord.ChaosCost ~= 0 then
                  cost = skillCostRecord.ChaosCost
                else
                  if func2 and tonumber(func2(0)) ~= 0 then
                    if func2para == "orderpwr" then
                      cost = tonumber(func2(0))
                    else
                      if func2para == "chaospwr" then
                        cost = tonumber(func2(0))
                      else
                        if func2para == "chaoscostreduce" then
                          cost = tonumber(func2(v:GetskillPowerCostReduceChaos()))
                        else
                          if func2para == "ordercostreduce" then
                            cost = tonumber(func2(v:GetskillPowerCostReduceOrder()))
                          end
                        end
                      end
                    end
                  end
                end
                if cost and cost < purple.cost then
                  purple.cost = cost
                  purple.skillId = skillId
                  purple.roleId = v:GetConfigId()
                end
              end
              -- DECOMPILER ERROR at PC181: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC181: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC190: Confused about usage of register: R5 in 'UnsetPending'

  if yellow.cost ~= 10000 then
    (autoBattle.orderSKill).roleId = yellow.roleId
    -- DECOMPILER ERROR at PC193: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (autoBattle.orderSKill).skillId = yellow.skillId
  end
  -- DECOMPILER ERROR at PC199: Confused about usage of register: R5 in 'UnsetPending'

  if purple.cost ~= 10000 then
    (autoBattle.disorderSkill).roleId = purple.roleId
    -- DECOMPILER ERROR at PC202: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (autoBattle.disorderSkill).skillId = purple.skillId
  end
end

BattleNewMainDialog.OnSkillSuccess = function(self, notification)
  -- function num : 0_24 , upvalues : _ENV, CBattleConfig, PowerAccumulateStateType, UIManager
  local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
  local leftBefore = (notification.userInfo).redcurrent + (notification.userInfo).redchange
  local leftBeforePower = leftBefore // tonumber((CBattleConfig:GetRecorder(1)).attr)
  local leftCurrentPower = (notification.userInfo).redcurrent // tonumber((CBattleConfig:GetRecorder(1)).attr)
  local rightBefore = (notification.userInfo).bluecurrent + (notification.userInfo).bluechange
  local rightBeforePower = rightBefore // tonumber((CBattleConfig:GetRecorder(2)).attr)
  local rightCurrentPower = (notification.userInfo).bluecurrent // tonumber((CBattleConfig:GetRecorder(2)).attr)
  -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

  if battleID == 1120 and leftCurrentPower ~= leftBeforePower then
    for i = leftCurrentPower + 1, leftBeforePower do
      ((self._alonePowerEffect)[i]):SetActive(true)
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R13 in 'UnsetPending'

      if (self._alonePowerEffectHandlers)[i] == 0 then
        (self._alonePowerEffectHandlers)[i] = ((self._alonePowerEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1048))
      end
    end
  end
  do
    if leftCurrentPower ~= leftBeforePower then
      for i = leftCurrentPower + 1, leftBeforePower do
        ((self._leftPowerEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R13 in 'UnsetPending'

        if (self._leftPowerEffectHandlers)[i] == 0 then
          (self._leftPowerEffectHandlers)[i] = ((self._leftPowerEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1049))
        end
      end
    end
    do
      if rightCurrentPower ~= rightBeforePower then
        for i = rightCurrentPower + 1, rightBeforePower do
          ((self._rightPowerEffect)[i]):SetActive(true)
          -- DECOMPILER ERROR at PC130: Confused about usage of register: R13 in 'UnsetPending'

          if (self._rightPowerEffectHandlers)[i] == 0 then
            (self._rightPowerEffectHandlers)[i] = ((self._rightPowerEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1050))
          end
        end
      end
      do
        if self._breakOutPowerUnlockState and self._breakOutPowerState ~= PowerAccumulateStateType.Drain and rightCurrentPower ~= rightBeforePower then
          do
            if not self._rightPowerImgGridsBaseCell then
              local dialogDefine = require("logic.dialog.newbattle.rightpowerimggridflyeffectcell")
              self._rightPowerImgGridsBaseCell = (UIManager.CreateLuaWindow)(dialogDefine.AssetBundleName .. ".assetbundle", dialogDefine.AssetName, (self._normalProgress)._uiObject)
              ;
              (self._rightPowerImgGridsBaseCell):SetPosition(0, 0, 0, -10000)
              self._rightPowerImgGridsBaseCellSizeX = (self._rightPowerImgGridsBaseCell):GetRectSize()
            end
            for i = rightCurrentPower + 1, rightBeforePower do
              local first = {xValue = ((self._rightPowerImgGridsPosition)[i]).x + self._rightPowerImgGridsSizeX / 2, yValue = ((self._rightPowerImgGridsPosition)[i]).y + self._rightPowerImgGridsSizeY / 2}
              local last = {xValue = (self._breakOutPowerBtnPosition).x + self._breakOutPowerBtnSizeX / 2 - self._rightPowerImgGridsBaseCellSizeX / 2, yValue = (self._breakOutPowerBtnPosition).y + self._breakOutPowerBtnSizeY / 2 - self._rightPowerImgGridsBaseCellSizeY / 2}
              ;
              (table.insert)(self._rightPowerImgGridsFlyTask, (Tween.new)(tonumber((CBattleConfig:GetRecorder(100)).attr), first, last, (CBattleConfig:GetRecorder(101)).attr))
              ;
              (table.insert)(self._rightPowerImgGridsFlyEffect, (DialogManager.CopyDialog)("newbattle.rightpowerimggridflyeffectcell", (self._rightPowerImgGridsBaseCell)._uiObject, (self._normalProgress)._uiObject))
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnSkillFail = function(self, notification)
  -- function num : 0_25
  (self._frame):FireEvent("ShowSkillCard", notification.userInfo)
end

BattleNewMainDialog.OnSupportRoleUsed = function(self, notification)
  -- function num : 0_26 , upvalues : _ENV
  self._leftAssistNum = self._leftAssistNum - (notification.userInfo).count
  ;
  (self._supportRoleNum):SetText(tostring(self._leftAssistNum) .. "/" .. tostring(self._totalAssistNum))
end

BattleNewMainDialog.OnRoleEquipSkillUsed = function(self, notification)
  -- function num : 0_27
end

BattleNewMainDialog.ShouldLengthChange = function(self)
  -- function num : 0_28
  return true
end

BattleNewMainDialog.DestroyBossHPBar = function(self, entityid)
  -- function num : 0_29
  if (self._hpCells)[entityid] then
    ((self._hpCells)[entityid]):Destroy()
  end
end

BattleNewMainDialog.OnHPCellVisibleChange = function(self, notification)
  -- function num : 0_30
  local entityid = (notification.userInfo).entityid
  local visible = (notification.userInfo).visible
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  if not (self._leftHpCellsVisibleCount)[entityid] then
    (self._leftHpCellsVisibleCount)[entityid] = not (self._leftHpCells)[entityid] or 0
    do
      local preLeftHpCellsVisibleCount = (self._leftHpCellsVisibleCount)[entityid]
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

      if visible == 1 then
        (self._leftHpCellsVisibleCount)[entityid] = (self._leftHpCellsVisibleCount)[entityid] + 1
      else
        -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

        if visible == 0 then
          (self._leftHpCellsVisibleCount)[entityid] = (self._leftHpCellsVisibleCount)[entityid] - 1
        end
      end
      -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

      if (self._leftHpCellsVisibleCount)[entityid] >= 0 and preLeftHpCellsVisibleCount < 0 then
        ((self._leftHpCells)[entityid]):Show(true)
      end
      if (self._leftHpCellsVisibleCount)[entityid] < 0 and preLeftHpCellsVisibleCount >= 0 then
        ((self._leftHpCells)[entityid]):Show(false, true)
      end
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

      if not (self._summonHpCellsVisibleCount)[entityid] then
        (self._summonHpCellsVisibleCount)[entityid] = not (self._summonHpCells)[entityid] or 0
        do
          local preSummonHpCellsVisibleCount = (self._summonHpCellsVisibleCount)[entityid]
          -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

          if visible == 1 then
            (self._summonHpCellsVisibleCount)[entityid] = (self._summonHpCellsVisibleCount)[entityid] + 1
          else
            -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

            if visible == 0 then
              (self._summonHpCellsVisibleCount)[entityid] = (self._summonHpCellsVisibleCount)[entityid] - 1
            end
          end
          -- DECOMPILER ERROR at PC94: Unhandled construct in 'MakeBoolean' P1

          if (self._summonHpCellsVisibleCount)[entityid] >= 0 and preSummonHpCellsVisibleCount < 0 then
            ((self._summonHpCells)[entityid]):Show(true)
          end
          if (self._summonHpCellsVisibleCount)[entityid] < 0 and preSummonHpCellsVisibleCount >= 0 then
            ((self._summonHpCells)[entityid]):Show(false, true)
          end
          -- DECOMPILER ERROR at PC118: Confused about usage of register: R4 in 'UnsetPending'

          if not (self._rightHpCellsVisibleCount)[entityid] then
            (self._rightHpCellsVisibleCount)[entityid] = not (self._rightHpCells)[entityid] or 0
            local preLeftHpCellsVisibleCount = (self._rightHpCellsVisibleCount)[entityid]
            -- DECOMPILER ERROR at PC127: Confused about usage of register: R5 in 'UnsetPending'

            if visible == 1 then
              (self._rightHpCellsVisibleCount)[entityid] = (self._rightHpCellsVisibleCount)[entityid] + 1
            else
              -- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

              if visible == 0 then
                (self._rightHpCellsVisibleCount)[entityid] = (self._rightHpCellsVisibleCount)[entityid] - 1
              end
            end
            -- DECOMPILER ERROR at PC146: Unhandled construct in 'MakeBoolean' P1

            if (self._rightHpCellsVisibleCount)[entityid] >= 0 and preLeftHpCellsVisibleCount < 0 then
              ((self._rightHpCells)[entityid]):Show(true)
            end
            if (self._rightHpCellsVisibleCount)[entityid] < 0 and preLeftHpCellsVisibleCount >= 0 then
              ((self._rightHpCells)[entityid]):Show(false, true)
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.RecycleDamageNumCell = function(self, cell)
  -- function num : 0_31 , upvalues : _ENV
  (table.insert)(self._recycleList, cell._dialogKey)
end

BattleNewMainDialog.GetDamageNumCell = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local count = #self._recycleList
  local dialogKey = (self._recycleList)[count]
  local cell = nil
  if dialogKey then
    cell = (self._damageCells)[dialogKey]
    ;
    (table.remove)(self._recycleList, count)
    if not cell then
      LogError("DamageNumCells management failed.")
    end
  end
  if not cell then
    cell = (DialogManager.CopyDialog)("newbattle.damagenumcell", (self._baseDamageNumCell)._uiObject, (self._damageParent)._uiObject)
    cell:SetDelegate(self)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._damageCells)[cell._dialogKey] = cell
  end
  return cell
end

BattleNewMainDialog.OnHPChanged = function(self, notification)
  -- function num : 0_33 , upvalues : _ENV
  local battler = (notification.userInfo).battler
  local damageType = (notification.userInfo).damageType
  local hpChanged = (notification.userInfo).hpChanged
  local skillid = (notification.userInfo).skillid
  local realHpChanged = (notification.userInfo).realHpChanged
  local cell = self:GetDamageNumCell()
  cell:Refresh(battler, damageType, hpChanged, skillid)
  if hpChanged < 0 and battler:IsRightCamp() then
    local entityId = battler:GetEntityId()
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._totalNumForSecondHurt)[entityId] = (self._totalNumForSecondHurt)[entityId] or 0
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._totalNumForSecondHurt)[entityId] = (self._totalNumForSecondHurt)[entityId] + (math.abs)(hpChanged)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._totalTimeForSecondHurt)[entityId] = (self._totalTimeForSecondHurt)[entityId] or 1
    if self._breakOutPowerTotalDamageNum then
      self._breakOutPowerTotalDamageNum = self._breakOutPowerTotalDamageNum + (math.abs)(hpChanged)
      ;
      (self._breakOutPowerTotalDamageNumTxt):SetText(self._breakOutPowerTotalDamageNum)
      ;
      (self._breakOutPowerTotalDamageNumEffect):SetAnchorAndOffset(0, self._breakOutPowerTotalDamageNumEffectAnchorMinY, 1, self._breakOutPowerTotalDamageNumEffectAnchorMaxY, self._breakOutPowerTotalDamageNumTxtRectX - (self._breakOutPowerTotalDamageNumTxt):GetPreferredSize(), self._breakOutPowerTotalDamageNumEffectOffsetMinY, 0, self._breakOutPowerTotalDamageNumEffectOffsetMaxY)
      if self._battleEnergyCountAnimationIsEnd then
        self._battleEnergyCountAnimationIsEnd = false
        ;
        (self._breakOutPowerTotalDamagePanel):PlayAnimation("BattleEnergyCount")
      end
    end
    cell = nil
    if (self._leftHpCells)[entityId] then
      cell = (self._leftHpCells)[entityId]
    else
      if (self._rightHpCells)[entityId] then
        cell = (self._rightHpCells)[entityId]
      else
        if (self._summonHpCells)[entityId] then
          cell = (self._summonHpCells)[entityId]
        end
      end
    end
    if cell and cell.RefreshSecondHurtNum then
      cell:RefreshSecondHurtNum((math.ceil)((self._totalNumForSecondHurt)[entityId] / (self._totalTimeForSecondHurt)[entityId]), (self._totalNumForSecondHurt)[entityId])
    end
    if self._isSpring then
      self._totalDamage = self._totalDamage + (math.abs)(realHpChanged)
      ;
      (self._newYearBattleCountText):SetText((NumberManager.GetSpringBattleDamageShowNumber)(self._totalDamage))
    end
  end
end

BattleNewMainDialog.OnDamageMiss = function(self, notification)
  -- function num : 0_34
  local battler = (notification.userInfo).battler
  local damageType = (notification.userInfo).damageType
  local cell = self:GetDamageNumCell()
  cell:Refresh(battler, damageType)
end

BattleNewMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_35
  return #self._entityList
end

BattleNewMainDialog.CellAtIndex = function(self, frame)
  -- function num : 0_36
  return "newbattle.battleskillcell"
end

BattleNewMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_37
  return (self._entityList)[index]
end

BattleNewMainDialog.OnPauseBtnClick = function(self)
  -- function num : 0_38 , upvalues : _ENV, SoundLevelTable
  local postguide1003 = self._pauseGuideState
  if self._pauseGuideState then
    self._pauseGuideState = false
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
  end
  if not self._playingBattleEndAnimation then
    LogInfo("BattleNewMainDialog", "OnPauseBtnClick and not self._playingBattleEndAnimation")
    local dialog = (DialogManager.CreateSingletonDialog)("newbattle.battlepausedialog")
    if dialog then
      dialog:SetData(((NekoData.BehaviorManager).BM_Battle):GetBattleId())
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattlePause()
    local categoryRecord = SoundLevelTable:GetRecorder(4)
    if categoryRecord then
      (LuaAudioManager.PauseCategory)(tonumber(categoryRecord.categoryID), true)
    end
    ;
    (self._frame):FireEvent("ChangeLittleCharRaycastTarget", true)
    self._pause = true
  end
  do
    if postguide1003 then
      (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1003, self, 2)
    end
  end
end

BattleNewMainDialog.OnEnemyDetailBtnClick = function(self)
  -- function num : 0_39 , upvalues : _ENV, SoundLevelTable
  if not self._playingBattleEndAnimation then
    LogInfo("BattleNewMainDialog", "OnEnemyDetailBtnClick and not self._playingBattleEndAnimation")
    local dialog = (DialogManager.CreateSingletonDialog)("newbattle.battlepausedialog")
    if dialog then
      dialog:SetData(((NekoData.BehaviorManager).BM_Battle):GetBattleId(), "enemyinfo")
    end
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattlePause()
    local categoryRecord = SoundLevelTable:GetRecorder(4)
    if categoryRecord then
      (LuaAudioManager.PauseCategory)(tonumber(categoryRecord.categoryID), true)
    end
    ;
    (self._frame):FireEvent("ChangeLittleCharRaycastTarget", true)
    self._pause = true
  end
end

BattleNewMainDialog.OnLeaveBtnClick = function(self)
  -- function num : 0_40 , upvalues : _ENV
  self:OnPauseBtnClick()
  local dialog = (DialogManager.GetDialog)("newbattle.battlepausedialog")
  if dialog then
    dialog:OnLeaveBtnClick()
  end
end

BattleNewMainDialog.OnApplicationPause = function(self, notification)
  -- function num : 0_41 , upvalues : _ENV
  local value = notification.userInfo
  if value and not (DialogManager.GetDialog)("newbattle.battleteachguidedialog") and not (DialogManager.GetDialog)("guide.guidedialoginbattle") and not (DialogManager.GetDialog)("newbattle.battlepausedialog") then
    (DialogManager.DestroySingletonDialog)("newbattle.battlecountdowndialog")
    self:OnPauseBtnClick()
  end
end

BattleNewMainDialog.OnDetailBtnClick = function(self)
  -- function num : 0_42 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battledetaildialog")
  if not dialog then
    ((DialogManager.CreateSingletonDialog)("newbattle.battledetaildialog")):SetData()
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattlePause()
  end
end

BattleNewMainDialog.OnGMBtnClick = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("debug.battlegmdialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("debug.battlegmdialog")
  else
    ;
    ((DialogManager.CreateSingletonDialog)("debug.battlegmdialog")):SetData({selfInvinvible = (self._battleWorld):GetIsLeftGMInvincible(), enemyInvinvible = (self._battleWorld):GetIsRightGMInvincible()})
  end
end

BattleNewMainDialog.OnSupportRoleClick = function(self)
  -- function num : 0_44 , upvalues : _ENV
  if not self._playingBattleEndAnimation and not self._pause and not self._useSupportRole and self._leftAssistNumBegin == self._leftAssistNum then
    self._useSupportRole = true
    ;
    (self:GetRootWindow()):PlayAnimation("BattleAssistShake")
    local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cpartner")
    ;
    ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(protocol)
  end
  do
    ;
    (DialogManager.DestroySingletonDialog)("newbattle.battleroleskillsdetaildialog")
  end
end

BattleNewMainDialog.OnWinRetreatBtnClick = function(self)
  -- function num : 0_45 , upvalues : _ENV, BattleEndType
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
  protocol.type = BattleEndType.LeftWinCBattleKill
  ;
  ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(protocol)
end

BattleNewMainDialog.OnLoseRetreatBtnClick = function(self)
  -- function num : 0_46 , upvalues : _ENV, BattleEndType
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
  protocol.type = BattleEndType.RightWinCBattleKill
  ;
  ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(protocol)
end

BattleNewMainDialog.OnWinSkipBtnClick = function(self)
  -- function num : 0_47 , upvalues : _ENV, BattleEndType
  local protocol = (BattleClientProtocolManager.CreateProtocol)("action.cbattlekill")
  protocol.type = BattleEndType.SkipWin
  ;
  ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(protocol)
end

BattleNewMainDialog.OnAutoBtnClick = function(self)
  -- function num : 0_48 , upvalues : _ENV, AutoBattleModeType
  if not self._playingBattleEndAnimation and ((NekoData.BehaviorManager).BM_Dungeon):GetMode() ~= "auto" then
    if not self._pause then
      (self._autoBtn):SetActive(false)
      ;
      (self._autoCancelBtn):SetActive(true)
      if self._autoCancelBtnEffectHandler then
        (self._autoCancelBtnEffect):ReleaseEffect(self._autoCancelBtnEffectHandler)
        self._autoCancelBtnEffectHandler = nil
      end
      self._autoCancelBtnEffectHandler = (self._autoCancelBtnEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1032))
      local tag = {}
      ;
      (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight = 1
      ;
      (self._frame):FireEvent("ChangeAutoSkill", nil)
      if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Default then
        (self._defaultModeAutoBattlePanel):SetActive(true)
      end
    else
      do
        ;
        (DialogManager.DestroySingletonDialog)("newbattle.battleroleskillsdetaildialog")
        if self._autoBattleGuideState then
          self._autoBattleGuideState = false
          ;
          ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
          ;
          ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
        end
      end
    end
  end
end

BattleNewMainDialog.OnAutoCancelBtnClick = function(self)
  -- function num : 0_49 , upvalues : _ENV, AutoBattleModeType
  if not self._playingBattleEndAnimation and ((NekoData.BehaviorManager).BM_Dungeon):GetMode() ~= "auto" then
    if not self._pause then
      if self._autoCancelBtnEffectHandler then
        (self._autoCancelBtnEffect):ReleaseEffect(self._autoCancelBtnEffectHandler)
        self._autoCancelBtnEffectHandler = nil
      end
      ;
      (self._autoBtn):SetActive(true)
      ;
      (self._autoCancelBtn):SetActive(false)
      ;
      (((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()).autoFight = 0
      ;
      (self._frame):FireEvent("ChangeAutoSkill", nil)
      if ((NekoData.BehaviorManager).BM_Game):GetAutoBattleMode() == AutoBattleModeType.Default then
        (self._defaultModeAutoBattlePanel):SetActive(false)
      end
    else
      ;
      (DialogManager.DestroySingletonDialog)("newbattle.battleroleskillsdetaildialog")
    end
  end
  if self._autoBattleGuideState then
    LogWarning("BattleNewMainDialog", "自动战斗引导点击Auto按钮结束，但是此处是取消自动战斗状态")
    self._autoBattleGuideState = false
    ;
    ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
  end
end

BattleNewMainDialog.OnSpeedBtnClick = function(self)
  -- function num : 0_50 , upvalues : _ENV, CBattleConfig, GuidTypes
  if not self._playingBattleEndAnimation and ((NekoData.BehaviorManager).BM_Dungeon):GetMode() ~= "auto" then
    if not self._pause then
      local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetAutoBattleInfo()
      if (self._speedBtn):IsSelected() then
        ((NekoData.DataManager).DM_TimeScale):SetBattleNormalSpeed()
        ;
        (self._speedBtn):SetSelected(false)
        autoBattle.speed = 1
        if self._speedBtnEffectHandler then
          (self._speedBtnEffect):ReleaseEffect(self._speedBtnEffectHandler)
          self._speedBtnEffectHandler = nil
        end
      else
        ;
        ((NekoData.DataManager).DM_TimeScale):SetBattleNTimesSpeed()
        ;
        (self._speedBtn):SetSelected(true)
        autoBattle.speed = tonumber((CBattleConfig:GetRecorder(85)).attr)
        if self._speedBtnEffectHandler then
          (self._speedBtnEffect):ReleaseEffect(self._speedBtnEffectHandler)
          self._speedBtnEffectHandler = nil
        end
        self._speedBtnEffectHandler = (self._speedBtnEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1032))
      end
    else
      do
        ;
        (DialogManager.DestroySingletonDialog)("newbattle.battleroleskillsdetaildialog")
        if self._battleSpeedGuideState then
          self._battleSpeedGuideState = false
          ;
          ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
          ;
          ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
          ;
          ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuidTypes.BATTLE_2X, 1)
        end
      end
    end
  end
end

BattleNewMainDialog.OnBreakOutPowerBtnClick = function(self)
  -- function num : 0_51 , upvalues : PowerAccumulateStateType, _ENV
  if self._breakOutPowerState == PowerAccumulateStateType.Full and self._breakOutPowerUnlockState then
    if self._breakOutPowerGuideState then
      self._breakOutPowerGuideState = false
      ;
      ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
    end
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
    local creq = (BattleClientProtocolManager.CreateProtocol)("action.cbreakoutpower")
    ;
    ((NekoData.BehaviorManager).BM_Battle):SendProtocolToLogicWorld(creq)
    ;
    (self._breakOutPowerEnergyFullEffect):SetActive(false)
  end
end

BattleNewMainDialog.RefreshTeamElementInfo = function(self)
  -- function num : 0_52 , upvalues : _ENV, LineUpStation, CElementEffect, CImagePathTable, CBossNianPart, CBattleStartProtocol
  local teamId = ((NekoData.BehaviorManager).BM_SBattleStart):GetLineId()
  local currentTeamRoleList = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(teamId)
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station,roleId in pairs(currentTeamRoleList) do
    if roleId ~= 0 then
      haveTeamInfo = true
      stationElementTag[station] = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleId)):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        (table.insert)(etherStationList, station)
      end
    end
  end
  if not haveTeamInfo then
    currentTeamRoleList = ((NekoData.BehaviorManager).BM_SBattleStart):GetLeftRoleMap()
    for station,v in pairs(currentTeamRoleList) do
      local roleId = v.id
      if roleId ~= 0 then
        stationElementTag[station] = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleId)):GetElement()
        if stationElementTag[station] == ElementType.Ether then
          (table.insert)(etherStationList, station)
        end
      end
    end
  end
  do
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _,station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    else
      do
        if stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
          for _,station in ipairs(etherStationList) do
            stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
          end
        else
          do
            if stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
              for _,station in ipairs(etherStationList) do
                stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
              end
            else
              do
                if stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
                  for _,station in ipairs(etherStationList) do
                    stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
                  end
                else
                  do
                    if stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
                      for _,station in ipairs(etherStationList) do
                        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
                      end
                    else
                      do
                        if stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
                          for _,station in ipairs(etherStationList) do
                            stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
                          end
                        end
                        do
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
                            if not CImagePathTable:GetRecorder(elementRecord.image) then
                              local imgRecord = DataCommon.DefaultImageAsset
                            end
                            ;
                            (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                          else
                            do
                              local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
                              do
                                if not CImagePathTable:GetRecorder(elementRecord.image) then
                                  local imgRecord = DataCommon.DefaultImageAsset
                                end
                                ;
                                (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                                local battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
                                local bossRecorder = CBossNianPart:GetRecorderByValue("battleId", battleID)
                                self._extraElemenEffect = {}
                                -- DECOMPILER ERROR at PC287: Confused about usage of register: R10 in 'UnsetPending'

                                if bossRecorder and bossRecorder.teamBuffTextID ~= -1 then
                                  (self._extraElemenEffect).type = CBattleStartProtocol.SPRING_FESTIVAL
                                  -- DECOMPILER ERROR at PC294: Confused about usage of register: R10 in 'UnsetPending'

                                  ;
                                  (self._extraElemenEffect).str = (TextManager.GetText)(bossRecorder.teamBuffTextID, bossRecorder.teamBuffValue1)
                                  -- DECOMPILER ERROR at PC297: Confused about usage of register: R10 in 'UnsetPending'

                                  ;
                                  (self._extraElemenEffect).icon = bossRecorder.bossWeakIcon
                                  -- DECOMPILER ERROR at PC306: Confused about usage of register: R10 in 'UnsetPending'

                                  if self._elementStage == 2 and self._oneTotalElementValue == bossRecorder.element then
                                    (self._extraElemenEffect).enable = true
                                  end
                                end
                                -- DECOMPILER ERROR at PC319: Confused about usage of register: R10 in 'UnsetPending'

                                if self._inWeekBoss and ((NekoData.BehaviorManager).BM_WeekBoss):GetTeamAddtion() then
                                  (self._extraElemenEffect).type = CBattleStartProtocol.WEEK_BOSS
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnElementBtnClick = function(self)
  -- function num : 0_53 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("teamedit.teamelementinfodialog")):SetData(self._oneTotalElementValue, self._elementStage, self._extraElemenEffect)
end

BattleNewMainDialog.PlayBattleEndAnimation = function(self, protocol)
  -- function num : 0_54 , upvalues : _ENV, BattleEndType
  if not self._playingBattleEndAnimation then
    (DialogManager.DestroySingletonDialog)("newbattle.battlepausedialog")
    if self._autoCancelBtnEffectHandler then
      (self._autoCancelBtnEffect):ReleaseEffect(self._autoCancelBtnEffectHandler)
      self._autoCancelBtnEffectHandler = nil
    end
    if self._speedBtnEffectHandler then
      (self._speedBtnEffect):ReleaseEffect(self._speedBtnEffectHandler)
      self._speedBtnEffectHandler = nil
    end
    if protocol.type == BattleEndType.LeftWinCBattleKill or protocol.type == BattleEndType.SkipWin or protocol.type == BattleEndType.LeftWin then
      (self:GetRootWindow()):PlayAnimation("BattleEndWin")
      for k,v in pairs(self._leftHpCells) do
        ((self._leftHpCells)[k]):Show(false)
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._leftHpCells)[k] = nil
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._leftHpCellsVisibleCount)[k] = nil
      end
    else
      do
        if protocol.type == BattleEndType.LeftWinCBattleKill or protocol.type == BattleEndType.SkipWin or protocol.type == BattleEndType.RightWin or protocol.type == BattleEndType.RightWinOverTime then
          (self:GetRootWindow()):PlayAnimation("BattleEnd")
        end
        self._playingBattleEndAnimation = true
        ;
        (self._frame):FireEvent("ChangeSkillAutoEffectState", false)
      end
    end
  end
end

BattleNewMainDialog.SetGuideFrame = function(self, guideParam, guideId, direction, wordId)
  -- function num : 0_55 , upvalues : GuideTimeType, _ENV
  local guideUI = nil
  if guideParam.guideTimeType == GuideTimeType.PowerFirstFull then
    if guideParam.stage == 1 then
      guideUI = self._pauseBtnGuide
      self._pauseGuideState = true
    else
      guideUI = self._breakOutPowerGuide
      self._breakOutPowerGuideState = true
    end
  else
    -- DECOMPILER ERROR at PC21: Unhandled construct in 'MakeBoolean' P1

    if guideParam.guideTimeType == GuideTimeType.AutoBattleGuide and guideParam.stage == 1 then
      guideUI = self._autoBtnGuide
      self._autoBattleGuideState = true
    end
  end
  if guideParam.guideTimeType == GuideTimeType.BattleSpeedGuide and guideParam.stage == 1 then
    guideUI = self._speedBtnGuide
    self._battleSpeedGuideState = true
  end
  if guideUI then
    ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(guideId, function()
    -- function num : 0_55_0 , upvalues : guideUI
    local width, height = guideUI:GetRectSize()
    local screenPos = guideUI:GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_55_1 , upvalues : guideUI, guideParam, GuideTimeType
    local width, height = guideUI:GetRectSize()
    local screenPos = guideUI:GetLocalPointInUiRootPanel()
    local posX = screenPos.x
    if guideParam.guideTimeType == GuideTimeType.PowerFirstFull then
      posX = posX - 218
    end
    return {width = width, height = height, posX = posX, posY = screenPos.y}
  end
, direction, wordId)
    ;
    ((NekoData.DataManager).DM_TimeScale):SetBattleGuidePause()
  end
end

BattleNewMainDialog.ChangeAutoBattleSkills = function(self)
  -- function num : 0_56 , upvalues : _ENV, PowerAccumulateStateType, CBattleConfig
  local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
  local list = {}
  if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
    for roleId,skillId in pairs(autoBattle.eruptSkill) do
      if skillId ~= 0 then
        (table.insert)(list, {roleId = roleId, skillId = skillId, canClick = false})
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_56_0
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
      end
    end
  else
    do
      if (autoBattle.orderSKill).skillId ~= 0 then
        (table.insert)(list, {roleId = (autoBattle.orderSKill).roleId, skillId = (autoBattle.orderSKill).skillId, canClick = false})
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_56_1
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
      end
      if (autoBattle.disorderSkill).skillId ~= 0 then
        (table.insert)(list, {roleId = (autoBattle.disorderSkill).roleId, skillId = (autoBattle.disorderSkill).skillId, canClick = false})
        -- DECOMPILER ERROR at PC115: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_56_2
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
      end
      ;
      ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
      ;
      (self._frame):FireEvent("ChangeAutoSkill", nil)
    end
  end
end

BattleNewMainDialog.OnBuffsUpdate = function(self, notification)
  -- function num : 0_57 , upvalues : _ENV
  if not (self._leftHpCells)[(notification.userInfo).entityid] and not (self._rightHpCells)[(notification.userInfo).entityid] then
    local cell = (self._summonHpCells)[(notification.userInfo).entityid]
  end
  if cell then
    cell:RefreshBuffs(notification.userInfo)
    ;
    ((NekoData.BehaviorManager).BM_Battle):RecordEntityBuff(notification.userInfo)
  end
end

BattleNewMainDialog.GetFunction = function(self, funcStr)
  -- function num : 0_58 , upvalues : _ENV
  if (string.find)(funcStr, "orderpwr") then
    local str = "return function(orderpwr) return " .. funcStr .. " end"
    return (assert(load(str)))(), "orderpwr"
  else
    do
      if (string.find)(funcStr, "chaoscostreduce") then
        local str = "return function(chaoscostreduce) return " .. funcStr .. " end"
        return (assert(load(str)))(), "chaoscostreduce"
      else
        do
          if (string.find)(funcStr, "ordercostreduce") then
            local str = "return function(ordercostreduce) return " .. funcStr .. " end"
            return (assert(load(str)))(), "ordercostreduce"
          else
            do
              if (string.find)(funcStr, "chaospwr") then
                local str = "return function(chaospwr) return " .. funcStr .. " end"
                return (assert(load(str)))(), "chaospwr"
              end
            end
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnFillInBattlePower = function(self, notification)
  -- function num : 0_59 , upvalues : _ENV, CBattleConfig
  if self._magicSurgeEffectHandler then
    (self._magicSurgeEffect):ReleaseEffect(self._magicSurgeEffectHandler)
    self._magicSurgeEffectHandler = nil
  end
  if not self._magicSurgeEffectHandler then
    self._magicSurgeEffectHandler = (self._magicSurgeEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1051))
  end
  self._breakOutPowerShow = true
  local redPower = (fixedpoint.tonumber)((notification.userInfo).curRedPower)
  local attr1 = tonumber((CBattleConfig:GetRecorder(1)).attr)
  if redPower % attr1 > 0 then
    redPower = redPower / attr1
  else
    redPower = redPower // attr1
  end
  local first = {value = redPower}
  local last = {value = tonumber((CBattleConfig:GetRecorder(8)).attr)}
  self._breakOutRedPowerIncreaseTask = (Tween.new)(tonumber((CBattleConfig:GetRecorder(88)).attr) / 30, first, last, "linear")
  local bluePower = (fixedpoint.tonumber)((notification.userInfo).curBluePower)
  local attr2 = tonumber((CBattleConfig:GetRecorder(2)).attr)
  if bluePower % attr2 > 0 then
    bluePower = bluePower / attr2
  else
    bluePower = bluePower // attr2
  end
  first = {value = bluePower}
  last = {value = tonumber((CBattleConfig:GetRecorder(9)).attr)}
  self._breakOutBluePowerIncreaseTask = (Tween.new)(tonumber((CBattleConfig:GetRecorder(88)).attr) / 30, first, last, "linear")
end

BattleNewMainDialog.OnBattlePauseStateChange = function(self, notification)
  -- function num : 0_60
  (self._frame):FireEvent("ChangeLittleCharRaycastTarget", notification.userInfo)
end

BattleNewMainDialog.OnAccumulatePowerStateChange = function(self, notification)
  -- function num : 0_61 , upvalues : PowerAccumulateStateType, _ENV, PowerEnergyStateNum, CBattleConfig
  self._breakOutPowerState = (notification.userInfo).state
  if self._breakOutPowerState == PowerAccumulateStateType.Filling then
    if self._cdEndEffectHandler then
      (self._cdEndEffect):ReleaseEffect(self._cdEndEffectHandler)
      self._cdEndEffectHandler = nil
    end
    if not self._cdEndEffectHandler then
      self._cdEndEffectHandler = (self._cdEndEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1108))
    end
  else
    if self._breakOutPowerState == PowerAccumulateStateType.Full then
      (self._breakOutPowerFullUI):SetActive(true)
      ;
      (self._breakOutPowerEnergyFullEffect):SetActive(true)
    else
      if self._breakOutPowerState == PowerAccumulateStateType.Drain then
        self._breakOutPowerTotalDamageNum = nil
        ;
        (self._breakOutPowerTotalDamagePanel):PlayAnimation("BattleEnergyCountHide")
        self._battleEnergyCountAnimationIsEnd = true
        ;
        (self._breakOutPowerEmptyUI):SetActive(true)
        for i = 1, PowerEnergyStateNum do
          ((self._breakOutPowerStateUI)[i]):SetActive(false)
        end
        ;
        (self._breakOutPowerFullUI):SetActive(false)
        if self._breakOutPowerBreakOutEffectHandler then
          (self._breakOutPowerFullEffect):ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
          self._breakOutPowerBreakOutEffectHandler = nil
        end
        ;
        (self._breakOutPowerCountProgress):SetActive(true)
        self._breakOutPowerCountTotalTime = tonumber(((((BattleECS.Utility).DataUtility).cBattleConstCfgTable)[97]).attr) / 30
        ;
        (self._breakOutPowerCountProgress):SetFillAmount(1)
        ;
        (self._breakOutPowerCountNum):SetText(self._breakOutPowerCountTotalTime)
        local first = {value = self._breakOutPowerCountTotalTime}
        local last = {value = 0}
        self._breakOutPowerCountProgressAndNumTask = (Tween.new)(self._breakOutPowerCountTotalTime, first, last, "linear")
        local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
        local list = {}
        if (autoBattle.orderSKill).skillId ~= 0 then
          (table.insert)(list, {roleId = (autoBattle.orderSKill).roleId, skillId = (autoBattle.orderSKill).skillId, canClick = false})
          -- DECOMPILER ERROR at PC151: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_61_0
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
        end
        if (autoBattle.disorderSkill).skillId ~= 0 then
          (table.insert)(list, {roleId = (autoBattle.disorderSkill).roleId, skillId = (autoBattle.disorderSkill).skillId, canClick = false})
          -- DECOMPILER ERROR at PC186: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_61_1
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
        end
        ;
        ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
        ;
        (self._frame):FireEvent("ChangeAutoSkill", nil)
      else
        do
          if self._breakOutPowerState == PowerAccumulateStateType.BreakOut then
            if self._effectEnergyPowerEffectHandler then
              (self._effectEnergy):ReleaseEffect(self._effectEnergyPowerEffectHandler)
              self._effectEnergyPowerEffectHandler = nil
            end
            if not self._effectEnergyPowerEffectHandler then
              self._effectEnergyPowerEffectHandler = (self._effectEnergy):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1107))
            end
            self._breakOutPowerTotalDamageNum = 0
            ;
            (self._breakOutPowerTotalDamageNumTxt):SetText(self._breakOutPowerTotalDamageNum)
            ;
            (self._breakOutPowerTotalDamageNumEffect):SetAnchorAndOffset(0, self._breakOutPowerTotalDamageNumEffectAnchorMinY, 1, self._breakOutPowerTotalDamageNumEffectAnchorMaxY, self._breakOutPowerTotalDamageNumTxtRectX - (self._breakOutPowerTotalDamageNumTxt):GetPreferredSize(), self._breakOutPowerTotalDamageNumEffectOffsetMinY, 0, self._breakOutPowerTotalDamageNumEffectOffsetMaxY)
            ;
            (self._breakOutPowerTotalDamagePanel):PlayAnimation("BattleEnergyCountShow")
            self._battleEnergyCountAnimationIsEnd = true
            for i = 1, PowerEnergyStateNum do
              ((self._breakOutPowerStateUI)[i]):SetActive(false)
            end
            ;
            (self._breakOutPowerFullUI):PlayAnimation("BattleEnergyFull")
            if self._breakOutPowerBreakOutEffectHandler then
              (self._breakOutPowerFullEffect):ReleaseEffect(self._breakOutPowerBreakOutEffectHandler)
              self._breakOutPowerBreakOutEffectHandler = nil
            end
            self._breakOutPowerBreakOutEffectHandler = (self._breakOutPowerFullEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1138))
            local autoBattle = ((NekoData.BehaviorManager).BM_Battle):GetTempAutoBattleInfo()
            local newAutoSkillList = {}
            for _,v in ipairs(self._entityList) do
              newAutoSkillList[v:GetConfigId()] = (v:GetSkillList())[1]
            end
            for roleId,skillId in pairs(autoBattle.eruptSkill) do
              if newAutoSkillList[roleId] then
                newAutoSkillList[roleId] = skillId
              end
            end
            autoBattle.eruptSkill = newAutoSkillList
            local list = {}
            for roleId,skillId in pairs(autoBattle.eruptSkill) do
              if skillId ~= 0 then
                (table.insert)(list, {roleId = roleId, skillId = skillId, canClick = false})
                -- DECOMPILER ERROR at PC339: Confused about usage of register: R10 in 'UnsetPending'

                ;
                (list[#list]).loadTimeTask = (GameTimer.AddTask)(0, tonumber((CBattleConfig:GetRecorder(104)).attr), function(arg)
    -- function num : 0_61_2
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((arg.list)[arg.index]).canClick = true
  end
, {list = list, index = #list})
              end
            end
            ;
            ((NekoData.BehaviorManager).BM_Battle):SaveOptionalModeAutoBattleSkillInfo(list)
            ;
            (self._frame):FireEvent("ChangeAutoSkill", nil)
          end
        end
      end
    end
  end
end

BattleNewMainDialog.OnSkillBegin = function(self, notification)
  -- function num : 0_62 , upvalues : _ENV
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell then
    cell:BeginShowSkillLoading(protocol.skillid, protocol.type, protocol.lasttime, protocol.skillattr)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell skillid %s", entityId, protocol.skillid)
  end
end

BattleNewMainDialog.OnSkillInterrupted = function(self, notification)
  -- function num : 0_63 , upvalues : _ENV
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell then
    cell:ClearSkillLoading(protocol.skillid)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell skillid %s", entityId, protocol.skillid)
  end
end

BattleNewMainDialog.OnInvincibleStateChange = function(self, notification)
  -- function num : 0_64 , upvalues : _ENV
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell then
    cell:RefreshInvincibleState(protocol.state)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

BattleNewMainDialog.OnShieldValueChange = function(self, notification)
  -- function num : 0_65 , upvalues : _ENV
  local protocol = notification.userInfo
  local entityId = protocol.entityid
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell then
    cell:RefreshShield(protocol)
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

BattleNewMainDialog.ShowLeftPowerGrid = function(self, fullGridNum1, power1)
  -- function num : 0_66 , upvalues : _ENV
  for i,v in ipairs(self._leftPowerGrids) do
    if i <= fullGridNum1 then
      v:SetActive(true)
      ;
      ((self._leftPowerImgGrids)[i]):SetActive(true)
      ;
      ((self._leftPowerImgGrids)[i]):SetFillAmount(1)
      if (self._leftPowerLightDotEffectHandlers)[i] ~= 0 and i ~= power1 then
        ((self._leftPowerLightDot)[i]):SetActive(false)
        ;
        ((self._leftPowerLightDotEffect)[i]):SetActive(false)
      end
      ;
      ((self._leftPowerGridFullEffect)[i]):SetActive(true)
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

      if (self._leftPowerGridFullEffectHandlers)[i] == 0 and (self._leftPowerGridOtherEffectHandlers)[i] == 0 then
        (self._leftPowerGridFullEffectHandlers)[i] = ((self._leftPowerGridFullEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1045))
      end
      if i == power1 then
        ((self._leftPowerLightDot)[i]):SetActive(true)
        ;
        ((self._leftPowerLightDotEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R8 in 'UnsetPending'

        if (self._leftPowerLightDotEffectHandlers)[i] == 0 then
          (self._leftPowerLightDotEffectHandlers)[i] = ((self._leftPowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1042))
        end
        ;
        ((self._leftPowerLightDot)[i]):SetXPosition(0, self._leftPowerWidth * (1 - (power1 + 1 - i)) - self._lightDotWidth / 2)
      end
    else
      if power1 < i and i - 1 < power1 then
        v:SetActive(true)
        ;
        ((self._leftPowerImgGrids)[i]):SetActive(true)
        ;
        ((self._leftPowerImgGrids)[i]):SetFillAmount(power1 + 1 - i)
        ;
        ((self._leftPowerLightDot)[i]):SetActive(true)
        ;
        ((self._leftPowerLightDotEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC140: Confused about usage of register: R8 in 'UnsetPending'

        if (self._leftPowerLightDotEffectHandlers)[i] == 0 then
          (self._leftPowerLightDotEffectHandlers)[i] = ((self._leftPowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1042))
        end
        ;
        ((self._leftPowerLightDot)[i]):SetXPosition(0, self._leftPowerWidth * (1 - (power1 + 1 - i)) - self._lightDotWidth / 2)
        if (self._leftPowerGridOtherEffectHandlers)[i] ~= 0 then
          ((self._leftPowerGridFullEffect)[i]):SetActive(true)
        else
          if (self._leftPowerGridFullEffectHandlers)[i] ~= 0 then
            ((self._leftPowerGridFullEffect)[i]):SetActive(false)
          end
        end
      else
        if (self._leftPowerGridOtherEffectHandlers)[i] ~= 0 then
          ((self._leftPowerGridFullEffect)[i]):SetActive(true)
          v:SetActive(true)
        else
          v:SetActive(false)
          if (self._leftPowerGridFullEffectHandlers)[i] ~= 0 then
            ((self._leftPowerGridFullEffect)[i]):SetActive(false)
          end
        end
        ;
        ((self._leftPowerImgGrids)[i]):SetActive(false)
        ;
        ((self._leftPowerLightDot)[i]):SetActive(false)
        if (self._leftPowerLightDotEffectHandlers)[i] ~= 0 then
          ((self._leftPowerLightDotEffect)[i]):SetActive(false)
        end
      end
    end
  end
end

BattleNewMainDialog.ShowRightPowerGrid = function(self, fullGridNum2, power2)
  -- function num : 0_67 , upvalues : _ENV
  for i,v in ipairs(self._rightPowerGrids) do
    if i <= fullGridNum2 then
      v:SetActive(true)
      ;
      ((self._rightPowerImgGrids)[i]):SetActive(true)
      ;
      ((self._rightPowerImgGrids)[i]):SetFillAmount(1)
      if (self._rightPowerLightDotEffectHandlers)[i] ~= 0 and i ~= power2 then
        ((self._rightPowerLightDot)[i]):SetActive(false)
        ;
        ((self._rightPowerLightDotEffect)[i]):SetActive(false)
      end
      ;
      ((self._rightPowerGridFullEffect)[i]):SetActive(true)
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

      if (self._rightPowerGridFullEffectHandlers)[i] == 0 then
        (self._rightPowerGridFullEffectHandlers)[i] = ((self._rightPowerGridFullEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1046))
      end
      if i == power2 then
        ((self._rightPowerLightDot)[i]):SetActive(true)
        ;
        ((self._rightPowerLightDotEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R8 in 'UnsetPending'

        if (self._rightPowerLightDotEffectHandlers)[i] == 0 then
          (self._rightPowerLightDotEffectHandlers)[i] = ((self._rightPowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1043))
        end
        ;
        ((self._rightPowerLightDot)[i]):SetXPosition(0, self._leftPowerWidth * (power2 + 1 - i) - self._lightDotWidth / 2)
      end
    else
      if power2 < i and i - 1 < power2 then
        v:SetActive(true)
        ;
        ((self._rightPowerImgGrids)[i]):SetActive(true)
        ;
        ((self._rightPowerImgGrids)[i]):SetFillAmount(power2 + 1 - i)
        ;
        ((self._rightPowerLightDot)[i]):SetActive(true)
        ;
        ((self._rightPowerLightDotEffect)[i]):SetActive(true)
        -- DECOMPILER ERROR at PC135: Confused about usage of register: R8 in 'UnsetPending'

        if (self._rightPowerLightDotEffectHandlers)[i] == 0 then
          (self._rightPowerLightDotEffectHandlers)[i] = ((self._rightPowerLightDotEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1043))
        end
        ;
        ((self._rightPowerLightDot)[i]):SetXPosition(0, self._leftPowerWidth * (power2 + 1 - i) - self._lightDotWidth / 2)
        if (self._rightPowerGridFullEffectHandlers)[i] ~= 0 then
          ((self._rightPowerGridFullEffect)[i]):SetActive(false)
        end
      else
        v:SetActive(false)
        ;
        ((self._rightPowerImgGrids)[i]):SetActive(false)
        ;
        ((self._rightPowerLightDot)[i]):SetActive(false)
        if (self._rightPowerLightDotEffectHandlers)[i] ~= 0 then
          ((self._rightPowerLightDotEffect)[i]):SetActive(false)
        end
        if (self._rightPowerGridFullEffectHandlers)[i] ~= 0 then
          ((self._rightPowerGridFullEffect)[i]):SetActive(false)
        end
      end
    end
  end
end

BattleNewMainDialog.OnActiveSkillStateChange = function(self, notification)
  -- function num : 0_68
  (self._frame):FireEvent("SkillCDStateChange", notification.userInfo)
end

BattleNewMainDialog.OnChangeSecondHurtShowState = function(self, notification)
  -- function num : 0_69 , upvalues : _ENV
  local data = notification.userInfo
  local entityId = data.entityId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._totalNumForSecondHurt)[entityId] = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._totalTimeForSecondHurt)[entityId] = 1
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell and cell.RefreshSecondHurtNumShowState then
    cell:RefreshSecondHurtNumShowState(data.state)
  end
  LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
end

BattleNewMainDialog.OnEntityNameChanging = function(self, notification)
  -- function num : 0_70 , upvalues : _ENV
  local protocol = notification.userInfo
  local entityId = protocol.entityId
  local cell = nil
  if (self._leftHpCells)[entityId] then
    cell = (self._leftHpCells)[entityId]
  else
    if (self._rightHpCells)[entityId] then
      cell = (self._rightHpCells)[entityId]
    else
      if (self._summonHpCells)[entityId] then
        cell = (self._summonHpCells)[entityId]
      end
    end
  end
  if cell then
    cell:RefreshName()
  else
    LogWarningFormat("BattleNewMainDialog", "entityid %s dont have hpcell", entityId)
  end
end

BattleNewMainDialog.OnOrderPowerSpecialUIEffect = function(self, notification)
  -- function num : 0_71 , upvalues : _ENV
  local effectId = (notification.userInfo).effectType
  local i = (notification.userInfo).powerGridIndex
  ;
  ((self._leftPowerGridFullEffect)[i]):SetActive(true)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if (self._leftPowerGridOtherEffectHandlers)[i] == 0 and effectId ~= -1 then
    (self._leftPowerGridOtherEffectHandlers)[i] = ((self._leftPowerGridFullEffect)[i]):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(effectId))
  else
    if effectId == -1 and (self._leftPowerGridOtherEffectHandlers)[i] ~= 0 then
      ((self._leftPowerGridFullEffect)[i]):ReleaseEffect((self._leftPowerGridOtherEffectHandlers)[i])
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._leftPowerGridOtherEffectHandlers)[i] = 0
    end
  end
end

BattleNewMainDialog.OnBreakOutPowerNumberChange = function(self, notification)
  -- function num : 0_72 , upvalues : PowerAccumulateStateType, PowerEnergyStateNum
  if self._breakOutPowerState == PowerAccumulateStateType.Filling then
    for i = 1, PowerEnergyStateNum do
      ((self._breakOutPowerStateUI)[i]):SetActive(false)
    end
    if (self._breakOutPowerStateUI)[(notification.userInfo).breakoutPower] then
      ((self._breakOutPowerStateUI)[(notification.userInfo).breakoutPower]):SetActive(true)
      ;
      (self._breakOutPowerEmptyUI):SetActive(false)
    end
  end
end

BattleNewMainDialog.OnBossViolentEnter = function(self, notification)
  -- function num : 0_73 , upvalues : _ENV
  for k,v in pairs(self._rightHpCells) do
    local bossEntity = (((NekoData.BehaviorManager).BM_Battle):GetRightBattlers())[k]
    if bossEntity and bossEntity:IsBoss() then
      ((self._rightHpCells)[k]):StartViolent()
      break
    end
  end
end

BattleNewMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_74
  self:OnPauseBtnClick()
end

BattleNewMainDialog.ShowDamage = function(self)
  -- function num : 0_75 , upvalues : _ENV
  local def = (BattleClientProtocolManager.GetBeanDef)("data.enum_camp")
  self._showDamageTask = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_75_0 , upvalues : _ENV, self, def
    local damageData = ((NekoData.BehaviorManager).BM_Battle):GetCurrentBattleDamage()
    self._totalDamage = 0
    for k,v in pairs(damageData) do
      if v.camp == def.LeftFighter then
        self._totalDamage = self._totalDamage + v.num
      end
    end
    LogError("self._totalDamage", self._totalDamage)
  end
)
end

return BattleNewMainDialog

