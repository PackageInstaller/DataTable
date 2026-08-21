-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseRoguelikeData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseRoguelikeData", package.seeall)

local M = class("CourseRoguelikeData")

function M:ctor(info, clueCfg, finishRate)
	self._id = info.scriptId
	self._cntFinished = info.finishCnt
	self._cntPass = info.passCnt
	self._cntClue = info.clueCnt
	self._lvMax = info.maxLevel
	self._cntClueCfg = clueCfg
	self._finishedRate = finishRate
end

function M:getId()
	return self._id
end

function M:getFinished()
	return self._cntFinished
end

function M:getFinishedRate()
	return self._finishedRate
end

function M:getPass()
	return self._cntPass
end

function M:getClue()
	return self._cntClue
end

function M:getClueCfg()
	return self._cntClueCfg
end

function M:getLvMax()
	return self._lvMax
end

return M
