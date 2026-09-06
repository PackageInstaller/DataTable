-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/config/CiyuanSigninConfig.lua

module("logic.extensions.ciyuansignin.config.CiyuanSigninConfig", package.seeall)

local CiyuanSigninConfig = class("CiyuanSigninConfig", BaseConfig)

CiyuanSigninConfig.PlayerType = {
	DimensionHeart = 3,
	DimensionDragon = 2,
	None = 1
}

function CiyuanSigninConfig:onInit()
	CiyuanSigninConfig.super.onInit(self)

	self._activityCfg = nil
	self._typeCfg = nil
	self._rewardCfg = nil
end

function CiyuanSigninConfig:getNames()
	return {
		"ciyuan_signin_activity",
		"ciyuan_signin_player_type",
		"ciyuan_signin_prize"
	}
end

function CiyuanSigninConfig:handleConfig(name, content)
	if name == "ciyuan_signin_activity" then
		self._activityCfg = content
	elseif name == "ciyuan_signin_player_type" then
		self._typeCfg = content
	elseif name == "ciyuan_signin_prize" then
		self._rewardCfg = content
	end
end

function CiyuanSigninConfig:getActivityCfg(activityId)
	return self._activityCfg[activityId]
end

function CiyuanSigninConfig:getPlayerTypeCfg(activityId, typeId)
	local cfgs = self:getPlayerTypeCfgs(activityId)

	return cfgs and cfgs[typeId]
end

function CiyuanSigninConfig:getPlayerTypeCfgs(activityId)
	return self._typeCfg[activityId]
end

function CiyuanSigninConfig:getSignRewardCfgs(activityId, typeId)
	local actCfgs = self._rewardCfg[activityId]

	if not actCfgs then
		return {}
	end

	local cfgs = {}

	for day, typeCfgs in pairs(actCfgs) do
		local cfg = typeCfgs and typeCfgs[typeId]

		if cfg then
			cfgs[#cfgs + 1] = cfg
		end
	end

	table.sort(cfgs, function(a, b)
		return a.day < b.day
	end)

	return cfgs
end

function CiyuanSigninConfig:getSignRewardCfg(activityId, typeId, day)
	local actCfgs = self._rewardCfg[activityId]
	local typeCfgs = actCfgs and actCfgs[day]

	return typeCfgs and typeCfgs[typeId]
end

function CiyuanSigninConfig:getSignRewardCount(activityId, typeId)
	return #self:getSignRewardCfgs(activityId, typeId)
end

function CiyuanSigninConfig:getMaxSignDay(activityId)
	local actCfgs = self._rewardCfg[activityId]
	local count = 0

	for _ in pairs(actCfgs or {}) do
		count = count + 1
	end

	return count
end

CiyuanSigninConfig.instance = CiyuanSigninConfig.New()

return CiyuanSigninConfig
