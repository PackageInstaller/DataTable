-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/model/ConsumelotteryModel.lua

module("logic.extensions.consumelottery.view.ConsumelotteryModel", package.seeall)

local ConsumelotteryModel = class("ConsumelotteryModel", BaseModel)

function ConsumelotteryModel:ctor()
	return
end

function ConsumelotteryModel:onInit()
	self:onReset()
end

function ConsumelotteryModel:onReset()
	self._curRound = 0
	self._prizeInfo = {}
	self._hasMonthDailyTicket = false
	self._leftTicket = 0
	self._totalUsedTicket = 0
	self._isUseMonthDailyTicket = false
	self._actId = 0
end

function ConsumelotteryModel:setActId(id)
	self._actId = id
end

function ConsumelotteryModel:getCurrRound(actId)
	local cfg = ConsumelotteryConfig.instance:getActCfg(actId)
	local pcfgs = ConsumelotteryConfig.instance:getLotteryPrizeCfg(cfg.prizePlanId)

	if pcfgs[self._curRound] then
		return self._curRound
	else
		return #pcfgs
	end
end

function ConsumelotteryModel:setConsumeLotteryInfo(msg)
	self._curRound = msg.curRound
	self._prizeInfo = msg.prizeInfo
	self._hasMonthDailyTicket = msg.hasMonthDailyTicket
	self._leftTicket = msg.leftTicket
	self._totalUsedTicket = msg.totalUsedTicket
end

function ConsumelotteryModel:hasMonthDailyTicket()
	return self._hasMonthDailyTicket
end

function ConsumelotteryModel:getLeftTicket()
	return self._leftTicket
end

function ConsumelotteryModel:getUseTicket()
	return self._totalUsedTicket
end

function ConsumelotteryModel:lotteryDrawRes(msg)
	if self._curRound ~= msg.nextRound then
		self._curRound = msg.nextRound

		ConsumeLotteryAgent.instance:sendPM_ConsumeLotteryGetInfoReq(self._actId)

		return
	end

	for i, v in ipairs(self._prizeInfo) do
		if v.id == msg.prizeId then
			v.leftNum = math.max(0, v.leftNum - 1)
			v.hasGainPrize = true

			break
		end
	end

	self._totalUsedTicket = self._totalUsedTicket + 1

	if not self._isUseMonthDailyTicket then
		self._leftTicket = self._leftTicket - 1
	else
		self._hasMonthDailyTicket = false
	end

	self._leftTicket = math.max(self._leftTicket, 0)
end

function ConsumelotteryModel:setUseMonthDailyTicket(flag)
	self._isUseMonthDailyTicket = flag
end

function ConsumelotteryModel:checkRewardIsGet(id)
	for i, v in ipairs(self._prizeInfo) do
		if v.id == id and v.hasGainPrize then
			return true
		end
	end

	return false
end

function ConsumelotteryModel:getYInshiLeftNum()
	for i, v in ipairs(self._prizeInfo) do
		if v.id == 1 then
			return v.leftNum
		end
	end

	return 0
end

ConsumelotteryModel.instance = ConsumelotteryModel.New()

return ConsumelotteryModel
