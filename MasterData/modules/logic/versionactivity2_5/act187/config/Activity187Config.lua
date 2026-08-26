-- chunkname: @modules/logic/versionactivity2_5/act187/config/Activity187Config.lua

module("modules.logic.versionactivity2_5.act187.config.Activity187Config", package.seeall)

local Activity187Config = class("Activity187Config", BaseConfig)

function Activity187Config:reqConfigNames()
	return {
		"activity187_const",
		"activity187",
		"activity187_blessing"
	}
end

function Activity187Config:onInit()
	return
end

function Activity187Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function Activity187Config:getAct187ConstCfg(constId, nilError)
	local cfg = lua_activity187_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("Activity187Config:getAct187ConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function Activity187Config:getAct187Const(constId)
	local result
	local cfg = self:getAct187ConstCfg(constId, true)

	return (cfg or nil) and cfg.value
end

function Activity187Config:getAct187AccrueRewardCfg(actId, accrueId, nilError)
	if lua_activity187.configDict[actId] then
		if not lua_activity187.configDict[actId] and nilError then
			logError(string.format("Activity187Config:getAct187AccrueRewardCfg error, cfg is nil, actId:%s, accrueId:%s", actId, accrueId))
		end

		return lua_activity187.configDict[actId]
	end
end

function Activity187Config:getAccrueRewardIdList(actId)
	local result = {}
	local cfgDict = lua_activity187.configDict[actId]

	if cfgDict then
		for id, _ in pairs(cfgDict) do
			result[#result + 1] = id
		end
	end

	return result
end

function Activity187Config:getAccrueRewards(actId, accrueId)
	local result = {}
	local cfg = self:getAct187AccrueRewardCfg(actId, accrueId, true)

	if cfg then
		local items = GameUtil.splitString2(cfg.bonus, true)

		for _, item in ipairs(items) do
			result[#result + 1] = {
				accrueId = accrueId,
				materilType = item[1],
				materilId = item[2],
				quantity = item[3]
			}
		end
	end

	return result
end

function Activity187Config:getAct187BlessingCfg(actId, rewardId, nilError)
	if activity187_blessing.configDict[actId] then
		if not activity187_blessing.configDict[actId] and nilError then
			logError(string.format("Activity187Config:getAct187BlessingCfg error, cfg is nil, actId:%s, rewardId:%s", actId, rewardId))
		end

		return activity187_blessing.configDict[actId]
	end
end

function Activity187Config:getLantern(actId, rewardId)
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	return (cfg or nil) and cfg.lantern
end

function Activity187Config:getLanternRibbon(actId, rewardId)
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	return (cfg or nil) and cfg.lanternRibbon
end

function Activity187Config:getLanternImg(actId, rewardId)
	local result
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	return (cfg or nil) and cfg.lanternImg
end

function Activity187Config:getLanternImgBg(actId, rewardId)
	local result
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	return (cfg or nil) and cfg.lanternImgBg
end

function Activity187Config:getBlessing(actId, rewardId)
	local cfg = self:getAct187BlessingCfg(actId, rewardId)

	return (cfg or nil) and cfg.blessing
end

Activity187Config.instance = Activity187Config.New()

return Activity187Config
