-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131LogMo.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131LogMo", package.seeall)

local Activity131LogMo = pureTable("Activity131LogMo")

function Activity131LogMo:ctor()
	self.info = {}
end

function Activity131LogMo:init(speaker, speech, audioId)
	self._speaker = speaker
	self._speech = speech
	self._audioId = audioId
end

function Activity131LogMo:getSpeaker()
	return self._speaker
end

function Activity131LogMo:getSpeech()
	return self._speech
end

function Activity131LogMo:getAudioId()
	return self._audioId or 0
end

return Activity131LogMo
