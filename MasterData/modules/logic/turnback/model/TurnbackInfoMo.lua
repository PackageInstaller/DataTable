-- chunkname: @modules/logic/turnback/model/TurnbackInfoMo.lua

module("modules.logic.turnback.model.TurnbackInfoMo", package.seeall)

local TurnbackInfoMo = pureTable("TurnbackInfoMo")

function TurnbackInfoMo:ctor()
	self.id = 0
	self.tasks = {}
	self.bonusPoint = 0
	self.firstShow = true
	self.hasGetTaskBonus = {}
	self.signInDay = 0
	self.signInInfos = {}
	self.onceBonus = false
	self.endTime = 0
	self.startTime = 0
	self.remainAdditionCount = 0
	self.leaveTime = 0
	self.monthCardAddedBuyCount = 0
	self.newType = true
	self.hasBuyDoubleBonus = false
	self.config = nil
	self.dropinfos = {}
	self.getDailyBonus = nil
end

function TurnbackInfoMo:init(info)
	self.id = info.id
	self.tasks = info.tasks
	self.bonusPoint = info.bonusPoint
	self.firstShow = info.firstShow
	self.hasGetTaskBonus = info.hasGetTaskBonus
	self.signInDay = info.signInDay
	self.signInInfos = info.signInInfos
	self.onceBonus = info.onceBonus
	self.startTime = tonumber(info.startTime)
	self.endTime = tonumber(info.endTime)
	self.leaveTime = tonumber(info.leaveTime)
	self.monthCardAddedBuyCount = tonumber(info.monthCardAddedBuyCount)

	self:setRemainAdditionCount(info.remainAdditionCount, true)

	self.newType = info.version == TurnbackEnum.type.New
	self.hasBuyDoubleBonus = info.buyDoubleBonus
	self.config = TurnbackConfig.instance:getTurnbackCo(self.id)
	self.dropinfos = info.dropInfos
	self.dailyBonus = info.getDailyBonus
	self._leaveDays = Mathf.Floor((ServerTime.now() - self.leaveTime) / TimeUtil.OneDaySecond)
	self.resourceReturn = info.resourceReturn

	self:refreshResourceReturnInfo()
end

function TurnbackInfoMo:isStart()
	return ServerTime.now() - self.startTime >= 0
end

function TurnbackInfoMo:isEnd()
	return ServerTime.now() - self.endTime > 0
end

function TurnbackInfoMo:isInReommendTime()
	return self.leaveTime > 0 and ServerTime.now() - self.leaveTime >= 0
end

function TurnbackInfoMo:getLeaveDay()
	return self._leaveDays
end

function TurnbackInfoMo:isInOpenTime()
	local isStart = self:isStart()
	local isEnd = self:isEnd()

	if not isStart or isEnd then
		return false
	end

	return true
end

function TurnbackInfoMo:isNewType()
	return self.newType
end

function TurnbackInfoMo:updateHasGetTaskBonus(hasGetTaskBonus)
	self.hasGetTaskBonus = hasGetTaskBonus
end

function TurnbackInfoMo:setRemainAdditionCount(newCount, isInit)
	local tmpNewCount = 0

	if newCount and newCount > 0 then
		tmpNewCount = newCount
	end

	local isChange = self.remainAdditionCount ~= tmpNewCount

	self.remainAdditionCount = tmpNewCount

	if isChange and not isInit then
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AdditionCountChange, self.id)
	end
end

function TurnbackInfoMo:isRemainAdditionCount()
	local remainCount = self:getRemainAdditionCount()

	return remainCount > 0
end

function TurnbackInfoMo:isAdditionInOpenTime()
	local additionDurationDays = TurnbackConfig.instance:getAdditionDurationDays(self.id)
	local turnbackElapsedTime = ServerTime.now() - self.startTime

	return turnbackElapsedTime < additionDurationDays * TimeUtil.OneDaySecond
end

function TurnbackInfoMo:isAdditionValid()
	local isInOpenTime = self:isInOpenTime()
	local isAdditionInOpenTime = self:isAdditionInOpenTime()
	local isRemainCount = self:isRemainAdditionCount()

	return isInOpenTime and isAdditionInOpenTime and isRemainCount
end

function TurnbackInfoMo:getRemainAdditionCount()
	return self.remainAdditionCount
end

function TurnbackInfoMo:getBuyDoubleBonus()
	return self.hasBuyDoubleBonus
end

function TurnbackInfoMo:setDailyBonus(getDailyBonus)
	self.dailyBonus = getDailyBonus
end

function TurnbackInfoMo:isClaimedDailyBonus(day)
	day = day - 1

	local bits = Bitwise["<<"](1, day)

	return Bitwise.has(self.dailyBonus, bits)
end

function TurnbackInfoMo:getCurRewardCurrencyInfo()
	if not self._currencyInfo then
		local co = self.config

		if co and not string.nilorempty(co.resourceReturnVitality) then
			self._currencyInfo = string.splitToNumber(co.resourceReturnVitality, "#")
		end
	end

	return self._currencyInfo
end

function TurnbackInfoMo:getReturnRewardInfo()
	return self.resourceReturn
end

function TurnbackInfoMo:getReturnLeftTaskIds()
	return self._leftTaskIds
end

function TurnbackInfoMo:refreshResourceReturnInfo()
	self._returnRewardList = {}
	self._returnRewardDict = {}
	self._returnTaskIdList = {}
	self._leftTaskIds = self.resourceReturn.leftTaskIds
	self._isCanClaimReward = false

	if not self.resourceReturn or not self.resourceReturn.open then
		return
	end

	self._lastFinishRandomTaskId = self.resourceReturn.lastFinishRandomTaskId

	if self.resourceReturn.resourceReturnTasks then
		for _, info in ipairs(self.resourceReturn.resourceReturnTasks) do
			table.insert(self._returnTaskIdList, info.id)
		end
	end

	if self.resourceReturn.rewards then
		for _, rewardInfo in ipairs(self.resourceReturn.rewards) do
			local mo = {}

			mo.state = rewardInfo.state
			mo.rewardId = rewardInfo.rewardId
			mo.needVitality = rewardInfo.needVitality
			mo.co = lua_turnback_return_reward.configDict[rewardInfo.rewardId]
			mo.bonus = GameUtil.splitString2(mo.co.bonus, true, "|", "#")

			table.insert(self._returnRewardList, mo)

			self._returnRewardDict[mo.needVitality] = mo

			if rewardInfo.state == TurnbackEnum.SearchState.CanGet then
				self._isCanClaimReward = true
			end
		end
	end
end

function TurnbackInfoMo:onGetResourceReturnReward(hasGetReturnRewardIds)
	local list = {}

	if hasGetReturnRewardIds then
		for _, id in ipairs(hasGetReturnRewardIds) do
			list[id] = true
		end
	end

	for _, mo in ipairs(self._returnRewardList) do
		if list[mo.rewardId] then
			mo.state = TurnbackEnum.SearchState.HasGet
		end
	end
end

function TurnbackInfoMo:getReturnRewardList()
	return self._returnRewardList
end

function TurnbackInfoMo:getReturnRewardMoByNeedVitality(needVitality)
	return self._returnRewardDict[needVitality]
end

function TurnbackInfoMo:isCanClaimReward()
	return self._isCanClaimReward
end

function TurnbackInfoMo:getReturnTaskIds()
	return self._returnTaskIdList
end

function TurnbackInfoMo:getLastFinishRandomTaskId()
	return self._lastFinishRandomTaskId
end

return TurnbackInfoMo
