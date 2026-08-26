-- chunkname: @modules/logic/bgmswitch/controller/BGMSwitchController.lua

module("modules.logic.bgmswitch.controller.BGMSwitchController", package.seeall)

local BGMSwitchController = class("BGMSwitchController", BaseController)

function BGMSwitchController:onInit()
	self._hasStopMainBgm = nil
	self._bgmProgress = BGMSwitchProgress.New()
end

function BGMSwitchController:reInit()
	self._hasStopMainBgm = nil
	self._ppk = nil

	TaskDispatcher.cancelTask(self._delayStartAll, self)
end

function BGMSwitchController:addConstEvents()
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterScene, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExistScene, self)
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStoryStart, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onStoryFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, self._onTriggerEvent, self)
	self.registerCallback(self, BGMSwitchEvent.SwitchGearByGuide, self._switchGearByGuide, self)
end

function BGMSwitchController:_isPlayableView()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]
	local playViewList = self:_getPlayViewList()

	for _, view in pairs(playViewList) do
		if topView == view then
			return true
		end
	end

	return NavigateMgr.instance:isMainViewInTop()
end

function BGMSwitchController:_getPlayViewList()
	return {
		ViewName.MainSwitchView,
		ViewName.SurvivalOperActFullView,
		ViewName.TowerDeepOperActFullView
	}
end

function BGMSwitchController:_onEnterScene(curSceneType, curSceneId)
	if curSceneType == SceneType.Main and LoginController.instance:isEnteredGame() and self:_isPlayableView() then
		self:checkStartAll()
	end
end

function BGMSwitchController:_onExistScene(curSceneType, curSceneId, nextSceneType)
	if curSceneType == SceneType.Main then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)

		self._hasStopMainBgm = true
	end
end

function BGMSwitchController:_onStoryStart()
	TaskDispatcher.cancelTask(self._delayStartAll, self)
	self:checkStopAll()
end

function BGMSwitchController:_onStoryFinish()
	self:checkStartAll()
end

local StopBgmViews

function BGMSwitchController:_onOpenView(viewName)
	StopBgmViews = StopBgmViews or {
		[ViewName.WeekWalkView] = true
	}

	if StopBgmViews[viewName] then
		self:checkStopAll()
	end

	if self:_isPlayableView() then
		self:checkStartAll()
	end
end

function BGMSwitchController:_onCloseView()
	if self:_isPlayableView() then
		TaskDispatcher.runDelay(self._onCloseViewCheckAgain, self, 0.1)
	end
end

function BGMSwitchController:_onCloseViewCheckAgain()
	if self:_isPlayableView() then
		self:checkStartAll()
	end
end

local StopMainBgmBusDict = {
	[AudioEnum.Bgm.Stop_LeiMiTeBeiBgm] = true
}

function BGMSwitchController:_onTriggerEvent(audioId)
	if StopMainBgmBusDict[audioId] then
		self:checkStopAll()
	end
end

function BGMSwitchController:checkStopAll()
	local isMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main

	if isMainScene then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)
		WeatherController.instance:stopWeatherAudio()

		self._hasStopMainBgm = true

		self._bgmProgress:stopMainBgm()
	end
end

function BGMSwitchController:checkStartAll()
	TaskDispatcher.runDelay(self._delayStartAll, self, 0.1)
end

function BGMSwitchController:_delayStartAll()
	local isMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main

	if self._hasStopMainBgm and isMainScene then
		self._hasStopMainBgm = nil

		self:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function BGMSwitchController:startAllOnLogin()
	local isMainScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Main

	if isMainScene then
		local gear = BGMSwitchModel.instance:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear)

		BGMSwitchModel.instance:setMechineGear(gear)
		self:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function BGMSwitchController:checkStartMainBGM(bForce)
	TaskDispatcher.cancelTask(self._delayStartAll, self)

	local audioId = self:getBgmAudioId()

	if not bForce and audioId == self._mainAudioId then
		return
	end

	if audioId then
		self:playMainBgm(audioId, bForce, true)
	end

	if isDebugBuild then
		local playModel = BGMSwitchModel.instance:getBGMPlayMode()
		local currServerSelBgmList = BGMSwitchModel.instance:getCurrentServerUsingBgmList()
		local currBgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(audioId)
		local prevBgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(self._preAudioId)
		local var_18_0 = {}

		var_18_0[StatEnum.EventProperties.AudioId] = currBgmCo and tostring(currBgmCo.id) or nil

		if currBgmCo then
			var_18_0[StatEnum.EventProperties.AudioName] = currBgmCo.audioName or nil
		end

		if prevBgmCo then
			var_18_0[StatEnum.EventProperties.BeforeSwitchAudio] = prevBgmCo.audioName or nil
		end

		var_18_0[StatEnum.EventProperties.OperationType] = "background bgm auto next"
		var_18_0[StatEnum.EventProperties.PlayMode] = playModel == BGMSwitchEnum.PlayMode.Random and "Random" or "LoopOne"
		var_18_0[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currServerSelBgmList)

		local properties = var_18_0

		logNormal("track checkStartMainBGM: " .. cjson.encode(properties))
	end
end

function BGMSwitchController:playMainBgm(audioId, bForce, bStopPrevBgmImmediately)
	if not bForce and audioId == self._mainAudioId then
		return
	end

	self._mainAudioId = audioId

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	self:stopMainBgm()
	BGMSwitchController.instance:resumeMainBgm()

	if self._preAudioId ~= nil and self._preAudioId ~= audioId and bStopPrevBgmImmediately and self._playingId then
		local currBgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(self._preAudioId)

		if currBgmCo then
			AudioMgr.instance:stopPlayingID(self._playingId)
		end
	end

	self._playingId = AudioMgr.instance:triggerEx(audioId, bit.bor(AkCallbackEnum.Type.AK_EnableGetSourcePlayPosition, AkCallbackEnum.Type.AK_Duration), nil)
	self._preAudioId = audioId

	self._bgmProgress:playMainBgm(audioId)
	self:dispatchEvent(BGMSwitchEvent.OnPlayMainBgm, audioId)
end

function BGMSwitchController:getPlayingId()
	return self._playingId
end

function BGMSwitchController:getMainBgmAudioId()
	return self._mainAudioId
end

function BGMSwitchController:stopMainBgm()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Replay_Mainmusic1_9)
	self._bgmProgress:stopMainBgm()
end

function BGMSwitchController:pauseMainBgm()
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function BGMSwitchController:resumeMainBgm()
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
end

function BGMSwitchController:backMainBgm()
	if BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId then
		return
	end

	local audioId = self:getBgmAudioId()

	if audioId and self._preAudioId ~= audioId then
		self:playMainBgm(audioId, true, true)
	end
end

function BGMSwitchController:getBgmAudioId()
	local isBgmUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	if isBgmUnlock then
		local usedBgmId = BGMSwitchModel.instance:getUsedBgmIdFromServer()

		if BGMSwitchModel.instance:isRandomBgmId(usedBgmId) then
			usedBgmId = BGMSwitchModel.instance:nextBgm(1, true)
		end

		local bgmSwitchCO = BGMSwitchConfig.instance:getBGMSwitchCO(usedBgmId)
		local audioId = bgmSwitchCO and bgmSwitchCO.audio

		return audioId or AudioEnum.UI.Play_Replay_Music_Daytime
	end

	return AudioEnum.UI.Play_Replay_Music_Daytime
end

function BGMSwitchController:getProgress()
	return self._bgmProgress:getProgress()
end

function BGMSwitchController:openBGMSwitchView(isThumbnail)
	ViewMgr.instance:openView(ViewName.BGMSwitchView, isThumbnail)
end

function BGMSwitchController:openBGMSwitchMusicFilterView()
	ViewMgr.instance:openView(ViewName.BGMSwitchMusicFilterView)
end

function BGMSwitchController:_switchGearByGuide(gearStateStr)
	local oriGear = BGMSwitchModel.instance:getMechineGear()
	local gearStateNum = tonumber(gearStateStr)

	if gearStateNum == BGMSwitchEnum.Gear.OFF then
		self:stopMainBgm()
	end

	BGMSwitchModel.instance:setMechineGear(gearStateNum)
	self:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
end

function BGMSwitchController:hasBgmRedDot()
	local isBgmUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	if not isBgmUnlock then
		return false
	end

	local isBGMUnFinished = GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId)

	if not isBGMUnFinished then
		return true
	end

	local unReadCount = BGMSwitchModel.instance:getUnReadCount()

	if unReadCount == 0 then
		return false
	end

	local saveUnReadCount = PlayerPrefsHelper.getNumber(self:getPlayerPrefKey(), nil)

	if not saveUnReadCount then
		return true
	end

	return saveUnReadCount < unReadCount
end

function BGMSwitchController:getPlayerPrefKey()
	self._ppk = self._ppk or PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.MainBgmUnreadCount)

	return self._ppk
end

BGMSwitchController.instance = BGMSwitchController.New()

return BGMSwitchController
