-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/controller/RichmanxplanController.lua

module("logic.extensions.richmanxplan.controller.RichmanxplanController", package.seeall)

local RichmanxplanController = class("RichmanxplanController", BaseController)

RichmanxplanController.DiceType = {
	Rush = 3,
	Fixed = 2,
	Normal = 1
}
RichmanxplanController.RichmanState = {
	Free = 0,
	WaitingRun = 1,
	WaitingEvent = 2
}
RichmanxplanController.EventType = {
	Shangpu = 2,
	Zhanbu = 5,
	Ziyuan = 7,
	Baochong = 8,
	Caipiao = 9,
	Zhaomu = 6,
	Boyi = 3,
	Tudi = 1,
	Yaojiang = 4
}
RichmanxplanController.ShopItemType = {
	Score = 3,
	Item = 1,
	Buff = 2
}
RichmanxplanController.FilterType = {
	All = 0,
	One = 1,
	Two = 2,
	Three = 3
}

function RichmanxplanController:ctor()
	return
end

function RichmanxplanController:onInit()
	self:onReset()
end

function RichmanxplanController:onReset()
	return
end

function RichmanxplanController:handlePM_RichManXPlanRunRes(msg)
	local activityId = msg.activityId
	local location = msg.location

	RichmanxplanModel.instance:updateLocation(activityId, location)
end

function RichmanxplanController:handlePM_RichManXPlanEventRes(msg)
	if msg.isEnd then
		RichmanxplanModel.instance:setEventState(msg.activityId, RichmanxplanController.RichmanState.Free)

		if msg.cancel then
			return
		end

		local buffId = 0

		if msg.eventType == RichmanxplanController.EventType.Caipiao then
			local eventCfg = RichmanxplanConfig.instance:getCaipiaoEventCfg(msg.activityId, msg.eventId)

			FloatWordMgr.instance:show(string.format("下注成功！%s投骰子后开奖！", eventCfg.diceTimes))
		elseif msg.eventType == RichmanxplanController.EventType.Ziyuan then
			local params = GameUtil.jsonToTable(msg.handleParam)
			local prizeCfg = RichmanxplanConfig.instance:getPrizeItemCfg(msg.activityId, msg.eventId, params.prizeId)

			if prizeCfg.type == RichmanxplanController.ShopItemType.Buff then
				buffId = checknumber(prizeCfg.param)
			end
		elseif msg.eventType == RichmanxplanController.EventType.Shangpu then
			local params = GameUtil.jsonToTable(msg.handleParam)
			local itemCfg = RichmanxplanConfig.instance:getShopItemCfg(msg.activityId, msg.eventId, params.itemId)

			if itemCfg.type == RichmanxplanController.ShopItemType.Buff then
				buffId = checknumber(itemCfg.param)
			end
		elseif msg.eventType == RichmanxplanController.EventType.Tudi then
			RichmanxplanModel.instance:buyTudiRes(msg)
			GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanRefreshMainView)
		elseif msg.eventType == RichmanxplanController.EventType.Boyi then
			local params = GameUtil.jsonToTable(msg.resultParam)
			local itemCfg = RichmanxplanConfig.instance:getBoyiItemCfg(msg.activityId, msg.eventId, params.itemId)

			if itemCfg.type == RichmanxplanController.ShopItemType.Buff then
				buffId = checknumber(itemCfg.param)
			end
		end

		if buffId > 0 then
			RichmanxplanModel.instance:addBuffEvent(msg.activityId, buffId)
			GlobalDispatcher:dispatch(GlobalNotify.RichManXPlanRefreshMainView)

			local buffCfg = RichmanxplanConfig.instance:getBuffCfg(msg.activityId, buffId)
			local stepCoinStr = string.format("1004:%s:1", buffCfg.fakeItemId)
			local itemlist = {}
			local matType, matId, matNum = MaterialMgr.getMatParams(stepCoinStr)
			local mo = MaterialModel.instance:createMo(matType, matId, matNum)

			table.insert(itemlist, mo)

			if #itemlist > 0 then
				local clientChangeSetId = MaterialController.instance:getClientChangeSetId(false)

				MaterialModel.instance:AddMaterial(matType, matId, 1)
				MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
			end
		end
	end
end

function RichmanxplanController:handlePM_NotifyRichManXPlanScoreChangeRes(msg)
	local activityId = msg.activityId
	local curScore = msg.curScore

	RichmanxplanModel.instance:updateCurrScore(activityId, curScore)
end

function RichmanxplanController:loadInfoInStartGame()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.RichManXPlan)

	if activityId > 0 then
		RichManXPlanAgent.instance:sendPM_RichManXPlanInfoReq(activityId)
		RichManXPlanAgent.instance:sendPM_RichManXPlanWorkInfoReq(activityId)
	end
end

RichmanxplanController.instance = RichmanxplanController.New()

return RichmanxplanController
