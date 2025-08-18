-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\HandsomeDebug.lua

local DebugGM = require("Debug/Modules/DebugGM")
local DebugConst = require("Debug/DebugConst")
local UserData = require("Helper/UserData")
local DebugHelper = DebugHelper
local WYDebugTemplate = {}

WYDebugTemplate.ENTRY_NAME = "危险的指令"

function WYDebugTemplate.clearPostProcess(sender, menu, value)
	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	ImageEffectMgr.CloseAllPostProcess()
end

function WYDebugTemplate.switchPostProcess(sender, menu, value)
	if value == "" then
		return
	end

	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	if value == "turn on" then
		ImageEffectMgr.SwitchPostProcess(true)
	elseif value == "turn off" then
		ImageEffectMgr.SwitchPostProcess(false)
	end
end

local modelStageMSAAOptimization = false

function WYDebugTemplate.switchModelStageMSAAOptimization(sender, menu, value)
	modelStageMSAAOptimization = not modelStageMSAAOptimization

	DebugHelper.SetModelStageMSAAOptimization(modelStageMSAAOptimization)
	MsgManager.notice(modelStageMSAAOptimization and "开启" or "关闭")
end

local shadowOptimization = false

function WYDebugTemplate.switchShadowOptimization(sender, menu, value)
	shadowOptimization = not shadowOptimization

	DebugHelper.SetShadowCameraRTOptimization(shadowOptimization)
	MsgManager.notice(shadowOptimization and "开启" or "关闭")
end

local mainCameraOptimization = false

function WYDebugTemplate.switchMainCameraOptimization(sender, menu, value)
	mainCameraOptimization = not mainCameraOptimization

	DebugHelper.SetMainCameraMSAAOptimization(mainCameraOptimization)
	MsgManager.notice(mainCameraOptimization and "开启" or "关闭")
end

local gyroActive = true

function WYDebugTemplate.clearAllGyro()
	gyroActive = not gyroActive

	local GyroUtils = Framework.Device.GyroUtils

	GyroUtils.SetActive(gyroActive)
	MsgManager.notice(gyroActive and "开启" or "关闭")
end

local fxaaEnabled = false

function WYDebugTemplate.switchFxaa(sender, menu, value)
	local GameQualitySettings = Framework.Settings.GameQualitySettings

	fxaaEnabled = not fxaaEnabled

	if fxaaEnabled then
		GameQualitySettings.LowAA = false
	else
		GameQualitySettings.LowAA = true
	end

	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	ImageEffectMgr.SwitchFxaa(fxaaEnabled)
end

function WYDebugTemplate.switchAntiAliasing(sender, menu, value)
	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager
	local GameQualitySettings = Framework.Settings.GameQualitySettings

	if value == "none" then
		GameQualitySettings.LowAA = true

		ImageEffectMgr.SwitchAntiAliasing(-1)

		return
	end

	GameQualitySettings.LowAA = false

	if value == "FXAA" then
		ImageEffectMgr.SwitchAntiAliasing(0)
	elseif value == "SMAA-Low" then
		ImageEffectMgr.SwitchAntiAliasing(1)
	elseif value == "SMAA-Medium" then
		ImageEffectMgr.SwitchAntiAliasing(2)
	elseif value == "SMAA-High" then
		ImageEffectMgr.SwitchAntiAliasing(3)
	end
end

function WYDebugTemplate.setSMAART(sender, menu, value)
	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	if value == "EdgeTex" then
		ImageEffectMgr.SetSmaaRT(1)
	elseif value == "BlendTex" then
		ImageEffectMgr.SetSmaaRT(2)
	else
		ImageEffectMgr.SetSmaaRT(0)
	end
end

function WYDebugTemplate.switchBloom(sender, menu, value)
	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	if value == "Close" then
		ImageEffectMgr.SwitchBloom(false, false)
	elseif value == "Normal" then
		ImageEffectMgr.SwitchBloom(true, false)
	elseif value == "Artist" then
		ImageEffectMgr.SwitchBloom(true, true)
	end
end

local dofEnabled = false

function WYDebugTemplate.switchDof(sender, menu, value)
	dofEnabled = not dofEnabled

	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager

	ImageEffectMgr.SwitchDof(dofEnabled)
end

function WYDebugTemplate.useHdr(sender, menu, value)
	if value == "" then
		return
	end

	local GameQualitySettings = Framework.Settings.GameQualitySettings

	if value == "true" then
		DebugHelper.Set2DHDR(true)

		GameQualitySettings.LowHDR = false

		CameraModeManager.setHDR(1)
	elseif value == "false" then
		DebugHelper.Set2DHDR(false)

		GameQualitySettings.LowHDR = true

		CameraModeManager.setHDR(0)
	end
end

function WYDebugTemplate.setRTFormat(sender, menu, value)
	if value == "" then
		return
	end

	DebugHelper.SetHdrRenderTexture(value)
end

function WYDebugTemplate.setCameraDepth(sender, menu, value)
	local isHighPrecision = false

	if value == "high" then
		isHighPrecision = true
	elseif value == "low" then
		-- block empty
	end

	for prefabPath, info in pairs(ModelStageManager.modelStageInfo) do
		info.stage:setCameraDepth(isHighPrecision)
	end
end

function WYDebugTemplate.setCameraPlane(sender, menu, value)
	local disList = utils.splitString(value, ",")

	if #disList ~= 2 then
		return
	end

	local nearPlane = disList[1]
	local farPlane = disList[2]

	for prefabPath, info in pairs(ModelStageManager.modelStageInfo) do
		info.stage:setCameraClipPlane(nearPlane, farPlane)
	end
end

function WYDebugTemplate.changeQuality(sender, menu, value)
	if value == "" then
		return
	end

	local GameSettingHelper = Framework.Settings.GameSettingHelper

	if value == "low" then
		GameSettingHelper.SetGameQuality(0)
	elseif value == "fast" then
		GameSettingHelper.SetGameQuality(1)
	elseif value == "middle" then
		GameSettingHelper.SetGameQuality(2)
	elseif value == "high" then
		GameSettingHelper.SetGameQuality(3)
	elseif value == "fantastic" then
		GameSettingHelper.SetGameQuality(4)
	end
end

function WYDebugTemplate.printTier()
	return
end

function WYDebugTemplate.setTier(sender, menu, value)
	if value == "" then
		return
	end

	DebugHelper.SetActiveTier(tonumber(value))
end

function WYDebugTemplate.playSequenceFrame(sender, menu, value)
	if value == "" then
		return
	end

	local function callback(...)
		local dlg = UIManager.getUI("sequenceFramePlayer", nil, false)

		if dlg then
			dlg:setVisible(false)
		end
	end

	local url = string.format("HeroUltra/%s/video_%s_ultra_short.mp4", value, value)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:playVideo(url, false, callback, false)
end

function WYDebugTemplate.playSequenceFrame2(sender, menu, value)
	if value == "" then
		return
	end

	local function callback(...)
		local dlg = UIManager.getUI("sequenceFramePlayer", nil, false)

		if dlg then
			dlg:pauseVideo()
		end
	end

	local url

	if value == "output" then
		url = string.format("Videos/%s.webm", value)
	else
		url = string.format("Videos/%s.mp4", value)
	end

	local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

	playerDlg:playVideo(url, false, callback)
end

function WYDebugTemplate.stopSequenceFrame(...)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		playerDlg:stop2DAnimation()
	end
end

function WYDebugTemplate.pauseOrResumeVideo(...)
	local playerDlg = UIManager.getUI("sequenceFramePlayer", nil, false)

	if playerDlg then
		if not WYDebugTemplate.isVideoPause then
			playerDlg:pauseVideo()

			WYDebugTemplate.isVideoPause = true
		else
			playerDlg:resumeVideo()

			WYDebugTemplate.isVideoPause = false
		end
	end
end

function WYDebugTemplate._repeatPlayCallback(url)
	for i = 1, 10000 do
		local dlg = UIManager.getUI("sequenceFramePlayer", nil, false)

		if dlg then
			dlg:setVisible(false)
		end

		coroutine.step()

		local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

		playerDlg:playVideo(url, false, nil, false, true)
		coroutine.wait(3)
		WYDebugTemplate.captureScreen()
		coroutine.step()

		if WYDebugTemplate.captureScript.ColorValue < 10 then
			-- block empty
		end
	end
end

function WYDebugTemplate.captureScreen()
	if not WYDebugTemplate.captureScript then
		local GameObject = UnityEngine.GameObject
		local scriptGO = GameObject("CaptureScreen")
		local ReadScreenPixelComponent = typeof(ReadScreenPixel)

		WYDebugTemplate.captureScript = scriptGO:AddComponent(ReadScreenPixelComponent)
	end

	WYDebugTemplate.captureScript:GetPixelColor()
end

function WYDebugTemplate.playVideoSpecial(sender, menu, value)
	if value == "" then
		return
	end

	coroutine.start(WYDebugTemplate._repeatPlayCallback, value)
end

local loadDelay = UserData.loadCommonData("AsyncLoadDelay")

loadDelay = tonumber(loadDelay)

if loadDelay then
	DebugHelper.SetLoadDelay(loadDelay)
end

function WYDebugTemplate.setLoadDelay(sender, menu, value)
	DebugHelper.SetLoadDelay(tonumber(value))
	UserData.saveCommonData("AsyncLoadDelay", value)
end

local QualitySettings = UnityEngine.QualitySettings
local ShadowResolution = UnityEngine.ShadowResolution

function WYDebugTemplate.setShadowDistance(sender, menu, value)
	QualitySettings.shadowDistance = value
end

function WYDebugTemplate.setShadowOffset(sender, menu, value)
	QualitySettings.shadowNearPlaneOffset = value
end

function WYDebugTemplate.setShadowResolution(sender, menu, value)
	if value == "" then
		return
	end

	if value == "Low" then
		QualitySettings.shadowResolution = ShadowResolution.Low
	elseif value == "Medium" then
		QualitySettings.shadowResolution = ShadowResolution.Medium
	elseif value == "High" then
		QualitySettings.shadowResolution = ShadowResolution.High
	else
		QualitySettings.shadowResolution = ShadowResolution.VeryHigh
	end
end

function WYDebugTemplate.getShadowInfo()
	local resString = ""

	if QualitySettings.shadowResolution == ShadowResolution.Low then
		resString = "Low"
	elseif QualitySettings.shadowResolution == ShadowResolution.Medium then
		resString = "Medium"
	elseif QualitySettings.shadowResolution == ShadowResolution.High then
		resString = "High"
	elseif QualitySettings.shadowResolution == ShadowResolution.VeryHigh then
		resString = "VeryHigh"
	end
end

function WYDebugTemplate.setModelStageRTScale(sender, menu, value)
	DebugHelper.SetRTScale(tonumber(value))
end

function WYDebugTemplate.setModelStageRenderStep(sender, menu, value)
	local step = tonumber(value)

	for prefabPath, stageInfo in pairs(ModelStageManager.modelStageInfo) do
		stageInfo.stage:skipRenderMode(step)
	end
end

function WYDebugTemplate.setSceenScale(sender, menu, value)
	local scale = tonumber(value)
	local DeviceHelper = require("Helper/DeviceHelper")
	local GameSettings = require("Helper/GameSettings")

	local function fakeScreenScale()
		return scale
	end

	GameSettings.qualityScreenScale = fakeScreenScale

	DeviceHelper.setRenderResolution()
end

function WYDebugTemplate.resetOriSceenScale()
	local DeviceHelper = require("Helper/DeviceHelper")
	local GameSettingHelper = Framework.Settings.GameSettingHelper
	local resolution = GameSettingHelper.GetOrigResolution()

	DeviceHelper.screenScale = 1

	DeviceHelper._setResolution(resolution.width, resolution.height)
end

function WYDebugTemplate.setRTSize(sender, menu, value)
	local valueList = utils.splitString(value, ",")

	if #valueList < 1 then
		return
	end

	local width = tonumber(valueList[1])
	local height = tonumber(valueList[2])

	DebugHelper.SetModelStageRTSize(width, height)
end

function WYDebugTemplate.setTargetFrame(sender, menu, value)
	local frame = tonumber(value)
	local LuaToolkit = Framework.Tools.LuaToolkit

	LuaToolkit.SetTargetFrameRate(value)
end

function WYDebugTemplate.setModelStageAntiAliasing(sender, menu, value)
	DebugHelper.SetModelStageRTAntiAliasing(tonumber(value))
end

function WYDebugTemplate.setQualitySettingAntiAliasing(sender, menu, value)
	DebugHelper.SetQualitySettingAntiAliasing(tonumber(value))
	CameraModeManager.setMSAA(tonumber(value))
end

function WYDebugTemplate.setAUPTimeSlice(sender, menu, value)
	local GameSettingHelper = Framework.Settings.GameSettingHelper
	local slice = tonumber(value)

	GameSettingHelper.SetAUPTimeSlice(slice)
end

function WYDebugTemplate.setAUPBufferSize(sender, menu, value)
	local GameSettingHelper = Framework.Settings.GameSettingHelper
	local size = tonumber(value)

	GameSettingHelper.SetAUPBufferSize(size)
end

function WYDebugTemplate.setAUPOn(sender, menu, value)
	if value == "true" then
		LoadManager.aupPowerOn = true
	elseif value == "false" then
		LoadManager.aupPowerOn = false
	end
end

function WYDebugTemplate.setVocalLanguage(sender, menu, value)
	local GameSettings = require("Helper/GameSettings")

	if value == "CN" then
		GameSettings.setVocalLanguage()
	elseif value == "JP" then
		GameSettings.setVocalLanguage("JP")
	end
end

function WYDebugTemplate.setSoftShadow(sender, menu, value)
	if value == "" then
		return
	end

	if value == "soft" then
		DebugHelper.SetSoftShadow(true)
	elseif value == "hard" then
		DebugHelper.SetSoftShadow(false)
	end
end

function WYDebugTemplate.setShadowCloseFit(sender, menu, value)
	if value == "" then
		return
	end

	if value == "close fit" then
		DebugHelper.SetShadowCloseFit(true)
	elseif value == "stable fit" then
		DebugHelper.SetShadowCloseFit(false)
	end
end

function WYDebugTemplate.stopShadow()
	local CustomShadowManager = require("System/CustomShadowManager")

	CustomShadowManager.clearShadow()
	DebugHelper.SetShadows(0)
end

function WYDebugTemplate.setShadow(sender, menu, value)
	if value == "" then
		return
	end

	local ShadowMapManager = Framework.Render.ShadowMap.ShadowMapManager

	if value == "close" then
		WYDebugTemplate.stopShadow()
	elseif value == "open" then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			GameFsm.getState(Const.STATE_BATTLE):_setCustomShadowActive(true)
		elseif GameFsm.isInState(Const.STATE_MAIN_HOME) then
			local stage = ModelStageManager.getModelStage("ModelStage/NewDisplayModelStage")

			stage:manualActiveShadow(true)
		else
			local PerformManager = require("Logic/perform/PerformManager")

			PerformManager.setCustomShadowActive(true)
		end

		ShadowMapManager.SetSoftShadow(false)
	elseif value == "soft" then
		ShadowMapManager.SetSoftShadow(true)
	end
end

function WYDebugTemplate.setShadowRTSize(sender, menu, value)
	if value == "" then
		return
	end

	local ShadowMapManager = Framework.Render.ShadowMap.ShadowMapManager

	ShadowMapManager.SetTextureSize(tonumber(value))
end

function WYDebugTemplate.stopAutoRotate(...)
	DebugHelper.StopAutoRotate()
end

function WYDebugTemplate.testFlyIcon(...)
	local FlyIconUtils = require("UI/Common/FlyIconUtils")
	local stageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if stageDlg then
		FlyIconUtils.setFlyEffect3DToUI(Vector3(-115.97, 74.81, 1777.76), stageDlg.partHook.btnGet)
	end
end

function WYDebugTemplate.getAstcSupport()
	DebugHelper.GetAstcSupport()
end

local function testVideoAVG()
	UIManager.playAVG(1, nil, nil)
end

local SCENE_LIST = {
	6,
	5,
	1
}

function WYDebugTemplate.switchScene(sender, menu, value)
	if value == "" then
		return
	end

	local tgtSceneNo = SCENE_LIST[tonumber(value)]

	SceneManager.addLoadScene(tgtSceneNo)

	local function loadCallback()
		return
	end

	LoadManager.start(loadCallback)
end

function WYDebugTemplate.loadAllModels()
	local Model = require("Entity/Model")
	local ResCommonModel = require("ClientData/ResCommonModel")
	local ModelFactory = Framework.Entity.ModelFactory

	local function loadCallback(modelInstanceId)
		local modelGO = ModelFactory.GetModelObject(modelInstanceId)
	end

	for modelId, v in pairs(ResCommonModel) do
		local entityModel = Model(loadCallback, modelId)

		entityModel:setModelDataShow(modelId, Const.MODEL_TYPE.ShowResult)
		entityModel:loadGameObject(nil, true)
	end
end

function WYDebugTemplate.changeModel(sender, menu, value)
	local ModelTool = require("Entity/ModelTool")
	local ModelFactory = Framework.Entity.ModelFactory
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.ShowStepOne
	modelData.model_id = tonumber(value)
	modelData.scale = 1.2

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)
	local modelInsId = heroMainDlg.curModelInsId
	local _modelData = ModelTool.analyzeModelData(modelData)

	ModelFactory.ReplaceModelAll(modelInsId, _modelData, nil)
	ModelFactory.SetModelLayer(modelInsId, Const.LAYER_ROLE2)
end

function WYDebugTemplate.newbieDrawCard(...)
	DebugGM.executeGM(nil, nil, "//stage 1 2 4")
	DebugGM.executeGM(nil, nil, "//task complete 100")
	DebugGM.executeGM(nil, nil, "//item 100002 9000")
end

local heros = {
	{
		resid = 214007
	},
	{
		resid = 214001
	},
	{
		resid = 211101
	},
	{
		resid = 215009
	},
	{
		resid = 214008
	},
	{
		resid = 215007
	},
	{
		resid = 214101
	},
	{
		resid = 211005
	},
	{
		resid = 213101
	},
	{
		resid = 213011
	}
}

function WYDebugTemplate.fakeDrawCard(...)
	local Hero = require("Common/Object/Hero")

	CurAvatar.lastDrawItems = {}

	for i, v in ipairs(heros) do
		local tempHero = Hero(v)

		table.insert(CurAvatar.lastDrawItems, tempHero)
	end

	local drawOptDlg = UIManager.getUI("drawCardOperateDlg", true)

	drawOptDlg:showDrawCardOperate(Const.DrawTypeStandard, #CurAvatar.lastDrawItems == 1)
end

UserData.saveCommonData("HeightFog", "0")

Framework.Settings.GameQualitySettings.LowHeightFog = true

function WYDebugTemplate.enableHeightFog(...)
	local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager
	local GameQualitySettings = Framework.Settings.GameQualitySettings
	local heightFogStr = UserData.loadCommonData("HeightFog")

	if heightFogStr == "1" then
		UserData.saveCommonData("HeightFog", "0")
		MsgManager.notice("关闭高度雾")

		GameQualitySettings.LowHeightFog = true
	else
		UserData.saveCommonData("HeightFog", "1")
		MsgManager.notice("开启高度雾")

		GameQualitySettings.LowHeightFog = false
	end
end

function WYDebugTemplate.changeMainMenuModelStage(sender, menu, value)
	if value == "" then
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage"
	else
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage_" .. value
	end
end

function WYDebugTemplate.lowQuality()
	local GameSettings = require("Helper/GameSettings")

	GameSettings.tryToNoticeQuality()
end

function WYDebugTemplate.clearPref()
	local PlayerPrefs = UnityEngine.PlayerPrefs

	PlayerPrefs.DeleteAll()
end

function WYDebugTemplate.printScreenInfo()
	local SystemInfo = UnityEngine.SystemInfo
	local Screen = UnityEngine.Screen
	local model = string.lower(SystemInfo.deviceModel)
	local GameSettings = require("Helper/GameSettings")
	local width, height, density = GameSettings.getScreenRealMetrics()
	local dpi = Screen.dpi
	local DeviceHelper = require("Helper/DeviceHelper")
	local LuaToolkit = Framework.Tools.LuaToolkit
	local SDKAppUtils = require("SDK/SDKAppUtils")
	local deviceInfo = string.format("CpuType:%s  OS:%s  DevModel:%s  NativeDevID:%s", LuaToolkit.GetProcessorType(), LuaToolkit.GetOperatingSystem(), LuaToolkit.GetDeviceModel(), SDKAppUtils.getNativeDeviceID())
	local settingInfo = string.format("Custom:%s, Resolution:%s, MSAA:%s, FPS:%s", GameSettings.customQuality, GameSettings.ResolutionLv, GameSettings.MSAAEnable, GameSettings.HighFramerate)
end

function WYDebugTemplate.mainBgChangeHero(sender, menu, value)
	if not CurAvatar then
		return
	end

	local mainBg = UIManager.getUI("homeBg", nil, false)

	if not mainBg then
		return
	end

	local Hero = require("Common/Object/Hero")
	local heroId = tonumber(value)

	local function tmpRoleInfo(...)
		local heros = {
			Hero({
				resid = heroId
			})
		}

		return heros
	end

	CurAvatar.getMyRoleInfoHeros = tmpRoleInfo

	mainBg:onRefresh()
	WYDebugTemplate.setModelStageRenderStep(sender, menu, 0)
end

function WYDebugTemplate.test3DUI()
	local srType = typeof(UnityEngine.SpriteRenderer)
	local aTran = UnityEngine.GameObject.Find("A")
	local A = aTran.transform:GetComponent(srType)
	local cTran = UnityEngine.GameObject.Find("C")
	local C = cTran.transform:GetComponent(srType)

	A.sprite = C.sprite

	local labelType = typeof(UnityEngine.UI.Text)
	local bTran = UnityEngine.GameObject.Find("B")
	local B = bTran.transform:GetComponent(labelType)

	if B.text == "这是名字" then
		B.text = "小A"
	else
		B.text = "这是名字"
	end
end

local useCustomAmbient = false

function WYDebugTemplate.switchHeroDlgSkinAmbient()
	local stage = ModelStageManager.getModelStage("ModelStage/HeroDlgModelStage")

	useCustomAmbient = not useCustomAmbient

	for _, modelAux in pairs(stage._models) do
		if useCustomAmbient then
			modelAux:SetMaterialKeyword("CUSTOM_AMBIENT", useCustomAmbient)
		else
			modelAux:ResetMaterialKeyword("CUSTOM_AMBIENT")
		end
	end
end

function WYDebugTemplate.switchMemoryCache(sender, menu, value)
	if value == "" then
		return
	end

	local DeviceHelper = require("Helper/DeviceHelper")

	if value == "None" then
		DeviceHelper.loaderDelayDisposeOn(0)
		DeviceHelper.setUICache(true)
		EffectManager:changePoolCleanCount(10)
	elseif value == "Low" then
		DeviceHelper.loaderDelayDisposeOn(1)
		DeviceHelper.setUICache(true)
		EffectManager:changePoolCleanCount(30)
	elseif value == "High" then
		DeviceHelper.loaderDelayDisposeOn(2)
		DeviceHelper.setUICache(false)
		EffectManager:changePoolCleanCount(60)
	end
end

function WYDebugTemplate.completeNewbieAchieve(...)
	DebugGM.executeGM(nil, nil, "//stage 1 2 4")
	DebugGM.executeGM(nil, nil, "//attr 4 40 ")
	DebugGM.executeGM(nil, nil, "//task complete 150")
	DebugGM.executeGM(nil, nil, "//item 100002 15000")
	DebugGM.executeGM(nil, nil, "//action set 49 13130")
	DebugGM.executeGM(nil, nil, "//action set 50 150")
	DebugGM.executeGM(nil, nil, "//action set 42 8")
	DebugGM.executeGM(nil, nil, "//action set 43 12")
	DebugGM.executeGM(nil, nil, "//action set 72 2")
	DebugGM.executeGM(nil, nil, "//action set 39 12")
	DebugGM.executeGM(nil, nil, "//action set 103 1")
	DebugGM.executeGM(nil, nil, "//action set 86 1")
	DebugGM.executeGM(nil, nil, "//action set 87 1")
	DebugGM.executeGM(nil, nil, "//action set 88 1")
	DebugGM.executeGM(nil, nil, "//action set 31 15")
	DebugGM.executeGM(nil, nil, "//action set 21 15")
	DebugGM.executeGM(nil, nil, "//action set 132 200")
	DebugGM.executeGM(nil, nil, "//action set 131 36")
end

function WYDebugTemplate.getAllSkin()
	local ResHero = require("ClientData/ResHero")

	for k, v in pairs(ResHero) do
		RPC.executeGM("//hero " .. k)
	end
end

function WYDebugTemplate.tempFunc()
	WYDebugTemplate.getAllSkin()
end

function WYDebugTemplate.tempFunc2(...)
	collectgarbage("collect")
end

function WYDebugTemplate.tempFunc3(...)
	DebugHelper.GCCShap()
end

function WYDebugTemplate.tempFunc4(...)
	WYDebugTemplate.printScreenInfo()
end

local MOVIE_LIST = {
	"",
	"11001",
	"11003",
	"12001",
	"12002",
	"12003",
	"13001",
	"13002",
	"13003",
	"14003",
	"15001",
	"15002"
}
local MOVIE_LIST_2 = {
	"",
	"HeroUltra/12003/video_12003_ultra_short.mp4",
	"Videos/xinshou_1.mp4"
}
local SPEC_MOVIE_LIST = {
	"",
	"scene",
	"video_Ori_High_High",
	"video_Ori_High_Mid",
	"video_Ori_High_Low",
	"video_Ori_Mid_High",
	"video_Ori_Mid_Mid",
	"video_Ori_Mid_Low",
	"video_Ori_Low_High",
	"video_Ori_Low_Mid",
	"video_Ori_Low_Low",
	"video_Half_High_High",
	"video_Half_Mid_Mid",
	"video_Half_Low_Low"
}

WYDebugTemplate.FUNC_MENU = {
	{
		name = "临时功能",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.tempFunc
	},
	{
		name = "临时功能2",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.tempFunc2
	},
	{
		name = "临时功能3",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.tempFunc3
	},
	{
		name = "临时功能4",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.tempFunc4
	},
	{
		name = "Set RT format",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.setRTFormat,
		value = {
			"",
			"RGB111110Float",
			"ARGBHalf",
			"ARGB32"
		}
	},
	{
		name = "播放测试视频",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.playVideoSpecial,
		value = MOVIE_LIST_2
	},
	{
		name = "cache选项",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.switchMemoryCache,
		value = {
			"",
			"None",
			"Low",
			"High"
		}
	},
	{
		name = "LoadDelay",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = WYDebugTemplate.setLoadDelay
	},
	{
		name = "Use HDR",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.useHdr,
		value = {
			"",
			"true",
			"false"
		}
	},
	{
		name = "Get Tier",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.printTier
	},
	{
		name = "Set Tier",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.setTier,
		value = {
			"",
			"0",
			"1",
			"2"
		}
	},
	{
		name = "相机深度",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.setCameraDepth,
		value = {
			"",
			"low",
			"high"
		}
	},
	{
		name = "ModelStage隔帧渲染",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = WYDebugTemplate.setModelStageRenderStep
	},
	{
		name = "屏幕缩放",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = WYDebugTemplate.setSceenScale
	},
	{
		name = "目标帧率",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = WYDebugTemplate.setTargetFrame
	},
	{
		name = "阴影参数",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.setShadow,
		value = {
			"",
			"close",
			"open",
			"soft"
		}
	},
	{
		name = "阴影贴图尺寸",
		typ = DebugConst.BTN_TYPE_COMBOX,
		func = WYDebugTemplate.setShadowRTSize,
		value = {
			"",
			"1024",
			"2048"
		}
	},
	{
		name = "开关高度雾",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.enableHeightFog
	},
	{
		name = "清除应用数据",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = function()
			UserData.clearAllCommonData()
		end
	},
	{
		name = "Clear PostProcess",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = WYDebugTemplate.clearPostProcess
	}
}

return WYDebugTemplate
