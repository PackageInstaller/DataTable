-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/config/DivineSKLieXinClgConfig.lua

module("logic.extensions.divineskliexinclg.config.DivineSKLieXinClgConfig", package.seeall)

local DivineSKLieXinClgConfig = class("DivineSKLieXinClgConfig", BaseConfig)

function DivineSKLieXinClgConfig:onInit()
	return
end

function DivineSKLieXinClgConfig:getNames()
	return {
		"divine_sk_liexin_ut_score",
		"divine_sk_liexin_buff",
		"divine_sk_liexin_stage",
		"divine_sk_liexin_progress_prize",
		"divine_sk_liexin_creeps",
		"divine_sk_liexin_master",
		"divine_sk_liexin_clg"
	}
end

function DivineSKLieXinClgConfig:handleConfig(name, content)
	if name == "divine_sk_liexin_ut_score" then
		self._divine_sk_liexin_ut_score = content
	elseif name == "divine_sk_liexin_buff" then
		self._divine_sk_liexin_buff = content

		self:_handleBuffConfig(content)
	elseif name == "divine_sk_liexin_stage" then
		self._divine_sk_liexin_stage = content
	elseif name == "divine_sk_liexin_progress_prize" then
		self._divine_sk_liexin_progress_prize = content
	elseif name == "divine_sk_liexin_creeps" then
		self._divine_sk_liexin_creeps = content
	elseif name == "divine_sk_liexin_master" then
		self._divine_sk_liexin_master = content
	elseif name == "divine_sk_liexin_clg" then
		self._divine_sk_liexin_clg = content
	end
end

function DivineSKLieXinClgConfig:getActivityCfg(activityId)
	return self._divine_sk_liexin_clg[activityId]
end

function DivineSKLieXinClgConfig:getStageCfgs(stagePlanId)
	return self._divine_sk_liexin_stage[stagePlanId]
end

function DivineSKLieXinClgConfig:getStageCfg(stagePlanId, stageId)
	if self._divine_sk_liexin_stage[stagePlanId] then
		return self._divine_sk_liexin_stage[stagePlanId][stageId]
	end
end

function DivineSKLieXinClgConfig:getPrizeCfgs(prizePlanId)
	return self._divine_sk_liexin_progress_prize[prizePlanId]
end

function DivineSKLieXinClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_sk_liexin_master[creepsMasterId]
end

function DivineSKLieXinClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_sk_liexin_creeps[creepsMasterId]
end

function DivineSKLieXinClgConfig:getUtScorePlanCfg(utScorePlanId)
	return self._divine_sk_liexin_ut_score[utScorePlanId]
end

function DivineSKLieXinClgConfig:getBuffCfgs(collectBuffPlanId)
	return self._divine_sk_liexin_buff[collectBuffPlanId]
end

function DivineSKLieXinClgConfig:getBuffCfg(collectBuffPlanId, num)
	if self._divine_sk_liexin_buff[collectBuffPlanId] then
		return self._divine_sk_liexin_buff[collectBuffPlanId][num]
	end
end

function DivineSKLieXinClgConfig:_handleBuffConfig(content)
	self._buffCfgList = {}

	for i, v in ipairs(content.dataList) do
		self._buffCfgList[v.collectBuffPlanId] = self._buffCfgList[v.collectBuffPlanId] or {}

		table.insert(self._buffCfgList[v.collectBuffPlanId], v)
	end

	for i, v in pairs(self._buffCfgList) do
		table.sort(v, function(a, b)
			return a.num < b.num
		end)
	end
end

function DivineSKLieXinClgConfig:getBuffCfgList(collectBuffPlanId)
	return self._buffCfgList[collectBuffPlanId]
end

DivineSKLieXinClgConfig.instance = DivineSKLieXinClgConfig.New()

return DivineSKLieXinClgConfig
