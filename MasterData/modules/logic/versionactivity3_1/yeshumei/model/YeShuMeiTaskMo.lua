-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiTaskMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiTaskMo", package.seeall)

local YeShuMeiTaskMo = pureTable("YeShuMeiTaskMo")

function YeShuMeiTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function YeShuMeiTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function YeShuMeiTaskMo:isLock()
	return self.taskMO == nil
end

function YeShuMeiTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function YeShuMeiTaskMo:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function YeShuMeiTaskMo:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function YeShuMeiTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return YeShuMeiTaskMo
