-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/controller/JackpotController.lua

module("logic.extensions.jackpot.controller.JackpotController", package.seeall)

local JackpotController = class("JackpotController", BaseController)

function JackpotController:ctor()
	return
end

function JackpotController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.fireCheckRedDot, self)
end

function JackpotController:onReset()
	return
end

function JackpotController:fireCheckRedDot()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_JACKDRAW, JackpotModel.instance:checkRedDot())
end

function JackpotController:sendJackpotDrawReq(activityId, isShowGain)
	JackpotAgent.instance:sendJackpotDrawReq(activityId)

	self._drawActId = activityId
	self._isShowGain = isShowGain
end

function JackpotController:handleJackpotDrawRes(status, msg)
	local rewardid = msg.rewardId
	local changesetid = msg.changeSetId
	local nextorderid = msg.nextOrderId
	local drawInfo = JackpotModel.instance:getDrawInfo()
	local orderId = 0

	if drawInfo then
		orderId = drawInfo.orderId
	end

	local actCfg = JackpotConfig.instance:getActCfgById(self._drawActId)
	local poolCfg = JackpotConfig.instance:getPoolCfg(actCfg.jackpot)
	local rewardCfg = poolCfg[orderId][rewardid]
	local getBigPrize = rewardCfg.type == 1

	JackpotModel.instance:setChangeSetId(changesetid)
	JackpotModel.instance:drawSuccessed(rewardid, nextorderid)

	if drawInfo then
		if getBigPrize then
			if checknumber(nextorderid) == 0 then
				JackpotModel.instance:drwaAnimEnd(rewardid)
			end

			UIStateManager.instance:push(ViewName.JackpotchangepooltipView, orderId)
			JackpotController.instance:localNotify(JackpotModel.UpdateDrawInfos)
		elseif checknumber(nextorderid) > 0 then
			JackpotController.instance:localNotify(JackpotModel.UpdateDrawInfos)
		else
			JackpotController.instance:localNotify(JackpotModel.DrawSuccessed, rewardid)
		end
	else
		printInfo("===没有drawInfo")
	end

	self._drawActId = nil
end

JackpotController.instance = JackpotController.New()

return JackpotController
