-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity216TaskInfoMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity216TaskInfoMO", package.seeall)

local Activity216TaskInfoMO = pureTable("Activity216TaskInfoMO")

function Activity216TaskInfoMO:init(info)
	self.taskId = info.taskId
	self.progress = info.progress
	self.hasFinish = info.hasFinish
end

function Activity216TaskInfoMO:updateProgress(progress)
	self.progress = progress
end

function Activity216TaskInfoMO:updateItemSubmitCount(finish)
	self.hasFinished = finish
end

function Activity216TaskInfoMO:isRewardCouldGet()
	local maxProgress = 10

	return not self.hasFinish and maxProgress <= self.progress
end

function Activity216TaskInfoMO:isTaskFinished()
	return self.hasFinish
end

return Activity216TaskInfoMO
