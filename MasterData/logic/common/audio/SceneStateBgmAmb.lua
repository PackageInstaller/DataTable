-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/SceneStateBgmAmb.lua

module("logic.common.audio.SceneStateBgmAmb", package.seeall)

local M = class("SceneStateBgmAmb")

function M:ctor()
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_BGMAMBCHANGE, self._handleOnSceneBgmAmbChange, self)
	GlobalDispatcher:addEventListener(EventType.ON_CUR_BGMAMBCLOSE, self._handleOnCurBgmAmbClose, self)
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_BEGIN, self._onSceneLoadBegin, self)
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:_handleOnSceneBgmAmbChange(e, bgm, amb)
	self._curBgm = bgm
	self._curAmb = amb

	self:_playBgmAmb()
end

function M:_playBgmAmb()
	removetimer(self._playBgmAmb, self)

	if self._curBgm and self._curBgm ~= 0 then
		CriwareAudioFacade.instance:playBgmInnerById(self._curBgm, nil, nil)
	else
		CriwareAudioFacade.instance:stopBgm()
	end

	if self._curAmb and self._curAmb ~= 0 then
		CriwareAudioFacade.instance:playSEById(self._curAmb, nil, nil)
	else
		CriwareAudioFacade.instance:stopCurrentEnvironment()
	end
end

function M:_handleOnCurBgmAmbClose(e)
	if self._sceneBgm then
		self._curBgm = self._sceneBgm
	end

	if self._sceneAmb then
		self._curAmb = self._sceneAmb
	end

	settimer(0.1, self._playBgmAmb, self, false)
end

function M:_onSceneLoadBegin(e, sceneType, sceneId)
	if self._curSceneId == sceneId then
		return
	end

	removetimer(self._playBgmAmb, self)
end

function M:_onSceneLoaded(e, sceneType, sceneId)
	self._referenceCount = 0
	self._curSceneType = sceneType
	self._curSceneId = sceneId
	self._sceneBgm = nil
	self._sceneAmb = nil

	if not self._curSceneType or self._curSceneType == SceneType.Battle or self._curSceneType == SceneType.BattleCalculateEditor or self._curSceneType == SceneType.AirWorkShop or self._curSceneType == SceneType.AutoRun or self._curSceneType == SceneType.Profiler then
		return
	end

	if self._referenceCount > 0 then
		return
	end

	if self._curSceneType == SceneType.Room then
		self:_playRoomBgm()
	else
		local sceneCO = SceneConfig.instance:getSceneCO(self._curSceneId)

		if not sceneCO then
			return
		end

		if sceneCO.bgm ~= 0 or sceneCO.amb ~= 0 then
			self._curBgm = sceneCO.bgm
			self._curAmb = sceneCO.amb
			self._sceneBgm = self._curBgm
			self._sceneAmb = self._curAmb

			self:_playBgmAmb()
		end
	end
end

function M:_playRoomBgm()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime, true, true, false)
	local bgm = inAirtightTime and CriwareAudioEnum.music_main_echo or CriwareAudioEnum.music_main
	local se = inAirtightTime and CriwareAudioEnum.amb_changjing_haitan_echo or CriwareAudioEnum.amb_changjing_haitan

	CriwareAudioPlayer.instance:stopAllBgm()
	CriwareAudioPlayer.instance:stopAllSESound()
	CriwareAudioFacade.instance:setAisacControl("main_lowpass", "main_lowpass", 1)

	self._curBgm = bgm
	self._curAmb = se
	self._sceneBgm = self._curBgm
	self._sceneAmb = self._curAmb

	self:_playBgmAmb()
end

return M
