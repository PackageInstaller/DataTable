-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/config/DivineXingJiangClgConfig.lua

module("logic.extensions.divinexingjiangclg.config.DivineXingJiangClgConfig", package.seeall)

local DivineXingJiangClgConfig = class("DivineXingJiangClgConfig", BaseConfig)

function DivineXingJiangClgConfig:onInit()
	DivineXingJiangClgConfig.super.onInit(self)

	self.divine_xing_jiang_clg = nil
	self.divine_xing_jiang_clg_common = nil
	self.divine_xing_jiang_clg_stage = nil
	self.divine_xing_jiang_clg_buff = nil
	self.divine_xing_jiang_clg_creeps_master = nil
	self.divine_xing_jiang_clg_creeps = nil
	self.divine_xing_jiang_clg_star_atlas = nil
end

function DivineXingJiangClgConfig:getNames()
	return {
		"divine_xing_jiang_clg",
		"divine_xing_jiang_clg_common",
		"divine_xing_jiang_clg_stage",
		"divine_xing_jiang_clg_buff",
		"divine_xing_jiang_clg_creeps_master",
		"divine_xing_jiang_clg_creeps",
		"divine_xing_jiang_clg_star_atlas"
	}
end

function DivineXingJiangClgConfig:handleConfig(name, content)
	if name == "divine_xing_jiang_clg" then
		self.divine_xing_jiang_clg = content
	elseif name == "divine_xing_jiang_clg_common" then
		self.divine_xing_jiang_clg_common = content
	elseif name == "divine_xing_jiang_clg_stage" then
		self.divine_xing_jiang_clg_stage = content
	elseif name == "divine_xing_jiang_clg_buff" then
		self.divine_xing_jiang_clg_buff = content
	elseif name == "divine_xing_jiang_clg_creeps_master" then
		self.divine_xing_jiang_clg_creeps_master = content
	elseif name == "divine_xing_jiang_clg_creeps" then
		self.divine_xing_jiang_clg_creeps = content
	elseif name == "divine_xing_jiang_clg_star_atlas" then
		self.divine_xing_jiang_clg_star_atlas = content
	end
end

function DivineXingJiangClgConfig:getActivityCfg(activityId)
	return self.divine_xing_jiang_clg[activityId]
end

function DivineXingJiangClgConfig:getCommonValue(key)
	return self.divine_xing_jiang_clg_common[key] and self.divine_xing_jiang_clg_common[key].value
end

function DivineXingJiangClgConfig:getStageList(activityId)
	return self.divine_xing_jiang_clg_stage[activityId]
end

function DivineXingJiangClgConfig:getStageCfg(activityId, stageId)
	return self.divine_xing_jiang_clg_stage[activityId] and self.divine_xing_jiang_clg_stage[activityId][stageId]
end

function DivineXingJiangClgConfig:getSameTeamStageCfg(activityId, stageId)
	if self._stageDic == nil or self._stageDic[activityId] == nil then
		self:_handleStage(activityId)
	end

	return self._stageDic[activityId] and self._stageDic[activityId][stageId]
end

function DivineXingJiangClgConfig:getBuffList(activityId)
	return self.divine_xing_jiang_clg_buff.dataList
end

function DivineXingJiangClgConfig:getMonsterCfg(creepsMasterId)
	return self.divine_xing_jiang_clg_creeps_master[creepsMasterId]
end

function DivineXingJiangClgConfig:getCreeps(creepsMasterId)
	return self.divine_xing_jiang_clg_creeps[creepsMasterId]
end

function DivineXingJiangClgConfig:_handleStage(activityId)
	self._stageDic = self._stageDic or {}
	self._stageDic[activityId] = {}

	local list = self.divine_xing_jiang_clg_stage[activityId]
	local starIds = {}

	for k, v in ipairs(list) do
		if not TableUtil.isHad(starIds, v.starAtlasId) then
			table.insert(starIds, v.starAtlasId)
		end
	end

	local tempDic = {}

	for i, v1 in ipairs(starIds) do
		for k, v2 in ipairs(list) do
			if v1 == v2.starAtlasId then
				tempDic[v1] = tempDic[v1] or {}

				table.insert(tempDic[v1], v2)

				if #tempDic[v1] == 2 then
					break
				end
			end
		end
	end

	for k, array in pairs(tempDic) do
		self._stageDic[activityId][array[1].stageId] = array[2]
		self._stageDic[activityId][array[2].stageId] = array[1]
	end
end

function DivineXingJiangClgConfig:getStarAtlasCfg(starAtlasId)
	return self.divine_xing_jiang_clg_star_atlas[starAtlasId]
end

DivineXingJiangClgConfig.instance = DivineXingJiangClgConfig.New()

return DivineXingJiangClgConfig
