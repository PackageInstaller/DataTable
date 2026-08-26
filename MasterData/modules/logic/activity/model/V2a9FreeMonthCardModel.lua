-- chunkname: @modules/logic/activity/model/V2a9FreeMonthCardModel.lua

module("modules.logic.activity.model.V2a9FreeMonthCardModel", package.seeall)

local V2a9FreeMonthCardModel = class("V2a9FreeMonthCardModel", BaseModel)

V2a9FreeMonthCardModel.LoginMaxDay = 30

function V2a9FreeMonthCardModel:onInit()
	return
end

function V2a9FreeMonthCardModel:reInit()
	return
end

function V2a9FreeMonthCardModel:getRewardTotalDay()
	local dayCount = 0
	local actId = ActivityEnum.Activity.V2a9_FreeMonthCard
	local loginDay = ActivityType101Model.instance:getType101LoginCount(actId)
	local countMaxDay = loginDay <= V2a9FreeMonthCardModel.LoginMaxDay and loginDay or V2a9FreeMonthCardModel.LoginMaxDay

	for i = countMaxDay, 1, -1 do
		local curGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, i)

		if not curGet then
			dayCount = dayCount + 1
		end
	end

	return dayCount
end

function V2a9FreeMonthCardModel:getCurDay()
	local actId = ActivityEnum.Activity.V2a9_FreeMonthCard
	local loginDay = ActivityType101Model.instance:getType101LoginCount(actId)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, loginDay)

	if loginDay <= V2a9FreeMonthCardModel.LoginMaxDay then
		return loginDay
	end

	if couldGet then
		local countMaxDay = loginDay <= V2a9FreeMonthCardModel.LoginMaxDay and loginDay or V2a9FreeMonthCardModel.LoginMaxDay

		for i = countMaxDay, 1, -1 do
			local curGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, i)

			if curGet then
				return i
			end
		end
	end

	return 0
end

function V2a9FreeMonthCardModel:isCurDayCouldGet()
	local actId = ActivityEnum.Activity.V2a9_FreeMonthCard
	local loginDay = ActivityType101Model.instance:getType101LoginCount(actId)

	if loginDay <= 0 then
		return false
	end

	local curDay = V2a9FreeMonthCardModel.instance:getCurDay()

	if curDay <= 0 then
		return false
	end

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, loginDay)

	if couldGet and curDay <= V2a9FreeMonthCardModel.LoginMaxDay then
		return true
	end

	return false
end

V2a9FreeMonthCardModel.instance = V2a9FreeMonthCardModel.New()

return V2a9FreeMonthCardModel
