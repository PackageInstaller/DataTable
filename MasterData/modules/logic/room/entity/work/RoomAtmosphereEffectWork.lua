-- chunkname: @modules/logic/room/entity/work/RoomAtmosphereEffectWork.lua

module("modules.logic.room.entity.work.RoomAtmosphereEffectWork", package.seeall)

local RoomAtmosphereEffectWork = class("RoomAtmosphereEffectWork", BaseWork)
local AUDIO_DELAY_TIME = 0.3

function RoomAtmosphereEffectWork:ctor(effectId, effParentGO)
	self._effectId = effectId
	self._effResPath = RoomConfig.instance:getRoomEffectPath(effectId)

	local abPath

	self._effGO = RoomGOPool.getInstance(self._effResPath, effParentGO, "effect_" .. effectId, (not GameResMgr.IsFromEditorDir or nil) and FightHelper.getEffectAbPath(self._effResPath))
	self._playingId = nil
	self._tmpAudioId = nil

	gohelper.setActive(self._effGO, false)
end

function RoomAtmosphereEffectWork:onStart()
	gohelper.setActive(self._effGO, false)
	gohelper.setActive(self._effGO, true)

	local duration = RoomConfig.instance:getRoomEffectDuration(self._effectId)

	if duration <= 0 then
		self:finish(true)
	else
		local audioId = RoomConfig.instance:getRoomEffectAudioId(self._effectId)

		if audioId and audioId ~= 0 and not gohelper.isNil(self._effGO) then
			self._tmpAudioId = audioId

			TaskDispatcher.runDelay(self.delayPlayAudio, self, AUDIO_DELAY_TIME)
		end

		TaskDispatcher.runDelay(self.finish, self, duration)
	end
end

function RoomAtmosphereEffectWork:delayPlayAudio()
	self._playingId = AudioMgr.instance:trigger(self._tmpAudioId, self._effGO)
	self._tmpAudioId = nil
end

function RoomAtmosphereEffectWork:setAudioIsFade(isFade)
	if gohelper.isNil(self._effGO) then
		return
	end

	AudioMgr.instance:trigger((isFade or nil) and AudioEnum.Room.set_firework_lower, self._effGO)
end

function RoomAtmosphereEffectWork:finish(isFail)
	local result = not isFail

	self:onDone(result)
end

function RoomAtmosphereEffectWork:clearWork()
	TaskDispatcher.cancelTask(self.finish, self)
	TaskDispatcher.cancelTask(self.delayPlayAudio, self)

	if not gohelper.isNil(self._effGO) then
		gohelper.setActive(self._effGO, false)
		AudioMgr.instance:trigger(AudioEnum.Room.stop_home_activity_firework, self._effGO)
	elseif self._playingId then
		AudioMgr.instance:stopPlayingID(self._playingId)

		self._playingId = nil
	end
end

function RoomAtmosphereEffectWork:onDestroy()
	self:clearWork()
	RoomGOPool.returnInstance(self._effResPath, self._effGO)

	self._effGO = nil
	self._effectId = nil
	self._effResPath = nil
	self._tmpAudioId = nil
end

return RoomAtmosphereEffectWork
