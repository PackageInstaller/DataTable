-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/config/FemaleGodConfig.lua

module("logic.extensions.femalegod.config.FemaleGodConfig", package.seeall)

local FemaleGodConfig = class("FemaleGodConfig", BaseConfig)

function FemaleGodConfig:onInit()
	FemaleGodConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function FemaleGodConfig:getNames()
	return {
		"inflation_money_activity",
		"inflation_money_progress_prize",
		"inflation_money_related_actId",
		"inflation_money_closet_pop"
	}
end

function FemaleGodConfig:handleConfig(name, content)
	if name == "inflation_money_activity" then
		self._activityCfg = content
	elseif name == "inflation_money_progress_prize" then
		self._inflation_money_progress_prize = content
	elseif name == "inflation_money_related_actId" then
		self._inflation_money_related_actId = content

		self:_setRelatedActIdDic()
	elseif name == "inflation_money_closet_pop" then
		self._inflation_money_closet_pop = content
	end
end

function FemaleGodConfig:getActivityCfg(activityId)
	return self._activityCfg[activityId]
end

function FemaleGodConfig:getActivityCfgByRelateActId(actId)
	local relateCfg = self:findRelatedCfgByRelateActId(actId)

	return self._activityCfg[relateCfg.activityId]
end

function FemaleGodConfig:getProgressCfg(activityId)
	return self._inflation_money_progress_prize[activityId]
end

function FemaleGodConfig:getRelatedCfg(activityId)
	return self._inflation_money_related_actId[activityId]
end

function FemaleGodConfig:getClosetCfg(activityId)
	return self._inflation_money_closet_pop[activityId]
end

function FemaleGodConfig:_setRelatedActIdDic()
	self._relatedActIdDic = {}

	for activityId, datas in pairs(self._inflation_money_related_actId) do
		self._relatedActIdDic[activityId] = {}

		for relatedActId, data in pairs(datas) do
			self._relatedActIdDic[activityId][relatedActId] = data
		end
	end
end

function FemaleGodConfig:findRelatedCfgByRelateActId(actId)
	for activityId, data in pairs(self._inflation_money_related_actId) do
		for relatedActId, cfg in pairs(data) do
			if relatedActId == checknumber(actId) then
				return cfg
			end
		end
	end
end

FemaleGodConfig.instance = FemaleGodConfig.New()

return FemaleGodConfig
