-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/config/MakeSnowmanConfig.lua

module("logic.extensions.makesnowman.config.MakeSnowmanConfig", package.seeall)

local MakeSnowmanConfig = class("MakeSnowmanConfig", BaseConfig)

function MakeSnowmanConfig:onInit()
	MakeSnowmanConfig.super.onInit(self)
end

function MakeSnowmanConfig:getNames()
	return {
		"make_snowman",
		"make_snowman_prize",
		"make_snowman_manmake"
	}
end

function MakeSnowmanConfig:handleConfig(name, content)
	if name == "make_snowman" then
		self._make_snowman = content
	elseif name == "make_snowman_prize" then
		self._make_snowman_prize = content
	elseif name == "make_snowman_manmake" then
		self._make_snowman_manmake = content
	end
end

function MakeSnowmanConfig:getFirstActivityId()
	return self._make_snowman.dataList[1].activityId
end

function MakeSnowmanConfig:getActivityCfg(activityId)
	return self._make_snowman[activityId]
end

function MakeSnowmanConfig:getProgressCfg(prizePlanId)
	return self._make_snowman_prize[prizePlanId]
end

function MakeSnowmanConfig:getPrizeCfg(prizePlanId, prizeId)
	return self._make_snowman_prize[prizePlanId][prizeId]
end

function MakeSnowmanConfig:getSnowmanCfg(snowmanId)
	return self._make_snowman_manmake[snowmanId]
end

function MakeSnowmanConfig:getPosCFg(snowmanId, posId)
	return self._make_snowman_manmake[snowmanId][posId]
end

MakeSnowmanConfig.instance = MakeSnowmanConfig.New()

return MakeSnowmanConfig
