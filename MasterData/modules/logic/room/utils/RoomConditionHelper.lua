-- chunkname: @modules/logic/room/utils/RoomConditionHelper.lua

module("modules.logic.room.utils.RoomConditionHelper", package.seeall)

local RoomConditionHelper = {}

RoomConditionHelper._conditionFunction = nil

function RoomConditionHelper._getFuncDict()
	RoomConditionHelper._conditionFunction = RoomConditionHelper._conditionFunction or {
		EpisodeFinish = function(episodeId)
			return DungeonModel.instance:hasPassLevelAndStory(tonumber(episodeId))
		end,
		FinishTask = function(taskId)
			local taskMO = TaskModel.instance:getTaskById(tonumber(taskId))

			return taskMO and taskMO.finishCount >= taskMO.config.maxFinishCount
		end,
		OpenFunction = function(openId)
			return OpenModel.instance:isFunctionUnlock(tonumber(openId))
		end,
		ChapterMapElement = function(preElementId)
			return DungeonMapModel.instance:elementIsFinished(tonumber(preElementId))
		end,
		HasHeroId = function(heroId)
			local heroMo = HeroModel.instance:getByHeroId(tonumber(heroId))

			return heroMo and heroMo:isOwnHero()
		end,
		HeroSkinId = function(str)
			local nums = string.splitToNumber(str, "#")

			if nums and #nums > 1 then
				local heroMo = HeroModel.instance:getByHeroId(nums[1])

				if heroMo and heroMo.skin == nums[2] then
					return true
				end
			end

			return false
		end
	}

	return RoomConditionHelper._conditionFunction
end

function RoomConditionHelper.isConditionStr(conditionStr)
	if string.nilorempty(conditionStr) then
		return true
	end

	local funcMap = RoomConditionHelper._getFuncDict()
	local condFlag = true
	local condStrArr = string.split(conditionStr, " or ")

	for i, condStr in ipairs(condStrArr) do
		local condArr = string.split(condStr, " and ")

		if condArr and #condArr > 0 then
			condFlag = true

			for _, cond in ipairs(condArr) do
				local params = string.split(cond, "=")
				local func = funcMap[string.trim(params[1])]

				if func and not func(params[2]) then
					condFlag = false

					break
				end
			end
		end

		if condFlag then
			return true
		end
	end

	return condFlag
end

return RoomConditionHelper
