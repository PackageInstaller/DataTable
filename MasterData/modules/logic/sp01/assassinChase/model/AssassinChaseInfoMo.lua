-- chunkname: @modules/logic/sp01/assassinChase/model/AssassinChaseInfoMo.lua

module("modules.logic.sp01.assassinChase.model.AssassinChaseInfoMo", package.seeall)

local AssassinChaseInfoMo = pureTable("AssassinChaseInfoMo")

function AssassinChaseInfoMo:init(activityId, hasChosenDirection, chosenInfo, optionDirections)
	self.activityId = activityId
	self.hasChosenDirection = hasChosenDirection
	self.chosenInfo = chosenInfo
	self.optionDirections = optionDirections

	local constConfig = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.ChangeDirectionTimeLimit)
	local limitHours = tonumber(constConfig.value) or 0

	self.nextDayChangeOffset = limitHours * TimeUtil.OneHourSecond

	self:refreshTime()
end

function AssassinChaseInfoMo:isSelect()
	return self.hasChosenDirection and self.chosenInfo ~= nil
end

function AssassinChaseInfoMo:refreshTime()
	if self:isSelect() then
		local nextDayChangeOffset = self.nextDayChangeOffset
		local dailyRefreshTimeOffset = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
		local genTime = self.chosenInfo.directionGenTime / TimeUtil.OneSecondMilliSecond
		local localGenTime = ServerTime.timeInLocal(genTime)

		self.changeEndTime = localGenTime - dailyRefreshTimeOffset + TimeUtil.OneDaySecond + nextDayChangeOffset
		self.rewardTime = localGenTime + TimeUtil.OneDaySecond
	end
end

function AssassinChaseInfoMo:canGetBonus()
	if not self:isSelect() then
		return false
	end

	if self.rewardTime == nil then
		return false
	end

	local curTime = ServerTime.now()

	return curTime >= self.rewardTime
end

function AssassinChaseInfoMo:canChangeDirection()
	if not self:isSelect() then
		return false
	end

	if self.changeEndTime == nil then
		return false
	end

	local curTime = ServerTime.now()

	return curTime < self.changeEndTime
end

function AssassinChaseInfoMo:getCurState()
	local state

	return self:isSelect() == false and AssassinChaseEnum.ViewState.Select or self.chosenInfo and self.chosenInfo.rewardId ~= nil and self.chosenInfo.rewardId ~= 0 and AssassinChaseEnum.ViewState.Result or AssassinChaseEnum.ViewState.Progress
end

return AssassinChaseInfoMo
