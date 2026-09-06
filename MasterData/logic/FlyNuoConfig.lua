-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/config/FlyNuoConfig.lua

module("logic.extensions.flyingnuo.config.FlyNuoConfig", package.seeall)

local FlyNuoConfig = class("FlyNuoConfig", BaseConfig)

function FlyNuoConfig:onInit()
	FlyNuoConfig.super.onInit(self)
end

function FlyNuoConfig:getNames()
	return {
		"flying_nuo",
		"flying_nuo_prize",
		"flying_nuo_buy_times",
		"flying_nuo_common_config",
		"flying_nuo_rule_config"
	}
end

function FlyNuoConfig:handleConfig(name, content)
	if name == "flying_nuo" then
		self.flying_nuoCfg = content
	elseif name == "flying_nuo_prize" then
		self.flying_nuo_prizeCfg = content
	elseif name == "flying_nuo_buy_times" then
		self.flying_nuo_buy_timesCfg = content
	elseif name == "flying_nuo_common_config" then
		self.flying_nuo_commonCfg = content
		self._reliveCostList = string.split(self:getCommonValue("RELIVE_CONSUMES"), ",")
	elseif name == "flying_nuo_rule_config" then
		self.flying_nuo_ruleCfg = content
	end
end

function FlyNuoConfig:getActivityCfgById(id)
	return self.flying_nuoCfg[id]
end

function FlyNuoConfig:getBuyCfgByType(planId, type)
	return self.flying_nuo_buy_timesCfg[planId][type]
end

function FlyNuoConfig:getCanbuyWudiTimes(activityId)
	local cfg = self:getActivityCfgById(activityId)
	local list = self:getBuyCfgByType(cfg.buyTimesPlan, 2)

	return #list
end

function FlyNuoConfig:getBuyCfgByTime(planId, type, time)
	return self.flying_nuo_buy_timesCfg[planId][type][time]
end

function FlyNuoConfig:getPrizeCfg(planId)
	return self.flying_nuo_prizeCfg[planId]
end

function FlyNuoConfig:getCommonValue(key)
	return self.flying_nuo_commonCfg[key].value
end

function FlyNuoConfig:getDayGameTime()
	return self:getCommonValue("MAX_GAME_TIMES")
end

function FlyNuoConfig:getReliveCostCfgByTime(time)
	return self._reliveCostList[time]
end

function FlyNuoConfig:getCanReliveTime()
	return #self._reliveCostList
end

function FlyNuoConfig:getGravity()
	return checknumber(self:getCommonValue("GRAVITY"))
end

function FlyNuoConfig:getPipeScoreXishu()
	return checknumber(self:getCommonValue("SCORE_EXCHANGE"))
end

function FlyNuoConfig:getJumpForce()
	return checknumber(self:getCommonValue("JUMP_FORE"))
end

function FlyNuoConfig:getPipeInitSpeed()
	return checknumber(self:getCommonValue("PIPE_SPEED"))
end

function FlyNuoConfig:getPipeAcceleration()
	return checknumber(self:getCommonValue("PIPE_A"))
end

function FlyNuoConfig:getPipeMaxSpeed()
	return checknumber(self:getCommonValue("PIPE_MAX_SPEED"))
end

function FlyNuoConfig:getPipeBornSafeDistance()
	return checknumber(self:getCommonValue("SAFE_DISTANCE"))
end

function FlyNuoConfig:getPlayerConstHP()
	return checknumber(self:getCommonValue("HP"))
end

function FlyNuoConfig:getPipeOffset()
	if not self._PIPE_OFFSET then
		self._PIPE_OFFSET = {}

		local str = self:getCommonValue("PIPE_OFFSET")

		str = string.gsub(str, "%[", "")
		str = string.gsub(str, "%]", "")

		local t = string.split(str, ",")

		self._PIPE_OFFSET[1] = checknumber(t[1])
		self._PIPE_OFFSET[2] = checknumber(t[2])
	end

	return self._PIPE_OFFSET[1], self._PIPE_OFFSET[2]
end

function FlyNuoConfig:getPipeOffsetLimit()
	local heigh = self:getPipeHeight()
	local num = heigh / 2

	return -num, num
end

function FlyNuoConfig:getPipeSpace()
	return checknumber(self:getCommonValue("PIPE_SPACE"))
end

function FlyNuoConfig:getWudiFlyTime()
	return checknumber(self:getCommonValue("WUDI_FLY_TIME"))
end

function FlyNuoConfig:getItemScore()
	local str = self:getCommonValue("ITEM_SCORE")
	local t = string.split(str, ",")
	local len = #t
	local index = math.random(1, len)

	return checknumber(t[index])
end

function FlyNuoConfig:getHpItemPR()
	return checknumber(self:getCommonValue("HP_ITEM_PR"))
end

function FlyNuoConfig:getScoreItemPR()
	return checknumber(self:getCommonValue("SCORE_ITEM_PR"))
end

function FlyNuoConfig:getPipeHeight()
	return checknumber(self:getCommonValue("PIPE_HEIFHT"))
end

function FlyNuoConfig:getActivityShopCfg(activityId)
	self._shopCfgs = self._shopCfgs or {}

	if not self._shopCfgs[activityId] then
		self._shopCfgs[activityId] = {}

		local exchangeCfgs = ActivityshopModel.instance:getActivityShopCfg(GameEnum.ActivityType.FlyNuo, activityId)

		for _, cfg in pairs(exchangeCfgs or {}) do
			if cfg and checknumber(cfg.shopItemId) > 0 then
				table.insert(self._shopCfgs[activityId], {
					shopItemId = cfg.shopItemId,
					name = cfg.name,
					sellContent = string.split(cfg.sellContent, ":"),
					sellPrice = string.split(cfg.sellPrice, ":"),
					sellPeriodLimit = cfg.sellPeriodLimit,
					sellLimitCount = cfg.sellLimitCount,
					activityId = cfg.activityId
				})
			end
		end
	end

	return self._shopCfgs[activityId]
end

function FlyNuoConfig:getActLeftTime(activityId)
	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FlyNuo, activityId)
	local time = GameUtil.string2time(cfg.endTime)

	return math.max(0, time - ServerTime.now())
end

function FlyNuoConfig:getConsumeMatId(activityId)
	local cfg = self:getActivityCfgById(activityId)

	return cfg.matId
end

function FlyNuoConfig:getMinRankScore()
	return checknumber(self:getCommonValue("MIN_RANK_SCORE"))
end

function FlyNuoConfig:getHpItemRandomCount()
	return checknumber(self:getCommonValue("HP_ITEM_COUNT"))
end

function FlyNuoConfig:getScoreItemRandomCount()
	return checknumber(self:getCommonValue("HP_ITEM_COUNT"))
end

function FlyNuoConfig:getBgMoveSpeed()
	return checknumber(self:getCommonValue("BG_MOVE_SPEED"))
end

function FlyNuoConfig:getRuleDesc(id)
	return self.flying_nuo_ruleCfg[id].desc
end

FlyNuoConfig.instance = FlyNuoConfig.New()

return FlyNuoConfig
