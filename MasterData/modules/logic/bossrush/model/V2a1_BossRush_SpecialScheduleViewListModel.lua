-- chunkname: @modules/logic/bossrush/model/V2a1_BossRush_SpecialScheduleViewListModel.lua

module("modules.logic.bossrush.model.V2a1_BossRush_SpecialScheduleViewListModel", package.seeall)

local V2a1_BossRush_SpecialScheduleViewListModel = class("V2a1_BossRush_SpecialScheduleViewListModel", ListScrollModel)

function V2a1_BossRush_SpecialScheduleViewListModel:setStaticData(staticData)
	self._staticData = staticData
end

function V2a1_BossRush_SpecialScheduleViewListModel:claimRewardByIndex(index)
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

function V2a1_BossRush_SpecialScheduleViewListModel:getStaticData()
	return self._staticData
end

function V2a1_BossRush_SpecialScheduleViewListModel._sort(a, b)
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

function V2a1_BossRush_SpecialScheduleViewListModel:getFinishCount(moList, stage)
	local count = 0

	for _, mo in pairs(moList) do
		if mo.config and mo.config.stage == stage and mo.finishCount < mo.config.maxFinishCount and mo.hasFinished then
			count = count + 1
		end
	end

	return count
end

function V2a1_BossRush_SpecialScheduleViewListModel:setMoList(stage)
	local moList = BossRushModel.instance:getLayer4RewardMoListByStage(stage)
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

function V2a1_BossRush_SpecialScheduleViewListModel:getAllTask(stage)
	local moList = BossRushModel.instance:getLayer4RewardMoListByStage(stage)
	local taskIds = {}

	for _, mo in pairs(moList) do
		table.insert(taskIds, mo.id)
	end

	return taskIds
end

function V2a1_BossRush_SpecialScheduleViewListModel:isReddot(stage)
	local tasks = BossRushModel.instance:getLayer4RewardMoListByStage(stage)

	if tasks then
		for _, mo in pairs(tasks) do
			local config = mo.config

			if mo.finishCount < config.maxFinishCount and mo.hasFinished then
				return true
			end
		end
	end
end

V2a1_BossRush_SpecialScheduleViewListModel.instance = V2a1_BossRush_SpecialScheduleViewListModel.New()

return V2a1_BossRush_SpecialScheduleViewListModel
