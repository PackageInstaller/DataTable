-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/config/SaintKnightTaskConfig.lua

module("logic.extensions.saintknighttask.config.SaintKnightTaskConfig", package.seeall)

local SaintKnightTaskConfig = class("SaintKnightTaskConfig", BaseConfig)

function SaintKnightTaskConfig:onInit()
	SaintKnightTaskConfig.super.onInit(self)
end

function SaintKnightTaskConfig:getNames()
	return {
		"saint_knight_task_activity",
		"saint_knight_task_common",
		"saint_knight_task_rank",
		"saint_knight_task_collection",
		"saint_knight_task_world_plan",
		"saint_knight_task_form_verify",
		"saint_knight_task_form_verify_desc",
		"saint_knight_task_world_prize",
		"saint_knight_task_person_plan",
		"saint_knight_task_person",
		"saint_knight_task_team_config",
		"saint_knight_task_team_prize"
	}
end

function SaintKnightTaskConfig:handleConfig(name, content)
	if name == "saint_knight_task_activity" then
		self._sktActCfg = content
	elseif name == "saint_knight_task_common" then
		self._sktCommonCfg = content
	elseif name == "saint_knight_task_rank" then
		self._sktRankCfg = content
	elseif name == "saint_knight_task_collection" then
		self._sktCollCfg = content
	elseif name == "saint_knight_task_world_plan" then
		self._sktWorldTaskPlanCfg = content
	elseif name == "saint_knight_task_form_verify" then
		self._sktVerifyCfg = content
	elseif name == "saint_knight_task_form_verify_desc" then
		self._sktVerifyDescCfg = content
	elseif name == "saint_knight_task_world_prize" then
		self._sktWorldTaskPrizeCfgs = content
	elseif name == "saint_knight_task_person_plan" then
		self._sktPersonTaskPlanCfg = content
	elseif name == "saint_knight_task_person" then
		self._sktPersonTaskCfgs = content

		self:handlePersonTaskCfgsToQueues(content)
		self:handlePersonTaskCfgsToPool(content)
	elseif name == "saint_knight_task_team_config" then
		self._sktTeamConfigCfg = content
	elseif name == "saint_knight_task_team_prize" then
		self._sktTeamPrizeCfg = content
	end
end

function SaintKnightTaskConfig:getSktActCfg()
	return self._sktActCfg
end

function SaintKnightTaskConfig:getSktActData(activityId)
	return self._sktActCfg[activityId]
end

function SaintKnightTaskConfig:getSktCommonValue(key)
	return self._sktCommonCfg[key].value
end

function SaintKnightTaskConfig:getSktWorldTaskFirstRed()
	return checknumber(self:getSktCommonValue("WORLD_TASK_FIRST_RED"))
end

function SaintKnightTaskConfig:getSktPersonTaskFirstRed()
	return checknumber(self:getSktCommonValue("PERSON_TASK_FIRST_RED"))
end

function SaintKnightTaskConfig:getSktWaterDarkDayRed()
	return checknumber(self:getSktCommonValue("WATER_DARK_DAY_RED"))
end

function SaintKnightTaskConfig:getSktWorldTaskPrizeRed()
	return checknumber(self:getSktCommonValue("WORLD_TASK_PRIZE_RED"))
end

function SaintKnightTaskConfig:getSktCollectionPrizeRed()
	return checknumber(self:getSktCommonValue("COLLECTION_PRIZE_RED"))
end

function SaintKnightTaskConfig:getSktVerifyPrizeRed()
	return checknumber(self:getSktCommonValue("VERIFY_PRIZE_RED"))
end

function SaintKnightTaskConfig:getSktRankCfg(activityId)
	local actData = self:getSktActData(activityId)

	return self._sktRankCfg[actData.rankPlanId or 0]
end

function SaintKnightTaskConfig:getSktRankData(activityId, index)
	local cfg = self:getSktRankCfg(activityId)

	return cfg and cfg[index]
end

function SaintKnightTaskConfig:getSktCollData(collectionTasksPlanId)
	return self._sktCollCfg[collectionTasksPlanId]
end

function SaintKnightTaskConfig:getSktCollDataById(activityId)
	local actData = self:getSktActData(activityId)

	return self:getSktCollData(actData.collectionTasksPlanId)
end

function SaintKnightTaskConfig:getSktWorldTaskPlanData(worldTaskPlanId)
	return self._sktWorldTaskPlanCfg[worldTaskPlanId]
end

function SaintKnightTaskConfig:getSktVerifyData(activityId)
	local actData = self:getSktActData(activityId)

	return self._sktVerifyCfg[actData.formVerityPlanId]
end

function SaintKnightTaskConfig:getSktVerifyDescData(activityId, raceId)
	local actData = self:getSktActData(activityId)

	if self._sktVerifyDescCfg[actData.formVerityPlanId] then
		return self._sktVerifyDescCfg[actData.formVerityPlanId][raceId]
	end
end

function SaintKnightTaskConfig:getSktWorldTaskPrizeCfg(worldPrizePlanId)
	return self._sktWorldTaskPrizeCfgs[worldPrizePlanId]
end

function SaintKnightTaskConfig:getSktWorldTaskPrizeData(worldPrizePlanId, index)
	return self._sktWorldTaskPrizeCfgs[worldPrizePlanId][index]
end

function SaintKnightTaskConfig:getSktWorldTaskPrizeCfgById(worldTaskPlanId)
	local planData = self:getSktWorldTaskPlanData(worldTaskPlanId)

	return self._sktWorldTaskPrizeCfgs[planData.worldPrizePlanId]
end

function SaintKnightTaskConfig:getSktWorldTaskPrizeDataById(worldTaskPlanId, index)
	return self:getSktWorldTaskPrizeCfgById(worldTaskPlanId)[index]
end

function SaintKnightTaskConfig:getSktPersonTaskPlanData(personTaskPlanId)
	return self._sktPersonTaskPlanCfg[personTaskPlanId]
end

function SaintKnightTaskConfig:getSktPersonTaskCfg(personTaskPlanId)
	return self._sktPersonTaskCfgs[personTaskPlanId]
end

function SaintKnightTaskConfig:getSktPersonTaskQueue(personTaskPlanId)
	return self._taskQueues[personTaskPlanId] or {}
end

function SaintKnightTaskConfig:getSktPersonTaskData(taskId)
	return self._taskPool[taskId]
end

function SaintKnightTaskConfig:getSktTeamConfigData(activityId)
	return self._sktTeamConfigCfg[activityId]
end

function SaintKnightTaskConfig:getSktTeamMemberCount(activityId)
	local data = self:getSktTeamConfigData(activityId)

	return data.teamMemberCount
end

function SaintKnightTaskConfig:getSktTeamPrizeCfg(activityId)
	return self._sktTeamPrizeCfg[activityId]
end

function SaintKnightTaskConfig:getSktTeamPrizeData(activityId, prizeId)
	local cfg = self:getSktTeamPrizeCfg(activityId)

	return cfg[prizeId]
end

function SaintKnightTaskConfig:handlePersonTaskCfgsToQueues(content)
	self._taskQueues = {}

	for personTaskPlanId, taskCfg in ipairs(content) do
		local queue = {}

		for _, data in pairs(taskCfg) do
			local showType = data.showType

			queue[showType] = queue[showType] or {}

			table.insert(queue[showType], data)
		end

		for _, list in ipairs(queue) do
			ArraySort.sortOn(list, "personTaskId")
		end

		self._taskQueues[personTaskPlanId] = queue
	end
end

function SaintKnightTaskConfig:handlePersonTaskCfgsToPool(content)
	local taskPool = {}

	for personTaskPlanId, taskCfg in ipairs(content) do
		for _, data in pairs(taskCfg) do
			taskPool[data.personTaskId] = data
		end
	end

	self._taskPool = taskPool
end

SaintKnightTaskConfig.instance = SaintKnightTaskConfig.New()

return SaintKnightTaskConfig
