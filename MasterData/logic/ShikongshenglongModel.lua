-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/ShikongshenglongModel.lua

module("logic.extensions.timelimitedchallenge.model.ShikongshenglongModel", package.seeall)

local ShikongshenglongModel = class("ShikongshenglongModel", BaseModel)

ShikongshenglongModel.TYPE_ZHIXULONG_ACT_ID = 112002

function ShikongshenglongModel:onInit()
	self:onReset()
end

function ShikongshenglongModel:onReset()
	self.curStageId = 0
	self.curChapter = 0
	self.sweepDic = {}
	self.curSweepStageId = 0
	self.curDailySignId = 0
	self.isSignToday = false
end

function ShikongshenglongModel:getInfos(msg)
	local activityid = checknumber(msg.activityId)

	self.curStageId = checknumber(msg.stageId) + 1

	local prizedstageids = msg.prizedStageIds

	self.sweepDic = {}

	for i = 1, #prizedstageids do
		self.sweepDic[prizedstageids[i]] = true
	end

	local cfg = ShikongshenglongConfig.instance:getStageCfg(activityid, self.curStageId)

	self.curChapter = cfg and cfg.chapterId or 3
	self.isSignToday = msg.todayHasSign
	self.curDailySignId = checknumber(msg.curDailySignId)

	GlobalDispatcher:dispatch(GlobalNotify.PM_SKL_GETINFORES, self.curChapter)
end

function ShikongshenglongModel:isSweep(stageId)
	return self.sweepDic[stageId] == true
end

function ShikongshenglongModel:isOverAll(activityid)
	return ShikongshenglongConfig.instance:getStageCfg(activityid, self.curStageId) == nil
end

function ShikongshenglongModel:isStageRed(stageId)
	if stageId > self.curStageId then
		return false
	end

	return self.sweepDic[stageId] == nil
end

function ShikongshenglongModel:isChapterRed(curActId, chapterId)
	local stages = ShikongshenglongConfig.instance:getStages(curActId, chapterId)

	for i, v in ipairs(stages) do
		if self:isStageRed(v.stageId) then
			return true
		end
	end

	return false
end

function ShikongshenglongModel:setCurSweepId(stageId)
	self.curSweepStageId = stageId
end

function ShikongshenglongModel:setCurHaveSweep()
	self.sweepDic[self.curSweepStageId] = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_SKL_SWEEPOVER)
end

function ShikongshenglongModel:setCurSignInfo(curdailysignid)
	self.curDailySignId = checknumber(curdailysignid)
	self.isSignToday = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_ZXL_GETSIGN)
end

ShikongshenglongModel.instance = ShikongshenglongModel.New()

return ShikongshenglongModel
