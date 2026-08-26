-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_RewardItemViewContainer.lua

module("modules.logic.activity.view.V2a8_DragonBoat_RewardItemViewContainer", package.seeall)

local V2a8_DragonBoat_RewardItemViewContainer = class("V2a8_DragonBoat_RewardItemViewContainer", Activity101SignViewBaseContainer)

function V2a8_DragonBoat_RewardItemViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a8_DragonBoat_RewardItem
	refListScrollParam.cellWidth = 355
	refListScrollParam.cellHeight = 638
	refListScrollParam.cellSpaceH = 30
	refListScrollParam.rectMaskSoftness = {
		30,
		0
	}
end

function V2a8_DragonBoat_RewardItemViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

function V2a8_DragonBoat_RewardItemViewContainer:getCurrentTaskCO()
	local actId = self:actId()

	return ActivityType101Config.instance:getMoonFestivalTaskCO(actId)
end

function V2a8_DragonBoat_RewardItemViewContainer:getCurrentDayCO()
	local actId = self:actId()
	local loginCount = ActivityType101Model.instance:getType101LoginCount(actId)

	return self:getDayCO(loginCount)
end

function V2a8_DragonBoat_RewardItemViewContainer:getDayCO(day)
	local actId = self:actId()
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO then
		return
	end

	local maxDay = ActivityType101Config.instance:getMoonFestivalSignMaxDay(actId)

	if maxDay <= 0 then
		return
	end

	day = GameUtil.clamp(day, 1, maxDay)

	return ActivityType101Config.instance:getMoonFestivalByDay(actId, day)
end

function V2a8_DragonBoat_RewardItemViewContainer:isNone(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardUncompleted(actId, id)
end

function V2a8_DragonBoat_RewardItemViewContainer:isFinishedTask(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardGot(actId, id)
end

function V2a8_DragonBoat_RewardItemViewContainer:isRewardable(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGet(actId, id)
end

function V2a8_DragonBoat_RewardItemViewContainer:sendGet101SpBonusRequest(sucCb, sucCbObj)
	local CO = self:getCurrentTaskCO()

	if not CO then
		return
	end

	local actId = self:actId()
	local id = CO.id

	if not ActivityType101Model.instance:isType101SpRewardCouldGet(actId, id) then
		return
	end

	Activity101Rpc.instance:sendGet101SpBonusRequest(actId, id, sucCb, sucCbObj)

	return true
end

local StateDay = {
	Done = 1999,
	None = 0
}

function V2a8_DragonBoat_RewardItemViewContainer:_getPrefsKey(day)
	return self:getPrefsKeyPrefix() .. tostring(day)
end

function V2a8_DragonBoat_RewardItemViewContainer:saveState(day, value)
	local key = self:_getPrefsKey(day)

	self:saveInt(key, value or StateDay.None)
end

function V2a8_DragonBoat_RewardItemViewContainer:getState(day, defaultValue)
	local key = self:_getPrefsKey(day)

	return self:getInt(key, defaultValue or StateDay.None)
end

function V2a8_DragonBoat_RewardItemViewContainer:saveStateDone(day, isDone)
	self:saveState(day, (isDone or nil) and (StateDay.Done or StateDay.None))
end

function V2a8_DragonBoat_RewardItemViewContainer:isStateDone(day)
	return self:getState(day) == StateDay.Done
end

function V2a8_DragonBoat_RewardItemViewContainer:isPlayAnimAvaliable(day)
	if self:isType101RewardCouldGet(day) then
		return not self:isStateDone(day)
	end

	return false
end

return V2a8_DragonBoat_RewardItemViewContainer
