-- chunkname: @modules/logic/versionactivity1_5/sportsnews/model/SportsNewsModel.lua

module("modules.logic.versionactivity1_5.sportsnews.model.SportsNewsModel", package.seeall)

local SportsNewsModel = class("SportsNewsModel", BaseModel)

function SportsNewsModel:finishOrder(actId, orderId)
	Activity106Rpc.instance:sendGet106OrderBonusRequest(actId, orderId, 1, function()
		ActivityWarmUpController.instance:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = actId,
			orderId = orderId
		})
	end, self)
end

function SportsNewsModel:onReadEnd(actId, orderId)
	SportsNewsRpc.instance:sendFinishReadTaskRequest(actId, orderId)
	self:finishOrder(actId, orderId)
end

function SportsNewsModel:getSelectedDayTask(day)
	return ActivityWarmUpTaskListModel.instance._taskGroup and ActivityWarmUpTaskListModel.instance._taskGroup[day]
end

function SportsNewsModel:getJumpToTab(actId)
	local jumpId = self._JumpOrderId

	if not jumpId then
		return nil
	end

	return (SportsNewsModel.instance:getDayByOrderId(actId, jumpId))
end

function SportsNewsModel:setJumpToOrderId(orderId)
	self._JumpOrderId = orderId
end

function SportsNewsModel:getDayByOrderId(actId, id)
	local co = Activity106Config.instance:getActivityWarmUpOrderCo(actId, id)

	return co and co.openDay
end

function SportsNewsModel:getPrefs(prefs)
	local prefs = self:getPrefsKey(prefs)

	return (PlayerPrefsHelper.getNumber(prefs, 0))
end

function SportsNewsModel:setPrefs(prefs)
	local prefs = self:getPrefsKey(prefs)

	PlayerPrefsHelper.setNumber(prefs, 1)
end

function SportsNewsModel:getPrefsKey(prefs)
	local actId = VersionActivity1_5Enum.ActivityId.SportsNews
	local userId = PlayerModel.instance:getPlayinfo().userId

	return string.format("%s#%s#%s", actId, userId, prefs)
end

function SportsNewsModel:hasCanFinishOrder()
	local _hasCanFinishOrderList = {}
	local allOrders = ActivityWarmUpModel.instance:getAllOrders()

	for _, order in pairs(allOrders) do
		local isCanFinish = false

		if order.cfg.listenerType == "ReadTask" then
			if order.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
				isCanFinish = true
			end
		elseif order.status == ActivityWarmUpEnum.OrderStatus.Collected then
			isCanFinish = true
		end

		if isCanFinish then
			local day = order.cfg.openDay
			local id = {
				order.id
			}

			_hasCanFinishOrderList[day] = _hasCanFinishOrderList[day] or {}

			table.insert(_hasCanFinishOrderList[day], id)
		end
	end

	return _hasCanFinishOrderList
end

SportsNewsModel.instance = SportsNewsModel.New()

return SportsNewsModel
