-- chunkname: @modules/logic/story/rpc/StoryRpc.lua

module("modules.logic.story.rpc.StoryRpc", package.seeall)

local StoryRpc = class("StoryRpc", BaseRpc)

function StoryRpc:sendGetStoryRequest(callback, callbackObj)
	local req = StoryModule_pb.GetStoryRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function StoryRpc:onReceiveGetStoryReply(resultCode, msg)
	if resultCode == 0 then
		StoryModel.instance:setStoryList(msg)
	end
end

function StoryRpc:sendUpdateStoryRequest(storyId, stepId, favor)
	local req = StoryModule_pb.UpdateStoryRequest()

	req.storyId = storyId
	req.stepId = stepId
	req.favor = favor

	StoryModel.instance:updateStoryList(req)
	self:sendMsg(req)
end

function StoryRpc:onReceiveUpdateStoryReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function StoryRpc:sendGetStoryFinishRequest(id)
	local req = StoryModule_pb.GetStoryFinishRequest()

	req.storyId = id

	self:sendMsg(req)
end

function StoryRpc:onReceiveGetStoryFinishReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function StoryRpc:onReceiveStoryFinishPush(resultCode, msg)
	if resultCode == 0 then
		StoryController.instance:setStoryFinished(msg.storyId)
		StoryController.instance:dispatchEvent(StoryEvent.FinishFromServer, msg.storyId)
	end
end

StoryRpc.instance = StoryRpc.New()

return StoryRpc
