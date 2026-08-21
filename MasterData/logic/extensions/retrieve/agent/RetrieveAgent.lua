-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/agent/RetrieveAgent.lua

module("logic.extensions.retrieve.agent.RetrieveAgent", package.seeall)

local M = class("RetrieveAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetPoolInfoRequest(lotteryInfoList)
	local msg = LotteryExtension_pb.GetPoolInfoRequest()

	for i, lotteryInfo in ipairs(lotteryInfoList) do
		local poolDescriptionHashNO = LotteryExtension_pb.PoolDescriptionHashNO()

		poolDescriptionHashNO.code = lotteryInfo.code
		poolDescriptionHashNO.descriptionHash = lotteryInfo.descriptionHash

		table.insert(msg.cached, commonCost)
	end

	self:sendMsg(msg)
end

function M:handleGetPoolInfoReply(status, msg)
	if status == 0 then
		RetrieveController.instance:refreshLotteryData(msg.pools)
	end
end

function M:sendLotteryRequest(pool, num, lotteryData)
	local req = LotteryExtension_pb.LotteryRequest()

	req.pool = pool
	req.num = num

	self:invoke({
		funcName = "handleLotteryReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local items = msg.items

				RetrieveController.instance:cacheLotteryResult(items)
				RetrieveDispatcher:dispatchEvent(RetrieveEventType.CHOOSE_LOTTERY_END, num, lotteryData)
				RetrieveController.instance:sendRequest()
			end
		end
	})
end

function M:sendGetLotteryLogRequest()
	local msg = LotteryExtension_pb.GetLotteryLogRequest()

	self:sendMsg(msg)
end

function M:handleGetLotteryLogReply(status, msg)
	if status == 0 then
		local logs = msg.logs

		RetrieveLogModel.instance:cacheLotteryLogData(logs)
	end
end

function M:sendPickLotteryItemRequest(pool, item)
	local req = LotteryExtension_pb.PickLotteryItemRequest()

	req.pool = pool
	req.item = item

	self:invoke({
		funcName = "handlePickLotteryItemReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				RetrieveDispatcher:dispatchEvent(RetrieveEventType.LOTTERY_PICK_ITEM, pool, item)
			end
		end
	})
end

function M:sendLotteryEchoRequest(pool, num, isActivity, itemId)
	local req = LotteryExtension_pb.LotteryEchoRequest()

	req.pool = pool
	req.num = num

	self:invoke({
		funcName = "handleLotteryEchoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local items = msg.items

				EchoCardPackController.instance:cacheResult(items)
				EchoCardPackController.instance:setUnpackData(msg.nextGuaranteeA, msg.nextGuaranteeS, isActivity, num, itemId)
				EchoCardPackController.instance:setUnpackState(EchoCardPackController.UnpackState.UnInOrder)
				ViewMgr.instance:open(ViewName.EchoCardUnpackView)
			end
		end
	})
end

M.instance = M.New()

return M
