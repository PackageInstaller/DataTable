-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/config/FruitNinjaConfig.lua

module("logic.extensions.fruitninja.config.FruitNinjaConfig", package.seeall)

local FruitNinjaConfig = class("FruitNinjaConfig", BaseConfig)

function FruitNinjaConfig:onInit()
	FruitNinjaConfig.super.onInit(self)
end

function FruitNinjaConfig:getNames()
	return {
		"fruit_ninja_activity",
		"fruit_ninja_progress_prize",
		"fruit_ninja_rank_prize",
		"fruit_ninja_game_plan",
		"fruit_ninja_rhythm",
		"fruit_ninja_fruit",
		"fruit_ninja_combo",
		"fruit_ninja_critical"
	}
end

function FruitNinjaConfig:handleConfig(name, content)
	if name == "fruit_ninja_activity" then
		self._fruit_ninja_activity = content
	elseif name == "fruit_ninja_progress_prize" then
		self._fruit_ninja_progress_prize = content
	elseif name == "fruit_ninja_rank_prize" then
		self._fruit_ninja_rank_prize = content
	elseif name == "fruit_ninja_game_plan" then
		self._fruit_ninja_game_plan = content
	elseif name == "fruit_ninja_rhythm" then
		self._fruit_ninja_rhythm = content
	elseif name == "fruit_ninja_fruit" then
		self._fruit_ninja_fruit = content
	elseif name == "fruit_ninja_combo" then
		self._fruit_ninja_combo = content
	elseif name == "fruit_ninja_critical" then
		self._fruit_ninja_critical = content
	end
end

function FruitNinjaConfig:getActData(activityId)
	return self._fruit_ninja_activity[activityId]
end

function FruitNinjaConfig:getProgressPrizeCfg(activityId)
	return self._fruit_ninja_progress_prize[activityId]
end

function FruitNinjaConfig:getProgressPrizeData(activityId, prizeId)
	if self._fruit_ninja_progress_prize[activityId] then
		return self._fruit_ninja_progress_prize[activityId][prizeId]
	end
end

function FruitNinjaConfig:getProgressPrizeDataByScore(activityId, score)
	local cfg = self._fruit_ninja_progress_prize[activityId]

	return MmUtil.binarySearchInSingleKey(cfg, "needScore", score)
end

function FruitNinjaConfig:getRankCfg(activityId)
	return self._fruit_ninja_rank_prize[activityId]
end

function FruitNinjaConfig:getRankData(activityId, rank)
	local cfg = self._fruit_ninja_rank_prize[activityId]

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function FruitNinjaConfig:getGamePlanData(gamePlanId)
	return self._fruit_ninja_game_plan[gamePlanId]
end

function FruitNinjaConfig:getRhythmCfg(gamePlanId)
	local data = self:getGamePlanData(gamePlanId)

	if data then
		if not data.rhythmPlanId then
			local rhythmPlanId = 0

			return self._fruit_ninja_rhythm[rhythmPlanId]
		end
	end
end

function FruitNinjaConfig:getCrazyRhythmCfg(gamePlanId)
	local data = self:getGamePlanData(gamePlanId)

	if data then
		if not data.crazyRhythmPlanId then
			local rhythmPlanId = 0

			return self._fruit_ninja_rhythm[rhythmPlanId]
		end
	end
end

function FruitNinjaConfig:getFruitData(fruitId)
	return self._fruit_ninja_fruit[fruitId]
end

function FruitNinjaConfig:getFruitScore(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.score or 0)
end

function FruitNinjaConfig:getSliceHealth(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.sliceHealth or 0)
end

function FruitNinjaConfig:getOutHealth(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.outHealth or 0)
end

function FruitNinjaConfig:isClearScreen(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.isClearScreen or false)
end

function FruitNinjaConfig:getFruitDoubleTime(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.doubleTime or 0)
end

function FruitNinjaConfig:getFruitCrazyTime(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.crazyTime or 0)
end

function FruitNinjaConfig:getFruitCriticalScore(fruitId)
	local data = self:getFruitData(fruitId)

	return (data or nil) and (data.criticalScore or 0)
end

function FruitNinjaConfig:getFruitIconPath(fruitId)
	local data = self:getFruitData(fruitId)

	return data and data.iconPath
end

function FruitNinjaConfig:getFruitClipPath(fruitId)
	local data = self:getFruitData(fruitId)

	return data and data.clipPath
end

function FruitNinjaConfig:getComboCfg(gamePlanId)
	local data = self:getGamePlanData(gamePlanId)

	if data then
		if not data.rhythmPlanId then
			local rhythmPlanId = 0

			return self._fruit_ninja_combo[rhythmPlanId]
		end
	end
end

function FruitNinjaConfig:getComboData(gamePlanId, comboId)
	local cfg = self:getComboCfg(gamePlanId)

	return cfg and cfg[comboId]
end

function FruitNinjaConfig:getComboDataByCount(gamePlanId, comboCount)
	local cfg = self:getComboCfg(gamePlanId)

	return MmUtil.binarySearchInSingleKey(cfg, "comboCount", comboCount)
end

function FruitNinjaConfig:getCriticalCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.criPlanId then
			local criPlanId = 0

			return self._fruit_ninja_critical[criPlanId]
		end
	end
end

function FruitNinjaConfig:getCriticalData(activityId, criId)
	local cfg = self:getCriticalCfg(activityId)

	return cfg and cfg[criId]
end

function FruitNinjaConfig:getCriticalDataByScore(activityId, score)
	local cfg = self:getCriticalCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "score", score)
end

FruitNinjaConfig.instance = FruitNinjaConfig.New()

return FruitNinjaConfig
