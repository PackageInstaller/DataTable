-- chunkname: @modules/logic/activity/view/V2a1_MoonFestival_SignItemViewContainer.lua

module("modules.logic.activity.view.V2a1_MoonFestival_SignItemViewContainer", package.seeall)

local V2a1_MoonFestival_SignItemViewContainer = class("V2a1_MoonFestival_SignItemViewContainer", Activity101SignViewBaseContainer)

function V2a1_MoonFestival_SignItemViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a1_MoonFestival_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a1_MoonFestival_SignItemViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

function V2a1_MoonFestival_SignItemViewContainer:getCurrentTaskCO()
	local actId = self:actId()

	return ActivityType101Config.instance:getMoonFestivalTaskCO(actId)
end

function V2a1_MoonFestival_SignItemViewContainer:getCurrentDayCO()
	local actId = self:actId()
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO then
		return
	end

	local maxDay = ActivityType101Config.instance:getMoonFestivalSignMaxDay(actId)

	if maxDay <= 0 then
		return
	end

	local loginCount = ActivityType101Model.instance:getType101LoginCount(actId)
	local day = GameUtil.clamp(loginCount, 1, maxDay)

	return ActivityType101Config.instance:getMoonFestivalByDay(actId, day)
end

function V2a1_MoonFestival_SignItemViewContainer:isNone(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardUncompleted(actId, id)
end

function V2a1_MoonFestival_SignItemViewContainer:isFinishedTask(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardGot(actId, id)
end

function V2a1_MoonFestival_SignItemViewContainer:isRewardable(id)
	local actId = self:actId()

	return ActivityType101Model.instance:isType101SpRewardCouldGet(actId, id)
end

function V2a1_MoonFestival_SignItemViewContainer:sendGet101SpBonusRequest(sucCb, sucCbObj)
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

return V2a1_MoonFestival_SignItemViewContainer
