-- chunkname: @modules/logic/versionactivity2_4/music/model/VersionActivity2_4MusicBeatModel.lua

module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicBeatModel", package.seeall)

local VersionActivity2_4MusicBeatModel = class("VersionActivity2_4MusicBeatModel", BaseModel)

function VersionActivity2_4MusicBeatModel:onInit()
	self:reInit()
end

function VersionActivity2_4MusicBeatModel:reInit()
	return
end

function VersionActivity2_4MusicBeatModel:onStart(episodeId)
	VersionActivity2_4MusicController.instance:initBgm()

	self._episodeId = episodeId

	local _, score = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.Score)

	self._scoreList = string.splitToNumber(score, "#")

	local _, scoreTime = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.ScoreTime)
	local list = GameUtil.splitString2(scoreTime, true, "|", "#")

	self._scoreShowTimeList = list[1]
	self._scoreTimeList = {}
	self._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Perfect] = list[2]
	self._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Great] = list[3]
	self._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Cool] = list[1]
	self._successCount = 0
end

function VersionActivity2_4MusicBeatModel:getSuccessCount()
	return self._successCount
end

function VersionActivity2_4MusicBeatModel:setSuccessCount(count)
	self._successCount = count
end

function VersionActivity2_4MusicBeatModel:getEpisodeId()
	return self._episodeId
end

function VersionActivity2_4MusicBeatModel:updateGradleList(list)
	self._gradeList = list
end

function VersionActivity2_4MusicBeatModel:getGradleList()
	return self._gradeList or {}
end

function VersionActivity2_4MusicBeatModel:getShowTime()
	return self._scoreShowTimeList[1]
end

function VersionActivity2_4MusicBeatModel:getHideTime()
	return self._scoreShowTimeList[2]
end

function VersionActivity2_4MusicBeatModel:getScoreTimeList()
	return self._scoreTimeList
end

function VersionActivity2_4MusicBeatModel:getGradeScore(index)
	return (self._scoreList or nil) and (self._scoreList[index] or 0)
end

VersionActivity2_4MusicBeatModel.instance = VersionActivity2_4MusicBeatModel.New()

return VersionActivity2_4MusicBeatModel
