-- chunkname: @modules/logic/bossrush/model/V1a4_BossRush_ScoreTaskAchievementListModel.lua

module("modules.logic.bossrush.model.V1a4_BossRush_ScoreTaskAchievementListModel", package.seeall)

local V1a4_BossRush_ScoreTaskAchievementListModel = class("V1a4_BossRush_ScoreTaskAchievementListModel", ListScrollModel)

function V1a4_BossRush_ScoreTaskAchievementListModel:setStaticData(staticData)
	self._staticData = staticData
end

function V1a4_BossRush_ScoreTaskAchievementListModel:getStaticData()
	return self._staticData
end

function V1a4_BossRush_ScoreTaskAchievementListModel:claimRewardByIndex(index)
	local mo = self:getByIndex(index)

	if not mo then
		return
	end

	local id = mo.id
	local config = mo.config

	mo.finishCount = math.min(mo.finishCount + 1, config.maxFinishCount)
	mo.hasFinished = false

	self:sort(self._sort)
	TaskRpc.instance:sendFinishTaskRequest(id)
end

function V1a4_BossRush_ScoreTaskAchievementListModel._sort(a, b)
	if a.getAll then
		return true
	end

	if b.getAll then
		return false
	end

	local a_config = a.config
	local b_config = b.config
	local a_id = a.id
	local b_id = b.id
	local a_isGot = a.finishCount >= a_config.maxFinishCount and 1 or 0
	local b_isGot = b.finishCount >= b_config.maxFinishCount and 1 or 0
	local a_isAvaliable = a.hasFinished and 1 or 0
	local b_isAvaliable = b.hasFinished and 1 or 0
	local a_maxProgress = a.maxProgress
	local b_maxProgress = b.maxProgress

	if a_isAvaliable ~= b_isAvaliable then
		return b_isAvaliable < a_isAvaliable
	end

	if a_isGot ~= b_isGot then
		return a_isGot < b_isGot
	end

	if a_maxProgress ~= b_maxProgress then
		return a_maxProgress < b_maxProgress
	end

	return a_id < b_id
end

function V1a4_BossRush_ScoreTaskAchievementListModel:getFinishCount(moList, stage)
	local count = 0

	for _, mo in pairs(moList) do
		if mo.config and mo.config.stage == stage and mo.finishCount < mo.config.maxFinishCount and mo.hasFinished then
			count = count + 1
		end
	end

	return count
end

function V1a4_BossRush_ScoreTaskAchievementListModel:setAchievementMoList(stage)
	local moList = self:getMoList(stage)
	local finishTaskCount = self:getFinishCount(moList, stage)

	if finishTaskCount > 1 then
		table.insert(moList, 1, {
			getAll = true,
			stage = stage
		})
	end

	table.sort(moList, self._sort)
	self:setList(moList)
end

function V1a4_BossRush_ScoreTaskAchievementListModel:getAllAchievementTask(stage)
	local moList = self:getMoList(stage)
	local taskIds = {}

	for _, mo in pairs(moList) do
		table.insert(taskIds, mo.id)
	end

	return taskIds
end

function V1a4_BossRush_ScoreTaskAchievementListModel:isReddot(stage, tabIndex)
	local tasks = self:getMoList(stage, tabIndex)

	if tasks then
		for _, mo in pairs(tasks) do
			local config = mo.config

			if mo.finishCount < config.maxFinishCount and mo.hasFinished then
				return true
			end
		end
	end
end

function V1a4_BossRush_ScoreTaskAchievementListModel:getMoList(stage)
	local taskListenerType = BossRushEnum.TaskListenerType.highestPoint
	local ScoreDesc = "p_v1a4_bossrushleveldetail_txt_ScoreDesc"

	return (BossRushModel.instance:getMoListByStageAndType(stage, taskListenerType, ScoreDesc))
end

V1a4_BossRush_ScoreTaskAchievementListModel.instance = V1a4_BossRush_ScoreTaskAchievementListModel.New()

return V1a4_BossRush_ScoreTaskAchievementListModel
