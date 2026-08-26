-- chunkname: @modules/logic/necrologiststory/rpc/NecrologistStoryRpc.lua

module("modules.logic.necrologiststory.rpc.NecrologistStoryRpc", package.seeall)

local NecrologistStoryRpc = class("NecrologistStoryRpc", BaseRpc)

function NecrologistStoryRpc:onInit()
	self._sendTypeDict = nil
end

function NecrologistStoryRpc:reInit()
	self._sendTypeDict = nil

	TaskDispatcher.cancelTask(self._delaySendUpdateInfo, self)
end

function NecrologistStoryRpc:sendGetNecrologistStoryRequest(storyId, callback, callbackObj)
	local req = NecrologistStoryModule_pb.GetNecrologistStoryRequest()

	req.storyId = storyId or 0

	return self:sendMsg(req, callback, callbackObj)
end

function NecrologistStoryRpc:onReceiveGetNecrologistStoryReply(resultCode, msg)
	if resultCode == 0 then
		NecrologistStoryModel.instance:updateStoryInfos(msg.story)
	end
end

function NecrologistStoryRpc:sendUpdateNecrologistStoryRequest(storyId, data, callback, callbackObj)
	if not callback then
		self._sendTypeDict = self._sendTypeDict or {}
		self._sendTypeDict[storyId] = data

		TaskDispatcher.cancelTask(self._delaySendUpdateInfo, self)
		TaskDispatcher.runDelay(self._delaySendUpdateInfo, self, 0.1)

		return
	end

	return self:_sendUpdateNecrologistStoryRequest(storyId, data, callback, callbackObj)
end

function NecrologistStoryRpc:_sendUpdateNecrologistStoryRequest(storyId, data, callback, callbackObj)
	local req = NecrologistStoryModule_pb.UpdateNecrologistStoryRequest()

	req.storyId = storyId

	if data then
		data:setNecrologistStoryRequest(req)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function NecrologistStoryRpc:onReceiveUpdateNecrologistStoryReply(resultCode, msg)
	if resultCode == 0 then
		NecrologistStoryModel.instance:updateStoryInfo(msg)
	end
end

function NecrologistStoryRpc:_delaySendUpdateInfo()
	if self._sendTypeDict then
		for storyId, mo in pairs(self._sendTypeDict) do
			self:_sendUpdateNecrologistStoryRequest(storyId, mo)
		end

		self._sendTypeDict = nil
	end
end

function NecrologistStoryRpc:sendFinishNecrologistStoryModeRequest(storyId, modeId, callback, callbackObj)
	local req = NecrologistStoryModule_pb.FinishNecrologistStoryModeRequest()

	req.storyId = storyId
	req.modeId = modeId

	return self:sendMsg(req, callback, callbackObj)
end

function NecrologistStoryRpc:onReceiveFinishNecrologistStoryModeReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

NecrologistStoryRpc.instance = NecrologistStoryRpc.New()

return NecrologistStoryRpc
