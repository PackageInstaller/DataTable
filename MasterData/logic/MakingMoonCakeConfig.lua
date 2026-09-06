-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/config/MakingMoonCakeConfig.lua

module("logic.extensions.makingmooncake.config.MakingMoonCakeConfig", package.seeall)

local MakingMoonCakeConfig = class("MakingMoonCakeConfig", BaseConfig)

MakingMoonCakeConfig.FIRST_LOGIN = "FirstLogin"
MakingMoonCakeConfig.FIRST_GAME = "FirstGame"

function MakingMoonCakeConfig:onInit()
	MakingMoonCakeConfig.super.onInit(self)
end

function MakingMoonCakeConfig:getNames()
	return {
		"making_moon_cake",
		"making_moon_cake_params",
		"making_moon_cake_score_prize",
		"making_moon_cake_times",
		"making_moon_cake_cumulative_prize",
		"making_moon_cake_text",
		"making_moon_cake_info",
		"making_moon_cake_material",
		"making_moon_cake_role"
	}
end

function MakingMoonCakeConfig:handleConfig(name, content)
	if name == "making_moon_cake" then
		self._activity = content
	elseif name == "making_moon_cake_params" then
		self._params = content
	elseif name == "making_moon_cake_score_prize" then
		self._scorePrize = content
	elseif name == "making_moon_cake_times" then
		self._times = content
	elseif name == "making_moon_cake_cumulative_prize" then
		self._cumulativePrize = content
	elseif name == "making_moon_cake_text" then
		self._text = content
	elseif name == "making_moon_cake_info" then
		self._info = content
	elseif name == "making_moon_cake_material" then
		self._material = content
	elseif name == "making_moon_cake_role" then
		self._making_moon_cake_role = content
	end
end

function MakingMoonCakeConfig:getActivity()
	return self._activity.dataList
end

function MakingMoonCakeConfig:getParamByKey(key)
	return self._params[key].value
end

function MakingMoonCakeConfig:getScorePrizeByPlanId(planId)
	return self._scorePrize[planId]
end

function MakingMoonCakeConfig:getTimesByPlanId(planId)
	return self._times[planId]
end

function MakingMoonCakeConfig:getCumulativePrizeByPlanId(planId)
	return self._cumulativePrize[planId]
end

function MakingMoonCakeConfig:getTextByKey(key)
	return self._text[key].value
end

function MakingMoonCakeConfig:getInfo()
	return self._info
end

function MakingMoonCakeConfig:getInfoById(id)
	return self._info[id]
end

function MakingMoonCakeConfig:getMaterial()
	return self._material
end

function MakingMoonCakeConfig:getMaterialById(id)
	return self._material[id]
end

function MakingMoonCakeConfig:getProgressName()
	local progressName = self:getParamByKey("PROGRESS_NAME")

	return (string.split(progressName, "#"))
end

function MakingMoonCakeConfig:getProgressReward(activityId)
	local cfgs = self._making_moon_cake_role[activityId]
	local prizesArr = {}

	if cfgs then
		for idx, data in ipairs(cfgs) do
			table.insert(prizesArr, data.prize)
		end
	end

	return prizesArr
end

function MakingMoonCakeConfig:getProgressQPetSources()
	local qPetSource = self:getParamByKey("PROGRESS_SELECT_PET")

	if qPetSource == nil then
		return {}
	else
		local arr = string.split(qPetSource, "#")

		return arr or {}
	end
end

function MakingMoonCakeConfig:getProgressQPetNames()
	local qPetName = self:getParamByKey("PROGRESS_SELECT_PET_NAME")

	if qPetName == nil then
		return {}
	else
		local arr = string.split(qPetName, "#")

		return arr or {}
	end
end

function MakingMoonCakeConfig:getAutoTotalScore()
	return (self:getParamByKey("PROGRESS_AUTO_SCORE"))
end

function MakingMoonCakeConfig:getRoleCfg(activityId)
	return self._making_moon_cake_role and self._making_moon_cake_role[activityId]
end

MakingMoonCakeConfig.instance = MakingMoonCakeConfig.New()

return MakingMoonCakeConfig
