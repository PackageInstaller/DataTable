-- chunkname: @modules/audio/bgm/AudioBgmManager.lua

module("modules.audio.bgm.AudioBgmManager", package.seeall)

local AudioBgmManager = class("AudioBgmManager")

function AudioBgmManager:ctor()
	self._bgmInfo = AudioBgmInfo.New()
	self._curBgmData = nil
	self._canPauseList = {}

	self:_addEvents()
end

function AudioBgmManager:init()
	return
end

function AudioBgmManager:_addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._onReOpenWhileOpen, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterScene, self._onEnterScene, self)
end

function AudioBgmManager:isIgnoreBGMView(viewName)
	if not self._ignoreBGMViewList then
		self._ignoreBGMViewList = {}
		self._ignoreBGMViewList[ViewName.FullScreenVideoView] = true
	end

	return self._ignoreBGMViewList[viewName]
end

function AudioBgmManager:_onEnterScene()
	self:_forceClearPauseBgm()
end

function AudioBgmManager:_onReOpenWhileOpen(viewName)
	if self:isIgnoreBGMView(viewName) then
		return
	end

	self:_startCheckBgm()
end

function AudioBgmManager:_onCloseViewFinish(viewName)
	if self:isIgnoreBGMView(viewName) then
		return
	end

	self:_startCheckBgm()
end

function AudioBgmManager:_onOpenViewFinsh(viewName)
	if self:isIgnoreBGMView(viewName) then
		return
	end

	self:_startCheckBgm()
end

function AudioBgmManager:checkBgm()
	self:_startCheckBgm()
end

function AudioBgmManager:_startCheckBgm()
	self._startFromat = 0

	TaskDispatcher.cancelTask(self._checkBgm, self)
	TaskDispatcher.runRepeat(self._checkBgm, self, 0)
end

function AudioBgmManager:_checkBgm()
	if self._startFromat == 0 then
		self._startFromat = self._startFromat + 1

		return
	end

	local bgmUsage = self:_getTopViewBgm() or self:_getSceneBgm()

	if bgmUsage then
		local layer = bgmUsage:getBgmLayer()

		self:_clearPauseBgm(bgmUsage)

		if layer then
			TaskDispatcher.cancelTask(self._checkBgm, self)
			self:playBgm(layer)
		end
	else
		TaskDispatcher.cancelTask(self._checkBgm, self)
		self:_setBgmData(nil)
	end
end

function AudioBgmManager:_getTopViewBgm()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		local oneViewName = openViewNameList[i]
		local viewContainer = ViewMgr.instance:getContainer(oneViewName)

		if viewContainer then
			local bgmUsage = self._bgmInfo:getViewBgmUsage(oneViewName)

			if bgmUsage then
				return bgmUsage
			end
		end
	end
end

function AudioBgmManager:_getSceneBgm()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	return (self._bgmInfo:getSceneBgmUsage(sceneType))
end

function AudioBgmManager:modifyAndPlay(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
	if AudioMgr.instance:useDefaultBGM() then
		if layer == AudioBgmEnum.Layer.Fight then
			playId = AudioEnum.Default_Fight_Bgm
			stopId = AudioEnum.Default_Fight_Bgm_Stop
		else
			playId = AudioEnum.Default_UI_Bgm
			stopId = AudioEnum.Default_UI_Bgm_Stop
		end
	end

	self:stopBgm(layer)
	self:modifyBgm(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
	self:playBgm(layer)
end

function AudioBgmManager:stopAndRemove(layer)
	self:stopBgm(layer)
	self:removeBgm(layer)
end

function AudioBgmManager:stopAndClear(layer)
	self:stopBgm(layer)
	self:clearBgm(layer)
end

function AudioBgmManager:modifyBgm(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
	self._bgmInfo:modifyBgmData(layer, playId, stopId, resumeId, pauseId, switchGroup, switchState)
end

function AudioBgmManager:modifyBgmAudioId(layer, playId)
	if self._bgmInfo:modifyBgmAudioId(layer, playId) then
		local data = self._bgmInfo:getBgmData(layer)

		if self._curBgmData == data then
			self:_stopBgm(data)
			self:_playBgm(data)

			return true
		end
	end

	return false
end

function AudioBgmManager:getCurPlayingId()
	return (self._curBgmData or nil) and (self._curBgmData.playId or nil)
end

function AudioBgmManager:setSwitch(layer)
	local data = self._bgmInfo:getBgmData(layer)

	if data then
		data:setSwitch()
	end
end

function AudioBgmManager:setSwitchData(layer, switchGroup, switchState)
	local data = self._bgmInfo:getBgmData(layer)

	if data then
		if data.switchGroup == switchGroup and data.switchState == switchState then
			return false
		end

		data.switchGroup = switchGroup
		data.switchState = switchState

		return true
	end

	return false
end

function AudioBgmManager:setStopId(layer, stopId)
	local data = self._bgmInfo:getBgmData(layer)

	if data then
		data.stopId = stopId
	end
end

function AudioBgmManager:removeBgm(layer)
	self._bgmInfo:removeBgm(layer)
end

function AudioBgmManager:clearBgm(layer)
	self._bgmInfo:clearBgm(layer)
end

function AudioBgmManager:playBgm(layer)
	local data = self._bgmInfo:getBgmData(layer)

	self:_setBgmData(data)
end

function AudioBgmManager:stopBgm(layer)
	local data = self._bgmInfo:getBgmData(layer)

	if self._curBgmData == data then
		self:_setBgmData(nil)
	end
end

function AudioBgmManager:_setBgmData(data)
	if self._curBgmData == data then
		return
	end

	if self:_getPlayId(self._curBgmData) == self:_getPlayId(data) then
		self._curBgmData = data

		return
	end

	self:_stopBgm(self._curBgmData)

	self._curBgmData = data

	self:_playBgm(self._curBgmData)
end

function AudioBgmManager:_stopBgm(bgmData)
	if not bgmData then
		return nil
	end

	local stopId = self:_getStopId(bgmData)

	self:dispatchEvent(AudioBgmEvent.onStopBgm, bgmData.layer, stopId)

	if stopId > 0 then
		AudioMgr.instance:trigger(stopId)
	end

	self:_stopBindList(bgmData)
end

function AudioBgmManager:_playBgm(bgmData)
	if not bgmData then
		return nil
	end

	local playId = self:_getPlayId(bgmData)

	self:dispatchEvent(AudioBgmEvent.onPlayBgm, bgmData.layer, playId)

	if playId > 0 then
		AudioMgr.instance:trigger(playId)
		bgmData:setSwitch()

		if bgmData.resumeId then
			self._canPauseList[bgmData.layer] = bgmData
		end
	end

	self:_playBindList(bgmData)
end

function AudioBgmManager:_playBindList(srcBgmData)
	local bindList = self._bgmInfo:getBindList(srcBgmData.layer)

	if not bindList then
		return
	end

	for i, layer in ipairs(bindList) do
		local bgmData = self._bgmInfo:getBgmData(layer)

		if bgmData then
			local playId = self:_getPlayId(bgmData)

			if playId > 0 then
				AudioMgr.instance:trigger(playId)
			end
		end
	end
end

function AudioBgmManager:_stopBindList(srcBgmData)
	local bindList = self._bgmInfo:getBindList(srcBgmData.layer)

	if not bindList then
		return
	end

	for i, layer in ipairs(bindList) do
		local bgmData = self._bgmInfo:getBgmData(layer)

		if bgmData then
			local stopId = self:_getStopId(bgmData)

			if stopId > 0 then
				AudioMgr.instance:trigger(stopId)
			end
		end
	end
end

function AudioBgmManager:_clearPauseBgm(bgmUsage)
	if bgmUsage and bgmUsage.clearPauseBgm then
		self:_forceClearPauseBgm()
	end
end

function AudioBgmManager:_forceClearPauseBgm()
	for key, value in pairs(self._canPauseList) do
		AudioMgr.instance:trigger(value.stopId)
		rawset(self._canPauseList, key, nil)
	end
end

function AudioBgmManager:_getPlayId(bgmData)
	if not bgmData then
		return nil
	end

	if self._canPauseList[bgmData.layer] then
		return bgmData.resumeId
	else
		return bgmData.playId
	end
end

function AudioBgmManager:_getStopId(bgmData)
	if not bgmData then
		return nil
	end

	if self._canPauseList[bgmData.layer] then
		return bgmData.pauseId
	else
		return bgmData.stopId
	end
end

AudioBgmManager.instance = AudioBgmManager.New()

LuaEventSystem.addEventMechanism(AudioBgmManager.instance)

return AudioBgmManager
