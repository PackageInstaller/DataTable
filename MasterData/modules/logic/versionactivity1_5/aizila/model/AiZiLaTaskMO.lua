-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaTaskMO.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaTaskMO", package.seeall)

local AiZiLaTaskMO = pureTable("AiZiLaTaskMO")

function AiZiLaTaskMO:init(taskCfg, taskMO, isMainTask)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
	self.showTypeTab = false
end

function AiZiLaTaskMO:updateMO(taskMO)
	self.taskMO = taskMO
end

function AiZiLaTaskMO:isMainTask()
	if self.config and self.config.showType == 1 then
		return true
	end

	return false
end

function AiZiLaTaskMO:getLineHeight()
	if self.showTypeTab then
		return AiZiLaEnum.UITaskItemHeight.ItemCell + AiZiLaEnum.UITaskItemHeight.ItemTab
	end

	return AiZiLaEnum.UITaskItemHeight.ItemCell
end

function AiZiLaTaskMO:isLock()
	return self.taskMO == nil
end

function AiZiLaTaskMO:setShowTab(isShow)
	self.showTypeTab = isShow
end

function AiZiLaTaskMO:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function AiZiLaTaskMO:getMaxProgress()
	return (self.config or nil) and (self.config.maxProgress or 0)
end

function AiZiLaTaskMO:getFinishProgress()
	return (self.taskMO or nil) and (self.taskMO.progress or 0)
end

function AiZiLaTaskMO:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return AiZiLaTaskMO
