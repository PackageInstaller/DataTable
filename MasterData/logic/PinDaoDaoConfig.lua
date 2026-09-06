-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/config/PinDaoDaoConfig.lua

module("logic.extensions.pindaodao.config.PinDaoDaoConfig", package.seeall)

local PinDaoDaoConfig = class("PinDaoDaoConfig", BaseConfig)

function PinDaoDaoConfig:getNames()
	return {
		"pin_dao_dao_goods",
		"pin_dao_dao_reduce",
		"pin_dao_dao_activity"
	}
end

function PinDaoDaoConfig:handleConfig(name, content)
	if name == "pin_dao_dao_goods" then
		self._pin_dao_dao_goods = content
	elseif name == "pin_dao_dao_reduce" then
		self._pin_dao_dao_reduce = content
	elseif name == "pin_dao_dao_activity" then
		self._pin_dao_dao_activity = content
	end
end

function PinDaoDaoConfig:getActivityCfgById(id)
	return self._pin_dao_dao_activity[id]
end

function PinDaoDaoConfig:getGoodsCfgByActivityId(activityId, goodsId)
	local goodsCfg = self._pin_dao_dao_goods[activityId]

	if goodsCfg then
		return goodsCfg[goodsId]
	end
end

function PinDaoDaoConfig:getGoodsCfgs(activityId)
	return self._pin_dao_dao_goods[activityId]
end

function PinDaoDaoConfig:getReduceCfgByActivityId(activityId, reduceType)
	local reduceCfg = self._pin_dao_dao_reduce[activityId]

	if reduceCfg then
		return reduceCfg[reduceType]
	end
end

PinDaoDaoConfig.instance = PinDaoDaoConfig.New()

return PinDaoDaoConfig
