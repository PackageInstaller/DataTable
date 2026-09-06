-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/config/RoguelikeConfig.lua

module("logic.extensions.roguelike.config.RoguelikeConfig", package.seeall)

local RoguelikeConfig = class("RoguelikeConfig", BaseConfig)

function RoguelikeConfig:getNames()
	return {
		"roguelike_activity",
		"roguelike_rank_prize",
		"roguelike_phase",
		"roguelike_normal_stage",
		"roguelike_ext_stage",
		"roguelike_drop_buff_rerandom_cost_plan",
		"roguelike_drop_buff",
		"roguelike_global_buff",
		"roguelike_rent_pet",
		"roguelike_creeps_master",
		"roguelike_creeps",
		"roguelike_tab1",
		"roguelike_tab2"
	}
end

function RoguelikeConfig:handleConfig(name, content)
	if name == "roguelike_activity" then
		self.roguelike_activity = content
	elseif name == "roguelike_rank_prize" then
		self.roguelike_rank_prize = content
	elseif name == "roguelike_phase" then
		self.roguelike_phase = content
	elseif name == "roguelike_normal_stage" then
		self.roguelike_normal_stage = content
	elseif name == "roguelike_ext_stage" then
		self.roguelike_ext_stage = content
	elseif name == "roguelike_drop_buff_rerandom_cost_plan" then
		self.roguelike_drop_buff_rerandom_cost_plan = content
	elseif name == "roguelike_drop_buff" then
		self.roguelike_drop_buff = content
	elseif name == "roguelike_global_buff" then
		self.roguelike_global_buff = content
	elseif name == "roguelike_rent_pet" then
		self.roguelike_rent_pet = content
	elseif name == "roguelike_creeps_master" then
		self.roguelike_creeps_master = content
	elseif name == "roguelike_creeps" then
		self.roguelike_creeps = content
	elseif name == "roguelike_tab1" then
		self._roguelike_tab1 = content
	elseif name == "roguelike_tab2" then
		self._roguelike_tab2 = content
	end
end

function RoguelikeConfig:getActivityCfg(activityId)
	return self.roguelike_activity[activityId]
end

function RoguelikeConfig:getRankPrizeList(activityId, phaseId, rankType)
	return self.roguelike_rank_prize[activityId] and self.roguelike_rank_prize[activityId][phaseId] and self.roguelike_rank_prize[activityId][phaseId][rankType]
end

function RoguelikeConfig:getPhaseCfg(activityId, phaseId)
	return self.roguelike_phase[activityId] and self.roguelike_phase[activityId][phaseId]
end

function RoguelikeConfig:getNormalStageList(activityId, phaseId)
	return self.roguelike_normal_stage[activityId] and self.roguelike_normal_stage[activityId][phaseId]
end

function RoguelikeConfig:getNormalStageCfg(activityId, phaseId, stageId)
	return self.roguelike_normal_stage[activityId] and self.roguelike_normal_stage[activityId][phaseId] and self.roguelike_normal_stage[activityId][phaseId][stageId]
end

function RoguelikeConfig:getExtStageList(activityId, phaseId)
	return self.roguelike_ext_stage[activityId] and self.roguelike_ext_stage[activityId][phaseId]
end

function RoguelikeConfig:getExtStageCfg(activityId, phaseId, stageId)
	return self.roguelike_ext_stage[activityId] and self.roguelike_ext_stage[activityId][phaseId] and self.roguelike_ext_stage[activityId][phaseId][stageId]
end

function RoguelikeConfig:getReRandomCfg(activityId, planId, reRandomCount)
	if self.roguelike_drop_buff_rerandom_cost_plan[activityId] then
		local cfgList = self.roguelike_drop_buff_rerandom_cost_plan[activityId][planId]

		if cfgList then
			local cfg = cfgList[#cfgList]

			for i, v in ipairs(cfgList) do
				if v.reRandomCount == reRandomCount then
					return v
				end
			end

			return cfg
		end
	end
end

function RoguelikeConfig:getDropBuff(activityId, buffId)
	return self.roguelike_drop_buff[activityId] and self.roguelike_drop_buff[activityId][buffId]
end

function RoguelikeConfig:getGlobalBuffList(activityId)
	return self.roguelike_global_buff[activityId]
end

function RoguelikeConfig:getGlobalBuffLvList(activityId, buffId)
	return self.roguelike_global_buff[activityId] and self.roguelike_global_buff[activityId][buffId]
end

function RoguelikeConfig:getGlobalBuffCfg(activityId, buffId, lv)
	return self.roguelike_global_buff[activityId] and self.roguelike_global_buff[activityId][buffId] and self.roguelike_global_buff[activityId][buffId][lv]
end

function RoguelikeConfig:getRentPetList(activityId)
	return self.roguelike_rent_pet[activityId]
end

function RoguelikeConfig:getRentPetCfg(activityId, creepsId)
	return self.roguelike_rent_pet[activityId] and self.roguelike_rent_pet[activityId][creepsId]
end

function RoguelikeConfig:getMonsterCfg(creepsMasterId)
	return self.roguelike_creeps_master[creepsMasterId]
end

function RoguelikeConfig:getCreeps(creepsMasterId)
	return self.roguelike_creeps[creepsMasterId]
end

function RoguelikeConfig:getBigTabSortList()
	if self._tab1_sort then
		return self._tab1_sort
	end

	self._tab1_sort = {}

	table.insertto(self._tab1_sort, self._roguelike_tab1.dataList)
	table.sort(self._tab1_sort, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	return self._tab1_sort
end

function RoguelikeConfig:getSmallTabCfg(id)
	return self._roguelike_tab2[id]
end

function RoguelikeConfig:getBigTabCfgBySmallTabIndex(smallTabIndex)
	local bigTabListCfgs = self._roguelike_tab1.dataList

	for i1, v1 in ipairs(bigTabListCfgs) do
		if v1.childIndex and #v1.childIndex > 0 then
			for i2, smallIndex in ipairs(v1.childIndex) do
				if smallIndex == smallTabIndex then
					return v1
				end
			end
		end
	end

	return bigTabListCfgs[1]
end

RoguelikeConfig.instance = RoguelikeConfig.New()

return RoguelikeConfig
