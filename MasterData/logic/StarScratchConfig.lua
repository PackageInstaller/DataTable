-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/config/StarScratchConfig.lua

module("logic.extensions.starscratch.config.StarScratchConfig", package.seeall)

local StarScratchConfig = class("StarScratchConfig", BaseConfig)

function StarScratchConfig:onInit()
	StarScratchConfig.super.onInit(self)
end

function StarScratchConfig:getNames()
	return {
		"star_scratch_activity",
		"star_scratch_cycle",
		"star_scratch_prize"
	}
end

function StarScratchConfig:handleConfig(name, content)
	if name == "star_scratch_activity" then
		self._star_scratch_activity = content
	elseif name == "star_scratch_cycle" then
		self._star_scratch_cycle = content
	elseif name == "star_scratch_prize" then
		self._star_scratch_prize = content

		self:_handleBigPrize()
	end
end

function StarScratchConfig:getActivityCfg(activityId)
	return self._star_scratch_activity[activityId]
end

function StarScratchConfig:getCycleCfgs(activityId)
	return self._star_scratch_cycle[activityId]
end

function StarScratchConfig:getCycleCfg(activityId, cycleId)
	return self._star_scratch_cycle[activityId][cycleId]
end

function StarScratchConfig:_handleBigPrize()
	self._bigPrize = {}

	for i, v in ipairs(self._star_scratch_prize.dataList) do
		self._bigPrize[v.activityId] = self._bigPrize[v.activityId] or {}
		self._bigPrize[v.activityId][v.cycleId] = self._bigPrize[v.activityId][v.cycleId] or {}

		if v.isBigPrize == true then
			table.insert(self._bigPrize[v.activityId][v.cycleId], v)
		end
	end
end

function StarScratchConfig:getBigPrize(activityId, cycleId)
	return self._bigPrize[activityId][cycleId]
end

function StarScratchConfig:getPrizeCfgs(activityId, cycleId)
	return self._star_scratch_prize[activityId][cycleId]
end

function StarScratchConfig:getPrizeCfg(activityId, cycleId, prizeId)
	return self._star_scratch_prize[activityId][cycleId][prizeId]
end

StarScratchConfig.instance = StarScratchConfig.New()

return StarScratchConfig
