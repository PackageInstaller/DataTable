-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/agent/JigsawExchangeAgent.lua

module("logic.extensions.infinitejigsaw.agent.JigsawExchangeAgent", package.seeall)

local JigsawExchangeAgent = class("JigsawExchangeAgent", BaseAgent)

function JigsawExchangeAgent:sendPM_JEGetTaskInfoReq(activityId)
	local req = JigsawExchangeExtension_pb.PM_JEGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGetTaskInfoRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGetTaskInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGetTaskInfoRes)
	end
end

function JigsawExchangeAgent:sendPM_JEGainTaskPrizeReq(activityId, taskId)
	local req = JigsawExchangeExtension_pb.PM_JEGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGainTaskPrizeRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGainTaskPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGainTaskPrizeRes)
	end
end

function JigsawExchangeAgent:sendPM_JEGetPictureInfoReq(activityId)
	local req = JigsawExchangeExtension_pb.PM_JEGetPictureInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGetPictureInfoRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGetPictureInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGetPictureInfoRes)
	end
end

function JigsawExchangeAgent:sendPM_JEActivateJigsawReq(activityId, pictureId, jigsawId)
	local req = JigsawExchangeExtension_pb.PM_JEActivateJigsawReq()

	req.activityId = activityId
	req.pictureId = pictureId
	req.jigsawId = jigsawId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEActivateJigsawRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEActivateJigsawRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEActivateJigsawRes, msg.activityId, msg.pictureId, msg.jigsawId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.JEFailedActivePiece, status)
	end
end

function JigsawExchangeAgent:sendPM_JEGainGroupPrizeReq(activityId, pictureId, groupPrizeId)
	local req = JigsawExchangeExtension_pb.PM_JEGainGroupPrizeReq()

	req.activityId = activityId
	req.pictureId = pictureId
	req.groupPrizeId = groupPrizeId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGainGroupPrizeRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGainGroupPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGainGroupPrizeRes, msg.activityId, msg.pictureId, msg.groupPrizeId)
	end
end

function JigsawExchangeAgent:sendPM_JEGainBigPrizeReq(activityId, pictureId)
	local req = JigsawExchangeExtension_pb.PM_JEGainBigPrizeReq()

	req.activityId = activityId
	req.pictureId = pictureId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGainBigPrizeRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGainBigPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGainBigPrizeRes, msg.activityId, msg.pictureId)
	end
end

function JigsawExchangeAgent:sendPM_JEGiveGiftReq(activityId)
	local req = JigsawExchangeExtension_pb.PM_JEGiveGiftReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JigsawExchangeAgent:handlePM_JEGiveGiftRes(status, msg)
	if status == 0 then
		InfiniteJigsawModel.instance:onJEGiveGiftRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JEGiveGiftRes)
	end
end

JigsawExchangeAgent.instance = JigsawExchangeAgent.New()

return JigsawExchangeAgent
