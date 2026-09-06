-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/config/ExpeditionConfig.lua

module("logic.extensions.expedition.config.ExpeditionConfig", package.seeall)

local ExpeditionConfig = class("ExpeditionConfig", BaseConfig)

ExpeditionConfig.ReviveItemId = 71

function ExpeditionConfig:onInit()
	ExpeditionConfig.super.onInit(self)

	self._expeditionConst = nil
	self._expeditionEventCfg = nil
	self._expeditionBuffCfg = nil
	self._expeditionRandomCfg = nil
	self._expeditionShopCfg = nil
end

function ExpeditionConfig:getNames()
	return {
		"expedition_param",
		"expedition_event",
		"expedition_buff",
		"expedition_random",
		"expedition_shop",
		"expedition_map",
		"expedition_grid_map",
		"expedition_fight_win_prize",
		"expedition_prize",
		"expedition_rival_property_weight",
		"expedition_job_prop_point",
		"expedition_level",
		"expedition_grid_type"
	}
end

function ExpeditionConfig:handleConfig(name, content)
	if name == "expedition_param" then
		self._expeditionConst = content

		local reviveItems = string.split(self:getConst("reviveCostItem"), ":")

		ExpeditionConfig.ReviveItemId = checknumber(reviveItems[2])
	elseif name == "expedition_map" then
		self._expMapData = content
	elseif name == "expedition_event" then
		self._expeditionEventCfg = content
	elseif name == "expedition_prize" then
		self._expeditionPrizeCfg = content
	elseif name == "expedition_buff" then
		self._expeditionBuffCfg = content
	elseif name == "expedition_random" then
		self._expeditionRandomCfg = content
	elseif name == "expedition_shop" then
		self._expeditionShopCfg = content
	elseif name == "expedition_grid_map" then
		self._gridMapCfg = content
	elseif name == "expedition_fight_win_prize" then
		self:_handleFightPrize(content)
	elseif name == "expedition_rival_property_weight" then
		self._rivalPropertyWeight = content
	elseif name == "expedition_job_prop_point" then
		self._jobPropPoint = content
	elseif name == "expedition_level" then
		self._nextLevelConfig = content
	elseif name == "expedition_grid_type" then
		self._expedition_grid_type = content
	end
end

function ExpeditionConfig:_handleFightPrize(content)
	self._expFightPrize = {}

	for i = 1, #content.dataList do
		local data = content.dataList[i]

		self._expFightPrize[data.planId] = self._expFightPrize[data.planId] or {}

		table.insert(self._expFightPrize[data.planId], data)
	end
end

function ExpeditionConfig:getConst(id)
	if self._expeditionConst[id] then
		if not string.nilorempty(self._expeditionConst[id].paramValue2) then
			return self._expeditionConst[id].paramValue2
		else
			return self._expeditionConst[id].paramValue
		end
	end
end

function ExpeditionConfig:getNextLevelCo(currLv)
	return self._nextLevelConfig[currLv]
end

function ExpeditionConfig:getConstInt(id)
	return checknumber(self:getConst(id))
end

function ExpeditionConfig:getExpeditionMapCo(id)
	return self._expMapData[id]
end

function ExpeditionConfig:getExpeditionMapStepCo(id, step)
	return self._expMapData[id][step]
end

function ExpeditionConfig:getMaxSight()
	return self:getConstInt("maxSight")
end

function ExpeditionConfig:getEventCfg(eventId)
	return self._expeditionEventCfg[eventId]
end

function ExpeditionConfig:getMapGripCfg(eventId)
	return self._gridMapCfg[eventId]
end

function ExpeditionConfig:getMapGripTypeCfg(eventId)
	return self._expedition_grid_type[eventId]
end

function ExpeditionConfig:getBuffCfg(id)
	return self._expeditionBuffCfg[id]
end

function ExpeditionConfig:getRandomCfg(id)
	return self._expeditionRandomCfg[id]
end

function ExpeditionConfig:getShopCfg(id)
	return self._expeditionShopCfg[id]
end

function ExpeditionConfig:getPrizCfg(id)
	return self._expeditionPrizeCfg[id]
end

function ExpeditionConfig:getFightPrize(id)
	return self._expFightPrize[id]
end

function ExpeditionConfig:getRivalPropertyWeight(lv)
	return (self._rivalPropertyWeight[lv] or nil) and (self._rivalPropertyWeight[lv].weight or 0)
end

function ExpeditionConfig:getJobSpeedPoint(job)
	return (self._jobPropPoint[job] or nil) and (self._jobPropPoint[job].speedPoint or 0)
end

function ExpeditionConfig:getJobPropCfg(job)
	return self._jobPropPoint[job]
end

ExpeditionConfig.instance = ExpeditionConfig.New()

return ExpeditionConfig
