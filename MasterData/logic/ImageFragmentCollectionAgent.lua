-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/agent/ImageFragmentCollectionAgent.lua

module("logic.extensions.imagefragmentcollection.agent.ImageFragmentCollectionAgent", package.seeall)

local ImageFragmentCollectionAgent = class("ImageFragmentCollectionAgent", BaseAgent)

ImageFragmentCollectionAgent.PM_ImageFragmentCollectionInfoRes = "ImageFragmentCollectionAgent_PM_ImageFragmentCollectionInfoRes"
ImageFragmentCollectionAgent.PM_ImageFragmentCollectionActiveFragmentRes = "ImageFragmentCollectionAgent_PM_ImageFragmentCollectionActiveFragmentRes"
ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveImagePrizeRes = "ImageFragmentCollectionAgent_PM_ImageFragmentCollectionReceiveImagePrizeRes"
ImageFragmentCollectionAgent.PM_ImageFragmentCollectionMassRes = "ImageFragmentCollectionAgent_PM_ImageFragmentCollectionMassRes"
ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveMassPrizeRes = "ImageFragmentCollectionAgent_PM_ImageFragmentCollectionReceiveMassPrizeRes"

function ImageFragmentCollectionAgent:ctor()
	return
end

function ImageFragmentCollectionAgent:setExtId(extId)
	ImageFragmentCollectionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ImageFragmentCollectionAgent:sendPM_ImageFragmentCollectionInfoReq(activityId, handler, handlerObj, errHandler)
	local req = ImageFragmentCollectionExtension_pb.PM_ImageFragmentCollectionInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ImageFragmentCollectionAgent:handlePM_ImageFragmentCollectionInfoRes(status, msg)
	self:dispatch(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionInfoRes, status, msg)
end

function ImageFragmentCollectionAgent:sendPM_ImageFragmentCollectionActiveFragmentReq(activityId, imageId, imageFragmentId, handler, handlerObj, errHandler)
	local req = ImageFragmentCollectionExtension_pb.PM_ImageFragmentCollectionActiveFragmentReq()

	req.activityId = activityId
	req.imageId = imageId
	req.imageFragmentId = imageFragmentId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionActiveFragmentRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ImageFragmentCollectionAgent:handlePM_ImageFragmentCollectionActiveFragmentRes(status, msg)
	self:dispatch(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionActiveFragmentRes, status, msg)
end

function ImageFragmentCollectionAgent:sendPM_ImageFragmentCollectionReceiveImagePrizeReq(activityId, imageId, handler, handlerObj, errHandler)
	local req = ImageFragmentCollectionExtension_pb.PM_ImageFragmentCollectionReceiveImagePrizeReq()

	req.activityId = activityId
	req.imageId = imageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveImagePrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ImageFragmentCollectionAgent:handlePM_ImageFragmentCollectionReceiveImagePrizeRes(status, msg)
	self:dispatch(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveImagePrizeRes, status, msg)
end

function ImageFragmentCollectionAgent:sendPM_ImageFragmentCollectionMassReq(activityId, handler, handlerObj, errHandler)
	local req = ImageFragmentCollectionExtension_pb.PM_ImageFragmentCollectionMassReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionMassRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ImageFragmentCollectionAgent:handlePM_ImageFragmentCollectionMassRes(status, msg)
	self:dispatch(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionMassRes, status, msg)
end

function ImageFragmentCollectionAgent:sendPM_ImageFragmentCollectionReceiveMassPrizeReq(activityId, massPrizeId, handler, handlerObj, errHandler)
	local req = ImageFragmentCollectionExtension_pb.PM_ImageFragmentCollectionReceiveMassPrizeReq()

	req.activityId = activityId
	req.massPrizeId = massPrizeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveMassPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ImageFragmentCollectionAgent:handlePM_ImageFragmentCollectionReceiveMassPrizeRes(status, msg)
	self:dispatch(ImageFragmentCollectionAgent.PM_ImageFragmentCollectionReceiveMassPrizeRes, status, msg)
end

ImageFragmentCollectionAgent.instance = ImageFragmentCollectionAgent.New()

return ImageFragmentCollectionAgent
