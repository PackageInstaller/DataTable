-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\StageSkipMixin.lua

local ResStageSkip = require("ClientData/ResStageSkip")
local ResRandClient = require("ClientData/ResRandClient")
local ResStage = require("ClientData/ResStage")
local ResStageMisc = require("ClientData/ResStageMisc")
local ResBeginnerGuide = require("ClientData/ResBeginnerGuide")
local StageSkipMixin = {}

function StageSkipMixin:initStageSkipMixin(baseData)
	return
end

function StageSkipMixin:checkCanSkipStage()
	if not Const.STAGE_SKIP_OPEN then
		return false
	end

	if ResStageMisc and ResStageMisc[1] and ResStageMisc[1].stage_skip_condition and ConditionLimitManager.inLimitState(ResStageMisc[1].stage_skip_condition) then
		return false
	end

	local curData = self:getNowStageData()
	local maxData = self:getMaxCanSkipStage()

	if maxData and curData then
		return maxData.idx >= curData.idx
	end

	return false
end

function StageSkipMixin:getShowNextStagesData(...)
	local maxData = self:getMaxCanSkipStage()

	if maxData then
		local index = maxData.idx

		if self.stageDatas and self.stageDatas[index] then
			return self.stageDatas[index]
		end
	end
end

function StageSkipMixin:getMaxCanSkipStage(...)
	local maxData = {}

	maxData.idx = 0

	for i = 1, #ResStageSkip do
		local resData = ResStageSkip[i]

		if resData and self:checkStageSkipLimit(resData) and resData.stage_id then
			local stageData = self:getMainStageInfo(resData.stage_id[1] or 1, resData.stage_id[2] or 1, resData.stage_id[3] or 1)

			if stageData and stageData.idx > maxData.idx then
				maxData = stageData
			end
		end
	end

	local stageData = self:getHaveUnFinishBeginnerGuideLevel()

	if stageData and maxData.idx > stageData.idx then
		maxData = stageData
	end

	return maxData
end

function StageSkipMixin:getStageAwardsData(Season, Chapter, Level)
	local map = {}
	local showIds = {}
	local showNums = {}
	local curData = self:getNowStageData()

	if not Season or not Chapter or not Level then
		return
	end

	local stageData = ResStage[Season][Chapter][Level]
	local endIdx

	if stageData and ResStage[Season] and ResStage[Season][Chapter] and ResStage[Season][Chapter][Level] then
		endIdx = ResStage[Season][Chapter][Level].idx
	end

	if endIdx then
		for i = curData.idx, endIdx do
			if self.stageDatas and self.stageDatas[i] then
				local award = self.stageDatas[i].award

				if award and ResRandClient[award] then
					local data = ResRandClient[award]

					for idx, id in ipairs(data.show_ids) do
						if map[id] then
							if data.show_nums[idx] then
								showNums[map[id]] = showNums[map[id]] + data.show_nums[idx]
							end
						else
							if data.show_nums[idx] then
								table.insert(showNums, data.show_nums[idx])
							end

							table.insert(showIds, id)

							map[id] = #showIds
						end
					end
				end
			end
		end
	end

	local data = {}

	data.show_ids = showIds
	data.show_nums = showNums

	return data
end

function StageSkipMixin:getBattleSkipShowDataByIdx(idx)
	if idx and self.stageDatas and self.stageDatas[idx] then
		local data = {}

		data.season = self.stageDatas[idx].season
		data.chapter = self.stageDatas[idx].chapter
		data.level = self.stageDatas[idx].level
		data.showAward = self:getStageAwardsData(data.season, data.chapter, data.level)

		return data
	end
end

function StageSkipMixin:onStageSkipResp(...)
	local ui = UIManager.tryGetUI("mainStageDlg")

	if ui then
		ui:refreshData()
	end
end

function StageSkipMixin:getSkipStageData(...)
	local stageData = self:getMaxCanSkipStage()
	local curData = self:getNowStageData()
	local showData = {}

	if stageData.idx > curData.idx then
		local num = stageData.idx - curData.idx + 1

		if num > 10 then
			local index = math.ceil(num / 3)
			local data1 = self:getBattleSkipShowDataByIdx(index + curData.idx - 1)

			if data1 then
				table.insert(showData, data1)
			end

			local data2 = self:getBattleSkipShowDataByIdx(index * 2 + curData.idx - 1)

			if data2 then
				table.insert(showData, data2)
			end
		elseif num >= 2 then
			local index = math.ceil(num / 2)
			local data = self:getBattleSkipShowDataByIdx(index + curData.idx - 1)

			if data then
				table.insert(showData, data)
			end
		end
	end

	local data = self:getBattleSkipShowDataByIdx(stageData.idx)

	if data then
		table.insert(showData, data)
	end

	return showData
end

function StageSkipMixin:getHaveUnFinishBeginnerGuideLevel(...)
	local minData
	local curData = self:getNowStageData()

	for beginnerId, info in pairs(ResBeginnerGuide) do
		if not BeginnerManager.isBeginnerFinished(beginnerId) and (info.conditions == Const.BEGINNER_CONDITION_STAGE or info.conditions == Const.BEGINNER_CONDITION_STAGE_RANGE) then
			local check = true
			local args = info.condition_args
			local check = true

			if info.conditions == Const.BEGINNER_CONDITION_STAGE_RANGE then
				local stageData = self:getMainStageInfo(tonumber(args[4] or 1), tonumber(args[5] or 1), tonumber(args[6] or 1))

				if curData.idx >= stageData.idx then
					check = false
				end
			elseif self:getMainStageStateByInfo(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1)) == Const.STAGE_STATE_PASSED then
				check = false
			end

			local stageData = self:getMainStageInfo(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1))

			if (not minData or minData.idx > stageData.idx) and check then
				minData = stageData
			end
		end
	end

	return minData
end

function StageSkipMixin:checkStageSkipLimit(data)
	if not data then
		return false
	end

	local heroLevelFlag = false
	local heroStarFlag = false
	local heroSpecialFlag = false
	local checkNumOfHeroLevel = 0
	local checkNumOfHeroStar = 0
	local checkNumOfHeroSpecialStar = 0

	for _, hero in pairs(self.heroDic) do
		if data.hero_limit1_level and hero.level >= data.hero_limit1_level then
			checkNumOfHeroLevel = checkNumOfHeroLevel + 1
		end

		if data.hero_limit2_star and hero.star >= data.hero_limit2_star then
			checkNumOfHeroStar = checkNumOfHeroStar + 1
		end

		if data.special_star and hero.star >= data.special_star then
			checkNumOfHeroSpecialStar = checkNumOfHeroSpecialStar + 1
		end

		if data.hero_limit1_num and checkNumOfHeroLevel >= data.hero_limit1_num then
			heroLevelFlag = true
		end

		if data.hero_limit2_num and checkNumOfHeroStar >= data.hero_limit2_num then
			heroStarFlag = true
		end

		if data.special_num and checkNumOfHeroSpecialStar >= data.special_num then
			heroSpecialFlag = true
		end

		if heroSpecialFlag or heroLevelFlag and heroStarFlag then
			return true
		end
	end

	return false
end

return StageSkipMixin
