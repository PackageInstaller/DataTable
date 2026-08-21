-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HackToolView.lua

module("logic.extensions.hacktool.view.HackToolView", package.seeall)

local profiler = {}
local kTabType = {
	HOUSE = 3,
	TASK = 5,
	PLOT_FIGHT = 2,
	TMP_ENTRY = 6,
	NORMAL = 1,
	RUN_GROUP = 4
}
local M = class("HackToolView", ViewComponent)
local json = require("cjson")
local PLOT_TEST_ID = "plottestid"
local BATTLE_LEVEL_TEST_ID = "dungeon_test_id"
local JIRA_ACCOUNT = "jaccount"
local JIRA_PASSWORD = "japassword"
local JIRA_DEFAULT_ACCOUNT = "jira账号"
local JIRA_DEFAULT_PASSWORD = "jira密码"
local PLOT_DEFAULT_ID = 10001
local ECHO_GYROS_SIMULATE = "item_gyros_simulate"
local viewNameList = {}
local nameIndex = 1

function M:ctor()
	M.super.ctor(self)

	self._btnClose = false
	self._addItemIdInput = false
	self._addItemNumInput = false
	self._btnAddItem = false
	self._btnTestPlot = false
	self._btnTestBattle = false
	self._btnAddAllHero = false
	self._btnPassBattle = false
	self._openAllSystem = false
	self._btnCreatOdd = false
	self._btnSave = false
	self._btnCleanLocalStorage = false
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._btnHome = self:getBtnByPath("title_view/layout/btnHome_1")
	self._btnLogout = self:getBtn("hacktoolpanel_847879100")
	self._addItemIdInput = self:getInput("hacktoolpanel_1359150854")
	self._addItemNumInput = self:getInput("hacktoolpanel_-1813458310")
	self._btnAddItem = self:getBtn("hacktoolpanel_902703635")
	self._btnTestPlot = self:getBtn("hacktoolpanel_1301172252")
	self._btnSkipPlot = self:getBtn("hacktoolpanel_2031797601")
	self._togglePlotTest = self:getGo("hacktoolpanel_-1670997115"):GetComponent(UIComponentType.SpaceXToggle)
	self._btnTestBattle = self:getBtn("hacktoolpanel_2038302145")
	self._btnAddRoleView = self:getBtn("hacktoolpanel_-1852305054")
	self._btnAddItemView = self:getBtn("hacktoolpanel_-1253679283")
	self._btnRuntimeInspector = self:getBtn("hacktoolpanel_477685959")
	self._plotIdInput = self:getInput("hacktoolpanel_-37072617")
	self._heroGMStrInput = self:getInput("hacktoolpanel_1761176181")
	self._btnAddAllHero = self:getBtn("hacktoolpanel_-1441988968")
	self._spineCutInput = self:getInput("hacktoolpanel_1636012455")
	self._spineCutBtn = self:getBtn("hacktoolpanel_-467747012")
	self._dungeonToggle = self:getGo("hacktoolpanel_-1017859395"):GetComponent(UIComponentType.SpaceXToggle)
	self._btnPassBattle = self:getBtn("hacktoolpanel_-1888046664")
	self._btnPassBattle2 = self:getBtn("hacktoolpanel_-1580760263")
	self._btnTestRoguelike = self:getBtn("hacktoolpanel_-183410012")
	self._btnClearRoguelike = self:getBtn("hacktoolpanel_414416254")
	self._btnQuitRoguelike = self:getBtn("hacktoolpanel_1342138155")
	self._btnRoguelikeOpenScript = self:getBtn("hacktoolpanel_353537043")
	self._btnBattleRecord = self:getBtn("hacktoolpanel_997245753")
	self._btnBattleCalculate = self:getBtn("hacktoolpanel_634311446")
	self._btnMainlineDungeon = self:getBtn("hacktoolpanel_-275892713")
	self._iptPreviewGuide = self:getInput("hacktoolpanel_-1128627667")
	self._iptPreviewGuideIndex = self:getInput("hacktoolpanel_-666785660")
	self._btnPreviewGuide = self:getBtn("hacktoolpanel_-1070193098")
	self._btnDeleteGuide = self:getBtn("hacktoolpanel_-630131256")
	self._btnJumpNewPlayer = self:getBtn("hacktoolpanel_607310406")
	self._iptPreviewRoleGet = self:getInput("hacktoolpanel_283870678")
	self._btnPreviewRoleGet = self:getBtn("hacktoolpanel_1179515307")
	self._battleLevelCodeInput = self:getInput("hacktoolpanel_-1179382806")
	self._btnTestDungeon = self:getBtn("hacktoolpanel_-556941789")
	self._btnStrengthAccount01 = self:getBtn("hacktoolpanel_375529501")
	self._btnStrengthAccount02 = self:getBtn("hacktoolpanel_520984579")
	self._btnPassAllFB = self:getBtn("hacktoolpanel_-1481784005")
	self._btnUnlockAllGuide = self:getBtn("hacktoolpanel_804489362")
	self._btnUnlockAllThought = self:getBtn("hacktoolpanel_-1969153993")

	goutil.setActive(self._btnPassAllFB.gameObject, false)

	self._toggleBattleDebug = self:getGo("hacktoolpanel_-1247286024"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleBattleProgramScene = self:getGo("hacktoolpanel_555724402"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleBattleHideScene = self:getGo("hacktoolpanel_-12075543"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleBattleOutputLog = self:getGo("hacktoolpanel_-241968478"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleBattleOutputServerLog = self:getGo("hacktoolpanel_1840035770"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleBattleLevelIDVisiable = self:getGo("hacktoolpanel_-2079437147"):GetComponent(UIComponentType.SpaceXToggle)
	self._guideToggle = self:getUIComponent("hacktoolpanel_219873045", UIComponentType.SpaceXToggle)
	self._toggleHouseNamebar = self:getUIComponent("hacktoolpanel_-973897944", UIComponentType.SpaceXToggle)
	self._toggleHouseGM = self:getUIComponent("hacktoolpanel_1259645739", UIComponentType.SpaceXToggle)
	self._btnTestMail = self:getBtn("hacktoolpanel_2048530639")
	self._mailGo = self:getGo("hacktoolpanel_-680734269")
	self._btnClostMail = self:getBtn("hacktoolpanel_858614755")

	goutil.setActive(self._mailGo, false)

	self._iptConfigMail = self:getInput("hacktoolpanel_970956847")
	self._btnAddConfigMail = self:getBtn("hacktoolpanel_-332943894")
	self._iptexpiredTime = self:getInput("hacktoolpanel_378011254")
	self._iptsenderName = self:getInput("hacktoolpanel_1959548741")
	self._iptsenderLocation = self:getInput("hacktoolpanel_1529179579")
	self._iptTitle = self:getInput("hacktoolpanel_-1558921467")
	self._iptContent = self:getInput("hacktoolpanel_1636617693")
	self._iptattachment = self:getInput("hacktoolpanel_1503910271")
	self._btnAddCustomMail = self:getBtn("hacktoolpanel_1322239018")
	self._btnTestLottery1 = self:getBtn("hacktoolpanel_-813795340")
	self._btnTestLottery2 = self:getBtn("hacktoolpanel_1625344411")
	self._btnRestLotteryCard = self:getBtn("hacktoolpanel_-1014810588")
	self._lotteryGo = self:getGo("hacktoolpanel_-936360566")
	self._lotteryView = Astral.SimpleLuaComponentContainer.Add(self._lotteryGo, LotteryHacktoolPanelView)

	local goSystemInfo = self:getGo("hacktoolpanel_-68585592")

	self._btnSystemInfo = self:getBtn("hacktoolpanel_2093839028")
	self._btnDebugMessage = self:getBtn("hacktoolpanel_-1084951540")
	self._systemInfoView = Astral.SimpleLuaComponentContainer.Add(goSystemInfo, SystemInfoHackToolView)

	self._systemInfoView:inactive()

	self._openAllSystem = self:getBtn("hacktoolpanel_1293126013")
	self._btnCloseHotUpdate = self:getBtn("hacktoolpanel_-1957608401")
	self._txtCloseHotUpdate = self:getGo("hacktoolpanel_-1957608401").transform:Find("Text"):GetComponent("Text")
	self._btnExportFurniture = self:getBtn("hacktoolpanel_1599441710")
	self._btnAddAllFurniture = self:getBtn("hacktoolpanel_-2099826992")

	if enableDebug then
		MsgDebugger.instance:init()
	end

	self._txtUID = self:getText("hacktoolpanel_-786196563")
	self._btnCopy = self:getBtn("hacktoolpanel_-2118029927")
	self._iptJumpTest = self:getInput("hacktoolpanel_426519060")
	self._btnJumpTest = self:getBtn("hacktoolpanel_-1280452120")
	self._btnCreatOdd = self:getBtn("hacktoolpanel_-1694103960")
	self._btnSave = self:getBtn("hacktoolpanel_152167507")
	self._accountInput = self:getInput("hacktoolpanel_-1308273329")
	self._passwordInput = self:getInput("hacktoolpanel_374198392")
	self._loginPopCodeInput = self:getInput("hacktoolpanel_1540428127")
	self._btnDeleteLoginCode = self:getBtn("hacktoolpanel_-364099252")
	self._btnDeleteAllLoginCode = self:getBtn("hacktoolpanel_-967093690")
	self._iptTaskId = self:getInput("hacktoolpanel_-1428598750")
	self._btnFinishTask = self:getBtn("hacktoolpanel_-939889738")
	self._btnDropdown = self:getUIComponent("hacktoolpanel_-282368689", UIComponentType.DropdownApapter)
	self._iptTaskId2 = self:getInput("hacktoolpanel_-1743432828")
	self._btnResetTask = self:getBtn("hacktoolpanel_1291910399")
	self._btnTryGetHeroId = self:getBtn("hacktoolpanel_-1473814794")
	self._addTacitHeroIdInput = self:getInput("hacktoolpanel_54390783")
	self._addTacitExpNumInput = self:getInput("hacktoolpanel_785752155")
	self._btnAddTacitExp = self:getBtn("hacktoolpanel_-90429972")
	self._resetHeroTacitInput = self:getInput("hacktoolpanel_54390783")
	self._btnResetTacit = self:getBtn("hacktoolpanel_-864277789")
	self._btnGuide = self:getBtn("hacktoolpanel_832459700")
	self._btnHide = self:getBtn("hacktoolpanel_-1157906565")
	self._btnHideUIRoot = self:getBtn("hacktoolpanel_-1378658636")
	self._btnFps = self:getBtn("hacktoolpanel_-697933806")
	self._btnViewEffect = self:getBtn("hacktoolpanel_859085732")
	self._btnCloseEffectInfo = self:getBtn("hacktoolpanel_-1622158638")
	self._postProcessScrollGo = self:getGo("hacktoolpanel_1188357041")
	self._togGodRay = self:getGo("hacktoolpanel_242079107"):GetComponent(UIComponentType.SpaceXToggle)
	self._togGlitchMask = self:getGo("hacktoolpanel_-1153476705"):GetComponent(UIComponentType.SpaceXToggle)
	self._togGlitch = self:getGo("hacktoolpanel_-235718395"):GetComponent(UIComponentType.SpaceXToggle)
	self._togHeightFog = self:getGo("hacktoolpanel_-1166656255"):GetComponent(UIComponentType.SpaceXToggle)
	self._togPlanarReflection = self:getGo("hacktoolpanel_71331912"):GetComponent(UIComponentType.SpaceXToggle)
	self._togOcclusion = self:getGo("hacktoolpanel_1523025281"):GetComponent(UIComponentType.SpaceXToggle)
	self._togADDITIONAL = self:getGo("hacktoolpanel_-25524578"):GetComponent(UIComponentType.SpaceXToggle)
	self._togUIBlur = self:getGo("hacktoolpanel_611894413"):GetComponent(UIComponentType.SpaceXToggle)
	self._togScreenSpaceReflection = self:getGo("hacktoolpanel_-1486461196"):GetComponent(UIComponentType.SpaceXToggle)
	self._togSSAO = self:getGo("hacktoolpanel_-1544417590"):GetComponent(UIComponentType.SpaceXToggle)
	self._togToonMask = self:getGo("hacktoolpanel_1538798739"):GetComponent(UIComponentType.SpaceXToggle)
	self._togWaterPlanarReflection = self:getGo("hacktoolpanel_-2076327230"):GetComponent(UIComponentType.SpaceXToggle)
	self._togMsaa = self:getGo("hacktoolpanel_-1563419235"):GetComponent(UIComponentType.SpaceXToggle)
	self._togSplitRenderScale = self:getGo("hacktoolpanel_-551868312"):GetComponent(UIComponentType.SpaceXToggle)
	self._togSplitRenderScale.IsOn = SpaceX.GraphicsUtils.GetIsSplitRenderScale()
	self._toggleNormal = self:getGo("right_tab_content_-242000516"):GetComponent(UIComponentType.SpaceXToggle)
	self._togglePlotFight = self:getGo("right_tab_content_-1578871314"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleHouse = self:getGo("right_tab_content_1651451756"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleRunGroup = self:getGo("right_tab_content_-1691267181"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleTask = self:getGo("right_tab_content_-1462805221"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleTmpEntry = self:getGo("right_tab_content_-1190107081"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleGroup = {
		self._toggleNormal,
		self._togglePlotFight,
		self._toggleHouse,
		self._toggleRunGroup,
		self._toggleTask,
		self._toggleTmpEntry
	}
	self._goBasePanel = self:getGo("hacktoolpanel_-183121969")
	self._goPlotFightPanel = self:getGo("hacktoolpanel_-25277278")
	self._goRunGroupPanel = self:getGo("hacktoolpanel_-1404925066")
	self._goHousePanel = self:getGo("hacktoolpanel_-2084181819")
	self._goTaskPanel = self:getGo("hacktoolpanel_-2145373213")
	self._goTmpEntryPanel = self:getGo("hacktoolpanel_-836360203")
	self._btnCleanLocalStorage = self:getBtn("hacktoolpanel_-1274800921")
	self._roguelikeTabView = Astral.SimpleLuaComponentContainer.Add(self.mainGO, RoguelikeTabView)
	self._gyrosToggle = self:getUIComponent("hacktoolpanel_1166720978", UIComponentType.SpaceXToggle)
	self._btnProfilerScene = self:getBtn("hacktoolpanel_585992293")
	self._btnAutoScene = self:getBtn("hacktoolpanel_296710648")
	self._toggleMainScenePerformEditor = self:getUIComponent("hacktoolpanel_38168798", UIComponentType.SpaceXToggle)
	self._toggleMainSceneAniCamEditor = self:getUIComponent("hacktoolpanel_1737808551", UIComponentType.SpaceXToggle)
	self._toggleUIDetect = self:getUIComponent("hacktoolpanel_-1910002824", UIComponentType.SpaceXToggle)
	self._toggleCanvasBuildCheck = self:getUIComponent("hacktoolpanel_1346035443", UIComponentType.SpaceXToggle)
	self._toggleGitCommit = self:getUIComponent("hacktoolpanel_1989526004", UIComponentType.SpaceXToggle)
	self._toggleOptimiseEditor = self:getUIComponent("hacktoolpanel_217627638", UIComponentType.SpaceXToggle)
	self._blockIndexInput = self:getInput("hacktoolpanel_344028703")
	self._btnSwitchBlock = self:getBtn("hacktoolpanel_235271362")
	self._btnGC = self:getBtn("hacktoolpanel_-190579312")
	self._btnClearCache = self:getBtn("hacktoolpanel_978924351")
	self._btnOpenAllView = self:getBtn("hacktoolpanel_1595959147")
	self._btnTestItemAndHero = self:getBtn("hacktoolpanel_-652118981")
	self._btnCrash = self:getBtnByPath("scorllPanel/basicsScroll/viewPort/content/hacktool_type2_item8/rightContent/btnCrash")
	self._toggleHouseHeroPath = self:getGoByPath("scorllPanel/roomScroll/viewPort/content/item2/toggle1"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleForbidDefaultPerform = self:getGoByPath("scorllPanel/roomScroll/viewPort/content/item2/toggle2"):GetComponent(UIComponentType.SpaceXToggle)
	self._toggleLogTips = self:getGoByPath("scorllPanel/basicsScroll/viewPort/content/hacktool_type1_item9/toggle_logTips"):GetComponent(UIComponentType.SpaceXToggle)
	self._btnAirClearRodeoMatch = self:getBtn("hacktoolpanel_-364975051")
	self._inputAirRodeoLastSettleTimeStamp = self:getInput("hacktoolpanel_-280577915")
	self._btnAirRodeoLastSettleTimeStamp = self:getBtn("hacktoolpanel_2132894560")
	self._btnStartSampleData = self:getBtn("hacktoolpanel_-1303618852")
	self._btnFinishSampleData = self:getBtn("hacktoolpanel_1402869171")
	self._dropDownServerType = self:getUIComponent("hacktoolpanel_-420327986", UIComponentType.DropdownApapter)
	self._dropDownAreaType = self:getUIComponent("hacktoolpanel_-1314142382", UIComponentType.DropdownApapter)
	self._btnChangeNetwork = self:getBtn("hacktoolpanel_-437979550")

	local gmConsole = self:getGoByPath("scorllPanel/basicsScroll/viewPort/content/gmitemconsoleview")

	self._gmConsoleView = Astral.SimpleLuaComponentContainer.Add(gmConsole, HackToolConsoleView)
	self._bgClick = Astral.UIClickTrigger.Get(goutil.findChild(self.mainGO, "bg"))
	self._btnToH = self:getBtn("hacktoolpanel_-1405772299")
	self._btnToV = self:getBtn("hacktoolpanel_603644825")
	self._btnFrame30 = self:getBtn("hacktoolpanel_71990777")
	self._btnFrame45 = self:getBtn("hacktoolpanel_-1925682783")
	self._btnFrame60 = self:getBtn("hacktoolpanel_-1771348549")
end

function M:bindEvents()
	self._btnToH:AddClickListener(self._onClickEchoCardH, self)
	self._btnToV:AddClickListener(self._onClickEchoCardV, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnSwitchBlock:AddClickListener(self._clickSwitchBlock, self)
	self._btnResetTacit:AddClickListener(self._clickResetTacitExp, self)
	self._btnTryGetHeroId:AddClickListener(self._clickTryGetHeroId, self)
	self._btnAddTacitExp:AddClickListener(self._clickAddTacitExp, self)
	self._btnResetTask:AddClickListener(self._clickResetTask, self)
	self._btnFinishTask:AddClickListener(self._clickTask, self)
	self._btnDeleteAllLoginCode:AddClickListener(self._clickDeleteAllLoginCache, self)
	self._btnDeleteLoginCode:AddClickListener(self._clickDeleteLoginCache, self)
	self._btnCreatOdd:AddClickListener(self._onClickCreatOdd, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnCopy:AddClickListener(self._onClickCopyUID, self)
	self._btnClose:AddClickListener(self._dealClose, self)
	self._btnLogout:AddClickListener(self._dealLogout, self)
	self._btnAddItem:AddClickListener(self._dealAddItem, self)
	self._btnAddAllHero:AddClickListener(self._addAllHero, self)
	self._btnTestPlot:AddClickListener(self._showPlot, self)
	self._btnSkipPlot:AddClickListener(self._skipPlot, self)
	self._btnTestBattle:AddClickListener(self._onBattleTest, self)
	self._btnTestDungeon:AddClickListener(self._onDungeonBattleTest, self)
	self._btnStrengthAccount01:AddClickListener(self._onClickStrengthAccount01, self)
	self._btnStrengthAccount02:AddClickListener(self._onClickStrengthAccount02, self)
	self._btnPassAllFB:AddClickListener(self._onClickPassAllFB, self)
	self._btnUnlockAllGuide:AddClickListener(self._onClickUnlockGuide, self)
	self._btnUnlockAllThought:AddClickListener(self._onClickUnlockThought, self)
	self._btnFrame30:AddClickListener(self._onClickFrame30, self)
	self._btnFrame45:AddClickListener(self._onClickFrame45, self)
	self._btnFrame60:AddClickListener(self._onClickFrame60, self)
	self._toggleBattleDebug:AddListener(self._onBattleDebugToggleChange, self)
	self._toggleBattleProgramScene:AddListener(self._onBattleToggleProgramSceneChange, self)
	self._toggleBattleHideScene:AddListener(self._onBattleToggleHideSceneChange, self)
	self._toggleBattleOutputLog:AddListener(self._onBattleToggleOutputLog, self)
	self._toggleBattleOutputServerLog:AddListener(self._onBattleToggleOutputServerLog, self)
	self._toggleBattleLevelIDVisiable:AddListener(self._onBattleToggleLevelIDVisiable, self)
	self._plotIdInput:AddOnValueChanged(self._onChangePlotID, self)
	self._spineCutBtn:AddClickListener(self._onClickSpineCutBtn, self)
	self._dungeonToggle:AddListener(self._onDungeonToggleChange, self)
	self._btnAddRoleView:AddClickListener(self._onOpenAddRoleView, self)
	self._btnAddItemView:AddClickListener(self._onOpenAddItemView, self)
	self._btnPassBattle:AddClickListener(self._onClickPassBattle, self)
	self._btnPassBattle2:AddClickListener(self._onClickPassBattleLost, self)
	self._btnTestRoguelike:AddClickListener(self._onClickTestRoguelike, self)
	self._btnClearRoguelike:AddClickListener(self._onClickClearRoguelike, self)
	self._btnQuitRoguelike:AddClickListener(self._onClickQuitRoguelike, self)
	self._btnRoguelikeOpenScript:AddClickListener(self._onClickOpenRoguelikeScript, self)
	self._btnPreviewGuide:AddClickListener(self._onClickPreviewGuide, self)
	self._btnDeleteGuide:AddClickListener(self._onClickDeleteGuide, self)
	self._btnJumpNewPlayer:AddClickListener(self._onClickJumpNewPlayer, self)
	self._btnBattleRecord:AddClickListener(self._onClickBattleRecord, self)
	self._btnBattleCalculate:AddClickListener(self._onClickBattleCalculate, self)
	self._btnMainlineDungeon:AddClickListener(self._onClickMainlineDungeon, self)
	self._guideToggle:AddListener(self._onGuideToggleChange, self)
	self._toggleHouseNamebar:AddListener(self._onHouseToggleChange, self)
	self._toggleMainScenePerformEditor:AddListener(self._onMainScenePerformEditorToggleChange, self)
	self._toggleMainSceneAniCamEditor:AddListener(self._onMainSceneAniCamToggleChange, self)
	self._toggleOptimiseEditor:AddListener(self._onOptimiseToggleChange, self)
	self._toggleUIDetect:AddListener(self._onUIDetectToggleChange, self)
	self._toggleCanvasBuildCheck:AddListener(self._onToggleChangeCanvasBuildCheck, self)
	self._toggleGitCommit:AddListener(self._onToggleGitCommit, self)
	self._toggleHouseGM:AddListener(self._onHouseGMToggleChange, self)
	self._btnAddConfigMail:AddClickListener(self._onClickAddConfigMail, self)
	self._btnAddCustomMail:AddClickListener(self._onClickAddCustomMail, self)
	self._btnClostMail:AddClickListener(self._onClickCloseMail, self)
	self._btnTestMail:AddClickListener(self._clickMail, self)
	self._btnTestLottery1:AddClickListener(self._clickLottery1, self)
	self._btnTestLottery2:AddClickListener(self._clickLottery2, self)
	self._btnRestLotteryCard:AddClickListener(self._clickResetLotteryCard, self)
	self._btnExportFurniture:AddClickListener(self._clickExportFurniture, self)
	self._btnAddAllFurniture:AddClickListener(self._clickAddAllFurniture, self)
	self._btnSystemInfo:AddClickListener(self._onClickSystemInfo, self)
	self._btnDebugMessage:AddClickListener(self._onClickDebugMessage, self)
	self._openAllSystem:AddClickListener(self._onClickOpenAllSystem, self)
	self._btnJumpTest:AddClickListener(self._onClickJumpTest, self)
	self._btnCloseHotUpdate:AddClickListener(self._onClickCloseHotUpdate, self)
	self._btnRuntimeInspector:AddClickListener(self._onClickShowRunTimeInspector, self)
	self._btnGuide:AddClickListener(self._onClickGuide, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnHideUIRoot:AddClickListener(self._onClickHideUIRoot, self)
	self._btnFps:AddClickListener(self._onClickFps, self)
	self._btnViewEffect:AddClickListener(self._onClickViewEffectInfo, self)
	self._btnCloseEffectInfo:AddClickListener(self._onClickCloseEffectInfo, self)
	self._toggleNormal:AddListener(self._onNormalToggle, self)
	self._togglePlotFight:AddListener(self._onPlotFightToggle, self)
	self._toggleHouse:AddListener(self._onHouseToggle, self)
	self._toggleRunGroup:AddListener(self._onRunGroupToggle, self)
	self._toggleTask:AddListener(self._onTaskToggle, self)
	self._toggleTmpEntry:AddListener(self._onTaskTmpEntry, self)
	self._btnCleanLocalStorage:AddClickListener(self._onClickLocalStorage, self)
	self._togGodRay:AddListener(self._onTogGodRay, self)
	self._togGlitchMask:AddListener(self._onTogGlitchMask, self)
	self._togGlitch:AddListener(self._onTogGlitch, self)
	self._togHeightFog:AddListener(self._onTogHeightFog, self)
	self._togPlanarReflection:AddListener(self._onPlanarReflection, self)
	self._togOcclusion:AddListener(self._onTogOcclusion, self)
	self._togADDITIONAL:AddListener(self._onTogADDITIONAL, self)
	self._togUIBlur:AddListener(self._onTogUIBlur, self)
	self._togScreenSpaceReflection:AddListener(self._onScreenSpaceReflection, self)
	self._togSSAO:AddListener(self._onTogSSAO, self)
	self._togToonMask:AddListener(self._onTogToonMask, self)
	self._togWaterPlanarReflection:AddListener(self._onTogWaterPlanarReflection, self)
	self._gyrosToggle:AddListener(self._onGyrosSimulate, self)
	self._btnProfilerScene:AddClickListener(self._loadProfilerScene, self)
	self._btnAutoScene:AddClickListener(self._loadAutoRunScene, self)
	self._btnTestItemAndHero:AddClickListener(self._onClickTestItemAndHero, self)
	self._btnCrash:AddClickListener(self._onClickBtnCrash, self)
	self._toggleHouseHeroPath:AddListener(self._onToggleHouseHeroPath, self)
	self._toggleForbidDefaultPerform:AddListener(self._onToggleForbidDefaultPerform, self)
	self._btnGC:AddClickListener(self._onClickGC, self)
	self._btnClearCache:AddClickListener(self._onClickClearCache, self)
	self._btnOpenAllView:AddClickListener(self._onClickOpenAllView, self)
	self._toggleLogTips:AddListener(self._onToggleLogTips, self)
	self._togMsaa:AddListener(self._onTogMsaa, self)
	self._togSplitRenderScale:AddListener(self._onTogRenderScale, self)
	self._btnPreviewRoleGet:AddClickListener(self._onClickPreviewRoleGet, self)
	self._btnAirClearRodeoMatch:AddClickListener(self._onClickAirClearRodeoMatch, self)
	self._btnAirRodeoLastSettleTimeStamp:AddClickListener(self._onClickAirRodeoLastSettleTimeStamp, self)
	self._btnStartSampleData:AddClickListener(self._onClickStartSampleData, self)
	self._btnFinishSampleData:AddClickListener(self._onClickFinishSampleData, self)
	self._addItemIdInput:AddOnValueChanged(self._onNameInputValueChange, self)
	self._bgClick:AddClickListener(self._onClickBg, self)
	self._btnChangeNetwork:AddClickListener(self._onClickChangeNetwork, self)
end

function M:unbindEvents()
	self._btnToH:RemoveClickListener()
	self._btnToV:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnStartSampleData:RemoveClickListener()
	self._btnFinishSampleData:RemoveClickListener()
	self._btnPreviewRoleGet:RemoveClickListener()
	self._btnSwitchBlock:RemoveClickListener()
	self._btnResetTacit:RemoveClickListener()
	self._btnTryGetHeroId:RemoveClickListener()
	self._btnAddTacitExp:RemoveClickListener()
	self._btnResetTask:RemoveClickListener()
	self._btnFinishTask:RemoveClickListener()
	self._btnDeleteAllLoginCode:RemoveClickListener()
	self._btnDeleteLoginCode:RemoveClickListener()
	self._btnCreatOdd:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
	self._btnTestMail:RemoveClickListener()
	self._btnClostMail:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnLogout:RemoveClickListener()
	self._btnAddItem:RemoveClickListener()
	self._btnAddAllHero:RemoveClickListener()
	self._btnTestPlot:RemoveClickListener()
	self._btnSkipPlot:RemoveClickListener()
	self._btnTestBattle:RemoveClickListener()
	self._btnTestDungeon:RemoveClickListener()
	self._btnStrengthAccount01:RemoveClickListener()
	self._btnStrengthAccount02:RemoveClickListener()
	self._btnPassAllFB:RemoveClickListener()
	self._btnUnlockAllGuide:RemoveClickListener()
	self._btnUnlockAllThought:RemoveClickListener()
	self._btnFrame30:RemoveClickListener()
	self._btnFrame45:RemoveClickListener()
	self._btnFrame60:RemoveClickListener()
	self._toggleBattleDebug:RemoveListener()
	self._toggleBattleProgramScene:RemoveListener()
	self._toggleBattleHideScene:RemoveListener()
	self._toggleBattleOutputLog:RemoveListener()
	self._toggleBattleOutputServerLog:RemoveListener()
	self._toggleBattleLevelIDVisiable:RemoveListener()
	self._plotIdInput:RemoveOnValueChanged()
	self._spineCutBtn:RemoveClickListener()
	self._dungeonToggle:RemoveListener()
	self._btnAddItemView:RemoveClickListener()
	self._btnPassBattle:RemoveClickListener()
	self._btnPassBattle2:RemoveClickListener()
	self._btnTestRoguelike:RemoveClickListener()
	self._btnClearRoguelike:RemoveClickListener()
	self._btnQuitRoguelike:RemoveClickListener()
	self._btnRoguelikeOpenScript:RemoveClickListener()
	self._btnPreviewGuide:RemoveClickListener()
	self._btnDeleteGuide:RemoveClickListener()
	self._btnJumpNewPlayer:RemoveClickListener()
	self._btnBattleRecord:RemoveClickListener()
	self._btnBattleCalculate:RemoveClickListener()
	self._btnMainlineDungeon:RemoveClickListener()
	self._guideToggle:RemoveListener()
	self._toggleHouseNamebar:RemoveListener()
	self._toggleMainScenePerformEditor:RemoveListener()
	self._toggleMainSceneAniCamEditor:RemoveListener()
	self._toggleOptimiseEditor:RemoveListener()
	self._toggleUIDetect:RemoveListener()
	self._toggleCanvasBuildCheck:RemoveListener()
	self._toggleGitCommit:RemoveListener()
	self._toggleHouseGM:RemoveListener()
	self._btnAddConfigMail:RemoveClickListener()
	self._btnAddCustomMail:RemoveClickListener()
	self._btnTestLottery1:RemoveClickListener()
	self._btnTestLottery2:RemoveClickListener()
	self._btnRestLotteryCard:RemoveClickListener()
	self._btnExportFurniture:RemoveClickListener()
	self._btnAddAllFurniture:RemoveClickListener()
	self._btnSystemInfo:RemoveClickListener()
	self._btnDebugMessage:RemoveClickListener()
	self._openAllSystem:RemoveClickListener()
	self._btnJumpTest:RemoveClickListener()
	self._btnCloseHotUpdate:RemoveClickListener()
	self._btnRuntimeInspector:RemoveClickListener()
	self._btnGuide:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnHideUIRoot:RemoveClickListener()
	self._btnFps:RemoveClickListener()
	self._btnViewEffect:RemoveClickListener()
	self._btnCloseEffectInfo:RemoveClickListener()
	self._toggleNormal:RemoveListener()
	self._togglePlotFight:RemoveListener()
	self._toggleHouse:RemoveListener()
	self._toggleRunGroup:RemoveListener()
	self._toggleTask:RemoveListener()
	self._toggleTmpEntry:RemoveListener()
	self._btnCleanLocalStorage:RemoveClickListener()
	self._togGodRay:RemoveListener()
	self._togGlitchMask:RemoveListener()
	self._togGlitch:RemoveListener()
	self._togHeightFog:RemoveListener()
	self._togPlanarReflection:RemoveListener()
	self._togOcclusion:RemoveListener()
	self._togADDITIONAL:RemoveListener()
	self._togUIBlur:RemoveListener()
	self._togScreenSpaceReflection:RemoveListener()
	self._togSSAO:RemoveListener()
	self._togToonMask:RemoveListener()
	self._togWaterPlanarReflection:RemoveListener()
	self._gyrosToggle:RemoveListener()
	self._btnProfilerScene:RemoveClickListener()
	self._btnAutoScene:RemoveClickListener()
	self._btnTestItemAndHero:RemoveClickListener()
	self._btnCrash:RemoveClickListener()
	self._toggleHouseHeroPath:RemoveListener()
	self._toggleForbidDefaultPerform:RemoveListener()
	self._btnGC:RemoveClickListener()
	self._btnClearCache:RemoveClickListener()
	self._btnOpenAllView:RemoveClickListener()
	self._toggleLogTips:RemoveListener()
	self._togMsaa:RemoveListener()
	self._togSplitRenderScale:RemoveListener()
	self._btnAirClearRodeoMatch:RemoveClickListener()
	self._btnAirRodeoLastSettleTimeStamp:RemoveClickListener()
	self._btnStartSampleData:RemoveClickListener()
	self._btnFinishSampleData:RemoveClickListener()
	self._addItemIdInput:RemoveOnValueChanged()
	self._bgClick:RemoveClickListener()
	self._btnChangeNetwork:RemoveClickListener()
	self._btnAddRoleView:RemoveClickListener()
end

function M:onEnter()
	goutil.setActive(self._postProcessScrollGo, false)
	self._dungeonToggle:ForceSetOn(DungeonModel.instance:getAllDungeonUnlock())
	self._plotIdInput:SetText(tonumber(Astral.LocalStorage.Instance:GetString(PLOT_TEST_ID, PLOT_DEFAULT_ID)))
	self._battleLevelCodeInput:SetText(tonumber(Astral.LocalStorage.Instance:GetString(BATTLE_LEVEL_TEST_ID)))
	self._spineCutInput:SetText(100011)

	local isForbidGuides = GuideController.instance:isForbidGuides()

	self._guideToggle.IsOn = not isForbidGuides
	self._toggleHouseNamebar.IsOn = HouseController.instance:getNamebarVisible()
	self._toggleHouseGM.IsOn = HouseGMController.instance:getGMToggle()
	self._toggleBattleDebug.IsOn = BattleTestUtil.isDebug()
	self._toggleBattleProgramScene.IsOn = BattleTestUtil.isUseProgramScene()
	self._toggleBattleHideScene.IsOn = BattleTestUtil.isHideScene()
	self._toggleBattleOutputLog.IsOn = BattleTestUtil.isOutputLog()
	self._toggleBattleOutputServerLog.IsOn = BattleTestUtil.isOutputServerLog()
	self._toggleMainScenePerformEditor.IsOn = MainUIModel.instance:getPerformEditorVisible()
	self._toggleMainSceneAniCamEditor.IsOn = ViewMgr.instance:isOpen(ViewName.MainPerformEditorView)
	self._toggleOptimiseEditor.IsOn = OptimizationTA.Ctrl.OptTaCtrl.Instance.isShowing
	self._toggleUIDetect.IsOn = MainUIModel.instance:getUIDetectVisible()
	self._toggleCanvasBuildCheck.IsOn = CanvasUpdateCheck.HasComp(ViewMgr.instance:getUIRoot())
	self._txtUID.text = string.format("UID:%s", PlayerModel.instance:getId())

	self._accountInput:SetText(Astral.LocalStorage.Instance:GetString(JIRA_ACCOUNT, JIRA_DEFAULT_ACCOUNT))
	self._passwordInput:SetText(Astral.LocalStorage.Instance:GetString(JIRA_PASSWORD, JIRA_DEFAULT_PASSWORD))

	local t = HacktoolMo.instance:getTabId()

	t = t or kTabType.NORMAL

	self:switchShowType(t)

	if HacktoolMo.instance:getOpenedBattle() then
		self:_onBattleTest()
	end

	local simulateValue = Astral.LocalStorage.Instance:GetInt(ECHO_GYROS_SIMULATE)

	self._gyrosToggle.IsOn = simulateValue == 1 and true or false
	self._toggleForbidDefaultPerform.IsOn = HouseGMController.instance:getForbidDefaultPerform()
	self._toggleLogTips.IsOn = MainUIModel.instance:getLogTipsVisible()

	self._gmConsoleView:setInput(self._addItemIdInput)
	self:updateCurNetwork()
end

function M:destroyUI()
	self._systemInfoView:destroy()

	self._systemInfoView = nil
end

function M:onExit()
	self._lotteryView:onExit()
end

function M:_onClickHome()
	if BattleMgr.instance:isInBattle() then
		ToolTipsMgr.showCharacterTopToast("战斗中不响应Home", CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	self:close()
end

function M:_dealClose()
	self:close()
end

function M:_dealLogout()
	UserAgent.instance:sendLogoutRequest()
end

function M:_dealAddItem()
	local itemId = self._addItemIdInput:GetText()
	local num = self._addItemNumInput:GetText()
	local data
	local _num = 1

	if num then
		_num = tonumber(num) or 1
	end

	if _num > 0 then
		data = HackToolUtil.createAddItemCmd({
			{
				itemId = tonumber(itemId),
				num = _num
			}
		})

		HackToolAgent.instance:sendGmRequest(data)
		self:close()
	elseif _num < 0 then
		_num = math.abs(_num)

		local _itemId = tonumber(itemId)
		local _itemCount = ItemModel.instance:getItemCountByItemId(_itemId)
		local _type = ItemUtil.getItemTypeByItemId(_itemId)

		if _itemCount < _num and _type ~= GameEnum.ItemTypeEnum.CurrencyItemType then
			FloatWordMgr.instance:show(string.format("道具不足[%d],库存[%d]", _num, _itemCount))

			return
		end

		local _itemDataLst = ItemModel.instance:getItemsByItemId(_itemId)

		if _itemDataLst then
			local _itemData = _itemDataLst[1]
			local _itemUuid = _itemData:getUuid()

			data = HackToolUtil.createReduceItemCmd({
				{
					itemId = _itemId,
					num = _num,
					uuid = _itemUuid
				}
			})

			HackToolAgent.instance:sendGmRequest(data)
		else
			printWarn(string.format("无法找到[%d]道具itemData", itemId))
		end
	end
end

function M:switchShowType(tabType)
	goutil.setActive(self._goBasePanel, tabType == kTabType.NORMAL)
	goutil.setActive(self._goRunGroupPanel, tabType == kTabType.RUN_GROUP)
	goutil.setActive(self._goPlotFightPanel, tabType == kTabType.PLOT_FIGHT)
	goutil.setActive(self._goHousePanel, tabType == kTabType.HOUSE)
	goutil.setActive(self._goTaskPanel, tabType == kTabType.TASK)
	goutil.setActive(self._goTmpEntryPanel, tabType == kTabType.TMP_ENTRY)

	self._toggleGroup[tabType].IsOn = true

	HacktoolMo.instance:setTabId(tabType)
end

function M:_onNormalToggle()
	self:switchShowType(kTabType.NORMAL)
end

function M:_onPlotFightToggle()
	self:switchShowType(kTabType.PLOT_FIGHT)
end

function M:_onHouseToggle()
	self:switchShowType(kTabType.HOUSE)
end

function M:_onRunGroupToggle()
	self:switchShowType(kTabType.RUN_GROUP)
end

function M:_onTaskToggle()
	self:switchShowType(kTabType.TASK)
end

function M:_onTaskTmpEntry()
	self:switchShowType(kTabType.TMP_ENTRY)
end

function M:_onClickLocalStorage()
	Astral.LocalStorage.Instance:DeleteAllLocalData()
end

function M:_addAllHero()
	local herogmstr = self._heroGMStrInput:GetText()

	HackToolAgent.instance:sendGmStrRequest(herogmstr)
end

function M:_onChangePlotID()
	local value = self._plotIdInput:GetText()

	if not string.nilorempty(value) then
		Astral.LocalStorage.Instance:SetString(PLOT_TEST_ID, value)
	end
end

function M:_showPlot()
	local plotid = PLOT_DEFAULT_ID

	if self._plotIdInput then
		local commandStr = self._plotIdInput:GetText()

		if string.nilorempty(commandStr) then
			FloatWordMgr.instance:show("请输入剧情id")

			return
		end

		plotid = tonumber(commandStr)

		if isInEditorMode then
			local path = string.format("%s/GameAssets/shared/story/stories/%s/cfgdata.json", UnityEngine.Application.dataPath, plotid)
			local fileExist = SpaceXFileUtil.IsFileExists(path)

			if not fileExist then
				FloatWordMgr.instance:show("剧情配置不存在")

				return
			end
		end

		local _sceId = SceneMgr.instance:getCurSceneId()

		StoryController.instance:Open(plotid)
		Astral.LocalStorage.Instance:SetString(PLOT_TEST_ID, plotid)
		self:close()
	end
end

function M:_skipPlot()
	StoryController.instance:Close(true)
	self:close()
end

function M:_onBattleTest()
	HacktoolMo.instance:setOpenBattle(true)

	if ViewMgr.instance:isOpen(ViewName.BattleTest) then
		ViewMgr.instance:close(ViewName.BattleTest)
	end

	ViewMgr.instance:open(ViewName.BattleTest)
end

function M:_onDungeonBattleTest()
	local battleLevelCode = checkint(self._battleLevelCodeInput:GetText())

	if battleLevelCode <= 0 then
		if enableErrorLog then
			printError("Invalid battle level code", battleLevelCode)
		end

		return
	end

	Astral.LocalStorage.Instance:SetString(BATTLE_LEVEL_TEST_ID, battleLevelCode)
	BattleTestUtil.requestDummyBattleLevel(battleLevelCode)
end

function M:_onClickStrengthAccount01()
	local data = HackToolUtil.createHeroLevelAndPower(0)

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickStrengthAccount02()
	local data = HackToolUtil.createHeroLevelAndPower(5)

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickPassAllFB()
	local data = HackToolUtil.createPassAllFB()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickUnlockGuide()
	local data = HackToolUtil.createUnlockAllGuide()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickUnlockThought()
	local data = HackToolUtil.createUnlockAllThought()

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickFrame30()
	UnityEngine.Application.targetFrameRate = 30
end

function M:_onClickFrame45()
	UnityEngine.Application.targetFrameRate = 45
end

function M:_onClickFrame60()
	UnityEngine.Application.targetFrameRate = 60
end

function M:_onBattleDebugToggleChange(_, isOn)
	BattleTestUtil.setDebug(isOn)
end

function M:_onBattleToggleProgramSceneChange(_, isOn)
	BattleTestUtil.setUseProgramScene(isOn)
end

function M:_onBattleToggleHideSceneChange(_, isOn)
	BattleTestUtil.setHideScene(isOn)
end

function M:_onBattleToggleOutputLog(_, isOn)
	BattleTestUtil.setOutputLog(isOn)
end

function M:_onBattleToggleOutputServerLog(_, isOn)
	BattleTestUtil.setOutputServerLog(isOn)
end

function M:_onBattleToggleLevelIDVisiable(_, isOn)
	HacktoolMo.instance:setLevelCodeVisible(isOn)

	if BattleMgr.instance:isInBattle() then
		GlobalDispatcher:dispatchEvent(EventType.SECRET_VISIBLE, 1, isOn)
	end
end

function M:_onClickPassBattle()
	HackToolAgent.instance:sendGmStrRequest("EndBattle 1")
	self:close()
end

function M:_onClickPassBattleLost()
	HackToolAgent.instance:sendGmStrRequest("EndBattle 0")
	self:close()
end

function M:_onClickTestRoguelike()
	ViewMgr.instance:open(ViewName.RogueTestMenu)
end

function M:_onClickClearRoguelike()
	local reqLuaTable = {}

	reqLuaTable.cmd = GameEnum.GMCmdEnum.ClearRoguelikeData
	reqLuaTable.value = {}

	HackToolAgent.instance:sendGmRequest(reqLuaTable)
end

function M:_onClickQuitRoguelike()
	RoguelikeAgent.instance:sendQuitRequest(true)
end

function M:_onClickOpenRoguelikeScript()
	local reqLuaTable = {}

	reqLuaTable.cmd = GameEnum.GMCmdEnum.OpenAllScriptD
	reqLuaTable.value = {}

	HackToolAgent.instance:sendGmRequest(reqLuaTable)
end

function M:_onClickPreviewGuide()
	local guideIdStr = self._iptPreviewGuide:GetText()
	local guideIndexStr = self._iptPreviewGuideIndex:GetText()

	if not string.nilorempty(guideIdStr) then
		self:close()

		local guideId = tonumber(guideIdStr)

		if guideId and guideId > 0 then
			GuideModel.instance:gmStartGuide(guideId)

			local stepId = 1

			if not string.nilorempty(guideIndexStr) then
				stepId = tonumber(guideIndexStr)
			end

			GuideController.instance:startGudie(guideId, stepId)
		end
	end
end

function M:_onClickDeleteGuide()
	local guideIdStr = self._iptPreviewGuide:GetText()
	local guideMap = {}

	if not string.nilorempty(guideIdStr) then
		local guideArray = string.split(guideIdStr, "#")

		for _, v in pairs(guideArray) do
			local guideId = tonumber(v)

			table.insert(guideMap, guideId)
		end
	end

	local reqLuaTable = HackToolUtil.createDeletGuide(guideMap)

	HackToolAgent.instance:sendGmRequest(reqLuaTable)
	self:close()
end

function M:_onClickJumpNewPlayer()
	HackToolAgent.instance:sendGmStrRequest("PassNoviceProcess")
	self:close()
	LoginController.instance:_onClickReturnToLogin()
end

function M:_onClickBattleRecord()
	ViewMgr.instance:open(ViewName.BattleRecord)
end

function M:_onClickBattleCalculate()
	self:close()
	BattleMgr.instance:enter(false, BattleCalculateEditorFlow)
end

function M:_onClickMainlineDungeon()
	self:close()
	ViewMgr.instance:openSpecialView(ViewName.MainlineEditorView)
end

function M:_onClickPassGuide()
	return
end

function M:_onClickSystemInfo()
	self._systemInfoView:active()
end

function M:_onClickDebugMessage()
	if MsgDebugger.instance:isShow() then
		MsgDebugger.instance:destroy()
	else
		MsgDebugger.instance:show()
	end
end

function M:_onClickOpenAllSystem()
	HackToolAgent.instance:sendGmRequest({
		cmd = GameEnum.GMCmdEnum.OpenAllSystem
	})
	FloatWordMgr.instance:show("所有已上线功能开启，重登账号才能生效")
end

function M:_onClickCopyUID()
	TextUtils.CopyText(PlayerModel.instance:getId())
end

local call_key = "call"
local return_key = "return"
local logic_key = "logic"

function profiler._profiling_handler(hooktype)
	if hooktype == call_key then
		local funcinfo = debug.getinfo(2, "nS")
		local source = funcinfo.short_src or "C_FUNC"

		if string.match(source, logic_key) then
			local name = funcinfo.name or "anonymous"
			local line = string.format("%d", funcinfo.linedefined or 0)
			local title = string.format("%-30s: %s: %s", name, source, line)

			UnityEngine.Profiling.Profiler.BeginSample(title)
		end
	elseif hooktype == return_key then
		local funcinfo = debug.getinfo(2, "nS")
		local source = funcinfo.short_src or "C_FUNC"

		if string.match(source, logic_key) then
			UnityEngine.Profiling.Profiler.EndSample()
		end
	end
end

function M:_onClickSpineCutBtn()
	local modelId = tonumber(self._spineCutInput:GetText())

	ViewMgr.instance:open(ViewName.CharacterSpineCutTest, modelId)
end

function M:_onDungeonToggleChange(_, isOn)
	if isOn then
		local data = {
			cmd = GameEnum.GMCmdEnum.MainlineNoVerification,
			value = {
				{
					on = 1
				}
			}
		}

		HackToolAgent.instance:sendGmRequest(data)
	else
		local data = {
			cmd = GameEnum.GMCmdEnum.MainlineNoVerification,
			value = {
				{
					on = 0
				}
			}
		}

		HackToolAgent.instance:sendGmRequest(data)
	end

	DungeonModel.instance:setAllDungeonUnlock(isOn)
end

function M:_onGuideToggleChange(_, isOn)
	GuideController.instance:forbidGuides(isOn)
end

function M:_onHouseToggleChange(toggle, isOn)
	HouseController.instance:setNamebarVisible(isOn)
end

function M:_onHouseGMToggleChange(toggle, isOn)
	HouseGMController.instance:setGMToggle(isOn)

	if isOn and not HouseGMController.instance:getGMToggle() then
		FloatWordMgr.instance:show("请切换至小屋内再开启该功能")

		self._toggleHouseGM.IsOn = HouseGMController.instance:getGMToggle()
	end
end

function M:_onMainScenePerformEditorToggleChange(toggle, isOn)
	MainUIModel.instance:setPerformEditorVisible(isOn)
end

function M:_onMainSceneAniCamToggleChange(toggle, isOn)
	if isOn then
		if not ViewMgr.instance:isOpen(ViewName.MainPerformEditorView) then
			ViewMgr.instance:openSpecialView(ViewName.MainPerformEditorView)
		end
	else
		ViewMgr.instance:close(ViewName.MainPerformEditorView)
	end
end

function M:_onOptimiseToggleChange(toggle, isOn)
	if isOn then
		if ViewMgr.instance:isOpen(ViewName.HackToolView) then
			ViewMgr.instance:close(ViewName.HackToolView)
		end

		if not OptimizationTA.Ctrl.OptTaCtrl.Instance.isCreated then
			OptimizationTA.Ctrl.OptTaCtrl.Instance.RenderQualitySettings = Gfx.instance:getShaderQualitySettingObj()

			OptimizationTA.Ctrl.OptTaCtrl.Instance:CreateLua()
		end

		OptimizationTA.Ctrl.OptTaCtrl.Instance:Show(true)
	elseif OptimizationTA.Ctrl.OptTaCtrl.Instance.isCreated then
		OptimizationTA.Ctrl.OptTaCtrl.Instance:Show(false)
	end
end

function M:_onUIDetectToggleChange(toggle, isOn)
	MainUIModel.instance:setUIDetectVisible(isOn)

	local show = MainUIModel.instance:getUIDetectVisible()

	if show then
		if not ViewMgr.instance:isOpen(ViewName.MainUIDetectView) then
			ViewMgr.instance:openSpecialView(ViewName.MainUIDetectView)
		end
	else
		ViewMgr.instance:close(ViewName.MainUIDetectView)
	end
end

function M:_onToggleChangeCanvasBuildCheck(toggle, isOn)
	local uiRoot = ViewMgr.instance:getUIRoot()

	if not uiRoot then
		return
	end

	if isOn then
		CanvasUpdateCheck.Get(uiRoot.gameObject)
	else
		CanvasUpdateCheck.Remove(uiRoot.gameObject)
	end
end

function M:_onToggleGitCommit(_, isOn)
	GlobalDispatcher:dispatchEvent(EventType.SECRET_VISIBLE, 2, isOn)
end

function M:_onOpenAddRoleView()
	ViewMgr.instance:open(ViewName.CustomCharacterView)
end

function M:_onOpenAddItemView()
	ViewMgr.instance:open(ViewName.AdditemHacktoolPanelViewPresentor)
	self:close()
end

function M:_onClickAddConfigMail()
	local mailStr = self._iptConfigMail:GetText()
	local mailId = tonumber(mailStr)
	local data = {
		cmd = GameEnum.GMCmdEnum.NewConfigMail,
		value = {
			{
				code = mailId or 1001
			}
		}
	}

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickAddCustomMail()
	local expirTimeStr = self._iptexpiredTime:GetText() or 0
	local sendName = string.nilorempty(self._iptsenderName:GetText()) and "系统" or self._iptsenderName:GetText()
	local location = string.nilorempty(self._iptsenderLocation:GetText()) and "高志大厦" or self._iptsenderLocation:GetText()
	local _title = string.nilorempty(self._iptTitle:GetText()) and "测试手写邮件" or self._iptTitle:GetText()
	local _content = string.nilorempty(self._iptContent:GetText()) and "测试邮件内容" or self._iptContent:GetText()
	local tmpattachment = string.nilorempty(self._iptattachment:GetText()) and 0 or self._iptattachment:GetText()
	local rewardCode = tonumber(tmpattachment)
	local attchmentResult = {}
	local expirTime = tonumber(expirTimeStr)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			if v.code and v.num and v.code ~= GameEnum.CurrencyCodeEnum.EXP then
				attchmentResult[tostring(v.code)] = v.num
			end
		end
	end

	local mail = {
		expiredTime = expirTime or 0,
		senderName = sendName,
		senderLocation = location,
		title = _title,
		content = _content,
		attachment = attchmentResult
	}
	local data = {
		cmd = GameEnum.GMCmdEnum.NewHandWriteMail,
		value = {
			mail
		}
	}

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickCloseMail()
	goutil.setActive(self._mailGo, false)
end

function M:_clickMail()
	goutil.setActive(self._mailGo, true)
end

function M:_clickLottery1()
	self._lotteryView:onEnter()
	self._lotteryView:openPanel1()
end

function M:_clickLottery2()
	self._lotteryView:onEnter()
	self._lotteryView:openPanel2()
end

function M:_clickResetLotteryCard()
	HackToolAgent.instance:sendGmStrRequest("ResetNewbieLottery")
	self:close()
end

function M:_onClickJumpTest()
	local jumpIdStr = self._iptJumpTest:GetText()

	if not string.nilorempty(jumpIdStr) then
		self:close()

		local jumpId = tonumber(jumpIdStr)

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	end
end

function M:_onClickCloseHotUpdate()
	return
end

function M:_onClickShowRunTimeInspector()
	ViewMgr.instance:open(ViewName.RunTimeInspector)
end

function M:syncHotUpdateText()
	local key = "skip_hot_update"
	local isSkip = Astral.LocalStorage.Instance:GetInt(key, 0) == 1

	if isSkip then
		self._txtCloseHotUpdate.text = "关闭热更"
	else
		self._txtCloseHotUpdate.text = "开启热更"
	end
end

function M:_clickExportFurniture()
	HouseFacade.instance:exportFurnitureCfgFile()
end

function M:_clickAddAllFurniture()
	local cos = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.FurnitureItemType)
	local itemList = {}

	for _, co in ipairs(cos) do
		table.insert(itemList, {
			num = 1,
			itemId = co.id
		})
	end

	local data = HackToolUtil.createAddItemCmd(itemList)

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickCreatOdd()
	self:_quickCreateIssue()
end

function M:_clickDeleteAllLoginCache()
	local list = LoginPopUpsConfig.instance:getConfigList(ConfigName.LoginPopUps)

	if list then
		for _, v in ipairs(list) do
			local otherCode, key

			if v.code == LoginPopEnum.PopCode[LoginPopEnum.PopType.LoginOfSeven] then
				local sevenSignActLst = WelfareSigninModel.instance:getAllSevenSignInActMo()

				for index, value in ipairs(sevenSignActLst or {}) do
					otherCode = value:getActivity()
					key = LoginPopUpUtil.getStoreKey(v.code, otherCode)

					Astral.LocalStorage.Instance:DeleteKey(key)
				end
			elseif v.code == LoginPopEnum.PopCode[LoginPopEnum.PopType.Sign] then
				key = LoginPopUpUtil.getStoreKey(v.code, 0)

				Astral.LocalStorage.Instance:DeleteKey(key)
			else
				key = LoginPopUpUtil.getStoreKey(v.code, otherCode)

				Astral.LocalStorage.Instance:DeleteKey(key)
			end
		end
	end

	FloatWordMgr.instance:show("删除所有弹框记录")
end

function M:_clickTask()
	local taskIdStr = self._iptTaskId:GetText()

	if string.nilorempty(taskIdStr) then
		return
	end

	local code = tonumber(taskIdStr)
	local param = HackToolUtil.createFinishTask(code)

	HackToolAgent.instance:sendGmRequest(param)
end

function M:_clickResetTask()
	local taskIdStr = self._iptTaskId2:GetText()

	if string.nilorempty(taskIdStr) then
		return
	end

	local code = tonumber(taskIdStr)
	local type = tonumber(self._btnDropdown.dropdown.value) + 1
	local param = HackToolUtil.resetTask(type, code)

	HackToolAgent.instance:sendGmRequest(param)
end

function M:_clickTryGetHeroId()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroId = viewPageMo and viewPageMo.hero:getId() or -1

	if heroId > 0 then
		self._addTacitHeroIdInput:SetText(heroId)
	else
		self._addTacitHeroIdInput:SetText("")
	end
end

function M:_clickAddTacitExp()
	if string.nilorempty(self._addTacitHeroIdInput:GetText()) or string.nilorempty(self._addTacitExpNumInput:GetText()) then
		return
	end

	local heroId = tonumber(self._addTacitHeroIdInput:GetText())
	local exp = tonumber(self._addTacitExpNumInput:GetText())
	local param = HackToolUtil.createAddTacitExp(heroId, exp)

	HackToolAgent.instance:sendGmRequest(param)
end

function M:_clickResetTacitExp()
	if string.nilorempty(self._resetHeroTacitInput:GetText()) then
		return
	end

	local heroId = tonumber(self._resetHeroTacitInput:GetText())
	local param = HackToolUtil.resetTacit(heroId)

	HackToolAgent.instance:sendGmRequest(param)
end

function M:_clickSwitchBlock()
	if string.nilorempty(self._blockIndexInput:GetText()) then
		return
	end

	if not BattleMgr.instance:isInBattle() then
		return
	end

	local blockStr = self._blockIndexInput:GetText()
	local index = tonumber(blockStr)

	GlobalDispatcher:dispatchEvent(EventType.SWITCH_BLOCK_EVENT, index)
end

function M:_clickDeleteLoginCache()
	local codeStr = self._loginPopCodeInput:GetText()

	if string.nilorempty(codeStr) then
		return
	end

	local code = tonumber(codeStr)

	if code and code > 0 then
		if not LoginPopUpsConfig.instance:getConfigByKey(ConfigName.LoginPopUps, code) then
			FloatWordMgr.instance:show(string.format("登陆弹框表没有[%s],删除无效", code))

			return
		end

		local otherCode, key

		if code == LoginPopEnum.PopCode[LoginPopEnum.PopType.LoginOfSeven] then
			local msg = string.format("删除七日登陆[%s]弹框记录", code)
			local tFail = {}
			local sevenSignActLst = WelfareSigninModel.instance:getAllSevenSignInActMo()

			for index, value in ipairs(sevenSignActLst or {}) do
				otherCode = value:getActivity()
				key = LoginPopUpUtil.getStoreKey(code, otherCode)

				Astral.LocalStorage.Instance:DeleteKey(key)

				if value:isAllReceive() then
					table.insert(tFail, otherCode)
				end
			end

			if msg then
				if #tFail > 0 then
					msg = string.format("%s,%s因签满或当天已签,不会弹出", msg, table.concat(tFail, ","))
				end

				print(msg)
				FloatWordMgr.instance:show(msg)
			end
		elseif code == LoginPopEnum.PopCode[LoginPopEnum.PopType.Sign] then
			key = LoginPopUpUtil.getStoreKey(code, 0)

			Astral.LocalStorage.Instance:DeleteKey(key)

			local msg = string.format("删除每日登陆[%s]弹框记录", code)

			print(msg)
			FloatWordMgr.instance:show(msg)
		else
			key = LoginPopUpUtil.getStoreKey(code, otherCode)

			Astral.LocalStorage.Instance:DeleteKey(key)

			local msg = string.format("删除[%s]弹框记录", code)

			print(msg)
			FloatWordMgr.instance:show(msg)
		end
	end
end

function M:_onClickSave()
	local jaccount = self._accountInput:GetText()
	local jpassword = self._passwordInput:GetText()

	if jaccount == nil or jpassword == nil then
		FloatWordMgr.instance:show("save failed!")
	end

	Astral.LocalStorage.Instance:SetString(JIRA_ACCOUNT, jaccount)
	Astral.LocalStorage.Instance:SetString(JIRA_PASSWORD, jpassword)
	FloatWordMgr.instance:show("save success!")
end

function M:_onClickGuide()
	ViewMgr.instance:open(ViewName.HacktoolGuideView)
end

function M:_onClickHide()
	if Astral.OSDef.isEditor then
		return
	end

	HacktoolMo.instance:setHideBtns(true)

	local btns = {
		goutil.find("TOPMOST/secret_tips(Clone)"),
		goutil.find("TOP/main_hack(Clone)"),
		goutil.find("TOP/main_ui_detect(Clone)"),
		goutil.find("HUD/battle_main(Clone)/modifyAttr")
	}

	for _, btn in pairs(btns) do
		if btn then
			goutil.setActive(btn, false)
		end
	end
end

function M:_onClickTestItemAndHero()
	FloatWordMgr.instance:show("添加成功")

	local data = {
		cmd = GameEnum.GMCmdEnum.AddTestItemAndHero
	}

	HackToolAgent.instance:sendGmRequest(data)
end

local showFps = false

function M:_onClickFps()
	showFps = not showFps

	local starterGO = goutil.find("AstralUnityStarter")

	if not showFps then
		PerformanceDebugger.Remove(starterGO)
	else
		local debuger = PerformanceDebugger.Get(starterGO)

		debuger.isShow = showFps
	end
end

function M:_buildEnvironmentInfo()
	local str = ""
	local servertime = os.date("%Y年%m月%d日%H时%M分%S秒", UserAgent.instance:sendGetServerTimeRequest())
	local SystemInfo = UnityEngine.SystemInfo

	str = str .. "\nUserId: " .. PlayerModel.instance:getId()
	str = str .. "\n服务器名字: " .. LoginModel.instance:getServerName()
	str = str .. "\n服务器时间: " .. servertime
	str = str .. "\n报错信息: " .. DebugErrorFilter.Instance:GetAllErrorLog()
	str = str .. "\n[device model] " .. SystemInfo.deviceModel
	str = str .. "\n[os version] " .. SystemInfo.operatingSystem
	str = str .. "\n[system memory size] " .. SystemInfo.systemMemorySize .. "M"
	str = str .. "\n"
	str = str .. "\n[graphic device name] " .. SystemInfo.graphicsDeviceName .. " (version " .. SystemInfo.graphicsDeviceVersion .. ")"
	str = str .. "\n[graphic memory size] " .. SystemInfo.graphicsMemorySize .. "M"
	str = str .. "\n[graphic max texSize] " .. SystemInfo.maxTextureSize
	str = str .. "\n[graphic shader level] " .. SystemInfo.graphicsShaderLevel
	str = str .. "\n"
	str = str .. "\n[processor type] " .. SystemInfo.processorType
	str = str .. "\n[processor count] " .. SystemInfo.processorCount
	str = str .. "\n[processor frequency] " .. SystemInfo.processorFrequency .. "MHz"
	str = str .. "\n"
	str = str .. "\n[screen size] " .. UnityEngine.Screen.width .. " x " .. UnityEngine.Screen.height
	str = str .. "\n[screen pixel density dpi] " .. UnityEngine.Screen.dpi

	local w, h = AdaptationUtils.GetUISize(0, 0)

	str = str .. "\n[adaptation size] " .. w .. " x " .. h

	return str
end

function M:_quickCreateIssue()
	local jaccount = Astral.LocalStorage.Instance:GetString(JIRA_ACCOUNT)
	local jpassword = Astral.LocalStorage.Instance:GetString(JIRA_PASSWORD)
	local loginjiraurl = "http://jira.info/login.jsp"
	local logindata = TemplateCollectionUtils.CreateDictionary_StringString()
	local cookie = TemplateCollectionUtils.CreateDictionary_StringString()

	logindata:Add("os_username", jaccount)
	logindata:Add("os_password", jpassword)
	logindata:Add("login", "登录")
	HttpUtils.Post(loginjiraurl, logindata, cookie)

	local url = "http://jira.info/secure/QuickCreateIssue.jspa?decorator=none"
	local data = TemplateCollectionUtils.CreateDictionary_StringString()
	local environment = self:_buildEnvironmentInfo()

	data:Add("pid", 10605)
	data:Add("issuetype", 10111)
	data:Add("atl_token", cookie:get_Item("atlassian.xsrf.token"))
	data:Add("formToken", cookie:get_Item("JSESSIONID"))
	data:Add("summary", "【】")
	data:Add("assignee", jaccount)
	data:Add("reporter", jaccount)
	data:Add("customfield_10004", "")
	data:Add("description", "{color:#de350b}描述：{color}\n {color:#de350b}重现步骤：{color}\n {color:#de350b}报错截图：{color}")
	data:Add("priority", 3)
	data:Add("environment", environment)
	data:Add("dnd-dropzone", "")
	data:Add("issuelinks", "issuelinks")
	data:Add("issuelinks-linktype", "is+caused+by")
	data:Add("customfield_10200", "")
	data:Add("customfield_10213", "")

	local reponsecontent = HttpUtils.Post(url, data, cookie)
	local reponse = json.decode(reponsecontent)

	if isInEditorMode then
		local issueurl = "http://jira.info/browse/" .. reponse.issueKey

		SDKManager.getSDKInstacne():showWebBrowser(issueurl, isUserBrowser)
	end
end

function M:_onClickViewEffectInfo()
	goutil.setActive(self._goBasePanel, false)
	goutil.setActive(self._postProcessScrollGo, true)
	self:_showFeatureState()
end

function M:_onClickCloseEffectInfo()
	goutil.setActive(self._postProcessScrollGo, false)
	goutil.setActive(self._goBasePanel, true)
end

function M:_showFeatureState()
	local featureState = false

	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.GODRAY)
	self._togGodRay.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.GLITCH_MASK)
	self._togGlitchMask.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.GLITCH)
	self._togGlitch.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.HEIGHT_FOG)
	self._togHeightFog.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.SCREEN_SPACE_REFLECTION)
	self._togScreenSpaceReflection.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.PLANAR_REFLECTION)
	self._togPlanarReflection.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.WATER_PLANAR_REFLECTION)
	self._togWaterPlanarReflection.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.OCCLUSION)
	self._togOcclusion.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.ADDITIONAL)
	self._togADDITIONAL.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.UIBLUR)
	self._togUIBlur.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.SSAO)
	self._togSSAO.IsOn = featureState
	featureState = SpaceX.RendererFeatureUtils.GetRendererFeatureState(RendererFeatureName.TOON_MASK)
	self._togToonMask.IsOn = featureState
	self._togMsaa.IsOn = SpaceX.GraphicsUtils.IsMsaaEnable()
end

function M:_onTogGodRay(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.GODRAY)
end

function M:_onTogGlitchMask(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.GLITCH_MASK)
end

function M:_onTogGlitch(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.GLITCH)
end

function M:_onTogHeightFog(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.HEIGHT_FOG)
end

function M:_onPlanarReflection(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.PLANAR_REFLECTION)
end

function M:_onTogOcclusion(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.OCCLUSION)
end

function M:_onTogADDITIONAL(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.ADDITIONAL)
end

function M:_onTogUIBlur(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.UIBLUR)
end

function M:_onScreenSpaceReflection(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.SCREEN_SPACE_REFLECTION)
end

function M:_onTogSSAO(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.SSAO)
end

function M:_onTogToonMask(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.TOON_MASK)
end

function M:_onTogWaterPlanarReflection(_, isOn)
	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, RendererFeatureName.WATER_PLANAR_REFLECTION)
end

function M:_onTogMsaa(_, isOn)
	local msaaSampleCount = isOn and 8 or 1

	SpaceX.GraphicsUtils.SetMsaaSampleCount(msaaSampleCount)
end

function M:_onTogRenderScale(_, isOn)
	SpaceX.GraphicsUtils.SetSplitRenderScale(isOn)
end

function M:_onGyrosSimulate(_, isOn)
	local toggleValue = isOn and 1 or 0

	Astral.LocalStorage.Instance:SetInt(ECHO_GYROS_SIMULATE, toggleValue)
end

function M:_loadProfilerScene()
	SceneFace.instance:enterProfilerScene()
end

function M:_loadAutoRunScene()
	SceneFace.instance:enterAutoRunScene()
end

function M:_onClickBtnCrash()
	CommonUtils.ForceCrash()
end

function M:_onClickGC()
	MemoryMgr.instance:gc()
end

function M:_onClickClearCache()
	MemoryMgr.instance:clearPool()
end

function M:_onClickOpenAllView()
	local viewNameFile = Astral.FileUtils.DirectRootPath .. "../Scripts/Lua/logic/common/datadef/ViewName.lua"

	Astral.FileUtils.Instance:CheckDirExistsForFile(viewNameFile)

	local file = assert(io.open(viewNameFile, "r"))
	local line = file:read("*line")

	viewNameList = {}
	nameIndex = 1

	while line do
		local beginStr = string.sub(line, 1, 2)

		if beginStr ~= "--" and not string.nilorempty(beginStr) and beginStr ~= "mo" then
			local viewName = string.match(line, "\"(.+)\"")

			printWarn("===ViewName line name=====", viewName)
			table.insert(viewNameList, viewName)
			settimer(1, self._openViewOneByOne, self, true)
		end

		line = file:read("*line")
	end

	file:close()
end

function M:_openViewOneByOne()
	local viewName = viewNameList[nameIndex]

	if nameIndex > 1 then
		local lastViewName = viewNameList[nameIndex - 1]

		ViewMgr.instance:close(lastViewName)
	end

	trycall(function()
		ViewMgr.instance:preCreate(viewName)
	end)

	nameIndex = nameIndex + 1

	if nameIndex > #viewNameList then
		removetimer(self._openViewOneByOne, self)
	end
end

function M:_onToggleHouseHeroPath(_, isOn)
	HouseDispatcher:dispatchEvent(HouseEventType.GM_SHOW_HERO_PATH, isOn)
end

function M:_onToggleForbidDefaultPerform(_, isOn)
	HouseGMController.instance:setForbidDefaultPerform(isOn)
end

function M:_onToggleLogTips(_, isOn)
	MainUIModel.instance:setLogTipsVisible(isOn)
	GlobalDispatcher:dispatchEvent(EventType.GM_LOG_TIPS_VISIBLE, isOn)
end

function M:_onClickPreviewRoleGet()
	local roleIdStr = self._iptPreviewRoleGet:GetText()

	if not string.nilorempty(roleIdStr) then
		RetrieveFacade.instance:showGetRole(tonumber(roleIdStr))
		self:close()
	end
end

function M:_onClickAirClearRodeoMatch()
	HackToolAgent.instance:sendGmStrRequest("AirClearRodeoMatch")
	self:close()
end

function M:_onClickAirRodeoLastSettleTimeStamp()
	local str = self._inputAirRodeoLastSettleTimeStamp:GetText()

	if string.nilorempty(str) then
		FloatWordMgr.instance:show("请输入时间戳")

		return
	end

	if not AirWorkShopUtil.isSystemOpen(true) then
		return
	end

	local ts = tonumber(str)
	local mondayTime_ts = TimeUtil.instance:getWDayTimeStamp(ts, 1, 5)

	mondayTime_ts = mondayTime_ts <= 0 and 0 or mondayTime_ts

	local nowTime = ServerTime.now()
	local mondayTime_now = TimeUtil.instance:getWDayTimeStamp(nowTime, 1, 5)

	if mondayTime_now <= mondayTime_ts then
		FloatWordMgr.instance:show("请输入上周或之前的时间戳")

		return
	end

	local lastSettleTime = AirWorkShopChallengeModel.instance:getLastSettleWeek()

	lastSettleTime = tonumber(lastSettleTime)

	local content = string.format("修改空气工坊-竞技模式-修改上次结算时间\n记录时间:%s (%s)\n输入时间:%s (%s)\n规整为(将修改为):%s %s", lastSettleTime, TimeUtil.instance:stampToDateStr(lastSettleTime), ts, TimeUtil.instance:stampToDateStr(ts), mondayTime_ts, TimeUtil.instance:stampToDateStr(mondayTime_ts))
	local dialog = Dialog.showMessage("空气工坊", content)

	dialog:setConfirmListener(function()
		local tableData = {
			cmd = GameEnum.GMCmdEnum.AirSetWeek,
			value = {
				week = mondayTime_ts
			}
		}

		HackToolAgent.instance:sendGmRequest(tableData)
		self:close()
	end, self)
end

function M:_onClickStartSampleData()
	Astral.CLog.logEnabled = false
end

function M:_onClickFinishSampleData()
	Astral.CLog.logEnabled = true
end

function M:_onNameInputValueChange(text)
	if text == "" then
		goutil.setActive(self._gmConsoleView:getMainGO(), false)

		return
	end

	goutil.setActive(self._gmConsoleView:getMainGO(), true)
	self._gmConsoleView:refreshData(text)
end

function M:_onClickBg()
	goutil.setActive(self._gmConsoleView:getMainGO(), false)
end

function M:_onClickHideUIRoot()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local canvas = goutil.addComponentOnce(uiRoot, ComponentType.CanvasGroup)

	canvas.alpha = 0

	HacktoolMo.instance:setHideUIEnable(true)
	self:close()
end

function M:updateCurNetwork()
	self._dropDownServerType.dropdown:ClearOptions()

	local ServerType = {
		{
			0,
			"内网开发服"
		},
		{
			1,
			"内网月版本服"
		},
		{
			2,
			"内网周版本服"
		},
		{
			3,
			"内网审核服"
		},
		{
			10,
			"外网开发服"
		},
		{
			11,
			"外网月版本服"
		},
		{
			12,
			"外网版署服"
		},
		{
			13,
			"外网正式服"
		},
		{
			14,
			"外网提审服"
		},
		{
			15,
			"外网预发布服"
		}
	}

	self._serverTypes = ServerType

	for i, v in ipairs(ServerType) do
		local opt = UnityEngine.UI.Dropdown.OptionData.New(v[2])

		self._dropDownServerType.dropdown.options:Add(opt)
	end

	self._dropDownServerType.dropdown.value = -1

	self._dropDownAreaType.dropdown:ClearOptions()

	local AreaType = {
		{
			"cn",
			"CN"
		},
		{
			"xm",
			"XM"
		}
	}

	self._areaTypes = AreaType

	for i, v in ipairs(AreaType) do
		local opt = UnityEngine.UI.Dropdown.OptionData.New(v[2])

		self._dropDownAreaType.dropdown.options:Add(opt)
	end

	self._dropDownAreaType.dropdown.value = -1
end

function M:_onClickChangeNetwork()
	local serverType = self._serverTypes[self._dropDownServerType.dropdown.value + 1][1]
	local areaType = self._areaTypes[self._dropDownAreaType.dropdown.value + 1][1]
	local gameConst = Astral.GameConstParser.Instance:GetLocalGameConst()

	gameConst.gameConfigUrlType = serverType
	gameConst.gameConfigAreaName = areaType

	Astral.GameConstParser.Instance:Save()
	BootstrapGameConfigMgr.switchGameConfig(serverType, areaType)
	print("切换到网络", serverType, areaType)
end

function M:_onClickEchoCardH()
	EchoCardPackController.instance:setHorizontalState(true)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_HV_STATE_CHANGE)
	self:close()
end

function M:_onClickEchoCardV()
	EchoCardPackController.instance:setHorizontalState(false)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_HV_STATE_CHANGE)
	self:close()
end

return M
