-- chunkname: @IQIGame\\Module\\Maze\\MazeSoundModule.lua

MazeSoundModule = {
	soundsSerialId = {}
}

function MazeSoundModule.Initialize()
	return
end

function MazeSoundModule.Shutdown()
	MazeSoundModule.Clear()
end

function MazeSoundModule.PlaySound(soundID, destroyRule, params)
	local sound = {
		soundID = soundID,
		destroyRule = destroyRule,
		params = params or {}
	}

	MazeSoundModule.__OnPlaySound(sound)
end

function MazeSoundModule.__OnPlaySound(soundData)
	local soundSerialId = LuaUtility.PlaySoundWithID(soundData.soundID)

	MazeSoundModule.soundsSerialId[soundSerialId] = soundData
end

function MazeSoundModule.CheckAndDestroy(conditionType, conditionParam)
	ForPairs(MazeSoundModule.soundsSerialId, function(serialId, soundData)
		local shouldDestroy = false

		if soundData.destroyRule == Constant.MazeEffectOrSoundDestoryType.StepEnd then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.StepEnd
		elseif soundData.destroyRule == Constant.MazeEffectOrSoundDestoryType.EventLinkEnd then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.EventLinkEnd
		elseif soundData.destroyRule == Constant.MazeEffectOrSoundDestoryType.ByStep then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.ByStep and conditionParam == soundData.params.step
		elseif soundData.destroyRule == Constant.MazeEffectOrSoundDestoryType.ByEventID then
			shouldDestroy = conditionType == Constant.MazeEffectOrSoundDestoryType.ByEventID and conditionParam == soundData.params.eventID
		end

		if shouldDestroy then
			LuaUtility.StopSoundWithSerialId(serialId)

			MazeEffectModule.effectsSerialId[serialId] = nil
		end
	end)
end

function MazeSoundModule.Clear()
	ForPairs(MazeSoundModule.soundsSerialId, function(serialId, soundData)
		LuaUtility.StopSoundWithSerialId(serialId)

		MazeEffectModule.effectsSerialId[serialId] = nil
	end)

	MazeSoundModule.soundsSerialId = {}
end
