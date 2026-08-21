-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/agent/ContainmentZoneAgent.lua

module("logic.extensions.containmentzone.agent.ContainmentZoneAgent", package.seeall)

local M = class("ContainmentZoneAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._stopHoldingRoomId = nil
	self._changeProtomerTargetRoomId = nil
end

function M:_handleErrorMsgShow(status, funcMsg)
	if enableErrorLog then
		local itemInfo = LanguageMgr.instance:getLangRcInfo(tostring(status))

		if itemInfo and itemInfo.workType ~= 0 then
			FloatWordMgr.instance:show(LanguageMgr.instance:getText(itemInfo))
		else
			printError(string.format("status[%d],func : %s", status, funcMsg or ""))
		end
	end
end

function M:sendGetSingleHoldRoomInfoRequest(roomId)
	local req = HouseExtension_pb.GetSingleHoldRoomInfoRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function M:handleGetSingleHoldRoomInfoReply(status, msg)
	if status == 0 then
		ContainmentModel.instance:updateRoomInfo(msg.holdRooms, true)
	else
		self:_handleErrorMsgShow(status, "[11]handleGetSingleHoldRoomInfoReply")
	end
end

function M:sendGetHoldRoomInfoRequest()
	local req = HouseExtension_pb.GetHoldRoomInfoRequest()

	self:sendMsg(req)
end

function M:handleGetHoldRoomInfoReply(status, msg)
	if status == 0 then
		if msg.holdRooms and #msg.holdRooms > 0 then
			ContainmentModel.instance:updateRoomInfoLst(msg.holdRooms)
		end
	else
		self:_handleErrorMsgShow(status, "[12]handleGetHoldRoomInfoReply")
	end
end

function M:sendUnlockHoldRoomRequest()
	return
end

function M:handleUnlockHoldRoomReply(status, msg)
	return
end

function M:sendStopHoldProtomerRequest(roomId)
	if self._stopHoldingRoomId then
		pritnWarn(string.format("[14]已经有停止收容房间的记录,收容[%d]室", self._stopHoldingRoomId))
	end

	local req = HouseExtension_pb.StopHoldProtomerRequest()

	req.roomId = roomId
	self._stopHoldingRoomId = roomId

	self:sendMsg(req)
end

function M:handleStopHoldProtomerReply(status, msg)
	if status == 0 then
		self:sendGetSingleHoldRoomInfoRequest(self._stopHoldingRoomId)
	else
		self:_handleErrorMsgShow(status, string.format("[14]停止收容房间[%d]失败", self._stopHoldingRoomId))
	end

	self._stopHoldingRoomId = nil
end

function M:sendUpgradeProtomerModuleRequest(protomerId, moduleId)
	local req = HouseExtension_pb.UpgradeProtomerModuleRequest()

	req.protomerId = protomerId
	req.moduleId = moduleId
	self._upgradeModuleInfo = {
		valProtomerId = protomerId,
		valModuleID = moduleId
	}

	self:sendMsg(req)
end

function M:handleUpgradeProtomerModuleReply(status, msg)
	if status == 0 then
		local protomerMo = ProtomerModel.instance:getProtomerInfo(self._upgradeModuleInfo.valProtomerId)

		protomerMo:setUpgradeModule(msg.upgradeModule)
		protomerMo:setModulePoint(msg.modulePoint)
		ProtomerModel.instance:updateProtomerFromClient(protomerMo, true)
	else
		self:_handleErrorMsgShow(status, "[15]handleUpgradeProtomerModuleReply")
	end
end

function M:sendGetProtomerInfoRequest()
	local req = HouseExtension_pb.GetProtomerInfoRequest()

	self:sendMsg(req)
end

function M:handleGetProtomerInfoReply(status, msg)
	if status == 0 then
		ProtomerModel.instance:updateProtomerLst(msg.protomers)
	else
		self:_handleErrorMsgShow(status, "[16]handleGetProtomerInfoReply")
	end
end

function M:sendChangeProtomerRequest(roomId, protomerId)
	local req = HouseExtension_pb.ChangeProtomerRequest()

	req.roomId = roomId
	req.protomerId = protomerId
	self._changeProtomerTargetRoomId = roomId

	printWarn(string.format("[17]准备发送切换原体协议，roomId[%d],protomerId[%d];原体原来在[%d]室", roomId, protomerId, ProtomerModel.instance:getProtomerRoomId(protomerId)))
	self:sendMsg(req)
end

function M:handleChangeProtomerReply(status, msg)
	if status == 0 then
		if msg.roomId and msg.roomId ~= 0 then
			ContainmentModel.instance:removeRoomProtomerCache(msg.roomId)
			self:sendGetSingleHoldRoomInfoRequest(msg.roomId)
		end

		local orgRoomId = self._changeProtomerTargetRoomId

		if orgRoomId and orgRoomId ~= 0 and orgRoomId ~= msg.roomId then
			self:sendGetSingleHoldRoomInfoRequest(orgRoomId)

			self._changeProtomerTargetRoomId = 0
		end
	else
		self:_handleErrorMsgShow(status, "[17]handleChangeProtomerReply")
	end
end

function M:sendGetReportsRequest(roomId)
	local req = HouseExtension_pb.GetReportsRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function M:handleGetReportsReply(status, msg)
	if status == 0 then
		ContainmentReportModel.instance:updateRoomReportLst(msg.reports)
	else
		self:_handleErrorMsgShow(status, "[18]handleGetReportsReply")
	end
end

function M:sendReceiveReportRequest(roomId, uuid)
	local req = HouseExtension_pb.ReceiveReportRequest()

	req.roomId = roomId
	req.uuid = uuid

	self:sendMsg(req)
end

function M:handleReceiveReportReply(status, msg)
	if status == 0 then
		ContainmentController.instance:receiveSingleReportReward(msg.reports, true)
		ContainmentModel.instance:updateRoomInfo(msg.holdRooms, true)
	else
		self:_handleErrorMsgShow(status, "[19]handleReceiveReportReply")
	end
end

function M:sendReceiveAllReportRequest(roomId)
	local req = HouseExtension_pb.ReceiveAllReportRequest()

	req.roomId = roomId

	self:sendMsg(req)
end

function M:handleReceiveAllReportReply(status, msg)
	if status == 0 then
		ContainmentController.instance:receiveReportLstReward(msg.reports)
		ContainmentModel.instance:updateRoomInfo(msg.holdRooms, true)
	else
		self:_handleErrorMsgShow(status, "[20]handleReceiveAllReportReply")
	end
end

function M:sendHoldSpeedUpRequest(roomId, count)
	local req = HouseExtension_pb.HoldSpeedUpRequest()

	req.roomId = roomId
	req.count = count
	self._useSpeedUpItemCount = count

	self:sendMsg(req)
end

function M:handleHoldSpeedUpReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(string.format(lang("tip_speedup_use_count"), self._useSpeedUpItemCount))
		ContainmentReportModel.instance:updateSpeedUpReport(msg.reports, true, true)
		ContainmentModel.instance:updateRoomInfo(msg.holdRooms, true)
	else
		self:_handleErrorMsgShow(status, "[21]handleHoldSpeedUpReply")
	end

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLD_SPEED_UP_REPLY)
end

function M:sendChangeBillboardRequest(protomerId, billboard)
	local req = HouseExtension_pb.ChangeBillboardRequest()

	req.protomerId = protomerId
	req.billboard = billboard
	self._billBoardInfo = {
		valProtomerId = protomerId,
		valBillboard = billboard
	}

	self:sendMsg(req)
end

function M:handleChangeBillboardReply(status, msg)
	if status == 0 then
		local protomerMo = ProtomerModel.instance:getProtomerInfo(self._billBoardInfo.valProtomerId)

		if protomerMo == nil then
			printError("getProtomer Fail")
		end

		protomerMo:setBillBoard(self._billBoardInfo.valBillboard)
		ProtomerModel.instance:updateProtomerFromClient(protomerMo, true)

		self._billBoardInfo = nil

		GlobalDispatcher:dispatchEvent(EventType.HOUSE_HOLD_BILLBOARD_CHANGE)
	else
		self:_handleErrorMsgShow(status, "[22]handleChangeBillboardReply")
	end
end

function M:handleGainReportPush(status, msg)
	if status == 0 then
		ContainmentReportModel.instance:updateNewReportLst(msg.reports)
		ContainmentModel.instance:updateRoomInfoLst(msg.holdRooms)
	else
		self:_handleErrorMsgShow(status, "[23]handleGainReportPush")
	end
end

function M:handleGainProtomerPush(status, msg)
	printWarn("[24] <color=#00FFFF>获取隐秘原体推送GainProtomerPush,status = </color>", status)

	if status == 0 then
		ProtomerModel.instance:gainProtomerPush(msg.protomers, true)
	else
		self:_handleErrorMsgShow(status, "[24]handleGainProtomerPush")
	end
end

function M:sendSetReportsReadRequest(uuidLst)
	if uuidLst and #uuidLst > 0 then
		local req = HouseExtension_pb.SetReportsReadRequest()

		for key, value in pairs(uuidLst or {}) do
			table.insert(req.uuid, value)
		end

		self:sendMsg(req)
	end
end

function M:handleSetReportsReadReply(status, msg)
	if status == 0 then
		-- block empty
	else
		self:_handleErrorMsgShow(status, "[39]handleSetReportsReadReply")
	end
end

function M:sendReceiveHouseRewardsRequest()
	local req = HouseExtension_pb.ReceiveHouseRewardsRequest()

	self:sendMsg(req)
end

function M:handleReceiveHouseRewardsReply(status, msg)
	if status == 0 then
		HouseMainController.instance:onReceiveHouseRewards(msg)
	else
		self:_handleErrorMsgShow(status, "[54]handleReceiveHouseRewardsReply")
	end
end

M.instance = M.New()

return M
