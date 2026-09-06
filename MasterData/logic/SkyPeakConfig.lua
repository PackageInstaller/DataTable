-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/config/SkyPeakConfig.lua

module("logic.extensions.skypeak.config.SkyPeakConfig", package.seeall)

local SkyPeakConfig = class("SkyPeakConfig", BaseConfig)

function SkyPeakConfig:onInit()
	SkyPeakConfig.super.onInit(self)
end

function SkyPeakConfig:getNames()
	return {
		"sky_peak_activity",
		"sky_peak_support_pet",
		"sky_peak_buff",
		"sky_peak_stage_alive_score",
		"sky_peak_stage_round_circle",
		"sky_peak_creeps",
		"sky_peak_boss",
		"sky_peak_rank_prize",
		"sky_peak_stage",
		"sky_peak_master"
	}
end

function SkyPeakConfig:handleConfig(name, content)
	if name == "sky_peak_activity" then
		self._sky_peak_activity = content
	elseif name == "sky_peak_support_pet" then
		self._sky_peak_support_pet = content
	elseif name == "sky_peak_buff" then
		self._sky_peak_buff = content

		self:_handleCreateBuffTree()
	elseif name == "sky_peak_stage_alive_score" then
		self._sky_peak_stage_alive_score = content

		self:_handleStageAliveScoreCfgs()
	elseif name == "sky_peak_stage_round_circle" then
		self._sky_peak_stage_round_circle = content

		self:_handleStageRoundCircleCfgs()
	elseif name == "sky_peak_creeps" then
		self._sky_peak_creeps = content
	elseif name == "sky_peak_boss" then
		self._sky_peak_boss = content
	elseif name == "sky_peak_rank_prize" then
		self._sky_peak_rank_prize = content
	elseif name == "sky_peak_stage" then
		self._sky_peak_stage = content
	elseif name == "sky_peak_master" then
		self._sky_peak_master = content
	end
end

function SkyPeakConfig:getActivityCfg(activityId)
	return self:_safeGet(self._sky_peak_activity, activityId)
end

function SkyPeakConfig:getSupportPetCfgs(supportPetPlanId)
	return self:_safeGet(self._sky_peak_support_pet, supportPetPlanId)
end

function SkyPeakConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			return nil
		end
	end

	return current
end

function SkyPeakConfig:_handleCreateBuffTree()
	if self._sky_peak_buff then
		if not self._sky_peak_buff.dataList then
			local datalist = {}

			self._sky_peak_buff_tree_list = {}
			self._sky_peak_buff_tree_rootIdList = {}

			for i, v in ipairs(datalist) do
				local activityId = v.activityId
				local nodeId = v.nodeId
				local parentNodeId = v.parentNodeId

				if not self._sky_peak_buff_tree_list[activityId] then
					self._sky_peak_buff_tree_list[activityId] = {}
					self._sky_peak_buff_tree_rootIdList[activityId] = {}
				end

				local treeList = self._sky_peak_buff_tree_list[activityId]

				if parentNodeId == 0 then
					treeList[nodeId] = {
						cfg = v,
						children = {}
					}

					table.insert(self._sky_peak_buff_tree_rootIdList[activityId], nodeId)
				else
					local parentNode = treeList[parentNodeId]

					if parentNode then
						table.insert(parentNode.children, {
							cfg = v,
							children = {}
						})

						treeList[nodeId] = parentNode.children[#parentNode.children]
					else
						print("Error: SkyPeakConfig:_handleCreateBuffTree() - parent node not found for nodeId:", nodeId)
					end
				end
			end
		end
	end
end

function SkyPeakConfig:getBuffNode(activityId, nodeId)
	return self:_safeGet(self._sky_peak_buff_tree_list, activityId, nodeId)
end

function SkyPeakConfig:getBuffTreeList(activityId)
	return self:_safeGet(self._sky_peak_buff_tree_list, activityId)
end

function SkyPeakConfig:getBuffTreeRootIdList(activityId)
	return self:_safeGet(self._sky_peak_buff_tree_rootIdList, activityId)
end

function SkyPeakConfig:getBuffCfgById(activityId, buffId)
	return self:_safeGet(self._sky_peak_buff, activityId, buffId)
end

function SkyPeakConfig:_handleStageAliveScoreCfgs()
	self._sky_peak_stage_alive_score_sortList = {}

	if self._sky_peak_stage_alive_score then
		if not self._sky_peak_stage_alive_score.dataList then
			local datalist = {}

			for i, v in ipairs(datalist) do
				local aliveScorePlanId = v.aliveScorePlanId

				self._sky_peak_stage_alive_score_sortList[aliveScorePlanId] = self._sky_peak_stage_alive_score_sortList[aliveScorePlanId] or {}

				table.insert(self._sky_peak_stage_alive_score_sortList[aliveScorePlanId], v)
			end
		end
	end
end

function SkyPeakConfig:getAliveScore(aliveScorePlanId, aliveNum)
	local cfgs = self._sky_peak_stage_alive_score_sortList[aliveScorePlanId]

	if cfgs then
		for i = 1, #cfgs do
			local v = cfgs[i]

			if aliveNum >= v.aliveNum then
				return v.score
			end
		end
	end

	return 0
end

function SkyPeakConfig:getAliveScoreCfgs(aliveScorePlanId)
	return self:_safeGet(self._sky_peak_stage_alive_score_sortList, aliveScorePlanId)
end

function SkyPeakConfig:_handleStageRoundCircleCfgs()
	self._sky_peak_stage_round_circle_sortList = {}

	if self._sky_peak_stage_round_circle then
		if not self._sky_peak_stage_round_circle.dataList then
			local datalist = {}

			for i, v in ipairs(datalist) do
				local circleScorePlanId = v.circleScorePlanId

				self._sky_peak_stage_round_circle_sortList[circleScorePlanId] = self._sky_peak_stage_round_circle_sortList[circleScorePlanId] or {}

				table.insert(self._sky_peak_stage_round_circle_sortList[circleScorePlanId], v)
			end
		end
	end
end

function SkyPeakConfig:getRoundCircleScore(circleScorePlanId, minCircle)
	local cfgs = self._sky_peak_stage_round_circle_sortList[circleScorePlanId]

	if cfgs then
		for i = 1, #cfgs do
			local v = cfgs[i]

			if minCircle <= v.minCircle then
				return v.score
			end
		end

		return cfgs[#cfgs].score
	end

	return 0
end

function SkyPeakConfig:getRoundCircleScoreCfgs(circleScorePlanId)
	return self:_safeGet(self._sky_peak_stage_round_circle_sortList, circleScorePlanId)
end

function SkyPeakConfig:getCreepsCfgs(creepsMasterId)
	return self:_safeGet(self._sky_peak_creeps, creepsMasterId)
end

function SkyPeakConfig:getTeamCfg(creepsMasterId)
	return self:_safeGet(self._sky_peak_master, creepsMasterId)
end

function SkyPeakConfig:getAllBossCfgs(activityId)
	return self:_safeGet(self._sky_peak_boss, activityId)
end

function SkyPeakConfig:getBossCfgById(activityId, bossId)
	return self:_safeGet(self._sky_peak_boss, activityId, bossId)
end

function SkyPeakConfig:getRankPrizeCfgByRank(activityId, rank)
	local rankPrizeCfgs = self:_safeGet(self._sky_peak_rank_prize, activityId)

	if rankPrizeCfgs then
		return MmUtil.unorderedSearchInArrayKey(rankPrizeCfgs, "rankRange", rank)
	end
end

function SkyPeakConfig:getAllStageCfgs(activityId)
	return self:_safeGet(self._sky_peak_stage, activityId)
end

function SkyPeakConfig:getStageNum(activityId)
	local stageCfgs = self:_safeGet(self._sky_peak_stage, activityId)

	if stageCfgs then
		return #stageCfgs
	end

	return 0
end

function SkyPeakConfig:getStageCfgById(activityId, stageId)
	return self:_safeGet(self._sky_peak_stage, activityId, stageId)
end

SkyPeakConfig.instance = SkyPeakConfig.New()

return SkyPeakConfig
