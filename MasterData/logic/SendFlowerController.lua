-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/controller/SendFlowerController.lua

module("logic.extensions.sendflower.controller.SendFlowerController", package.seeall)

local SendFlowerController = class("SendFlowerController", BaseController)

SendFlowerController.HandleGetRecord = "SendFlowerController.PM_HandleGetRecord"

function SendFlowerController:ctor()
	return
end

function SendFlowerController:onInit()
	self:onReset()
end

function SendFlowerController:onReset()
	self._showCardInfo = nil
	self._curFlowerId = nil
end

function SendFlowerController:openCharmValueView(showInfo)
	UIStateManager.instance:push(ViewName.CharmvalueView, showInfo)
end

function SendFlowerController:handleOpenCharmValueView(msg)
	SendFlowerModel.instance:updateFolwerInfos(msg)
	GlobalDispatcher:dispatch(SendFlowerController.HandleGetRecord)
end

function SendFlowerController:handleGetRecord(msg)
	SendFlowerModel.instance:updateRecordInfos(msg)
	GlobalDispatcher:dispatch(SendFlowerController.HandleGetRecord)
end

function SendFlowerController:openSendFlowerView(headInfo)
	if checkint(headInfo.userId) == 0 then
		TipsFacade.instance:openCommonTips("用户不存在")

		return
	end

	if not self:isTimeAbleToSendFlower() then
		TipsFacade.instance:openCommonTips("进入每日结算时间，暂停送花功能")

		return
	end

	UIStateManager.instance:push(ViewName.SendflowerView, headInfo)
end

function SendFlowerController:isTimeAbleToSendFlower()
	local balanceTimeValue = SendFlowerConfig.instance:getCommonParamByKey("BALANCE_TIME")
	local param = string.split(balanceTimeValue, "-")
	local curTime = ServerTime.now()
	local curDateStr = GameUtil.formatTimeStamp("%Y-%m-%d", curTime)
	local startTime = GameUtil.string2time(curDateStr .. " " .. param[1])
	local endTime = GameUtil.string2time(curDateStr .. " " .. param[2])

	if curTime <= endTime and startTime <= curTime then
		return false
	end

	return true
end

function SendFlowerController:tryToSupport(userId)
	if checkint(userId) == 0 then
		TipsFacade.instance:openCommonTips("用户不存在")

		return
	end

	if not self:isTimeAbleToSendFlower() then
		TipsFacade.instance:openCommonTips("进入每日结算时间，暂停膜拜功能")

		return
	end

	if not SendFlowerModel.instance:getIsAbleToSupport() then
		TipsFacade.instance:openCommonTips("支持次数已用尽，明日再来吧")

		return
	end

	SendFlowerAgent.instance:sendPM_SupportFlowerReq(userId)
end

function SendFlowerController:reqMalegodRank()
	SendFlowerAgent.instance:sendPM_GetIndividualRankReq(11)

	self._curFlowerId = 11
end

function SendFlowerController:reqGoddess()
	SendFlowerAgent.instance:sendPM_GetIndividualRankReq(12)

	self._curFlowerId = 12
end

function SendFlowerController:handleIndividualRankRes(msg)
	if checknumber(self._curFlowerId) == 11 then
		RankModel.instance:setRankData(msg, GameEnum.RankType.SendFlower_RANK, 1)
	elseif checknumber(self._curFlowerId) == 12 then
		RankModel.instance:setRankData(msg, GameEnum.RankType.SendFlower_RANK, 2)
	end

	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

SendFlowerController.instance = SendFlowerController.New()

return SendFlowerController
