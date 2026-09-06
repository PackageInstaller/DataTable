-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/model/FanRuiLotteryModel.lua

module("logic.extensions.fanruilottery.model.FanRuiLotteryModel", package.seeall)

local FanRuiLotteryModel = class("FanRuiLotteryModel", BaseModel)

FanRuiLotteryModel.ReadFlag = "FanRuiLotteryModel.ReadFlag"

function FanRuiLotteryModel:ctor()
	return
end

function FanRuiLotteryModel:onInit()
	self:onReset()
end

function FanRuiLotteryModel:onReset()
	return
end

function FanRuiLotteryModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.FanRuiLottery)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.FanRuiLottery)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FanRuiLottery, v.activityId) then
			local cfg = FanRuiLotteryConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.actId

				break
			end

			printError("====t_fan_rui_lottery_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function FanRuiLotteryModel:setData(msg)
	self._nextExchangeTime = checknumber(msg.nextExchangeTime) / 1000
	self._gainPrize = {}

	for i, v in ipairs(msg.gainPrizeIds or {}) do
		self._gainPrize[v] = true
	end
end

function FanRuiLotteryModel:setGetLotteryPrize(msg)
	self._gainPrize[msg.prizeId] = true
end

function FanRuiLotteryModel:setNextExchangeTime(msg)
	self._nextExchangeTime = checknumber(msg.nextExchangeTime) / 1000
end

function FanRuiLotteryModel:saveClientKey(key)
	self._clientKey = key
end

function FanRuiLotteryModel:getClientKey()
	return self._clientKey
end

function FanRuiLotteryModel:saveServerKey(key)
	self._serverKey = key
end

function FanRuiLotteryModel:getServerKey()
	return self._serverKey
end

function FanRuiLotteryModel:getIsGetPrize(id)
	return (self._gainPrize or nil) and (self._gainPrize[id] or false)
end

function FanRuiLotteryModel:getNextExchangeTime()
	return self._nextExchangeTime or 0
end

function FanRuiLotteryModel:getIsReadRule()
	return GameUtil.getUserData(FanRuiLotteryModel.ReadFlag .. "#ReadRule")
end

function FanRuiLotteryModel:setIsReadRule()
	return GameUtil.saveUserData(FanRuiLotteryModel.ReadFlag .. "#ReadRule", true)
end

function FanRuiLotteryModel:getIsReadStory(activityId)
	return GameUtil.getUserData(FanRuiLotteryModel.ReadFlag .. "#ReadStory" .. activityId)
end

function FanRuiLotteryModel:setIsReadStory(activityId)
	return GameUtil.saveUserData(FanRuiLotteryModel.ReadFlag .. "#ReadStory" .. activityId, true)
end

function FanRuiLotteryModel:getIsGetTagPrize(activityId)
	return GameUtil.getUserData(FanRuiLotteryModel.ReadFlag .. "#GetTagPrize" .. activityId)
end

function FanRuiLotteryModel:setIsGetTagPrize(activityId)
	return GameUtil.saveUserData(FanRuiLotteryModel.ReadFlag .. "#GetTagPrize" .. activityId, true)
end

function FanRuiLotteryModel:getIsGetNotTagPrize(activityId)
	return GameUtil.getUserData(FanRuiLotteryModel.ReadFlag .. "#GetNotTagPrize" .. activityId)
end

function FanRuiLotteryModel:setIsGetNotTagPrize(activityId)
	return GameUtil.saveUserData(FanRuiLotteryModel.ReadFlag .. "#GetNotTagPrize" .. activityId, true)
end

FanRuiLotteryModel.instance = FanRuiLotteryModel.New()

return FanRuiLotteryModel
