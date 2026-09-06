-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/controller/CollectingSkinController.lua

module("logic.extensions.collectingskin.controller.CollectingSkinController", package.seeall)

local CollectingSkinController = class("CollectingSkinController", BaseController)

CollectingSkinController.OpenSkinFrameView = "openskinframeview"

function CollectingSkinController:onInit()
	GlobalDispatcher:addListener(CollectingSkinController.OpenSkinFrameView, self._openSkinFrameView, self)
	self:onReset()
end

function CollectingSkinController:onReset()
	return
end

function CollectingSkinController:_openSkinFrameView(params)
	if params then
		local frameId, headTabId, secTabId = checknumber(params[1]), checknumber(params[2]), checknumber(params[3])

		self:openSkinFrameView(frameId, headTabId, secTabId)
	else
		printError("皮肤好礼框架 缺失传入参数 frameId, headTabId, secTabId")
	end
end

CollectingSkinController.JumpTab_HeadTabId = 0
CollectingSkinController.JumpTab_SecTabId = 0

function CollectingSkinController:openSkinFrameView(frameId, headTabId, secTabId)
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	if baseData then
		if not baseData.viewName then
			local viewName = ""

			if ViewMgr.instance:isOpen(viewName) then
				GlobalDispatcher:dispatch(GlobalNotify.HandleTabFrameWorkShowJump, frameId, headTabId, secTabId)
			else
				CollectingSkinController.JumpTab_HeadTabId = headTabId
				CollectingSkinController.JumpTab_SecTabId = secTabId

				UIStateManager.instance:push(viewName, frameId)
			end
		end
	end
end

function CollectingSkinController:getInfo(activityId)
	CollectingSkinAgent.instance:sendPM_CollectingSkinGetInfoReq(activityId)
end

function CollectingSkinController:handleGetInfo(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_CollectingSkinGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CollectingSkinGetInfo)
end

function CollectingSkinController:gainProgressPrzie(activityId, dataBitId)
	CollectingSkinAgent.instance:sendPM_CollectingSkinGainProgressPrizeReq(activityId, dataBitId)
end

function CollectingSkinController:handleGainPrize(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_CollectingSkinGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CollectingSkinGainProgressPrize)
end

function CollectingSkinController:gainSkinPrize(activityId, skinId)
	CollectingSkinAgent.instance:sendPM_CollectingSkinGainSkinPrizeReq(activityId, skinId)
end

function CollectingSkinController:handleGainSkinPrize(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_CollectingSkinGainSkinPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CollectingSkinGainSkinPrize)
end

function CollectingSkinController:gainItemPrize(activityId, dataBitId)
	CollectingSkinAgent.instance:sendPM_CollectingSkinGainItemPrizeReq(activityId, dataBitId)
end

function CollectingSkinController:handleGainItemPrize(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_CollectingSkinGainItemPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CollectingSkinGainItemPrize)
end

function CollectingSkinController:sendPM_CollectingSkinItemRankInfoReq(activityId)
	CollectingSkinAgent.instance:sendPM_CollectingSkinItemRankInfoReq(activityId)
end

function CollectingSkinController:handlePM_CollectingSkinItemRankInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_CollectingSkinItemRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CollectingSkinItemRankInfo, msg)
end

function CollectingSkinController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.CollectingSkin)
end

function CollectingSkinController:getSubMo(activityId)
	return CollectingSkinModel.instance:getSubMo(activityId)
end

CollectingSkinController.instance = CollectingSkinController.New()

return CollectingSkinController
