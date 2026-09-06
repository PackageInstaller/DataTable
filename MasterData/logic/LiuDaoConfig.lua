-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/config/LiuDaoConfig.lua

module("logic.extensions.liudao.config.LiuDaoConfig", package.seeall)

local LiuDaoConfig = class("LiuDaoConfig", BaseConfig)

function LiuDaoConfig:onInit()
	LiuDaoConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function LiuDaoConfig:getNames()
	return {
		"liu_dao_activity",
		"liu_dao_group_plan",
		"liu_dao_stage",
		"liu_dao_monster",
		"liu_dao_creeps",
		"liu_dao_buff",
		"liu_dao_progress_prize",
		"liu_dao_task",
		"liu_dao_refresh_plan",
		"liu_dao_enemy_zdl_plan"
	}
end

function LiuDaoConfig:handleConfig(name, content)
	if name == "liu_dao_activity" then
		self._liu_dao_activity = content
	elseif name == "liu_dao_group_plan" then
		self._liu_dao_group_plan = content
	elseif name == "liu_dao_stage" then
		self._liu_dao_stage = content
	elseif name == "liu_dao_monster" then
		self._liu_dao_monster = content
	elseif name == "liu_dao_creeps" then
		self._liu_dao_creeps = content
	elseif name == "liu_dao_buff" then
		self._liu_dao_buff = content
	elseif name == "liu_dao_task" then
		self._liu_dao_task = content
	elseif name == "liu_dao_progress_prize" then
		self._liu_dao_progress_prize = content

		self:_initUnlockPage()
	elseif name == "liu_dao_enemy_zdl_plan" then
		self._liu_dao_enemy_zdl_plan = content

		self:_conbineZdlPlanCfg()
	elseif name == "liu_dao_refresh_plan" then
		self._liu_dao_refresh_plan = content
	end
end

function LiuDaoConfig:_conbineZdlPlanCfg()
	self._zldPlan = {}

	for i, v in pairs(self._liu_dao_enemy_zdl_plan) do
		self._zldPlan[i] = {}

		for j, k in pairs(self._liu_dao_enemy_zdl_plan[i]) do
			table.insert(self._zldPlan[i], {
				zdlRatioPlanId = k.zdlRatioPlanId,
				zdl = k.zdl,
				ratio = k.ratio
			})
		end

		table.sort(self._zldPlan[i], function(a, b)
			if a.zdl < b.zdl then
				return true
			end
		end)
	end
end

function LiuDaoConfig:getActivityFirstCfg()
	return self._liu_dao_activity.dataList[1]
end

function LiuDaoConfig:getActivityCfg(activityid)
	return self._liu_dao_activity[activityid]
end

function LiuDaoConfig:getRewardProgressListCfgs(activityid)
	return self._liu_dao_progress_prize[activityid]
end

function LiuDaoConfig:getRewardProgressCfg(activityid, id)
	return self._liu_dao_progress_prize[activityid][id]
end

function LiuDaoConfig:getStageCfg(activityid, stageId)
	return self._liu_dao_stage[activityid][stageId]
end

function LiuDaoConfig:getRefreshTypeList(activityId, weekIndex, refreshType)
	local cfgList = self._liu_dao_group_plan[activityId][weekIndex]
	local res = {}

	for i, v in ipairs(cfgList) do
		if v.refreshType == refreshType then
			table.insert(res, v.groupId)
		end
	end

	return res
end

function LiuDaoConfig:getRefreshType(activityId, weekIndex)
	return self._liu_dao_group_plan[activityId][weekIndex]
end

function LiuDaoConfig:getGroupType(activityId, weekIndex, groupId)
	return self._liu_dao_group_plan[activityId][weekIndex][groupId]
end

function LiuDaoConfig:getMonsterCfg(creepsMasterId)
	return self._liu_dao_monster[creepsMasterId]
end

function LiuDaoConfig:getMonsterTeamCfg(creepsMasterId)
	return self._liu_dao_creeps[creepsMasterId]
end

function LiuDaoConfig:getZdlRatio(zdlRatioPlanId, zdl)
	if self._zldPlan[zdlRatioPlanId] == nil then
		return
	end

	local res = self._zldPlan[zdlRatioPlanId][1].ratio

	for i = 1, #self._zldPlan[zdlRatioPlanId] do
		if zdl < self._zldPlan[zdlRatioPlanId][i].zdl then
			break
		end

		res = self._zldPlan[zdlRatioPlanId][i].ratio
	end

	return res
end

function LiuDaoConfig:getTaskInfo(activityId, weekIndex, taskId)
	return self._liu_dao_task[activityId][weekIndex][taskId]
end

function LiuDaoConfig:getBuffCfg(buffId)
	return self._liu_dao_buff[buffId]
end

function LiuDaoConfig:_initUnlockPage()
	self._unlockList = {}

	for i, v in pairs(self._liu_dao_progress_prize) do
		self._unlockList[i] = {}

		for j, k in ipairs(self._liu_dao_progress_prize[i]) do
			local needScore = k.needScore

			if self._liu_dao_progress_prize[i][j].unlockPage and #self._liu_dao_progress_prize[i][j].unlockPage > 0 then
				for p, q in ipairs(self._liu_dao_progress_prize[i][j].unlockPage) do
					self._unlockList[i][q] = needScore
				end
			end
		end
	end
end

function LiuDaoConfig:getUnlockPage(activityId, page)
	return self._unlockList[activityId][page]
end

LiuDaoConfig.instance = LiuDaoConfig.New()

return LiuDaoConfig
