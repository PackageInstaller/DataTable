-- chunkname: @modules/logic/scene/room/comp/RoomSceneAudioComp.lua

module("modules.logic.scene.room.comp.RoomSceneAudioComp", package.seeall)

local RoomSceneAudioComp = class("RoomSceneAudioComp", BaseSceneComp)

RoomSceneAudioComp.CameraMaxDistance = -1.5
RoomSceneAudioComp.CameraMinDistance = -3.5

function RoomSceneAudioComp:init()
	self.audioManagerGo = gohelper.find("AudioManager")
	self.mainCameraGo = CameraMgr.instance:getMainCameraGO()

	gohelper.enableAkListener(self.audioManagerGo, false)
	gohelper.enableAkListener(self.mainCameraGo, true)

	self.mainCameraFocusPositionY = CameraMgr.instance:getFocusTrs().position.y

	RoomMapController.instance:registerCallback(RoomEvent.TouchScale, self.changeRTPCValue, self)
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStoryStart, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onStoryFinish, self)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, self._onStoryFinish, self)
	self:playRoomAudio(GameSceneMgr.instance:getCurSceneType(), GameSceneMgr.instance:getCurSceneId())
	ManufactureController.instance:registerCallback(ManufactureEvent.PlayCritterBuildingBgm, self._onPlayCritterBuildingBgm, self)
end

function RoomSceneAudioComp:_onPlayCritterBuildingBgm(delayTime, isPlay)
	self._isPlayCritterBuildingBgm = isPlay

	if self._waitCheck then
		return
	end

	if delayTime and delayTime > 0 then
		self._waitCheck = true

		TaskDispatcher.runDelay(self._realCheckIsPlayCritterBuildingBgm, self, delayTime)
	else
		self:_realCheckIsPlayCritterBuildingBgm()
	end
end

function RoomSceneAudioComp:_realCheckIsPlayCritterBuildingBgm()
	if self._bgmPlayingId then
		AudioMgr.instance:stopPlayingID(self._bgmPlayingId)
	end

	if self._isPlayCritterBuildingBgm then
		if not AudioEnum.Room.play_ui_home_mojing_music then
			local bgm = AudioEnum.Room.bgm_music_home

			if self._isPlayCritterBuildingBgm then
				AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
			else
				AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)
			end

			self._bgmPlayingId = AudioMgr.instance:trigger(bgm)
			self._waitCheck = false
		end
	end
end

function RoomSceneAudioComp:playRoomAudio(curSceneType, curSceneId)
	if curSceneType ~= SceneType.Room then
		return
	end

	self:changeRTPCValue()
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)

	self._bgmPlayingId = AudioMgr.instance:trigger(AudioEnum.Room.bgm_music_home)

	self:_playBuildingAudio()
	RoomMapController.instance:dispatchEvent(RoomEvent.StartPlayAmbientAudio)
end

function RoomSceneAudioComp:_playBuildingAudio()
	if RoomController.instance:isEditMode() then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local mapBuildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, mo in ipairs(mapBuildingMOList) do
		local entity = scene.buildingmgr:getBuildingEntity(mo.id, SceneTag.RoomBuilding)

		if entity and mo.config and mo.config.sound ~= 0 then
			entity:playAudio(mo.config.sound)
			logNormal(string.format("RoomBuildingEntity:playAudio() ->[%s] [%s] ", mo.config.name, mo.config.sound))
		end
	end
end

function RoomSceneAudioComp:changeRTPCValue()
	local mainCameraTrs = CameraMgr.instance:getMainCameraTrs()
	local rtpcValue = self:getRtpcValue(mainCameraTrs.position.y - self.mainCameraFocusPositionY)

	AudioMgr.instance:setRTPCValue(AudioEnum.RoomRTPC.MainCamera, rtpcValue)
end

function RoomSceneAudioComp:getRtpcValue(value)
	local result = 0

	if value <= RoomSceneAudioComp.CameraMinDistance then
		result = 0
	elseif value >= RoomSceneAudioComp.CameraMaxDistance then
		result = 1
	else
		local maxDistanceInterval = RoomSceneAudioComp.CameraMaxDistance - RoomSceneAudioComp.CameraMinDistance

		result = (value - RoomSceneAudioComp.CameraMinDistance) / maxDistanceInterval
	end

	return result
end

function RoomSceneAudioComp:_onStoryStart(storyId)
	local isCritterTrainStory = RoomTrainCritterModel.instance:isCritterTrainStory(storyId)

	if not isCritterTrainStory then
		AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_lower)
	end
end

function RoomSceneAudioComp:_onStoryFinish(storyId)
	AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_normal)
end

function RoomSceneAudioComp:onSceneClose()
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
	gohelper.enableAkListener(self.audioManagerGo, true)
	gohelper.enableAkListener(self.mainCameraGo, false)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchScale, self.changeRTPCValue, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self.playRoomAudio, self)
	StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStoryStart, self)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, self._onStoryFinish, self)
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, self._onStoryFinish, self)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingViewChange, self._onPlayCritterBuildingBgm, self)
end

return RoomSceneAudioComp
