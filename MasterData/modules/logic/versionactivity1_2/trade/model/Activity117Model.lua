-- chunkname: @modules/logic/versionactivity1_2/trade/model/Activity117Model.lua

module("modules.logic.versionactivity1_2.trade.model.Activity117Model", package.seeall)

local Activity117Model = class("Activity117Model", BaseModel)

function Activity117Model:onInit()
	self._actDict = {}
end

function Activity117Model:reInit()
	self._actDict = {}
end

function Activity117Model:release()
	self._actDict = {}
end

function Activity117Model:initAct(actId)
	self:getActData(actId, true)
end

function Activity117Model:getActData(actId, create)
	if not actId then
		return
	end

	local data = self._actDict[actId]

	if not data and create then
		data = Activity117MO.New()

		data:init(actId)

		self._actDict[actId] = data
	end

	return data
end

function Activity117Model:onReceiveInfos(serverData)
	local data = self:getActData(serverData.activityId)

	if not data then
		return
	end

	data:onInitServerData(serverData)
end

function Activity117Model:onNegotiateResult(serverData)
	local data = self:getActData(serverData.activityId)

	if not data then
		return
	end

	data:onNegotiateResult(serverData)
end

function Activity117Model:onDealSuccess(serverData)
	local data = self:getActData(serverData.activityId)

	if not data then
		return
	end

	data:onDealSuccess(serverData)
end

function Activity117Model:onOrderPush(serverData)
	local data = self:getActData(serverData.activityId)

	if not data then
		return
	end

	data:onOrderPush(serverData)
end

function Activity117Model:updateRewardDatas(serverData)
	local data = self:getActData(serverData.activityId)

	if not data then
		return
	end

	data:updateHasGetBonusIds(serverData.bonusIds)
end

function Activity117Model:getOrderDataById(actId, id)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:getOrderData(id)
end

function Activity117Model:getOrderList(actId, type)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:getOrderList(type)
end

function Activity117Model:getRewardList(actId)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:getRewardList()
end

function Activity117Model:getRemainDay(actId)
	local data = self:getActData(actId)

	if not data then
		return 0
	end

	return data:getRemainDay()
end

function Activity117Model:getCurrentScore(actId)
	local data = self:getActData(actId)

	if not data then
		return 0
	end

	return data:getCurrentScore()
end

function Activity117Model:getNextScore(actId, score)
	local data = self:getActData(actId)

	if not data then
		return 0
	end

	return data:getNextScore(score)
end

function Activity117Model:setSelectOrder(actId, order)
	local data = self:getActData(actId)

	if not data then
		return
	end

	data:setSelectOrder(order)
end

function Activity117Model:getSelectOrder(actId)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:getSelectOrder()
end

function Activity117Model:isSelectOrder(actId)
	local orderId = self:getSelectOrder(actId)

	return orderId ~= nil
end

function Activity117Model:setInQuote(actId, inQuote)
	local data = self:getActData(actId)

	if not data then
		return
	end

	data:setInQuote(inQuote)
end

function Activity117Model:isInQuote(actId)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:isInQuote()
end

function Activity117Model:getFinishOrderCount(actId)
	local data = self:getActData(actId)

	if not data then
		return
	end

	return data:getFinishOrderCount()
end

function Activity117Model:clear()
	return
end

Activity117Model.instance = Activity117Model.New()

return Activity117Model
