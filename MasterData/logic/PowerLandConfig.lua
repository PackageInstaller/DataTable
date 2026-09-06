-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/config/PowerLandConfig.lua

module("logic.extensions.powerland.config.PowerLandConfig", package.seeall)

local PowerLandConfig = class("PowerLandConfig", BaseConfig)

function PowerLandConfig:onInit()
	PowerLandConfig.super.onInit(self)
end

function PowerLandConfig:getNames()
	return {
		"power_land_activity",
		"power_land_stage",
		"power_land_team_plan",
		"power_land_creeps",
		"power_land_pet",
		"power_land_target",
		"power_land_common",
		"power_land_task",
		"power_land_prize"
	}
end

function PowerLandConfig:handleConfig(name, content)
	if name == "power_land_activity" then
		self._plActCfg = content
	elseif name == "power_land_stage" then
		self._plStageCfgs = content
	elseif name == "power_land_team_plan" then
		self._plTeamCfg = content
	elseif name == "power_land_creeps" then
		self._plCreepsCfgs = content
	elseif name == "power_land_pet" then
		self._plPetCfgs = content
	elseif name == "power_land_target" then
		self._plTargetCfgs = content

		self:_handlePlTargetCfgs(content.dataList)
	elseif name == "power_land_common" then
		self._plCommonCfg = content
	elseif name == "power_land_task" then
		self._plTaskCfgs = content
	elseif name == "power_land_prize" then
		self._plPrizeCfg = content
	end
end

function PowerLandConfig:getPlActCfg()
	return self._plActCfg
end

function PowerLandConfig:getPlActData(activityId)
	return self:getPlActCfg()[activityId]
end

function PowerLandConfig:getPlStageCfg(activityId)
	return self._plStageCfgs[activityId]
end

function PowerLandConfig:getPlStageData(activityId, stageId)
	return self:getPlStageCfg(activityId)[stageId]
end

function PowerLandConfig:getTotalStageNum(activityId)
	local stageCfg = PowerLandConfig.instance:getPlStageCfg(activityId)

	return (stageCfg or nil) and #stageCfg
end

function PowerLandConfig:getStageType(activityId, stageId)
	local stageData = self:getPlStageData(activityId, stageId)

	return stageData.stageType
end

function PowerLandConfig:getPlTeamData(teamPlanId, creepsMasterId)
	return self._plTeamCfg[teamPlanId][creepsMasterId]
end

function PowerLandConfig:getPlTeamDataById(activityId, stageId, creepsMasterId)
	local stageData = self:getPlStageData(activityId, stageId)

	return self._plTeamCfg[stageData.teamPlanId][creepsMasterId]
end

function PowerLandConfig:getPlCreepsCfg(creepsMasterId)
	return self._plCreepsCfgs[creepsMasterId]
end

function PowerLandConfig:getPlCreepsData(creepsMasterId, creepsId)
	return self:getPlCreepsCfg(creepsMasterId)[creepsId]
end

function PowerLandConfig:getPlCreepsCfgByStageId(activityId, stageId)
	local stageData = self:getPlStageData(activityId, stageId)

	return self:getPlCreepsCfg(stageData.creepsMasterId)
end

function PowerLandConfig:getPlPetCfg(petPlanId)
	return self._plPetCfgs[petPlanId]
end

function PowerLandConfig:getPlPetCfgByActId(activityId)
	local actData = self:getPlActData(activityId)

	return self._plPetCfgs[actData.petPlanId]
end

function PowerLandConfig:getPlPetData(petPlanId, creepsId)
	return self:getPlPetCfg(petPlanId)[creepsId]
end

function PowerLandConfig:getPlPetDataByActId(activityId, creepsId)
	return self:getPlPetCfgByActId(activityId)[creepsId]
end

function PowerLandConfig:getPlTargetCfgs()
	return self._plTargetCfgs
end

function PowerLandConfig:getPlTargetCfg(targetId)
	return self._plTargetCfgs[targetId]
end

function PowerLandConfig:getPlTargetData(targetId, level)
	return self:getPlTargetCfg(targetId)[level]
end

function PowerLandConfig:getRealPlTargetData(targetId, level)
	level = checknumber(level)

	local data = self:getPlTargetCfg(targetId)[level]

	return data or self:getTargetLevelMinLimitData(targetId)
end

function PowerLandConfig:_handlePlTargetCfgs(dataList)
	self._targetCfgList = {}

	for _, data in ipairs(dataList) do
		local targetId = data.targetId

		if self._targetCfgList[targetId] == nil then
			self._targetCfgList[targetId] = {}
		end

		table.insert(self._targetCfgList[targetId], data)
	end
end

function PowerLandConfig:_getTargetCfgList()
	return self._targetCfgList
end

function PowerLandConfig:getAllTargetId()
	local list = {}
	local targetCfgList = self:_getTargetCfgList()

	for targetId, cfg in ipairs(targetCfgList) do
		table.insert(list, targetId)
	end

	return list
end

function PowerLandConfig:getTargetDataList(targetId)
	local list = {}
	local targetCfgList = self:_getTargetCfgList()

	for _, data in ipairs(targetCfgList[targetId]) do
		table.insert(list, data)
	end

	return list
end

function PowerLandConfig:getTargetLevelMaxLimitData(targetId)
	local targetCfgList = self:_getTargetCfgList()

	return targetCfgList[targetId][#targetCfgList[targetId]]
end

function PowerLandConfig:getTargetLevelMinLimitData(targetId)
	local targetCfgList = self:_getTargetCfgList()

	return targetCfgList[targetId][1]
end

function PowerLandConfig:isTargetLevelExistence(targetId, level)
	local data = self:getPlTargetData(targetId, level)

	return data ~= nil
end

function PowerLandConfig:getPlCommonValue(key)
	if self._plCommonCfg[key] == nil then
		printError("对应key不存在,请检查代码和配置表( L-勇闯力量秘境-通用配置 )")

		return nil
	end

	return self._plCommonCfg[key].value
end

function PowerLandConfig:getPlInitalPetRefreshCount()
	return checknumber(self:getPlCommonValue("INITIAL_PET_REFRESH_COUNT"))
end

function PowerLandConfig:getPlInitalPetSelectionCount()
	return checknumber(self:getPlCommonValue("INITIAL_PET_SELECTION_COUNT"))
end

function PowerLandConfig:getPlSelectPetCount()
	return checknumber(self:getPlCommonValue("SELECT_PET_COUNT"))
end

function PowerLandConfig:getPlRefreshShopCost()
	return checknumber(self:getPlCommonValue("REFRESH_SHOP_COST"))
end

function PowerLandConfig:getPlShopPetCount()
	return checknumber(self:getPlCommonValue("SHOP_PET_COUNT"))
end

function PowerLandConfig:getPlStartGameTime()
	return checknumber(self:getPlCommonValue("START_GAME_TIME"))
end

function PowerLandConfig:getPlDailyAddGameTime()
	return checknumber(self:getPlCommonValue("DAILY_ADD_GAME_TIME"))
end

function PowerLandConfig:getPlWeeklyAddGameTime()
	return checknumber(self:getPlCommonValue("WEEKLY_ADD_GAME_TIME"))
end

function PowerLandConfig:getPlAddGameTimeLimit()
	return checknumber(self:getPlCommonValue("ADD_GAME_TIME"))
end

function PowerLandConfig:getPlAddGameTimeLimit()
	return checknumber(self:getPlCommonValue("ADD_GAME_TIME"))
end

function PowerLandConfig:getPlHomeViewBottomTips()
	return lang("活动期间每天增加1次挑战次数，每周增加次数上限为7次，活动期间最多可存储7次挑战。")
end

function PowerLandConfig:getPlShowItem()
	return self:getPlCommonValue("SHOW_ITEM")
end

function PowerLandConfig:getRuleTipsKey()
	return self:getPlCommonValue("RULE_TIPS_KEY")
end

function PowerLandConfig:getBubbleDesc()
	return lang("可获得:淬源晶石、随机金色星神碎片、神唤券")
end

function PowerLandConfig:getPlTaskCfg(activityId)
	return self._plTaskCfgs[activityId]
end

function PowerLandConfig:getPlTaskData(activityId, taskId)
	return self:getPlTaskCfg(activityId)[taskId]
end

function PowerLandConfig:getPlPrizeCfg(activityId)
	return self._plPrizeCfg[activityId]
end

function PowerLandConfig:getPlPrizeData(activityId, winCount)
	return self:getPlPrizeCfg(activityId)[winCount]
end

PowerLandConfig.instance = PowerLandConfig.New()

return PowerLandConfig
