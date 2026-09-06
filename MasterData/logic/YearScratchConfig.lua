-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/config/YearScratchConfig.lua

module("logic.extensions.yirenpozhen.config.YearScratchConfig", package.seeall)

local YearScratchConfig = class("YearScratchConfig", BaseConfig)

function YearScratchConfig:onInit()
	YearScratchConfig.super.onInit(self)
end

function YearScratchConfig:getNames()
	return {
		"year_scratch_activity",
		"year_scratch_cycle",
		"year_scratch_cycle_prize",
		"year_scratch_god_gen"
	}
end

function YearScratchConfig:handleConfig(name, content)
	if name == "year_scratch_activity" then
		self._year_scratch_activity = content
	elseif name == "year_scratch_cycle" then
		self._year_scratch_cycle = content
	elseif name == "year_scratch_cycle_prize" then
		self._year_scratch_cycle_prize = content

		self:handlePrize()
	elseif name == "year_scratch_god_gen" then
		self._year_scratch_god_gen = content
	end
end

function YearScratchConfig:getActivityCfg(activityId)
	return self._year_scratch_activity[activityId]
end

function YearScratchConfig:getCycleCfgs(activityId)
	return self._year_scratch_cycle[activityId]
end

function YearScratchConfig:getCycleCfg(activityId, cycleId)
	return self._year_scratch_cycle[activityId][cycleId]
end

function YearScratchConfig:handlePrize()
	self._bigPrizeList = self._bigPrizeList and table.clear(self._bigPrizeList) or {}

	if self._year_scratch_cycle_prize then
		for i, v in ipairs(self._year_scratch_cycle_prize.dataList) do
			self._bigPrizeList[v.activityId] = self._bigPrizeList[v.activityId] or {}
			self._bigPrizeList[v.activityId][v.cycleId] = self._bigPrizeList[v.activityId][v.cycleId] or {}

			if v.bigPrize == true then
				table.insert(self._bigPrizeList[v.activityId][v.cycleId], v.prize)
			end
		end
	end
end

function YearScratchConfig:getBigPrize(activityId, cycleId)
	if self._bigPrizeList and self._bigPrizeList[activityId] then
		return self._bigPrizeList[activityId][cycleId]
	end

	return nil
end

function YearScratchConfig:getPrize(activityId, cycleId, prizeId)
	return self._year_scratch_cycle_prize[activityId][cycleId][prizeId]
end

function YearScratchConfig:getGodGemCfg(activityId)
	return self._year_scratch_god_gen[activityId]
end

YearScratchConfig.instance = YearScratchConfig.New()

return YearScratchConfig
