-- chunkname: @modules/logic/dragonboat/model/DragonBoatFestivalModel.lua

module("modules.logic.dragonboat.model.DragonBoatFestivalModel", package.seeall)

local DragonBoatFestivalModel = class("DragonBoatFestivalModel", BaseModel)

function DragonBoatFestivalModel:onInit()
	self:reInit()
end

function DragonBoatFestivalModel:reInit()
	self._curDay = nil
end

function DragonBoatFestivalModel:hasRewardNotGet()
	local actId = ActivityEnum.Activity.DragonBoatFestival
	local actCos = ActivityConfig.instance:getNorSignActivityCos(actId)

	for _, v in pairs(actCos) do
		if self:isGiftUnlock(v.id) and not self:isGiftGet(v.id) then
			return true
		end
	end

	return false
end

function DragonBoatFestivalModel:setCurDay(day)
	self._curDay = day
end

function DragonBoatFestivalModel:getCurDay()
	if not self._curDay then
		local day = self:getFinalGiftGetDay()

		return self._curDay > self:getMaxDay() and self:getMaxDay() or self._curDay
	end
end

function DragonBoatFestivalModel:getFinalGiftGetDay()
	local actId = ActivityEnum.Activity.DragonBoatFestival
	local actCos = ActivityConfig.instance:getNorSignActivityCos(actId)
	local giftGetList = {}

	for _, v in pairs(actCos) do
		if self:isGiftUnlock(v.id) and self:isGiftGet(v.id) then
			table.insert(giftGetList, v.id)
		end
	end

	if GameUtil.getTabLen(giftGetList) > 0 then
		return giftGetList[#giftGetList]
	else
		return self:getLoginCount()
	end
end

function DragonBoatFestivalModel:isGiftGet(id)
	local actId = ActivityEnum.Activity.DragonBoatFestival

	if id > self:getMaxDay() then
		return false
	end

	return ActivityType101Model.instance:isType101RewardGet(actId, id)
end

function DragonBoatFestivalModel:isGiftUnlock(id)
	return id <= self:getLoginCount()
end

function DragonBoatFestivalModel:getMaxDay()
	local cos = DragonBoatFestivalConfig.instance:getDragonBoatCos()
	local maxDay = 0

	for _, v in pairs(cos) do
		maxDay = maxDay > v.day and maxDay or v.day
	end

	return maxDay
end

function DragonBoatFestivalModel:getLoginCount()
	local actId = ActivityEnum.Activity.DragonBoatFestival

	return (ActivityType101Model.instance:getType101LoginCount(actId))
end

function DragonBoatFestivalModel:getMaxUnlockDay()
	return self:getLoginCount() <= self:getMaxDay() and self:getLoginCount() or self:getMaxDay()
end

DragonBoatFestivalModel.instance = DragonBoatFestivalModel.New()

return DragonBoatFestivalModel
