-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/agent/BackpackAgent.lua

module("logic.extensions.backpack.agent.BackpackAgent", package.seeall)

local BackpackTypeEnum = GameEnum.BackpackTypeEnum
local M = class("BackpackAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendLoadBagRequest()
	local req = BackpackExtension_pb.LoadBagRequest()

	req.backType = 0

	self:sendMsg(req)
end

function M:handleLoadBagReply(status, loadBagReply)
	print("请求数据成功了========", status)

	if status == 0 then
		ItemModel.instance:parseLoadData(loadBagReply)
	end
end

function M:handleItemChangedPush(status, itemChangedPush)
	if status == 0 then
		ItemModel.instance:parseChangeDataPush(itemChangedPush)
		GlobalDispatcher:dispatchEvent(EventType.GAIN_ITEM_CHANGE_EVENT, itemChangedPush)
	end
end

function M:sendUseItemRequest(uuid, itemId, count, param)
	local req = BackpackExtension_pb.UseItemRequest()

	req.uuid = uuid
	req.itemId = itemId
	req.count = count or 1
	req.param = param or ""

	self:sendMsg(req)
end

function M:handleUseItemReply(status)
	if status ~= 0 then
		MsgBoardController.instance:_handleResultCodeMsg(nil, nil, status)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_USE_ITEM_REPLY, status)
end

function M:sendExchangeCurrencyRequest(id, count)
	local req = BackpackExtension_pb.ExchangeCurrencyRequest()

	req.id = id
	req.count = count

	self:sendMsg(req)
end

function M:handleExchangeCurrencyReply(status, msg)
	if status == 0 then
		CurrencyExchangeController.instance:onExchangeCurrencyReply(msg)
	end
end

function M:sendExchangeRemainedTimesRequest()
	local req = BackpackExtension_pb.ExchangeRemainedTimesRequest()

	self:sendMsg(req)
end

function M:handleExchangeRemainedTimesReply(status, msg)
	if status == 0 then
		CurrencyExchangeController.instance:onExchangeRemainedTimesReply(msg.remainedTimes)
	end
end

function M:sendGetPrefabItemInfoRequest(itemId, tipsData)
	local prefabItemData = ItemModel.instance:getPrefabItemData(itemId)

	if prefabItemData then
		GlobalDispatcher:dispatchEvent(EventType.ITEM_GET_ATTR_INFO_EVENT, itemId, prefabItemData, tipsData)

		return
	end

	local req = BackpackExtension_pb.GetPrefabItemInfoRequest()

	table.insert(req.itemId, itemId)
	self:invoke({
		funcName = "handleGetPrefabItemInfoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local len = #msg.item

				if len >= 1 then
					local item = msg.item[1]

					ItemModel.instance:updatePrefabItemData(itemId, item)
					GlobalDispatcher:dispatchEvent(EventType.ITEM_GET_ATTR_INFO_EVENT, itemId, item, tipsData)
				end
			end
		end
	})
end

function M:sendremoveRedPointRequest(itemType, uuids)
	local req = BackpackExtension_pb.removeRedPointRequest()

	req.itemType = itemType

	for i, v in ipairs(uuids) do
		table.insert(req.uuid, v)
	end

	self:invoke({
		funcName = "handleremoveRedPointReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_REDPOINT, itemType)
			end
		end
	})
end

function M:sendComposeRequest(sourceId, targetId, count)
	local msg = BackpackExtension_pb.ComposeRequest()

	msg.sourceId = sourceId
	msg.targetId = targetId
	msg.count = count

	self:sendMsg(msg)
end

function M:handleComposeReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

M.instance = M.New()

return M
