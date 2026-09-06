-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/model/ElemeModel.lua

module("logic.extensions.eleme.model.ElemeModel", package.seeall)

local ElemeModel = class("ElemeModel", BaseModel)

function ElemeModel:onInit()
	self:onReset()
end

function ElemeModel:onReset()
	self._msgMap = {}
end

function ElemeModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function ElemeModel:getMsgInfo(activityId)
	return self._msgMap[activityId]
end

function ElemeModel:onTakeOrder(msg)
	local activityId = msg.activityId
	local pb = self._msgMap[activityId]

	if pb then
		local index = msg.index
		local orders = pb.orders

		if orders then
			for i, v in ipairs(orders) do
				if v.index == index then
					v.state = 1
				end
			end
		end
	end
end

function ElemeModel:onRefreshOrder(msg)
	local activityId = msg.activityId
	local pb = self._msgMap[activityId]

	if pb then
		local newOrder = GameUtil.pbToTable(msg.newOrder)
		local orders = pb.orders

		if orders then
			for i, v in ipairs(orders) do
				if v.index == newOrder.index then
					orders[i] = newOrder
					pb.refreshTimes = checknumber(pb.refreshTimes) + 1

					break
				end
			end
		end
	end
end

function ElemeModel:onGetPrize(msg)
	local activityId = msg.activityId
	local pb = self._msgMap[activityId]

	if pb then
		pb.gainedPrizeId = pb.gainedPrizeId or {}

		table.insert(pb.gainedPrizeId, msg.prizeId)
	end
end

ElemeModel.instance = ElemeModel.New()

return ElemeModel
