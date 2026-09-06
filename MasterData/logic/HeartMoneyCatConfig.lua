-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/config/HeartMoneyCatConfig.lua

module("logic.extensions.heartmoneycat.config.HeartMoneyCatConfig", package.seeall)

local HeartMoneyCatConfig = class("HeartMoneyCatConfig", BaseConfig)

function HeartMoneyCatConfig:onInit()
	HeartMoneyCatConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function HeartMoneyCatConfig:getNames()
	return {
		"treasure_basin",
		"treasure_basin_consume",
		"treasure_basin_prize",
		"treasure_basin_gift"
	}
end

function HeartMoneyCatConfig:handleConfig(name, content)
	if name == "treasure_basin" then
		self._activity = content
	elseif name == "treasure_basin_consume" then
		self._consume = content
	elseif name == "treasure_basin_prize" then
		self._prize = content
	elseif name == "treasure_basin_gift" then
		self._gift = content
	end
end

function HeartMoneyCatConfig:getActivity()
	return self._activity.dataList
end

function HeartMoneyCatConfig:getConsumeByPlanId(planId)
	return self._consume[planId]
end

function HeartMoneyCatConfig:getPrizeByPlanId(planId)
	return self._prize[planId]
end

function HeartMoneyCatConfig:getGift()
	return self._gift
end

HeartMoneyCatConfig.instance = HeartMoneyCatConfig.New()

return HeartMoneyCatConfig
