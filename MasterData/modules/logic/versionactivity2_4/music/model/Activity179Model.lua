-- chunkname: @modules/logic/versionactivity2_4/music/model/Activity179Model.lua

module("modules.logic.versionactivity2_4.music.model.Activity179Model", package.seeall)

local Activity179Model = class("Activity179Model", BaseModel)

function Activity179Model:onInit()
	self:reInit()
end

function Activity179Model:reInit()
	self._episodeMap = {}
	self._activityId = nil
end

function Activity179Model:getActivityId()
	self._activityId = self._activityId or VersionActivity2_4Enum.ActivityId.MusicGame

	return self._activityId
end

function Activity179Model:getConstValue(id)
	return Activity179Config.instance:getConstValue(self:getActivityId(), id)
end

function Activity179Model:initEpisodeList(list)
	self._episodeMap = {}

	for i, mo in ipairs(list) do
		self:updateEpisode(mo)
	end
end

function Activity179Model:updateEpisode(mo)
	if not self._episodeMap[mo.episodeId] then
		local episodeMo = Act179EpisodeMO.New()

		self._episodeMap[mo.episodeId]:init(mo)

		self._episodeMap[mo.episodeId] = self._episodeMap[mo.episodeId]
	end
end

function Activity179Model:getEpisodeMo(episodeId)
	return self._episodeMap[episodeId]
end

function Activity179Model:episodeIsFinished(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	return episodeMo and episodeMo.isFinished
end

function Activity179Model:getCalibration()
	local value = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Activity179Calibration, 0)

	value = tonumber(value) or 0

	return value / 1000
end

function Activity179Model:setCalibration(value)
	return PlayerPrefsHelper.setNumber(PlayerPrefsKey.Activity179Calibration, value)
end

function Activity179Model:clearSelectedEpisodeId()
	self._selectedEpisodeId = nil
end

function Activity179Model:getSelectedEpisodeId()
	self._selectedEpisodeId = self._selectedEpisodeId or GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	return self._selectedEpisodeId
end

Activity179Model.instance = Activity179Model.New()

return Activity179Model
