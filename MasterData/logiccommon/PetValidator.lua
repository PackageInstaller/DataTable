-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/PetValidator.lua

module("logiccommon.common.util.PetValidator", package.seeall)

local PetValidator = {}

function PetValidator.IsMatchById(expressStr, petId)
	local info = BagPetsFacade.instance:getPetInfo(petId)

	return PetValidator.IsMatch(expressStr, info)
end

function PetValidator.IsMatch(expressStr, info)
	if not info then
		return false
	end

	local raceId = info.raceId
	local level = info.level
	local cfg = CharacterConfig.instance:getPetCo(raceId)

	if not cfg then
		return false
	end

	local job = PetSkinConfig.instance:getJobKeyList(raceId)
	local attr = PetSkinConfig.instance:getAllElementAttrs(raceId)
	local resultStr = expressStr
	local procStr = string.gsub(expressStr, "[%(%)]", "")

	procStr = string.gsub(procStr, "[%&%|%!]", "#")

	local expStrs = string.split(procStr, "#")

	for i, v in ipairs(expStrs) do
		local express = string.split(v, "$")
		local pre = express[1]
		local tail = express[2]
		local replaceStr = ""

		if pre == "Job" then
			replaceStr = PetValidator.JobExpress(tail, job)
		elseif pre == "Level" then
			replaceStr = PetValidator.LevelExpress(tail, level)
		elseif pre == "RaceType" then
			replaceStr = PetValidator.AttrExpress(tail, attr)
		elseif pre == "Race" then
			replaceStr = PetValidator.RaceExpress(tail, raceId)
		end

		resultStr = string.gsub(resultStr, v, replaceStr)
	end

	resultStr = string.gsub(resultStr, "%&", " and ")
	resultStr = string.gsub(resultStr, "%|", " or ")
	resultStr = string.gsub(resultStr, "%!", " not ")
	resultStr = "return " .. resultStr

	local func = loadstring(resultStr)

	return func()
end

function PetValidator.TalentExpress(expressStr, talentType)
	local params = string.split(expressStr, ",")
	local compFunc = PetValidator.GetCompFunc(params[1])
	local val = checknumber(params[2])

	return tostring(compFunc(talentType, val))
end

function PetValidator.LevelExpress(expressStr, level)
	local params = string.split(expressStr, ",")
	local compFunc = PetValidator.GetCompFunc(params[1])
	local val = checknumber(params[2])

	return tostring(compFunc(level, val))
end

function PetValidator.GetCompFunc(expressStr)
	return expressStr == GameEnum.GREATER_THAN and function(x, y)
		return y < x
	end or expressStr == GameEnum.LESS_THAN and function(x, y)
		return x < y
	end or expressStr == GameEnum.GREATER_THAN_OR_EQUAL_TO and function(x, y)
		return y <= x
	end or expressStr == GameEnum.LESS_THAN_OR_EQUAL_TO and function(x, y)
		return x <= y
	end or function(x, y)
		return x == y
	end
end

function PetValidator.RaceExpress(expressStr, raceId)
	return PetValidator.ParseExpress(expressStr, raceId)
end

function PetValidator.JobExpress(expressStr, jobList)
	for i, job in ipairs(jobList) do
		if PetValidator.ParseExpress(expressStr, job) == "true" then
			return "true"
		end
	end

	return "false"
end

function PetValidator.AttrExpress(expressStr, attr)
	return PetValidator.ParseExpress(expressStr, attr)
end

function PetValidator.ParseExpress(expressStr, val)
	local valList = string.split(expressStr, ",")

	for i, v in ipairs(valList) do
		if checknumber(v) == val or v == val then
			return "true"
		end
	end

	return "false"
end

return PetValidator
