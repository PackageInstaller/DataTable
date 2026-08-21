-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/agent/ChamberAgent.lua

module("logic.extensions.chamber.agent.ChamberAgent", package.seeall)

local M = class("ChamberAgent", BaseAgent)

function M:sendSlotInfoRequest()
	local req = ChamberExtension_pb.SlotInfoRequest()

	self:sendMsg(req)
end

function M:handleSlotInfoReply(status, msg)
	if status == 0 then
		ChamberModel.instance:updateAllSlotByAgent(msg)
		GlobalDispatcher:dispatchEvent(EventType.CHAMBER_SLOT_UPDATE)
	end
end

function M:handleChamberRefreshPush(status, msg)
	return
end

function M:sendMountRequest(slot, uuid, callback)
	local req = ChamberExtension_pb.MountRequest()

	req.slot = slot
	req.uuid = uuid

	self:invoke({
		funcName = "handleMountReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				ChamberModel.instance:mountSlot(slot, uuid)

				if callback then
					callback()
				end

				GlobalDispatcher:dispatchEvent(EventType.CHAMBER_SLOT_MOUNT)
			end
		end
	})
end

function M:sendUnmountRequest(slot, callback)
	local req = ChamberExtension_pb.UnmountRequest()

	req.slot = slot

	self:invoke({
		funcName = "handleUnmountReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				ChamberModel.instance:unmountSlot(slot)

				if callback then
					callback()
				end

				GlobalDispatcher:dispatchEvent(EventType.CHAMBER_SLOT_UNMOUNT)
			end
		end
	})
end

function M:exchange(downSlot, upSlot, upUuid, callback)
	return
end

function M:exchangeWithSelf(downSlot, upSlot, upUuid, callback)
	return
end

function M:sendGetDefaultChamberClueItemRequest()
	local req = ChamberExtension_pb.GetDefaultChamberClueItemRequest()

	self:sendMsg(req)
end

function M:handleGetDefaultChamberClueItemReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

M.instance = M.New()

return M
